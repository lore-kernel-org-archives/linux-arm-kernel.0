From: pavel@denx.de (Pavel Machek)
Date: Thu, 12 Jul 2012 15:28:09 +0200
Subject: [ACKed PATCH] clocksource: dw_apb_timer: Add common DTS glue for
 dw_apb_timer
In-Reply-To: <alpine.LFD.2.02.1207112307061.32033@ionos>
References: <1342037596-17710-1-git-send-email-dinguyen@altera.com>
 <alpine.LFD.2.02.1207112307061.32033@ionos>
Message-ID: <20120712132809.GD11798@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2012-07-11 23:10:43, Thomas Gleixner wrote:
> On Wed, 11 Jul 2012, dinguyen at altera.com wrote:
> 
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Make a common device tree glue for clocksource/dw_apb_timer.
> > Move mach-picoxcell/time.c to be a generic device tree application
> > of the dw_apb_timer.
> > 
> > Configure mach-picoxcell to use the dw_apb_timer_of device tree
> > implementation in drivers/clocksource.
> > 
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > Acked-by: Jamie Iles <jamie@jamieiles.com>
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Please take it through the proper ARM/SoC tree so work depending on
> that does not get blocked.

Arnd, can you apply this? Or should we create public git tree to pull
from?

Thanks,
								Pavel

---

Make a common device tree glue for clocksource/dw_apb_timer.
Move mach-picoxcell/time.c to be a generic device tree application
of the dw_apb_timer.

Configure mach-picoxcell to use the dw_apb_timer_of device tree
implementation in drivers/clocksource.

Signed-off-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Acked-by: Jamie Iles <jamie@jamieiles.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/devicetree/bindings/rtc/dw-apb.txt   |   25 ++++++++++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/mach-picoxcell/Makefile                   |    1 -
 arch/arm/mach-picoxcell/common.c                   |    3 +-
 arch/arm/mach-picoxcell/common.h                   |    2 +-
 drivers/clocksource/Kconfig                        |    3 ++
 drivers/clocksource/Makefile                       |    1 +
 .../clocksource/dw_apb_timer_of.c                  |   52 ++++++++++++--------
 8 files changed, 64 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/dw-apb.txt
 rename arch/arm/mach-picoxcell/time.c => drivers/clocksource/dw_apb_timer_of.c (57%)

diff --git a/Documentation/devicetree/bindings/rtc/dw-apb.txt b/Documentation/devicetree/bindings/rtc/dw-apb.txt
new file mode 100644
index 0000000..93e2b0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/dw-apb.txt
@@ -0,0 +1,25 @@
+* Designware APB timer
+
+Required properties:
+- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: IRQ line for the timer.
+- clock-frequency: The frequency in HZ of the timer.
+- clock-freq: For backwards compatibility with picoxcell
+
+Example:
+
+		timer1: timer at ffc09000 {
+				compatible = "snps,dw-apb-timer-sp";
+				interrupts = <0 168 4>;
+				clock-frequency = <200000000>;
+				reg = <0xffc09000 0x1000>;
+			};
+
+		timer2: timer at ffd00000 {
+				compatible = "snps,dw-apb-timer-osc";
+				interrupts = <0 169 4>;
+				clock-frequency = <200000000>;
+				reg = <0xffd00000 0x1000>;
+			};
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a91009c..57eb6ef 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -658,6 +658,7 @@ config ARCH_PICOXCELL
 	select ARM_VIC
 	select CPU_V6K
 	select DW_APB_TIMER
+	select DW_APB_TIMER_OF
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_GPIO
 	select HAVE_TCM
diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index e5ec4a8..8e39f80 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -1,2 +1 @@
 obj-y	:= common.o
-obj-y	+= time.o
diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index a2e8ae8..8f9a0b4 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -14,6 +14,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/dw_apb_timer.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/vic.h>
@@ -97,7 +98,7 @@ DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= picoxcell_init_irq,
 	.handle_irq	= vic_handle_irq,
-	.timer		= &picoxcell_timer,
+	.timer		= &dw_apb_timer,
 	.init_machine	= picoxcell_init_machine,
 	.dt_compat	= picoxcell_dt_match,
 	.restart	= picoxcell_wdt_restart,
diff --git a/arch/arm/mach-picoxcell/common.h b/arch/arm/mach-picoxcell/common.h
index 83d55ab..a65cb02 100644
--- a/arch/arm/mach-picoxcell/common.h
+++ b/arch/arm/mach-picoxcell/common.h
@@ -12,6 +12,6 @@
 
 #include <asm/mach/time.h>
 
-extern struct sys_timer picoxcell_timer;
+extern struct sys_timer dw_apb_timer;
 
 #endif /* __PICOXCELL_COMMON_H__ */
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
diff --git a/arch/arm/mach-picoxcell/time.c b/drivers/clocksource/dw_apb_timer_of.c
similarity index 57%
rename from arch/arm/mach-picoxcell/time.c
rename to drivers/clocksource/dw_apb_timer_of.c
index 2ecba67..f7dba5b 100644
--- a/arch/arm/mach-picoxcell/time.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -1,11 +1,20 @@
 /*
+ * Copyright (C) 2012 Altera Corporation
  * Copyright (c) 2011 Picochip Ltd., Jamie Iles
  *
+ * Modified from mach-picoxcell/time.c
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * All enquiries to support at picochip.com
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/dw_apb_timer.h>
 #include <linux/of.h>
@@ -15,8 +24,6 @@
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
 
-#include "common.h"
-
 static void timer_get_base_and_rate(struct device_node *np,
 				    void __iomem **base, u32 *rate)
 {
@@ -25,11 +32,12 @@ static void timer_get_base_and_rate(struct device_node *np,
 	if (!*base)
 		panic("Unable to map regs for %s", np->name);
 
-	if (of_property_read_u32(np, "clock-freq", rate))
-		panic("No clock-freq property for %s", np->name);
+	if (of_property_read_u32(np, "clock-freq", rate) &&
+		of_property_read_u32(np, "clock-frequency", rate))
+		panic("No clock-frequency property for %s", np->name);
 }
 
-static void picoxcell_add_clockevent(struct device_node *event_timer)
+static void add_clockevent(struct device_node *event_timer)
 {
 	void __iomem *iobase;
 	struct dw_apb_clock_event_device *ced;
@@ -49,7 +57,7 @@ static void picoxcell_add_clockevent(struct device_node *event_timer)
 	dw_apb_clockevent_register(ced);
 }
 
-static void picoxcell_add_clocksource(struct device_node *source_timer)
+static void add_clocksource(struct device_node *source_timer)
 {
 	void __iomem *iobase;
 	struct dw_apb_clocksource *cs;
@@ -67,55 +75,57 @@ static void picoxcell_add_clocksource(struct device_node *source_timer)
 
 static void __iomem *sched_io_base;
 
-static u32 picoxcell_read_sched_clock(void)
+static u32 read_sched_clock(void)
 {
 	return __raw_readl(sched_io_base);
 }
 
-static const struct of_device_id picoxcell_rtc_ids[] __initconst = {
+static const struct of_device_id sptimer_ids[] __initconst = {
 	{ .compatible = "picochip,pc3x2-rtc" },
+	{ .compatible = "snps,dw-apb-timer-sp" },
 	{ /* Sentinel */ },
 };
 
-static void picoxcell_init_sched_clock(void)
+static void init_sched_clock(void)
 {
 	struct device_node *sched_timer;
 	u32 rate;
 
-	sched_timer = of_find_matching_node(NULL, picoxcell_rtc_ids);
+	sched_timer = of_find_matching_node(NULL, sptimer_ids);
 	if (!sched_timer)
 		panic("No RTC for sched clock to use");
 
 	timer_get_base_and_rate(sched_timer, &sched_io_base, &rate);
 	of_node_put(sched_timer);
 
-	setup_sched_clock(picoxcell_read_sched_clock, 32, rate);
+	setup_sched_clock(read_sched_clock, 32, rate);
 }
 
-static const struct of_device_id picoxcell_timer_ids[] __initconst = {
+static const struct of_device_id osctimer_ids[] __initconst = {
 	{ .compatible = "picochip,pc3x2-timer" },
+	{ .compatible = "snps,dw-apb-timer-osc" },
 	{},
 };
 
-static void __init picoxcell_timer_init(void)
+static void __init timer_init(void)
 {
 	struct device_node *event_timer, *source_timer;
 
-	event_timer = of_find_matching_node(NULL, picoxcell_timer_ids);
+	event_timer = of_find_matching_node(NULL, osctimer_ids);
 	if (!event_timer)
 		panic("No timer for clockevent");
-	picoxcell_add_clockevent(event_timer);
+	add_clockevent(event_timer);
 
-	source_timer = of_find_matching_node(event_timer, picoxcell_timer_ids);
+	source_timer = of_find_matching_node(event_timer, osctimer_ids);
 	if (!source_timer)
 		panic("No timer for clocksource");
-	picoxcell_add_clocksource(source_timer);
+	add_clocksource(source_timer);
 
 	of_node_put(source_timer);
 
-	picoxcell_init_sched_clock();
+	init_sched_clock();
 }
 
-struct sys_timer picoxcell_timer = {
-	.init = picoxcell_timer_init,
+struct sys_timer dw_apb_timer = {
+	.init = timer_init,
 };
-- 
1.7.9.5







-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
