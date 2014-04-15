From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 15 Apr 2014 15:35:59 +0800
Subject: [PATCH v2 07/12] ARM: hisi: add hip04 SoC support
In-Reply-To: <20140410085052.GC22639@e106331-lin.cambridge.arm.com>
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
 <1396944052-9887-8-git-send-email-haojian.zhuang@linaro.org>
 <20140410085052.GC22639@e106331-lin.cambridge.arm.com>
Message-ID: <CAD6h2NRcQg2Gy+4rDR188r8VERqTo_YbCFZdXo-Baqcz9N+JSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 April 2014 16:50, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Apr 08, 2014 at 09:00:47AM +0100, Haojian Zhuang wrote:
>> Hisilicon Hi3xxx is based on Cortex A9 Core. Now HiP04 SoC is based on
>> Cortex A15 Core. Since multiple clusters is used in HiP04 SoC, it could
>> be based on MCPM.
>>
>>
>> +config ARCH_HIP04
>> +       bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7_LPAE
>> +       select HAVE_ARM_ARCH_TIMER
>> +       select MCPM if SMP
>> +       help
>> +         Support for Hisilicon HiP04 processor family
>
> Nit: Surely this is an SoC family? The processor is Cortex-A15, as you
> state above.
>
Yes, it's SoC, not processor. I'll fix it.

>> +
>>  endmenu
>>
>>  endif
>> diff --git a/arch/arm/mach-hisi/core.h b/arch/arm/mach-hisi/core.h
>> index af23ec2..e008c7a 100644
>> --- a/arch/arm/mach-hisi/core.h
>> +++ b/arch/arm/mach-hisi/core.h
>> @@ -12,4 +12,10 @@ extern void hi3xxx_cpu_die(unsigned int cpu);
>>  extern int hi3xxx_cpu_kill(unsigned int cpu);
>>  extern void hi3xxx_set_cpu(int cpu, bool enable);
>>
>> +#define HIP04_BOOTWRAPPER_PHYS         0x10c00000
>> +#define HIP04_BOOTWRAPPER_MAGIC                0xa5a5a5a5
>> +#define HIP04_BOOTWRAPPER_SIZE         0x00010000
>
> The address and size should come from DT.
>
> What is the magic, exactly? How is it used by the kernel and
> bootwrapper?
>
Of course, I can move it into DT.

>
>> +static void __init hip04_reserve(void)
>> +{
>> +       memblock_reserve(HIP04_BOOTWRAPPER_PHYS, HIP04_BOOTWRAPPER_SIZE);
>> +}
>
> As Arnd said, do this in your DT. This is not a hardware property the
> kernel needs to statically know, but rather a system-specific property
> that needs to be in the DT such that it can vary.
>
Sure. I'll update it.

>
>> +static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
>> +{
>> +       unsigned long data, mask;
>> +
>> +       if (!relocation || !sysctrl)
>> +               return -ENODEV;
>> +       if (cluster >= HIP04_MAX_CLUSTERS || cpu >= HIP04_MAX_CPUS_PER_CLUSTER)
>> +               return -EINVAL;
>> +
>> +       spin_lock(&boot_lock);
>> +       writel_relaxed(HIP04_BOOTWRAPPER_PHYS, relocation);
>> +       writel_relaxed(HIP04_BOOTWRAPPER_MAGIC, relocation + 4);
>> +       writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
>
> So the kernel is poking the hardware directly to throw CPUs into a
> bootwrapper that it pokes to throw the CPUs into the kernel? That does
> not strike me as fantastic.
>
> It's a shame we have to manage coherency here at all and don't have a
> PSCI implementation to abstract this. That would mean you wouldn't need
> a machine descriptor at all, could reuse existing infrastructure, and
> you'd be able to use Hyp.
>

Do we need a firmware to support PSCI first? Up to now, I don't have
this kind of firmware.

>
>> +static void hip04_mcpm_power_down(void)
>> +{
>> +       unsigned int mpidr, cpu, cluster;
>> +       unsigned int v;
>> +
>> +       spin_lock(&boot_lock);
>> +       spin_unlock(&boot_lock);
>
> Huh? What's this for?

Actually it could be removed. Since secondary CPU is always booted up
one by one.
>
>> +       asm volatile(
>> +       "       mrc     p15, 0, %0, c1, c0, 0\n"
>> +       "       bic     %0, %0, %1\n"
>> +       "       mcr     p15, 0, %0, c1, c0, 0\n"
>> +         : "=&r" (v)
>> +         : "Ir" (CR_C)
>> +         : "cc");
>
> I don't think that cc clobber is necessary, none of these instructions
> set the flags.

Yes, I'll remove it.
>
>> +       asm volatile(
>> +       /*
>> +       * Turn off coherency
>> +       */
>> +       "       mrc     p15, 0, %0, c1, c0, 1\n"
>> +       "       bic     %0, %0, %1\n"
>> +       "       mcr     p15, 0, %0, c1, c0, 1\n"
>> +       : "=&r" (v)
>> +       : "Ir" (0x40)
>
> 0x40?

Disable SMP bit in ACTLR register.

>
>> +       : "cc");
>
> Likewise I don't think this clobber is necessary.

Yes, I'll remove it.
>
>> +static int __init hip04_mcpm_init(void)
>> +{
>> +       struct device_node *np;
>> +       int ret = -ENODEV;
>> +
>> +       np = of_find_compatible_node(NULL, NULL, "hisilicon,hip04-mcpm");
>> +       if (!np) {
>> +               pr_err("failed to find hisilicon,hip04-mcpm node\n");
>> +               goto err;
>> +       }
>
> MCPM is a Linux-specific software construct. It is not a piece of
> hardware, and not a generic interface name. Please come up with a better
> name for this that makes it clear exactly what you are describing.
>

OK. I'll use "hisilicon,core-power-control" instead.

>> +       relocation = of_iomap(np, 0);
>> +       if (!relocation) {
>> +               pr_err("failed to get relocation space\n");
>> +               ret = -ENOMEM;
>> +               goto err;
>> +       }
>> +       sysctrl = of_iomap(np, 1);
>> +       if (!sysctrl) {
>> +               pr_err("failed to get sysctrl base\n");
>> +               ret = -ENOMEM;
>> +               goto err_sysctrl;
>> +       }
>> +       fabric = of_iomap(np, 2);
>> +       if (!fabric) {
>> +               pr_err("failed to get fabric base\n");
>> +               ret = -ENOMEM;
>> +               goto err_fabric;
>> +       }
>
> These sounds like they would be better described by separate nodes.
>
OK
