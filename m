From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 8 Aug 2014 21:12:55 +0800
Subject: [PATCH v17 2/9] ARM: hisi: enable MCPM implementation
In-Reply-To: <alpine.LFD.2.11.1408071047370.6061@knanqh.ubzr>
References: <1407408695-19626-1-git-send-email-haojian.zhuang@linaro.org>
 <1407408695-19626-3-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1408071047370.6061@knanqh.ubzr>
Message-ID: <CAD6h2NStM9Od9Ds0J7GEqQ93Djh5g6hdo9Hmqk2dkDFaRBp2RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 August 2014 23:29, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 7 Aug 2014, Haojian Zhuang wrote:
>
>> Multiple CPU clusters are used in Hisilicon HiP04 SoC. Now use MCPM
>> framework to manage power on HiP04 SoC.
>>
>> Changelog:
>> v17:
>>   * Parse bootwrapper parameters in DTS file.
>>   * Fix to use msleep() in spinlock region.
>> v16:
>>   * Parse bootwrapper parameters in command line instead.
>> v13:
>>   * Restore power down operation in MCPM.
>>   * Fix disabling snoop filter issue in MCPM.
>> v12:
>>   * Use wfi as power down state in MCPM.
>>   * Remove wait_for_powerdown() in MCPM because wfi is used now.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> This still has issues.
>
>
>
>> ---
>>  arch/arm/mach-hisi/Makefile   |   1 +
>>  arch/arm/mach-hisi/platmcpm.c | 362 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 363 insertions(+)
>>  create mode 100644 arch/arm/mach-hisi/platmcpm.c
>>
>> diff --git a/arch/arm/mach-hisi/Makefile b/arch/arm/mach-hisi/Makefile
>> index ee2506b..d64831e 100644
>> --- a/arch/arm/mach-hisi/Makefile
>> +++ b/arch/arm/mach-hisi/Makefile
>> @@ -3,4 +3,5 @@
>>  #
>>
>>  obj-y        += hisilicon.o
>> +obj-$(CONFIG_MCPM)           += platmcpm.o
>>  obj-$(CONFIG_SMP)            += platsmp.o hotplug.o headsmp.o
>> diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
>> new file mode 100644
>> index 0000000..2eabd52
>> --- /dev/null
>> +++ b/arch/arm/mach-hisi/platmcpm.c
>> @@ -0,0 +1,362 @@
>> +/*
>> + * Copyright (c) 2013-2014 Linaro Ltd.
>> + * Copyright (c) 2013-2014 Hisilicon Limited.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + */
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/memblock.h>
>> +#include <linux/of_address.h>
>> +
>> +#include <asm/cputype.h>
>> +#include <asm/cp15.h>
>> +#include <asm/mcpm.h>
>> +
>> +#include "core.h"
>> +
>> +/* bits definition in SC_CPU_RESET_REQ[x]/SC_CPU_RESET_DREQ[x]
>> + * 1 -- unreset; 0 -- reset
>> + */
>> +#define CORE_RESET_BIT(x)            (1 << x)
>> +#define NEON_RESET_BIT(x)            (1 << (x + 4))
>> +#define CORE_DEBUG_RESET_BIT(x)              (1 << (x + 9))
>> +#define CLUSTER_L2_RESET_BIT         (1 << 8)
>> +#define CLUSTER_DEBUG_RESET_BIT              (1 << 13)
>> +
>> +/*
>> + * bits definition in SC_CPU_RESET_STATUS[x]
>> + * 1 -- reset status; 0 -- unreset status
>> + */
>> +#define CORE_RESET_STATUS(x)         (1 << x)
>> +#define NEON_RESET_STATUS(x)         (1 << (x + 4))
>> +#define CORE_DEBUG_RESET_STATUS(x)   (1 << (x + 9))
>> +#define CLUSTER_L2_RESET_STATUS              (1 << 8)
>> +#define CLUSTER_DEBUG_RESET_STATUS   (1 << 13)
>> +#define CORE_WFI_STATUS(x)           (1 << (x + 16))
>> +#define CORE_WFE_STATUS(x)           (1 << (x + 20))
>> +#define CORE_DEBUG_ACK(x)            (1 << (x + 24))
>> +
>> +#define SC_CPU_RESET_REQ(x)          (0x520 + (x << 3))      /* reset */
>> +#define SC_CPU_RESET_DREQ(x)         (0x524 + (x << 3))      /* unreset */
>> +#define SC_CPU_RESET_STATUS(x)               (0x1520 + (x << 3))
>> +
>> +#define FAB_SF_MODE                  0x0c
>> +#define FAB_SF_INVLD                 0x10
>> +
>> +/* bits definition in FB_SF_INVLD */
>> +#define FB_SF_INVLD_START            (1 << 8)
>> +
>> +#define HIP04_MAX_CLUSTERS           4
>> +#define HIP04_MAX_CPUS_PER_CLUSTER   4
>> +
>> +#define POLL_MSEC    10
>> +#define TIMEOUT_MSEC 1000
>> +
>> +struct hip04_secondary_cpu_data {
>> +     u32     bootwrapper_phys;
>> +     u32     bootwrapper_size;
>> +     u32     bootwrapper_magic;
>> +     u32     relocation_entry;
>> +     u32     relocation_size;
>> +};
>> +
>> +static void __iomem *relocation, *sysctrl, *fabric;
>> +static int hip04_cpu_table[HIP04_MAX_CLUSTERS][HIP04_MAX_CPUS_PER_CLUSTER];
>> +static DEFINE_SPINLOCK(boot_lock);
>> +static u32 fabric_phys_addr;
>> +/*
>> + * [0]: bootwrapper physical address
>> + * [1]: bootwrapper size
>> + * [2]: relocation address
>> + * [3]: relocation size
>> + */
>> +static u32 hip04_boot_method[4];
>> +
>> +static bool hip04_cluster_is_down(unsigned int cluster)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < HIP04_MAX_CPUS_PER_CLUSTER; i++)
>> +             if (hip04_cpu_table[cluster][i])
>> +                     return false;
>> +     return true;
>> +}
>> +
>> +static void hip04_set_snoop_filter(unsigned int cluster, unsigned int on)
>> +{
>> +     unsigned long data;
>> +
>> +     if (!fabric)
>> +             BUG();
>> +     data = readl_relaxed(fabric + FAB_SF_MODE);
>> +     if (on)
>> +             data |= 1 << cluster;
>> +     else
>> +             data &= ~(1 << cluster);
>> +     writel_relaxed(data, fabric + FAB_SF_MODE);
>> +     while (1) {
>> +             if (data == readl_relaxed(fabric + FAB_SF_MODE))
>> +                     break;
>> +     }
>> +     return;
>> +}
>> +
>> +static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
>> +{
>> +     unsigned long data, mask;
>> +
>> +     if (!relocation || !sysctrl)
>> +             return -ENODEV;
>> +     if (cluster >= HIP04_MAX_CLUSTERS || cpu >= HIP04_MAX_CPUS_PER_CLUSTER)
>> +             return -EINVAL;
>> +
>> +     spin_lock_irq(&boot_lock);
>> +
>> +     if (hip04_cpu_table[cluster][cpu])
>> +             goto out;
>> +
>> +     /* Make secondary core out of reset. */
>> +     writel_relaxed(hip04_boot_method[0], relocation);
>> +     writel_relaxed(0xa5a5a5a5, relocation + 4);     /* magic number */
>> +     writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
>> +     writel_relaxed(0, relocation + 12);
>> +
>> +     if (hip04_cluster_is_down(cluster)) {
>> +             data = CLUSTER_DEBUG_RESET_BIT;
>> +             writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
>> +             do {
>> +                     cpu_relax();
>> +                     mask = CLUSTER_DEBUG_RESET_STATUS;
>> +                     data = readl_relaxed(sysctrl + \
>> +                                          SC_CPU_RESET_STATUS(cluster));
>> +             } while (data & mask);
>> +     }
>> +
>> +     data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
>> +            CORE_DEBUG_RESET_BIT(cpu);
>> +     writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
>> +out:
>> +     hip04_cpu_table[cluster][cpu]++;
>> +     spin_unlock_irq(&boot_lock);
>> +
>> +     return 0;
>> +}
>> +
>> +static void hip04_mcpm_power_down(void)
>> +{
>> +     unsigned int mpidr, cpu, cluster;
>> +     bool skip_wfi = false;
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
>> +             skip_wfi = true;
>> +     } else if (hip04_cpu_table[cluster][cpu] > 1) {
>> +             pr_err("Cluster %d CPU%d boots multiple times\n", cluster, cpu);
>> +             BUG();
>> +     }
>> +     spin_unlock(&boot_lock);
>> +
>> +     if (hip04_cluster_is_down(cluster))
>> +             v7_exit_coherency_flush(all);
>> +     else
>> +             v7_exit_coherency_flush(louis);
>
> This is not sufficient.  To be safe, the MCPM cluster state must be
> controlled as well.  And once the cache is flushed, the snoops must be
> disabled as well.  And this should be controlled with the boot_lock
> still held.  In other words here's what it should look like:
>
>         if (hip04_cluster_is_down(cluster) &&
>             __mcpm_outbound_enter_critical(cpu, cluster)) {
>                 spin_unlock(&boot_lock);
>                 v7_exit_coherency_flush(all);
>                 hip04_set_snoop_filter(cluster, 0);
>         } else {
>                 spin_unlock(&boot_lock);
>                 v7_exit_coherency_flush(louis);
>         }
>

I can make cpu online/offline successfully in these two cases.
1. Add msleep() in the end of power_up and move disabling snoop filter at here.
2. Disable snoop filter in wait_for_power_down after target core in WFI status.

Since case #1 isn't good, I choose the #2.

I also got some hisilicon documents. They said that setting target
core to WFI status is required before disabling snoop filter.

>> +
>> +     __mcpm_cpu_down(cpu, cluster);
>> +
>> +     if (!skip_wfi)
>> +             wfi();
>> +}
>> +
>> +static int hip04_mcpm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
>> +{
>> +     unsigned int data, tries, count;
>> +
>> +     BUG_ON(cluster >= HIP04_MAX_CLUSTERS ||
>> +            cpu >= HIP04_MAX_CPUS_PER_CLUSTER);
>> +
>> +     count = TIMEOUT_MSEC / POLL_MSEC;
>> +     spin_lock_irq(&boot_lock);
>> +     for (tries = 0; tries < count; tries++) {
>> +             data = readl_relaxed(sysctrl + SC_CPU_RESET_STATUS(cluster));
>> +             if (!(data & CORE_WFI_STATUS(cpu))) {
>> +                     spin_unlock_irq(&boot_lock);
>> +                     msleep(POLL_MSEC);
>> +                     spin_lock_irq(&boot_lock);
>> +                     continue;
>
> The "continue" is redundant here.
>
I missed "break" in this version. If I got expected value, I should
break current loop.

> Also, as I mentioned in my previous review, you should verify that the
> value of hip04_cpu_table[cluster][cpu] is still 0 everytime the lock is
> taken, and bail out (with -EBUSY in that case instead of -ETIMEOUT) if
> not.  I'd do it first thing in the loop.
>

OK
>> +             }
>> +     }
>> +     if (tries >= count)
>> +             goto err;
>> +     data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
>> +            CORE_DEBUG_RESET_BIT(cpu);
>> +     writel_relaxed(data, sysctrl + SC_CPU_RESET_REQ(cluster));
>> +     for (tries = 0; tries < count; tries++) {
>> +             data = readl_relaxed(sysctrl + SC_CPU_RESET_STATUS(cluster));
>> +             if (!(data & CORE_RESET_STATUS(cpu))) {
>> +                     spin_unlock_irq(&boot_lock);
>> +                     msleep(POLL_MSEC);
>> +                     spin_lock_irq(&boot_lock);
>> +                     continue;
>> +             }
>
> Ditto here.
>

OK
>> +     }
>> +     if (tries >= count)
>> +             goto err;
>> +     if (hip04_cluster_is_down(cluster))
>> +             hip04_set_snoop_filter(cluster, 0);
>
> That won't be needed anymore.
>
> Also, I want a comment explaining why the CPU reset is handled in this
> function.  I asked for that and explained why in my previous review as
> well.
>

I must need this at here. All cores in one cluster should be in WFI
status first. Then I could make them in reset mode. At last, I could
disable the snoop filter.

>> +     spin_unlock_irq(&boot_lock);
>> +     return 0;
>> +err:
>> +     spin_unlock_irq(&boot_lock);
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
>
> The value for hip04_cpu_table[cluster][cpu] must be set back to 1
> if it is still 0 here.
>

OK

>> +     spin_unlock(&boot_lock);
>> +}
>> +
>> +static void __naked hip04_mcpm_power_up_setup(unsigned int affinity_level)
>> +{
>> +     asm volatile ("                 \n"
>> +"    cmp     r0, #0                  \n"
>> +"    bxeq    lr                      \n"
>> +     /* calculate fabric phys address */
>> +"    adr     r2, 2f                  \n"
>> +"    ldmia   r2, {r1, r3}            \n"
>> +"    sub     r0, r2, r1              \n"
>> +"    ldr     r2, [r0, r3]            \n"
>> +     /* get cluster id from MPIDR */
>> +"    mrc     p15, 0, r0, c0, c0, 5   \n"
>> +"    ubfx    r1, r0, #8, #8          \n"
>> +     /* 1 << cluster id */
>> +"    mov     r0, #1                  \n"
>> +"    mov     r3, r0, lsl r1          \n"
>> +"    ldr     r0, [r2, #"__stringify(FAB_SF_MODE)"]   \n"
>> +"    tst     r0, r3                  \n"
>> +"    bxne    lr                      \n"
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
>> +     hip04_set_snoop_filter(cluster, 1);
>> +     hip04_cpu_table[cluster][cpu] = 1;
>> +     return true;
>> +}
>> +
>> +static int __init hip04_mcpm_init(void)
>> +{
>> +     struct device_node *np, *np_sctl, *np_fab;
>> +     struct resource fab_res;
>> +     int ret = -ENODEV;
>> +
>> +     np = of_find_compatible_node(NULL, NULL, "hisilicon,hip04-bootwrapper");
>> +     if (!np)
>> +             goto err;
>> +     ret = of_property_read_u32_array(np, "boot-method",
>> +                                      &hip04_boot_method[0], 4);
>> +     if (ret)
>> +             goto err;
>> +     np_sctl = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
>> +     if (!np_sctl)
>> +             goto err;
>> +     np_fab = of_find_compatible_node(NULL, NULL, "hisilicon,hip04-fabric");
>> +     if (!np_fab)
>> +             goto err;
>> +
>> +     ret = memblock_reserve(hip04_boot_method[0], hip04_boot_method[1]);
>> +     if (ret)
>> +             goto err;
>> +
>> +     relocation = ioremap(hip04_boot_method[2], hip04_boot_method[3]);
>> +     if (!relocation) {
>> +             pr_err("failed to map relocation space\n");
>> +             ret = -ENOMEM;
>> +             goto err_reloc;
>> +     }
>> +     sysctrl = of_iomap(np_sctl, 0);
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
>
> Shouldn't you free allocated resources here as well, as you do with
> err_fabric and the others?
>
>> +     ret = mcpm_platform_register(&hip04_mcpm_ops);
>> +     if (!ret) {
>> +             mcpm_sync_init(hip04_mcpm_power_up_setup);
>> +             mcpm_smp_set_ops();
>> +             pr_info("HiP04 MCPM initialized\n");
>> +     }
>> +     return ret;
>
> Same here in case of error.
>
>
>> +err_fabric:
>> +     iounmap(sysctrl);
>> +err_sysctrl:
>> +     iounmap(relocation);
>> +err_reloc:
>> +     memblock_free(hip04_boot_method[0], hip04_boot_method[1]);
>> +err:
>> +     return ret;
>> +}
>> +early_initcall(hip04_mcpm_init);
>> --
>> 1.9.1
>>
>>
