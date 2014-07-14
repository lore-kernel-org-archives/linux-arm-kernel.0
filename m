From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 14 Jul 2014 10:37:27 +0800
Subject: [PATCH v10 03/11] ARM: hisi: enable MCPM implementation
In-Reply-To: <alpine.DEB.2.10.1407101714400.2893@Yrabib>
References: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
 <1404957850-13340-4-git-send-email-haojian.zhuang@linaro.org>
 <alpine.DEB.2.10.1407101714400.2893@Yrabib>
Message-ID: <CAD6h2NQzV_=y=OqmGonzZTspoZiV5oRg3c52cCO-F1rYJUzZRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 July 2014 05:31, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 10 Jul 2014, Haojian Zhuang wrote:
>
>> Multiple CPU clusters are used in Hisilicon HiP04 SoC. Now use MCPM
>> framework to manage power on HiP04 SoC.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  arch/arm/mach-hisi/Makefile   |   1 +
>>  arch/arm/mach-hisi/platmcpm.c | 331 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 332 insertions(+)
>>  create mode 100644 arch/arm/mach-hisi/platmcpm.c
>>
>> diff --git a/arch/arm/mach-hisi/Makefile b/arch/arm/mach-hisi/Makefile
>> index ee2506b..d64831e 100644
>> +
>> +static void hip04_mcpm_power_down(void)
>> +{
>> +     unsigned int mpidr, cpu, cluster, data = 0;
>> +     bool skip_reset = false;
>> +
>> +     mpidr = read_cpuid_mpidr();
>> +     cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> +     cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> +
>> +     __mcpm_cpu_going_down(cpu, cluster);
>> +
>> +     spin_lock(&boot_lock);
>> +     BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
>> +     hip04_cpu_table[cluster][cpu]--;
>> +     if (hip04_cpu_table[cluster][cpu] == 1) {
>> +             /* A power_up request went ahead of us. */
>> +             skip_reset = true;
>> +     } else if (hip04_cpu_table[cluster][cpu] > 1) {
>> +             pr_err("Cluster %d CPU%d boots multiple times\n", cluster, cpu);
>> +             BUG();
>> +     }
>> +     spin_unlock(&boot_lock);
>> +
>> +     v7_exit_coherency_flush(louis);
>> +
>> +     __mcpm_cpu_down(cpu, cluster);
>
> What if there is a hip04_mcpm_power_up() being called on another CPU
> right here?  There is a race that I illustrated in a previous email
> which is still unresolved.
>

Thanks for your reminder again. I'll move it into the protection.

>> +
>> +     if (!skip_reset) {
>> +             data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
>> +                    CORE_DEBUG_RESET_BIT(cpu);
>> +             writel_relaxed(data, sysctrl + SC_CPU_RESET_REQ(cluster));
>> +     }
>> +}
>> +
>> +static int hip04_mcpm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
>> +{
>> +     unsigned int data, tries;
>> +
>> +     BUG_ON(cluster >= HIP04_MAX_CLUSTERS ||
>> +            cpu >= HIP04_MAX_CPUS_PER_CLUSTER);
>> +
>> +     for (tries = 0; tries < TIMEOUT_MSEC / POLL_MSEC; tries++) {
>> +             data = readl_relaxed(sysctrl + SC_CPU_RESET_STATUS(cluster));
>> +             if (!(data & CORE_RESET_STATUS(cpu))) {
>> +                     msleep(POLL_MSEC);
>> +                     continue;
>> +             }
>> +             return 0;
>> +     }
>> +     return -ETIMEDOUT;
>> +}
>> +
>> +static void hip04_mcpm_powered_up(void)
>> +{
>> +     if (!relocation)
>> +             return;
>> +     spin_lock(&boot_lock);
>> +     writel_relaxed(0, relocation);
>> +     writel_relaxed(0, relocation + 4);
>> +     writel_relaxed(0, relocation + 8);
>> +     writel_relaxed(0, relocation + 12);
>> +     spin_unlock(&boot_lock);
>> +}
>> +
>> +static void __naked hip04_mcpm_power_up_setup(unsigned int affinity_level)
>> +{
>> +     asm volatile ("                 \n"
>> +     /* calculate fabric phys address */
>> +"    adr     r2, 2f                  \n"
>> +"    ldmia   r2, {r1, r3}            \n"
>> +"    sub     r0, r2, r1              \n"
>> +"    add     r2, r0, r3              \n"
>> +"    ldr     r2, [r2]                \n"
>
> You may replace the above 2 instructions with "ldr r2, [r0, r3]".
>
OK.

>> +     /* get cluster id from MPIDR */
>> +"    mrc     p15, 0, r0, c0, c0, 5   \n"
>> +"    ubfx    r1, r0, #8, #8          \n"
>> +"    and     r1, r1, #0xf            \n"
>
> You don't need the "and" here.  It is implicit in ubfx.
>
OK.

>> +     /* 1 << cluster id */
>> +"    mov     r0, #1                  \n"
>> +"    mov     r3, r0, lsl r1          \n"
>> +"    ldr     r0, [r2, #"__stringify(FAB_SF_MODE)"]   \n"
>> +"    tst     r0, r3                  \n"
>> +"    bxne    lr                      \n"
>
> Instead of running all this code all the time, you could simply test r0
> at the very beginning and if it is not equal to 1 then return
> immediately. If it is 1 that means the CPU executing this code is the
> first one to run in the cluster, in which case you also don't have to
> test if the cluster snoop is already enabled here.
>

Since I need to enable the cluster snoop for cluster 0. At this time,
it's not enabled although core0 is running.

>> +"    orr     r1, r0, r3              \n"
>> +"    str     r1, [r2, #"__stringify(FAB_SF_MODE)"]   \n"
>> +"1:  ldr     r0, [r2, #"__stringify(FAB_SF_MODE)"]   \n"
>> +"    tst     r0, r3                  \n"
>> +"    beq     1b                      \n"
>> +"    bx      lr                      \n"
>> +
>> +"    .align  2                       \n"
>> +"2:  .word   .                       \n"
>> +"    .word   fabric_phys_addr        \n"
>> +     );
>> +}
>
> Of course you will also have to enable the snoops for the current
> cluster in hip04_cpu_table_init() as well.

It means that I need to reserve the copy to enable the snoop in c code
for cluster 0. Is it right?

>
>
>> +
>> +static const struct mcpm_platform_ops hip04_mcpm_ops = {
>> +     .power_up               = hip04_mcpm_power_up,
>> +     .power_down             = hip04_mcpm_power_down,
>> +     .wait_for_powerdown     = hip04_mcpm_wait_for_powerdown,
>> +     .powered_up             = hip04_mcpm_powered_up,
>> +};
>> +
>> +static bool __init hip04_cpu_table_init(void)
>> +{
>> +     unsigned int mpidr, cpu, cluster;
>> +
>> +     mpidr = read_cpuid_mpidr();
>> +     cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> +     cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> +
>> +     if (cluster >= HIP04_MAX_CLUSTERS ||
>> +         cpu >= HIP04_MAX_CPUS_PER_CLUSTER) {
>> +             pr_err("%s: boot CPU is out of bound!\n", __func__);
>> +             return false;
>> +     }
>> +     hip04_cpu_table[cluster][cpu] = 1;
>> +     return true;
>> +}
>> +
>> +static int __init hip04_mcpm_init(void)
>> +{
>> +     struct device_node *np, *np_fab;
>> +     struct resource fab_res;
>> +     int ret = -ENODEV;
>> +
>> +     np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
>> +     if (!np)
>> +             goto err;
>> +     np_fab = of_find_compatible_node(NULL, NULL, "hisilicon,hip04-fabric");
>> +     if (!np_fab)
>> +             goto err;
>> +
>> +     if (of_property_read_u32(np, "bootwrapper-phys",
>> +                              &hip04_boot.bootwrapper_phys)) {
>> +             pr_err("failed to get bootwrapper-phys\n");
>> +             ret = -EINVAL;
>> +             goto err;
>> +     }
>> +     if (of_property_read_u32(np, "bootwrapper-size",
>> +                              &hip04_boot.bootwrapper_size)) {
>> +             pr_err("failed to get bootwrapper-size\n");
>> +             ret = -EINVAL;
>> +             goto err;
>> +     }
>> +     if (of_property_read_u32(np, "bootwrapper-magic",
>> +                              &hip04_boot.bootwrapper_magic)) {
>> +             pr_err("failed to get bootwrapper-magic\n");
>> +             ret = -EINVAL;
>> +             goto err;
>> +     }
>> +     if (of_property_read_u32(np, "relocation-entry",
>> +                              &hip04_boot.relocation_entry)) {
>> +             pr_err("failed to get relocation-entry\n");
>> +             ret = -EINVAL;
>> +             goto err;
>> +     }
>> +     if (of_property_read_u32(np, "relocation-size",
>> +                              &hip04_boot.relocation_size)) {
>> +             pr_err("failed to get relocation-size\n");
>> +             ret = -EINVAL;
>> +             goto err;
>> +     }
>> +
>> +     relocation = ioremap(hip04_boot.relocation_entry,
>> +                          hip04_boot.relocation_size);
>> +     if (!relocation) {
>> +             pr_err("failed to map relocation space\n");
>> +             ret = -ENOMEM;
>> +             goto err;
>> +     }
>> +     sysctrl = of_iomap(np, 0);
>> +     if (!sysctrl) {
>> +             pr_err("failed to get sysctrl base\n");
>> +             ret = -ENOMEM;
>> +             goto err_sysctrl;
>> +     }
>> +     ret = of_address_to_resource(np_fab, 0, &fab_res);
>> +     if (ret) {
>> +             pr_err("failed to get fabric base phys\n");
>> +             goto err_fabric;
>> +     }
>> +     fabric_phys_addr = fab_res.start;
>> +     sync_cache_w(&fabric_phys_addr);
>> +     fabric = of_iomap(np_fab, 0);
>> +     if (!fabric) {
>> +             pr_err("failed to get fabric base\n");
>> +             ret = -ENOMEM;
>> +             goto err_fabric;
>> +     }
>> +
>> +     if (!hip04_cpu_table_init())
>> +             return -EINVAL;
>> +     ret = mcpm_platform_register(&hip04_mcpm_ops);
>> +     if (!ret) {
>> +             mcpm_sync_init(hip04_mcpm_power_up_setup);
>> +             pr_info("HiP04 MCPM initialized\n");
>> +     }
>> +     mcpm_smp_set_ops();
>> +     return ret;
>> +err_fabric:
>> +     iounmap(sysctrl);
>> +err_sysctrl:
>> +     iounmap(relocation);
>> +err:
>> +     return ret;
>> +}
>> +early_initcall(hip04_mcpm_init);
>> --
>> 1.9.1
>>
>>
