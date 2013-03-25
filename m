From: monstr@monstr.eu (Michal Simek)
Date: Mon, 25 Mar 2013 15:27:57 +0100
Subject: [PATCH 3/3] ARM: zynq: add SMP support
In-Reply-To: <1364043450-18700-4-git-send-email-s.trumtrar@pengutronix.de>
References: <1364043450-18700-1-git-send-email-s.trumtrar@pengutronix.de>
 <1364043450-18700-4-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <CAHTX3d+DiWx=qfh5St9no4HFduiLJJyRzh8+dYP+scq0uGTJdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/23 Steffen Trumtrar <s.trumtrar@pengutronix.de>:
> The Zynq7000 has a CortexA9 with at least 2 cores. Add support to boot them all.
> To do this a trampoline is needed. At runtime the jump address and two
> instructions are copied to RAM by CPU0 and then executed by CPU1.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi |  14 +++++
>  arch/arm/mach-zynq/Makefile      |   2 +
>  arch/arm/mach-zynq/common.c      |   1 +
>  arch/arm/mach-zynq/common.h      |  14 +++++
>  arch/arm/mach-zynq/headsmp.S     |  20 +++++++
>  arch/arm/mach-zynq/platsmp.c     | 110 +++++++++++++++++++++++++++++++++++++++
>  6 files changed, 161 insertions(+)
>  create mode 100644 arch/arm/mach-zynq/headsmp.S
>  create mode 100644 arch/arm/mach-zynq/platsmp.c
>
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index c103082..258b6c9 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -15,6 +15,20 @@
>  / {
>         compatible = "xlnx,zynq-7000";
>
> +       cpus {
> +               cpu at 0 {
> +                       compatible = "arm,cortex-a9";
> +                       next-level-cache = <&L2>;
> +                       clocks = <&armpll 0>;
> +               };
> +
> +               cpu at 1 {
> +                       compatible = "arm,cortex-a9";
> +                       next-level-cache = <&L2>;
> +                       clocks = <&armpll 0>;
> +               };
> +       };

Is this really needed?

> +
>         amba {
>                 compatible = "simple-bus";
>                 #address-cells = <1>;
> diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
> index 397268c..906d199 100644
> --- a/arch/arm/mach-zynq/Makefile
> +++ b/arch/arm/mach-zynq/Makefile
> @@ -4,3 +4,5 @@
>
>  # Common support
>  obj-y                          := common.o timer.o
> +AFLAGS_headsmp.o :=-Wa,-march=armv7-a
> +obj-$(CONFIG_SMP) += headsmp.o platsmp.o
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 1b9bb3d..4053962 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -117,6 +117,7 @@ static const char *xilinx_dt_match[] = {
>  };
>
>  MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
> +       .smp            = smp_ops(zynq_smp_ops),
>         .map_io         = xilinx_map_io,
>         .init_irq       = xilinx_irqchip_init,
>         .init_machine   = xilinx_init_machine,
> diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
> index 8b4dbba..451d386 100644
> --- a/arch/arm/mach-zynq/common.h
> +++ b/arch/arm/mach-zynq/common.h
> @@ -19,4 +19,18 @@
>
>  void __init xttcps_timer_init(void);
>
> +#ifdef CONFIG_SMP
> +extern void secondary_startup(void);
> +extern char secondary_trampoline, secondary_trampoline_end;
> +#endif
> +
> +extern struct smp_operations __initdata zynq_smp_ops;
> +extern void __iomem *slcr_base_addr;
> +extern void __iomem *scu_base;
> +
> +#define SLCR_UNLOCK_MAGIC      0xdf0d
> +
> +#define SLCR_UNLOCK            0x8
> +#define SLCR_A9_CPU_RST_CTRL   0x244

As previous code.

> +
>  #endif
> diff --git a/arch/arm/mach-zynq/headsmp.S b/arch/arm/mach-zynq/headsmp.S
> new file mode 100644
> index 0000000..145bbae
> --- /dev/null
> +++ b/arch/arm/mach-zynq/headsmp.S
> @@ -0,0 +1,20 @@
> +/*
> + *  Copyright (c) 2013 Steffen Trumtrar <s.trumtrar@pengutronix.de>
> + *
> + * based on mach-socfpga/headsmp.S
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/linkage.h>
> +#include <linux/init.h>
> +
> +       __CPUINIT
> +       .arch   armv7-a
> +
> +ENTRY(secondary_trampoline)
> +       ldr     r0, [pc]
> +       mov     pc, r0

This code is familiar to me. It looks like my jump trampoline which I
wrote in C. :-)

> +
> +ENTRY(secondary_trampoline_end)
> diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
> new file mode 100644
> index 0000000..1ea3d4f
> --- /dev/null
> +++ b/arch/arm/mach-zynq/platsmp.c
> @@ -0,0 +1,110 @@
> +/*
> + * Copyright (c) 2013 Steffen Trumtrar <s.trumtrar@pengutronix.de>
> + *
> + * based on
> + *  linux/arch/arm/mach-zynq/platsmp.c Copyright (C) 2011 Xilinx
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/irqchip/arm-gic.h>
> +#include <linux/io.h>
> +#include <linux/jiffies.h>
> +#include <linux/smp.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/smp_scu.h>
> +
> +#include "common.h"
> +
> +#define A9_RST_MASK    (1 << 0)
> +#define A9_CLKSTOP_MASK        (1 << 4)

as I wrote above moving to separate driver make sense to me.

> +
> +static DEFINE_SPINLOCK(boot_lock);
> +
> +static void __cpuinit zynq_smp_secondary_init(unsigned int cpu)
> +{
> +       /*
> +        * if any interrupts are already enabled for the primary
> +        * core (e.g. timer irq), then they will not have been enabled
> +        * for us: do so
> +        */
> +       gic_secondary_init(0);
> +
> +       /*
> +        * Synchronise with the boot thread.
> +        */
> +       spin_lock(&boot_lock);
> +       spin_unlock(&boot_lock);
> +}
> +
> +static inline void zynq_set_cpu_jump(int cpu, void *jump_addr)
> +{
> +       if (jump_addr) {

This is wrong because if jump_addr is 0x1 - 0xF then you are rewriting.
It is unlikely but it should be captured.
The main reason is AMP solution where Linux can't be added from 0x0
and user amp code can setup any entry point. Better to check it just for sure.

> +               int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
> +
> +               writel(virt_to_phys(jump_addr), phys_to_virt(8));

This will probably generate sparse warning.

> +               memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);

This is nice solution. I am hardcoding instruction and this looks like
good solution.
Let me do some experiment with it because maybe this could be
problematic when Linux
kernel starts from different address than 0x0.

> +
> +               flush_cache_all();
> +               outer_flush_all();
> +               smp_wmb();
> +       }
> +}
> +
> +static void zynq_enable_cpu(int cpu, bool enable)
> +{
> +       writel(A9_CLKSTOP_MASK << cpu, slcr_base_addr + SLCR_A9_CPU_RST_CTRL);
> +       writel(0, slcr_base_addr + SLCR_A9_CPU_RST_CTRL);
> +}
> +
> +int __cpuinit zynq_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +       writel(SLCR_UNLOCK_MAGIC, slcr_base_addr + SLCR_UNLOCK);
> +       writel((A9_CLKSTOP_MASK | A9_RST_MASK) << cpu,
> +               slcr_base_addr + SLCR_A9_CPU_RST_CTRL);
> +
> +       zynq_set_cpu_jump(cpu, secondary_startup);
> +       zynq_enable_cpu(cpu, true);
> +
> +       return 0;
> +}
> +
> +/*
> + * Initialise the CPU possible map early - this describes the CPUs
> + * which may be present or become present in the system.
> + */
> +static void __init zynq_smp_init_cpus(void)
> +{
> +       unsigned int ncores, i;
> +
> +       ncores = scu_get_core_count(scu_base);
> +
> +       for (i = 0; i < ncores; ++i)
> +               set_cpu_possible(i, true);
> +
> +       /* sanity check */
> +       if (ncores > num_possible_cpus()) {
> +               pr_warn("zynq: no. of cores (%d) greater than configured"
> +                       "maximum of %d - clipping\n", ncores, num_possible_cpus());
> +               ncores = num_possible_cpus();
> +       }

Is this necessary?
IRC: There is checking in smp_prepare_cpus in arch/arm/kernel/smp.c for it.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
