From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 12 Nov 2013 16:49:42 +0800
Subject: [PATCH v11 5/6] ARM: hi3xxx: add smp support
In-Reply-To: <527B6BCA.2010606@gmail.com>
References: <1383813691-31587-1-git-send-email-haojian.zhuang@linaro.org>
 <1383813691-31587-6-git-send-email-haojian.zhuang@linaro.org>
 <527B6BCA.2010606@gmail.com>
Message-ID: <CAD6h2NRTc42YAKr6zLdMpiYbpBLatA9HNpZeFa3pZZpvJXBuCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 November 2013 18:30, Dinh Nguyen <dinh.linux@gmail.com> wrote:
>
> On 11/7/13 2:41 AM, Haojian Zhuang wrote:
>> From: Zhangfei Gao <zhangfei.gao@linaro.org>
>>
>> Enable SMP support on hi3xxx platform
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Tested-by: Zhang Mingjun <zhang.mingjun@linaro.org>
>> Tested-by: Li Xin <li.xin@linaro.org>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  .../bindings/arm/hisilicon/hisilicon.txt           | 30 ++++++--
>>  arch/arm/boot/dts/hi3620.dtsi                      | 38 ++++++++++
>>  arch/arm/mach-hi3xxx/Kconfig                       |  3 +
>>  arch/arm/mach-hi3xxx/Makefile                      |  1 +
>>  arch/arm/mach-hi3xxx/core.h                        | 11 +++
>>  arch/arm/mach-hi3xxx/hi3xxx.c                      | 34 +++++++++
>>  arch/arm/mach-hi3xxx/platsmp.c                     | 84 ++++++++++++++++++++++
>>  7 files changed, 197 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/arm/mach-hi3xxx/core.h
>>  create mode 100644 arch/arm/mach-hi3xxx/platsmp.c
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> index 3be60c8..8c7a465 100644
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> @@ -1,10 +1,32 @@
>>  Hisilicon Platforms Device Tree Bindings
>>  ----------------------------------------------------
>>
>> -Hi3716 Development Board
>> -Required root node properties:
>> -     - compatible = "hisilicon,hi3716-dkb";
>> -
>>  Hi4511 Board
>>  Required root node properties:
>>       - compatible = "hisilicon,hi3620-hi4511";
>> +
>> +Hisilicon system controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,sysctrl"
>> +- reg : Register address and size
>> +
>> +Optional properties:
>> +- smp-offset : offset in sysctrl for notifying slave cpu booting
>> +             cpu 1, reg;
>> +             cpu 2, reg + 0x4;
>> +             cpu 3, reg + 0x8;
>> +             If reg value is not zero, cpun exit wfi and go
>> +- resume-offset : offset in sysctrl for notifying cpu0 when resume
>> +- reboot-offset : offset in sysctrl for system reboot
>> +
>> +Example:
>> +
>> +     /* for Hi3620 */
>> +     sysctrl: system-controller at fc802000 {
>> +             compatible = "hisilicon,sysctrl";
>> +             reg = <0xfc802000 0x1000>;
>> +             smp-offset = <0x31c>;
>> +             resume-offset = <0x308>;
>> +             reboot-offset = <0x4>;
>> +     };
>> diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
>> index b9d8679..e311937 100644
>> --- a/arch/arm/boot/dts/hi3620.dtsi
>> +++ b/arch/arm/boot/dts/hi3620.dtsi
>> @@ -39,6 +39,27 @@
>>                       reg = <0x0>;
>>                       next-level-cache = <&L2>;
>>               };
>> +
>> +             cpu at 1 {
>> +                     compatible = "arm,cortex-a9";
>> +                     device_type = "cpu";
>> +                     reg = <1>;
>> +                     next-level-cache = <&L2>;
>> +             };
>> +
>> +             cpu at 2 {
>> +                     compatible = "arm,cortex-a9";
>> +                     device_type = "cpu";
>> +                     reg = <2>;
>> +                     next-level-cache = <&L2>;
>> +             };
>> +
>> +             cpu at 3 {
>> +                     compatible = "arm,cortex-a9";
>> +                     device_type = "cpu";
>> +                     reg = <3>;
>> +                     next-level-cache = <&L2>;
>> +             };
>>       };
>>
>>       amba {
>> @@ -65,6 +86,17 @@
>>                       reg = <0x1000 0x1000>, <0x100 0x100>;
>>               };
>>
>> +             sysctrl: system-controller at 802000 {
>> +                     compatible = "hisilicon,sysctrl";
>> +                     reg = <0x802000 0x1000>;
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +
>> +                     smp-offset = <0x31c>;
>> +                     resume-offset = <0x308>;
>> +                     reboot-offset = <0x4>;
>> +             };
>> +
>>               dual_timer0: dual_timer at 800000 {
>>                       compatible = "arm,sp804", "arm,primecell";
>>                       reg = <0x800000 0x1000>;
>> @@ -115,6 +147,12 @@
>>                       status = "disabled";
>>               };
>>
>> +             timer5: timer at 600 {
>> +                     compatible = "arm,cortex-a9-twd-timer";
>> +                     reg = <0x600 0x20>;
>> +                     interrupts = <1 13 0xf01>;
>> +             };
> Do you have a clocks node for this timer?

As I mentioned in the 0th patch, clock binding are totally removed
in this patch. And clock driver will be append in another patch set.

>> +
>>               uart0: uart at b00000 {
>>                       compatible = "arm,pl011", "arm,primecell";
>>                       reg = <0xb00000 0x1000>;
>> diff --git a/arch/arm/mach-hi3xxx/Kconfig b/arch/arm/mach-hi3xxx/Kconfig
>> index 68bd26c..d0f298a 100644
>> --- a/arch/arm/mach-hi3xxx/Kconfig
>> +++ b/arch/arm/mach-hi3xxx/Kconfig
>> @@ -6,6 +6,9 @@ config ARCH_HI3xxx
>>       select CACHE_L2X0
>>       select CLKSRC_OF
>>       select GENERIC_CLOCKEVENTS
>> +     select HAVE_ARM_SCU
>> +     select HAVE_ARM_TWD
> Need "if SMP" to avoid a build failure for a non-smp kernel.
>

ARCH_HI3xxx always need SMP configuration. HAVE_SMP is already
required. So it's impossible to build a non-smp kernel with this kernel
configuration.

> Dinh
>> +     select HAVE_SMP
>>       select PINCTRL
>>       select PINCTRL_SINGLE
>>       help
>> diff --git a/arch/arm/mach-hi3xxx/Makefile b/arch/arm/mach-hi3xxx/Makefile
>> index d68ebb3..7a869a7 100644
>> --- a/arch/arm/mach-hi3xxx/Makefile
>> +++ b/arch/arm/mach-hi3xxx/Makefile
>> @@ -3,3 +3,4 @@
>>  #
>>
>>  obj-y        += hi3xxx.o
>> +obj-$(CONFIG_SMP)            += platsmp.o
>> diff --git a/arch/arm/mach-hi3xxx/core.h b/arch/arm/mach-hi3xxx/core.h
>> new file mode 100644
>> index 0000000..226f020
>> --- /dev/null
>> +++ b/arch/arm/mach-hi3xxx/core.h
>> @@ -0,0 +1,11 @@
>> +#ifndef __HISILICON_CORE_H
>> +#define __HISILICON_CORE_H
>> +
>> +#include <linux/reboot.h>
>> +
>> +extern void hi3xxx_set_cpu_jump(int cpu, void *jump_addr);
>> +extern int hi3xxx_get_cpu_jump(int cpu);
>> +extern void secondary_startup(void);
>> +extern struct smp_operations hi3xxx_smp_ops;
>> +
>> +#endif
>> diff --git a/arch/arm/mach-hi3xxx/hi3xxx.c b/arch/arm/mach-hi3xxx/hi3xxx.c
>> index 925af13..80990b3 100644
>> --- a/arch/arm/mach-hi3xxx/hi3xxx.c
>> +++ b/arch/arm/mach-hi3xxx/hi3xxx.c
>> @@ -14,11 +14,16 @@
>>  #include <linux/clk-provider.h>
>>  #include <linux/clocksource.h>
>>  #include <linux/irqchip.h>
>> +#include <linux/of_address.h>
>>  #include <linux/of_platform.h>
>>
>> +#include <asm/proc-fns.h>
>> +
>>  #include <asm/mach/arch.h>
>>  #include <asm/mach/map.h>
>>
>> +#include "core.h"
>> +
>>  /*
>>   * This table is only for optimization. Since ioremap() could always share
>>   * the same mapping if it's defined as static IO mapping.
>> @@ -29,6 +34,7 @@
>>   */
>>  static struct map_desc hi3620_io_desc[] __initdata = {
>>       {
>> +             /* sysctrl */
> What's this comment for?
>>               .pfn            = __phys_to_pfn(0xfc802000),
>>               .virtual        = 0xfe802000,
>>               .length         = 0x1000,
>> @@ -48,6 +54,32 @@ static void __init hi3xxx_timer_init(void)
>>       clocksource_of_init();
>>  }
>>
>> +static void hi3xxx_restart(enum reboot_mode mode, const char *cmd)
>> +{
>> +     struct device_node *np;
>> +     void __iomem *base;
>> +     int offset;
>> +
>> +     np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
>> +     if (!np) {
>> +             pr_err("failed to find hisilicon,sysctrl node\n");
>> +             return;
>> +     }
>> +     base = of_iomap(np, 0);
>> +     if (!base) {
>> +             pr_err("failed to map address in hisilicon,sysctrl node\n");
>> +             return;
>> +     }
>> +     if (of_property_read_u32(np, "reboot-offset", &offset) < 0) {
>> +             pr_err("failed to find reboot-offset property\n");
>> +             return;
>> +     }
>> +     writel_relaxed(0xdeadbeef, base + offset);
>> +
>> +     while (1)
>> +             cpu_do_idle();
>> +}
>> +
>>  static const char *hi3xxx_compat[] __initdata = {
>>       "hisilicon,hi3620-hi4511",
>>       NULL,
>> @@ -57,4 +89,6 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
>>       .map_io         = hi3620_map_io,
>>       .init_time      = hi3xxx_timer_init,
>>       .dt_compat      = hi3xxx_compat,
>> +     .smp            = smp_ops(hi3xxx_smp_ops),
>> +     .restart        = hi3xxx_restart,
>>  MACHINE_END
>> diff --git a/arch/arm/mach-hi3xxx/platsmp.c b/arch/arm/mach-hi3xxx/platsmp.c
>> new file mode 100644
>> index 0000000..a4d04c0
>> --- /dev/null
>> +++ b/arch/arm/mach-hi3xxx/platsmp.c
>> @@ -0,0 +1,84 @@
>> +/*
>> + * Copyright (c) 2013 Linaro Ltd.
>> + * Copyright (c) 2013 Hisilicon Limited.
>> + * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + */
>> +#include <linux/smp.h>
>> +#include <linux/io.h>
>> +#include <linux/of_address.h>
>> +
>> +#include <asm/cacheflush.h>
>> +#include <asm/smp_plat.h>
>> +#include <asm/smp_scu.h>
>> +
>> +#include "core.h"
>> +
>> +static void __iomem *ctrl_base = NULL;
>> +
>> +void hi3xxx_set_cpu_jump(int cpu, void *jump_addr)
>> +{
>> +     cpu = cpu_logical_map(cpu);
>> +     if (!cpu || !ctrl_base)
>> +             return;
>> +     writel_relaxed(virt_to_phys(jump_addr), ctrl_base + ((cpu - 1) << 2));
>> +}
>> +
>> +int hi3xxx_get_cpu_jump(int cpu)
>> +{
>> +     cpu = cpu_logical_map(cpu);
>> +     if (!cpu || !ctrl_base)
>> +             return 0;
>> +     return readl_relaxed(ctrl_base + ((cpu - 1 ) << 2));
>> +}
>> +
>> +static void __init hi3xxx_smp_prepare_cpus(unsigned int max_cpus)
>> +{
>> +     struct device_node *np = NULL;
>> +     unsigned long base = 0;
>> +     u32 offset = 0;
>> +     void __iomem *scu_base = NULL;
>> +
>> +     if (scu_a9_has_base()) {
>> +             base = scu_a9_get_base();
>> +             scu_base = ioremap(base, SZ_4K);
>> +             if (!scu_base) {
>> +                     pr_err("ioremap(scu_base) failed\n");
>> +                     return;
>> +             }
>> +             scu_enable(scu_base);
>> +             iounmap(scu_base);
>> +     }
>> +     if (!ctrl_base) {
>> +             np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
>> +             if (!np) {
>> +                     pr_err("failed to find hisilicon,sysctrl node\n");
>> +                     return;
>> +             }
>> +             ctrl_base = of_iomap(np, 0);
>> +             if (!ctrl_base) {
>> +                     pr_err("failed to map address\n");
>> +                     return;
>> +             }
>> +             if (of_property_read_u32(np, "smp-offset", &offset) < 0) {
>> +                     pr_err("failed to find smp-offset property\n");
>> +                     return;
>> +             }
>> +             ctrl_base += offset;
>> +     }
>> +}
>> +
>> +static int hi3xxx_boot_secondary(unsigned int cpu, struct task_struct *idle)
>> +{
>> +     hi3xxx_set_cpu_jump(cpu, secondary_startup);
>> +     arch_send_wakeup_ipi_mask(cpumask_of(cpu));
>> +     return 0;
>> +}
>> +
>> +struct smp_operations hi3xxx_smp_ops __initdata = {
>> +     .smp_prepare_cpus       = hi3xxx_smp_prepare_cpus,
>> +     .smp_boot_secondary     = hi3xxx_boot_secondary,
>> +};
>
