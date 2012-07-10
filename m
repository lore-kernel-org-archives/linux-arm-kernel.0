From: pavel@denx.de (Pavel Machek)
Date: Tue, 10 Jul 2012 20:11:33 +0200
Subject: Move designware timer OF glue into drivers/clocksource
In-Reply-To: <20120710142033.2786c434@skate>
References: <20120710094249.GF10225@elf.ucw.cz> <20120710142033.2786c434@skate>
Message-ID: <20120710181133.GB14804@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2012-07-10 14:20:33, Thomas Petazzoni wrote:
> Le Tue, 10 Jul 2012 11:42:50 +0200,
> Pavel Machek <pavel@denx.de> a ?crit :
> 
> > It seems mach-socfpga (not yet in tree, we are trying to merge it)
> > would need pretty much direct copy of arch/arm/mach-picoxcell/time.c
> > ... And because "just copying" it seems like quite bad idea, what
> > about this, instead?
> 
> Of course, the idea sounds good. A few comments:
> 
>  * Is a new file really needed? Wouldn't it be better to just add a
>    device tree binding to the existing dw_apb_timer driver?

Yes. x86 uses dw_apb_timer, too, and it does not have device tree.

>  * You're moving arch/arm/mach-picoxcell/time.c, but not updating any
>    mach-picoxcell Makefile, so I presume this would break the build.

I may have hand-edited patch too much. Here it is again.

>  * I'm not a big fan of the ../../../drivers/clocksource/...o in your
>    Makefile. What about using an hidden kconfig option in
>    drivers/clocksource/ that gets selected by your architecture, so
>    that the driver gets build? This is typically done for a few other
>    timer drivers in drivers/clocksource already.

Yes, that's what newest version did.

Thanks,
									Pavel

diff --git a/Documentation/devicetree/bindings/rtc/dw-apb.txt b/Documentation/devicetree/bindings/rtc/dw-apb.txt
new file mode 100644
index 0000000..c80c3cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/dw-apb.txt
@@ -0,0 +1,24 @@
+* Designware APB timer
+
+Required properties:
+- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: IRQ line for the timer.
+- clock-freq: The frequency in HZ of the timer.
+
+Example:
+
+		timer1: timer at ffc09000 {
+				compatible = "snps,dw-apb-timer-sp";
+				interrupts = <0 168 4>;
+				clock-freq = <200000000>;
+				reg = <0xffc09000 0x1000>;
+			};
+			
+		timer2: timer at ffd00000 {
+				compatible = "snps,dw-apb-timer-osc";
+				interrupts = <0 169 4>;
+				clock-freq = <200000000>;
+				reg = <0xffd00000 0x1000>;
+			};
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 996dd8b..2b5e3d5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -675,6 +676,7 @@ config ARCH_PICOXCELL
 	select ARM_VIC
 	select CPU_V6K
 	select DW_APB_TIMER
+	select DW_APB_TIMER_OF
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_GPIO
 	select HAVE_TCM
diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index e5ec4a8..2b8fbad 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -1,2 +1,2 @@
 obj-y	:= common.o
-obj-y	+= time.o
+
diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index a2e8ae8..9139884 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -97,7 +97,7 @@ DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= picoxcell_init_irq,
 	.handle_irq	= vic_handle_irq,
-	.timer		= &picoxcell_timer,
+	.timer		= &dw_apb_timer,
 	.init_machine	= picoxcell_init_machine,
 	.dt_compat	= picoxcell_dt_match,
 	.restart	= picoxcell_wdt_restart,
diff --git a/arch/arm/mach-picoxcell/time.c b/arch/arm/mach-picoxcell/time.c
deleted file mode 100644
index 2ecba67..0000000
--- a/arch/arm/mach-picoxcell/time.c
+++ /dev/null
@@ -1,121 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * All enquiries to support at picochip.com
- */
-#include <linux/dw_apb_timer.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-
-#include <asm/mach/time.h>
-#include <asm/sched_clock.h>
-
-#include "common.h"
-
-static void timer_get_base_and_rate(struct device_node *np,
-				    void __iomem **base, u32 *rate)
-{
-	*base = of_iomap(np, 0);
-
-	if (!*base)
-		panic("Unable to map regs for %s", np->name);
-
-	if (of_property_read_u32(np, "clock-freq", rate))
-		panic("No clock-freq property for %s", np->name);
-}
-
-static void picoxcell_add_clockevent(struct device_node *event_timer)
-{
-	void __iomem *iobase;
-	struct dw_apb_clock_event_device *ced;
-	u32 irq, rate;
-
-	irq = irq_of_parse_and_map(event_timer, 0);
-	if (irq == NO_IRQ)
-		panic("No IRQ for clock event timer");
-
-	timer_get_base_and_rate(event_timer, &iobase, &rate);
-
-	ced = dw_apb_clockevent_init(0, event_timer->name, 300, iobase, irq,
-				     rate);
-	if (!ced)
-		panic("Unable to initialise clockevent device");
-
-	dw_apb_clockevent_register(ced);
-}
-
-static void picoxcell_add_clocksource(struct device_node *source_timer)
-{
-	void __iomem *iobase;
-	struct dw_apb_clocksource *cs;
-	u32 rate;
-
-	timer_get_base_and_rate(source_timer, &iobase, &rate);
-
-	cs = dw_apb_clocksource_init(300, source_timer->name, iobase, rate);
-	if (!cs)
-		panic("Unable to initialise clocksource device");
-
-	dw_apb_clocksource_start(cs);
-	dw_apb_clocksource_register(cs);
-}
-
-static void __iomem *sched_io_base;
-
-static u32 picoxcell_read_sched_clock(void)
-{
-	return __raw_readl(sched_io_base);
-}
-
-static const struct of_device_id picoxcell_rtc_ids[] __initconst = {
-	{ .compatible = "picochip,pc3x2-rtc" },
-	{ /* Sentinel */ },
-};
-
-static void picoxcell_init_sched_clock(void)
-{
-	struct device_node *sched_timer;
-	u32 rate;
-
-	sched_timer = of_find_matching_node(NULL, picoxcell_rtc_ids);
-	if (!sched_timer)
-		panic("No RTC for sched clock to use");
-
-	timer_get_base_and_rate(sched_timer, &sched_io_base, &rate);
-	of_node_put(sched_timer);
-
-	setup_sched_clock(picoxcell_read_sched_clock, 32, rate);
-}
-
-static const struct of_device_id picoxcell_timer_ids[] __initconst = {
-	{ .compatible = "picochip,pc3x2-timer" },
-	{},
-};
-
-static void __init picoxcell_timer_init(void)
-{
-	struct device_node *event_timer, *source_timer;
-
-	event_timer = of_find_matching_node(NULL, picoxcell_timer_ids);
-	if (!event_timer)
-		panic("No timer for clockevent");
-	picoxcell_add_clockevent(event_timer);
-
-	source_timer = of_find_matching_node(event_timer, picoxcell_timer_ids);
-	if (!source_timer)
-		panic("No timer for clocksource");
-	picoxcell_add_clocksource(source_timer);
-
-	of_node_put(source_timer);
-
-	picoxcell_init_sched_clock();
-}
-
-struct sys_timer picoxcell_timer = {
-	.init = picoxcell_timer_init,
-};
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 99c6b20..e62bc7e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -16,6 +16,9 @@ config CLKSRC_MMIO
 config DW_APB_TIMER
 	bool
 
+config DW_APB_TIMER_OF
+	bool
+
 config CLKSRC_DBX500_PRCMU
 	bool "Clocksource PRCMU Timer"
 	depends on UX500_SOC_DB8500
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index dd3e661..2cdaf7d 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_EM_TIMER_STI)	+= em_sti.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
+obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
\ No newline at end of file
diff --git a/arch/arm/mach-socfpga/time.c b/drivers/clocksource/dw_apb_timer_of.c
similarity index 72%
rename from arch/arm/mach-socfpga/time.c
rename to drivers/clocksource/dw_apb_timer_of.c
index b9c6415..e89b0ae 100644
--- a/arch/arm/mach-socfpga/time.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -36,7 +36,7 @@ static void timer_get_base_and_rate(struct device_node *np,
 		panic("No clock-freq property for %s", np->name);
 }
 
-static void socfpga_add_clockevent(struct device_node *event_timer)
+static void add_clockevent(struct device_node *event_timer)
 {
 	void __iomem *iobase;
 	struct dw_apb_clock_event_device *ced;
@@ -56,7 +56,7 @@ static void socfpga_add_clockevent(struct device_node *event_timer)
 	dw_apb_clockevent_register(ced);
 }
 
-static void socfpga_add_clocksource(struct device_node *source_timer)
+static void add_clocksource(struct device_node *source_timer)
 {
 	void __iomem *iobase;
 	struct dw_apb_clocksource *cs;
@@ -74,55 +74,57 @@ static void socfpga_add_clocksource(struct device_node *source_timer)
 
 static void __iomem *sched_io_base;
 
-static u32 socfpga_read_sched_clock(void)
+static u32 read_sched_clock(void)
 {
 	return __raw_readl(sched_io_base);
 }
 
-static const struct of_device_id socfpga_sptimer_ids[] __initconst = {
-	{ .compatible = "socfpga,sp-timer" },
+static const struct of_device_id sptimer_ids[] __initconst = {
+	{ .compatible = "snps,dw-apb-timer-sp" },
+	{ .compatible = "picochip,pc3x2-rtc" },
 	{ /* Sentinel */ },
 };
 
-static void socfpga_init_sched_clock(void)
+static void init_sched_clock(void)
 {
 	struct device_node *sched_timer;
 	u32 rate;
 
-	sched_timer = of_find_matching_node(NULL, socfpga_sptimer_ids);
+	sched_timer = of_find_matching_node(NULL, sptimer_ids);
 	if (!sched_timer)
 		panic("No RTC for sched clock to use");
 
 	timer_get_base_and_rate(sched_timer, &sched_io_base, &rate);
 	of_node_put(sched_timer);
 
-	setup_sched_clock(socfpga_read_sched_clock, 32, rate);
+	setup_sched_clock(read_sched_clock, 32, rate);
 }
 
-static const struct of_device_id socfpga_osctimer_ids[] __initconst = {
-	{ .compatible = "socfpga,osc-timer" },
+static const struct of_device_id osctimer_ids[] __initconst = {
+	{ .compatible = "snps,dw-apb-timer-osc" },
+	{ .compatible = "picochip,pc3x2-timer" },
 	{},
 };
 
-static void __init socfpga_timer_init(void)
+static void __init timer_init(void)
 {
 	struct device_node *event_timer, *source_timer;
 
-	event_timer = of_find_matching_node(NULL, socfpga_osctimer_ids);
+	event_timer = of_find_matching_node(NULL, osctimer_ids);
 	if (!event_timer)
 		panic("No timer for clockevent");
-	socfpga_add_clockevent(event_timer);
+	add_clockevent(event_timer);
 
-	source_timer = of_find_matching_node(event_timer, socfpga_osctimer_ids);
+	source_timer = of_find_matching_node(event_timer, osctimer_ids);
 	if (!source_timer)
 		panic("No timer for clocksource");
-	socfpga_add_clocksource(source_timer);
+	add_clocksource(source_timer);
 
 	of_node_put(source_timer);
 
-	socfpga_init_sched_clock();
+	init_sched_clock();
 }
 
-struct sys_timer socfpga_timer = {
-	.init = socfpga_timer_init,
+struct sys_timer dw_apb_timer = {
+	.init = timer_init,
 };


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
