From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Jan 2018 12:09:43 +0800
Subject: [PATCH v3 1/8] ARM: sun9i: Support SMP bring-up on A80
In-Reply-To: <20180115120440.GT22781@e103592.cambridge.arm.com>
References: <20180115071450.18355-1-wens@csie.org>
 <20180115071450.18355-2-wens@csie.org>
 <20180115120440.GT22781@e103592.cambridge.arm.com>
Message-ID: <CAGb2v65Y7Xcfjd1-byb1_Ax3ft7iGWx2nq-0ys4dT9rWdHVRrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 8:04 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> On Mon, Jan 15, 2018 at 07:14:43AM +0000, Chen-Yu Tsai wrote:
>> The A80 is a big.LITTLE SoC with 1 cluster of 4 Cortex-A7s and
>> 1 cluster of 4 Cortex-A15s.
>>
>> This patch adds support to bring up the second cluster and thus all
>> cores using custom platform SMP code. Core/cluster power down has not
>> been implemented, thus CPU hotplugging is not supported.
>>
>> This is limited to !THUMB2_KERNEL for now. The entry code must be built
>> as ARM machine code, and it does not switch modes. Further work was
>> done to move the assembly code to a separate file and add the proper
>> mode statements and mode switching instructions. However initial tests
>> failed to boot properly with Thumb-2.
>>
>> Parts of the trampoline and re-entry code for the boot cpu was adapted
>> from the MCPM framework.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/mach-sunxi/Kconfig  |   7 +
>>  arch/arm/mach-sunxi/Makefile |   1 +
>>  arch/arm/mach-sunxi/mcpm.c   | 548 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 556 insertions(+)
>>  create mode 100644 arch/arm/mach-sunxi/mcpm.c
>>
>> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
>> index 58153cdf025b..b53e37d170e6 100644
>> --- a/arch/arm/mach-sunxi/Kconfig
>> +++ b/arch/arm/mach-sunxi/Kconfig
>> @@ -48,4 +48,11 @@ config MACH_SUN9I
>>       default ARCH_SUNXI
>>       select ARM_GIC
>>
>> +config ARCH_SUNXI_MCPM
>> +     bool
>> +     depends on SMP && !THUMB2_KERNEL
>> +     default MACH_SUN9I
>> +     select ARM_CCI400_PORT_CTRL
>> +     select ARM_CPU_SUSPEND
>> +
>
> If this no longer uses MCPM, you should get rid of "mcpm" from all the
> names, comments etc. -- it's just confusing otherwise.

Discussed with Maxime. Will switch to "mc_smp" instead. The "mc" part
is there to differentiate with some old smp code we have for the A31
and A23.

>
>>  endif
>> diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
>> index 27b168f121a1..cacd1afa8137 100644
>> --- a/arch/arm/mach-sunxi/Makefile
>> +++ b/arch/arm/mach-sunxi/Makefile
>> @@ -1,2 +1,3 @@
>>  obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
>> +obj-$(CONFIG_ARCH_SUNXI_MCPM) += mcpm.o
>>  obj-$(CONFIG_SMP) += platsmp.o
>> diff --git a/arch/arm/mach-sunxi/mcpm.c b/arch/arm/mach-sunxi/mcpm.c
>> new file mode 100644
>> index 000000000000..7c77bb3b367a
>> --- /dev/null
>> +++ b/arch/arm/mach-sunxi/mcpm.c
>
> [...]
>
>> +static int sunxi_mcpm_cpu_table[SUNXI_NR_CLUSTERS][SUNXI_CPUS_PER_CLUSTER];
>> +static int sunxi_mcpm_first_comer;
>> +
>> +/*
>> + * Enable cluster-level coherency, in preparation for turning on the MMU.
>> + *
>> + * Also enable regional clock gating and L2 data latency settings for
>> + * Cortex-A15. These settings are from the vendor kernel.
>> + */
>> +static void __naked sunxi_mcpm_cluster_cache_enable(void)
>> +{
>> +     asm volatile (
>> +             "mrc    p15, 0, r1, c0, c0, 0\n"
>> +             "movw   r2, #" __stringify(ARM_CPU_PART_MASK & 0xffff) "\n"
>> +             "movt   r2, #" __stringify(ARM_CPU_PART_MASK >> 16) "\n"
>> +             "and    r1, r1, r2\n"
>> +             "movw   r2, #" __stringify(ARM_CPU_PART_CORTEX_A15 & 0xffff) "\n"
>> +             "movt   r2, #" __stringify(ARM_CPU_PART_CORTEX_A15 >> 16) "\n"
>> +             "cmp    r1, r2\n"
>> +             "bne    not_a15\n"
>> +
>> +             /* The following is Cortex-A15 specific */
>> +
>> +             /* ACTLR2: Enable CPU regional clock gates */
>> +             "mrc p15, 1, r1, c15, c0, 4\n"
>> +             "orr r1, r1, #(0x1<<31)\n"
>> +             "mcr p15, 1, r1, c15, c0, 4\n"
>> +
>> +             /* L2ACTLR */
>> +             "mrc p15, 1, r1, c15, c0, 0\n"
>> +             /* Enable L2, GIC, and Timer regional clock gates */
>> +             "orr r1, r1, #(0x1<<26)\n"
>> +             /* Disable clean/evict from being pushed to external */
>> +             "orr r1, r1, #(0x1<<3)\n"
>> +             "mcr p15, 1, r1, c15, c0, 0\n"
>> +
>> +             /* L2CTRL: L2 data RAM latency */
>> +             "mrc p15, 1, r1, c9, c0, 2\n"
>> +             "bic r1, r1, #(0x7<<0)\n"
>> +             "orr r1, r1, #(0x3<<0)\n"
>> +             "mcr p15, 1, r1, c9, c0, 2\n"
>> +
>> +             /* End of Cortex-A15 specific setup */
>> +             "not_a15:\n"
>> +
>> +             /* Get value of sunxi_mcpm_first_comer */
>> +             "adr    r1, first\n"
>> +             "ldr    r0, [r1]\n"
>> +             "ldr    r0, [r1, r0]\n"
>> +
>> +             /* Skip cci_enable_port_for_self if not first comer */
>> +             "cmp    r0, #0\n"
>> +             "bxeq   lr\n"
>> +             "b      cci_enable_port_for_self\n"
>
> For Thumb, you need a ".align 2" here.
>
> I've never understood why gas doesn't implicitly align .word on arches
> that care about data alignment, but it doesn't...
>
> Since the MMU isn't on yet, you may get alignment faults if the .word
> is misaligned in the assembled code.

This was indeed the problem. Don't know why I missed it considering I
had added them for other parts in my full assembly patches...

>
>> +
>> +             "first: .word sunxi_mcpm_first_comer - .\n"
>> +     );
>> +}
>
> [...]
>
>> +static int __init sunxi_mcpm_init(void)
>> +{
>> +     struct device_node *cpucfg_node, *node;
>> +     struct resource res;
>> +     int ret;
>> +
>> +     if (!of_machine_is_compatible("allwinner,sun9i-a80"))
>> +             return -ENODEV;
>> +
>> +     if (!sunxi_mcpm_cpu_table_init())
>> +             return -EINVAL;
>> +
>> +     if (!cci_probed()) {
>> +             pr_err("%s: CCI-400 not available\n", __func__);
>> +             return -ENODEV;
>> +     }
>> +
>> +     node = of_find_compatible_node(NULL, NULL, "allwinner,sun9i-a80-prcm");
>> +     if (!node) {
>> +             pr_err("%s: PRCM not available\n", __func__);
>> +             return -ENODEV;
>> +     }
>> +
>> +     /*
>> +      * Unfortunately we can not request the I/O region for the PRCM.
>> +      * It is shared with the PRCM clock.
>> +      */
>> +     prcm_base = of_iomap(node, 0);
>> +     of_node_put(node);
>> +     if (!prcm_base) {
>> +             pr_err("%s: failed to map PRCM registers\n", __func__);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     cpucfg_node = of_find_compatible_node(NULL, NULL,
>> +                                           "allwinner,sun9i-a80-cpucfg");
>> +     if (!cpucfg_node) {
>> +             ret = -ENODEV;
>> +             pr_err("%s: CPUCFG not available\n", __func__);
>> +             goto err_unmap_prcm;
>> +     }
>> +
>> +     cpucfg_base = of_io_request_and_map(cpucfg_node, 0, "sunxi-mcpm");
>> +     if (IS_ERR(cpucfg_base)) {
>> +             ret = PTR_ERR(cpucfg_base);
>> +             pr_err("%s: failed to map CPUCFG registers: %d\n",
>> +                    __func__, ret);
>> +             goto err_put_cpucfg_node;
>> +     }
>> +
>> +     /* Configure CCI-400 for boot cluster */
>> +     ret = sunxi_mcpm_lookback();
>> +     if (ret) {
>> +             pr_err("%s: failed to configure boot cluster: %d\n",
>> +                    __func__, ret);
>> +             goto err_unmap_release_cpucfg;
>> +     }
>> +
>> +     /* We don't need the CPUCFG device node anymore */
>> +     of_node_put(cpucfg_node);
>> +
>> +     /* Set the hardware entry point address */
>> +     writel(__pa_symbol(sunxi_mcpm_secondary_startup),
>> +            prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
>
> It's possible the firmware / boot ROM doesn't know how to branch
> correctly to a Thumb symbol here.  This is often missed in firmware
> implementations (or deliberately omitted, since it easy to work
> around in the OS).

I've tried all the tricks to jump from ARM to Thumb. Then it occurred
to me, __pa_symbol() would set the lowest bit for Thumb symbols. So I
tried just using cpu_resume for the trampoline re-entry point, and it
worked.

I went back and checked the BROM code. It does

    ldr pc, <entry_code_address>

which I assume is the same as

    ldr ip, <entry_code_address>
    bx ip

Indeed just fixing the alignment issue above made it work.

> Things you could try:
>
> 1) Add CFLAGS_mcpm.o += -marm
> (to see whether building just this file as ARM fixes it).

This doesn't really work. The spinlock code are still Thumb instructions
and the assembler complains.

> 2) Split sunxi_mcpm_secondary_startup out into a separate asm file
> and build just that as ARM, so that the entry point from the firmware
> is ARM.

I tried this before but...

> If both work, the firmware can't branch directly to Thumb and so you
> need to keep the secondary entry point as ARM code.

as mentioned above the BROM does branch correctly and it was the .word
.alignment that was the culprit.

Thanks for all the feedback!
ChenYu

> If (1) works but (2) doesn't, then there must be somthing else in this
> file that is Thumb-incompatible, but I don't see it so far.
>
>
> [...]
>
> Cheers
> ---Dave
