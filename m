From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 5 Aug 2014 08:07:47 +0800
Subject: [PATCH v16 2/9] ARM: hisi: enable MCPM implementation
In-Reply-To: <alpine.LFD.2.11.1408041741460.6061@knanqh.ubzr>
References: <1407121088-4151-1-git-send-email-haojian.zhuang@linaro.org>
 <1407121088-4151-3-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1408041741460.6061@knanqh.ubzr>
Message-ID: <CAD6h2NTFJ0qBdymhQ1bEaKpCTQT13r2-F9HRDw9SdSS31Zer8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 August 2014 06:43, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> Sorry for the delay -- I was on vacation.
>
> On Mon, 4 Aug 2014, Haojian Zhuang wrote:
>
>> Multiple CPU clusters are used in Hisilicon HiP04 SoC. Now use MCPM
>> framework to manage power on HiP04 SoC.
>>
>> Changelog:
>> v16:
>>   * Parse bootwrapper parameters in command line instead.
>
> What is that about?  I don't particularly like to see bootloader
> handshake details passed to the kernel via the kernel command line
> mechanism.  Given this looks like special memory regions, can't they be
> specified via the device tree instead?
>

Others don't agree put them into DTS file. So I move them into command line.

>> v13:
>>   * Restore power down operation in MCPM.
>>   * Fix disabling snoop filter issue in MCPM.
>> v12:
>>   * Use wfi as power down state in MCPM.
>>   * Remove wait_for_powerdown() in MCPM because wfi is used now.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> More comments below.
>
>> ---
>>  arch/arm/mach-hisi/Makefile   |   1 +
>>  arch/arm/mach-hisi/platmcpm.c | 374 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 375 insertions(+)
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
>> index 0000000..fc17973
>> --- /dev/null
>> +++ b/arch/arm/mach-hisi/platmcpm.c
>> @@ -0,0 +1,374 @@
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
>> +static struct hip04_secondary_cpu_data hip04_boot;
>> +static u32 fabric_phys_addr;
>> +
>> +static int __init hip04_parse_bootwrapper(char *p)
>> +{
>> +     int data[4];
>> +
>> +     get_options(p, ARRAY_SIZE(data), &data[0]);
>> +     if (!data[0] || (data[0] < 3)) {
>> +             pr_err("fail to parse bootwrapper parameters\n");
>> +             return -EINVAL;
>> +     }
>> +     hip04_boot.bootwrapper_phys = data[1];
>> +     hip04_boot.bootwrapper_size = data[2];
>> +     hip04_boot.bootwrapper_magic = data[3];
>> +     memblock_reserve(data[1], data[2]);
>
> What if memblock_reserve() fails? You should at least avoid initializing
> hip04_boot in that case.
>

OK. I'll check the return value.

>> +     return 0;
>> +}
>> +early_param("bootwrapper", hip04_parse_bootwrapper);
>> +
>> +static int __init hip04_parse_relocation(char *p)
>> +{
>> +     int data[3];
>> +
>> +     get_options(p, ARRAY_SIZE(data), &data[0]);
>> +     if (!data[0] || (data[0] < 2)) {
>> +             pr_err("fail to parse relocation parameters\n");
>> +             return -EINVAL;
>> +     }
>> +     hip04_boot.relocation_entry = data[1];
>> +     hip04_boot.relocation_size = data[2];
>> +     return 0;
>> +}
>> +early_param("relocation", hip04_parse_relocation);
>> +
>> +static bool hip04_cluster_down(unsigned int cluster)
>
> I'd suggest renaming this into hip04_cluster_is_down() as it only
> returns a state and performs no action.
>

OK.

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
>> +     writel_relaxed(hip04_boot.bootwrapper_phys, relocation);
>> +     writel_relaxed(hip04_boot.bootwrapper_magic, relocation + 4);
>> +     writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
>> +     writel_relaxed(0, relocation + 12);
>> +
>> +     if (hip04_cluster_down(cluster)) {
>> +             data = CLUSTER_DEBUG_RESET_BIT;
>> +             writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
>> +             do {
>
> Inserting a cpu_relax() right here wouldn't hurt.
>

OK
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
>> +     v7_exit_coherency_flush(louis);
>
> If this is the last man, the whole cache must be flushed with
> v7_exit_coherency_flush(all).
>

OK
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
>> +     spin_lock(&boot_lock);
>> +     for (tries = 0; tries < count; tries++) {
>> +             data = readl_relaxed(sysctrl + SC_CPU_RESET_STATUS(cluster));
>> +             if (!(data & CORE_WFI_STATUS(cpu))) {
>> +                     msleep(POLL_MSEC);
>
> You can't sleep while holding a lock.
>
Yes, I'll fix it.

>> +                     continue;
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
>> +                     msleep(POLL_MSEC);
>
> Same here.
>
> Also I don't really like the way this MCPM method is abused to shut down
> a CPU because the target CPU can't do it on its own.  We're getting back
> to this again and I suppose this is because the hardware is not able to
> do otherwise.  However this mysterious CORE_WFI_STATUS bit made its
> apparition lately, so one may speculate that the hardware might be able
> to do more than it may seem. The lack of (english) documentation is
> really making a more optimal implementation impossible at this point. So
> I'll give in and let this pass but not without a sufficiently
> comprehensive comment in the code to that effect.
>
> Now... around msleep calls you have to drop and reacquire the lock.
> And when the lock is reacquired you should check that the CPU count is
> still 0 and bail out otherwise so not to mess up with a concurrent
> cpu_up().  This won't be enough to prevent a race against asynchronous
> wake-ups though, but you are not doing any of that yet.  That too would
> need to be documented in that comment.
>
>> +                     continue;
>> +             }
>> +     }
>> +     if (tries >= count)
>> +             goto err;
>> +     if (hip04_cluster_down(cluster))
>> +             hip04_set_snoop_filter(cluster, 0);
>> +     spin_unlock(&boot_lock);
>
> Oh, and that ought to be spin_lock_irq()/spin_unlock_irq() here.
>
>> +     return 0;
>> +err:
>> +     spin_unlock(&boot_lock);
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
>> +     hip04_set_snoop_filter(0, 1);
>
> This should be hip04_set_snoop_filter(cluster, 1).
>
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
>> +     if (!hip04_boot.bootwrapper_phys || !hip04_boot.relocation_entry) {
>> +             pr_err("fail to find bootwrapper or relocation param\n");
>> +             ret = -EINVAL;
>> +             goto err;
>> +     }
>> +
>> +     np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
>> +     if (!np)
>> +             goto err;
>> +     np_fab = of_find_compatible_node(NULL, NULL, "hisilicon,hip04-fabric");
>> +     if (!np_fab)
>> +             goto err;
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
>
> This mcpm_smp_set_ops() should be called only if MCPM registration is
> successful i.e. right after mcpm_sync_init inside the if conditional
> above.
>

OK

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
