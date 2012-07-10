From: pavel@denx.de (Pavel Machek)
Date: Tue, 10 Jul 2012 11:42:50 +0200
Subject: Move designware timer OF glue into drivers/clocksource
Message-ID: <20120710094249.GF10225@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

It seems mach-socfpga (not yet in tree, we are trying to merge it)
would need pretty much direct copy of arch/arm/mach-picoxcell/time.c
... And because "just copying" it seems like quite bad idea, what
about this, instead?

Signed-off-by: Pavel Machek <pavel@denx.de>

commit cf46b65003e13e09700401b2a96dcc07ecf20b07
Author: Pavel <pavel@ucw.cz>
Date:   Tue Jul 10 11:41:13 2012 +0200

diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index 7a06224..fde4952 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -68,28 +68,28 @@
 			};
 			
 		timer0: timer at ffc08000 {
-				compatible = "socfpga,sp-timer";
+				compatible = "snps,dw-apb-timer-sp";
 				interrupts = <0 167 4>;
 				clock-freq = <200000000>;
 				reg = <0xffc08000 0x1000>;
 			};
 
 		timer1: timer at ffc09000 {
-				compatible = "socfpga,sp-timer";
+				compatible = "snps,dw-apb-timer-sp";
 				interrupts = <0 168 4>;
 				clock-freq = <200000000>;
 				reg = <0xffc09000 0x1000>;
 			};
 			
 		timer2: timer at ffd00000 {
-				compatible = "socfpga,osc-timer";
+				compatible = "snps,dw-apb-timer-osc";
 				interrupts = <0 169 4>;
 				clock-freq = <200000000>;
 				reg = <0xffd00000 0x1000>;
 			};
 
 		timer3: timer at ffd01000 {
-				compatible = "socfpga,osc-timer";
+				compatible = "snps,dw-apb-timer-osc";
 				interrupts = <0 170 4>;
 				clock-freq = <200000000>;
 				reg = <0xffd01000 0x1000>;
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 62b6bae..75e7ebe 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -2,6 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-obj-y					:= common.o time.o
+obj-y					:= common.o ../../../drivers/clocksource/dw_apb_timer_of.o
 obj-$(CONFIG_MACH_SOCFPGA_CYCLONE5)	+= socfpga_cyclone5.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
diff --git a/arch/arm/mach-socfpga/common.h b/arch/arm/mach-socfpga/common.h
index 7948f74..4a0f596 100644
--- a/arch/arm/mach-socfpga/common.h
+++ b/arch/arm/mach-socfpga/common.h
@@ -23,6 +23,6 @@
 struct machine_desc;
 
 extern void socfpga_init_early(void);
-extern struct sys_timer socfpga_timer;
+extern struct sys_timer dw_apb_timer;
 
 #endif
diff --git a/arch/arm/mach-socfpga/socfpga_cyclone5.c b/arch/arm/mach-socfpga/socfpga_cyclone5.c
index 7d5a4fa..500ded7 100644
--- a/arch/arm/mach-socfpga/socfpga_cyclone5.c
+++ b/arch/arm/mach-socfpga/socfpga_cyclone5.c
@@ -129,7 +129,7 @@ DT_MACHINE_START(SOCFPGA_CYCLONE5, "Altera SOCFPGA Cyclone V")
 	.init_early	= socfpga_init_early,
 	.init_irq	= gic_init_irq,
 	.handle_irq     = gic_handle_irq,
-	.timer		= &socfpga_timer,
+	.timer		= &dw_apb_timer,
 	.init_machine	= socfpga_cyclone5_init,
 	.restart	= socfpga_cyclone5_restart,
 	.dt_compat	= altera_dt_match,
diff --git a/arch/arm/mach-socfpga/time.c b/arch/arm/mach-socfpga/time.c
deleted file mode 100644
index b9c6415..0000000
--- a/arch/arm/mach-socfpga/time.c
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- * Copyright (C) 2012 Altera Corporation
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * Modified from mach-picoxcell/time.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#include <linux/dw_apb_timer.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-
-#include <asm/mach/time.h>
-#include <asm/sched_clock.h>
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
-static void socfpga_add_clockevent(struct device_node *event_timer)
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
-static void socfpga_add_clocksource(struct device_node *source_timer)
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
-static u32 socfpga_read_sched_clock(void)
-{
-	return __raw_readl(sched_io_base);
-}
-
-static const struct of_device_id socfpga_sptimer_ids[] __initconst = {
-	{ .compatible = "socfpga,sp-timer" },
-	{ /* Sentinel */ },
-};
-
-static void socfpga_init_sched_clock(void)
-{
-	struct device_node *sched_timer;
-	u32 rate;
-
-	sched_timer = of_find_matching_node(NULL, socfpga_sptimer_ids);
-	if (!sched_timer)
-		panic("No RTC for sched clock to use");
-
-	timer_get_base_and_rate(sched_timer, &sched_io_base, &rate);
-	of_node_put(sched_timer);
-
-	setup_sched_clock(socfpga_read_sched_clock, 32, rate);
-}
-
-static const struct of_device_id socfpga_osctimer_ids[] __initconst = {
-	{ .compatible = "socfpga,osc-timer" },
-	{},
-};
-
-static void __init socfpga_timer_init(void)
-{
-	struct device_node *event_timer, *source_timer;
-
-	event_timer = of_find_matching_node(NULL, socfpga_osctimer_ids);
-	if (!event_timer)
-		panic("No timer for clockevent");
-	socfpga_add_clockevent(event_timer);
-
-	source_timer = of_find_matching_node(event_timer, socfpga_osctimer_ids);
-	if (!source_timer)
-		panic("No timer for clocksource");
-	socfpga_add_clocksource(source_timer);
-
-	of_node_put(source_timer);
-
-	socfpga_init_sched_clock();
-}
-
-struct sys_timer socfpga_timer = {
-	.init = socfpga_timer_init,
-};
diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
new file mode 100644
index 0000000..83bd997
--- /dev/null
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -0,0 +1,128 @@
+/*
+ * Copyright (C) 2012 Altera Corporation
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * Modified from mach-picoxcell/time.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/dw_apb_timer.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <asm/mach/time.h>
+#include <asm/sched_clock.h>
+
+static void timer_get_base_and_rate(struct device_node *np,
+				    void __iomem **base, u32 *rate)
+{
+	*base = of_iomap(np, 0);
+
+	if (!*base)
+		panic("Unable to map regs for %s", np->name);
+
+	if (of_property_read_u32(np, "clock-freq", rate))
+		panic("No clock-freq property for %s", np->name);
+}
+
+static void add_clockevent(struct device_node *event_timer)
+{
+	void __iomem *iobase;
+	struct dw_apb_clock_event_device *ced;
+	u32 irq, rate;
+
+	irq = irq_of_parse_and_map(event_timer, 0);
+	if (irq == NO_IRQ)
+		panic("No IRQ for clock event timer");
+
+	timer_get_base_and_rate(event_timer, &iobase, &rate);
+
+	ced = dw_apb_clockevent_init(0, event_timer->name, 300, iobase, irq,
+				     rate);
+	if (!ced)
+		panic("Unable to initialise clockevent device");
+
+	dw_apb_clockevent_register(ced);
+}
+
+static void add_clocksource(struct device_node *source_timer)
+{
+	void __iomem *iobase;
+	struct dw_apb_clocksource *cs;
+	u32 rate;
+
+	timer_get_base_and_rate(source_timer, &iobase, &rate);
+
+	cs = dw_apb_clocksource_init(300, source_timer->name, iobase, rate);
+	if (!cs)
+		panic("Unable to initialise clocksource device");
+
+	dw_apb_clocksource_start(cs);
+	dw_apb_clocksource_register(cs);
+}
+
+static void __iomem *sched_io_base;
+
+static u32 read_sched_clock(void)
+{
+	return __raw_readl(sched_io_base);
+}
+
+static const struct of_device_id sptimer_ids[] __initconst = {
+	{ .compatible = "snps,dw-apb-timer-sp" },
+	{ /* Sentinel */ },
+};
+
+static void init_sched_clock(void)
+{
+	struct device_node *sched_timer;
+	u32 rate;
+
+	sched_timer = of_find_matching_node(NULL, sptimer_ids);
+	if (!sched_timer)
+		panic("No RTC for sched clock to use");
+
+	timer_get_base_and_rate(sched_timer, &sched_io_base, &rate);
+	of_node_put(sched_timer);
+
+	setup_sched_clock(read_sched_clock, 32, rate);
+}
+
+static const struct of_device_id osctimer_ids[] __initconst = {
+	{ .compatible = "snps,dw-apb-timer-osc" },
+	{},
+};
+
+static void __init timer_init(void)
+{
+	struct device_node *event_timer, *source_timer;
+
+	event_timer = of_find_matching_node(NULL, osctimer_ids);
+	if (!event_timer)
+		panic("No timer for clockevent");
+	add_clockevent(event_timer);
+
+	source_timer = of_find_matching_node(event_timer, osctimer_ids);
+	if (!source_timer)
+		panic("No timer for clocksource");
+	add_clocksource(source_timer);
+
+	of_node_put(source_timer);
+
+	init_sched_clock();
+}
+
+struct sys_timer dw_apb_timer = {
+	.init = timer_init,
+};

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
