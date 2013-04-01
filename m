From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 17:21:22 -0500
Subject: [PATCH v2 12/13] ARM: move sp804 and integrator timers to
 drivers/clocksource
In-Reply-To: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
Message-ID: <1364854883-5961-13-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move timer-sp and integrator-ap timer code to drivers/clocksource and
update timer-sp.h and arm_timer.h includes.

This adds CLKSRC_OF support for the integrator-ap timer and removes the
use of "arm,timer-primary" and "arm,timer-secondary" aliases. The timer
selection should not be important as all 3 timers are equal capability.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                                   |    6 -
 arch/arm/common/Makefile                           |    1 -
 arch/arm/mach-integrator/Kconfig                   |    1 +
 arch/arm/mach-integrator/integrator_ap.c           |  170 +-----------------
 arch/arm/mach-integrator/integrator_cp.c           |    5 +-
 arch/arm/mach-realview/core.c                      |    5 +-
 arch/arm/mach-versatile/core.c                     |    4 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |    4 +-
 arch/arm/mach-vexpress/v2m.c                       |    4 +-
 drivers/clocksource/Kconfig                        |   12 ++
 drivers/clocksource/Makefile                       |    2 +
 drivers/clocksource/integrator_ap_timer.c          |  189 ++++++++++++++++++++
 .../arm/common => drivers/clocksource}/timer-sp.c  |    6 +-
 .../hardware => include/clocksource}/arm_timer.h   |    4 +-
 include/clocksource/integrator_ap_timer.h          |    7 +
 .../hardware => include/clocksource}/timer-sp.h    |    0
 16 files changed, 226 insertions(+), 194 deletions(-)
 create mode 100644 drivers/clocksource/integrator_ap_timer.c
 rename {arch/arm/common => drivers/clocksource}/timer-sp.c (98%)
 rename {arch/arm/include/asm/hardware => include/clocksource}/arm_timer.h (93%)
 create mode 100644 include/clocksource/integrator_ap_timer.h
 rename {arch/arm/include/asm/hardware => include/clocksource}/timer-sp.h (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 10e3053..982076c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1170,12 +1170,6 @@ config PLAT_PXA
 config PLAT_VERSATILE
 	bool
 
-config ARM_TIMER_SP804
-	bool
-	select CLKSRC_MMIO
-	select CLKSRC_OF if OF
-	select HAVE_SCHED_CLOCK
-
 source arch/arm/mm/Kconfig
 
 config ARM_NR_BANKS
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index dc8dd0d..5a4cc1a 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -10,4 +10,3 @@ obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
 obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
-obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index abeff25..c5e4ff3 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -5,6 +5,7 @@ menu "Integrator Options"
 config ARCH_INTEGRATOR_AP
 	bool "Support Integrator/AP and Integrator/PP2 platforms"
 	select CLKSRC_MMIO
+	select INTEGRATOR_AP_TIMER
 	select MIGHT_HAVE_PCI
 	select SERIAL_AMBA_PL010
 	select SERIAL_AMBA_PL010_CONSOLE
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index ea96144..c364e8e 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -27,8 +27,6 @@
 #include <linux/syscore_ops.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/kmi.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irqchip/versatile-fpga.h>
@@ -41,15 +39,15 @@
 #include <linux/stat.h>
 #include <linux/sys_soc.h>
 #include <linux/termios.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/integrator_ap_timer.h>
 #include <video/vga.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/setup.h>
 #include <asm/param.h>		/* HZ */
 #include <asm/mach-types.h>
-#include <asm/sched_clock.h>
 
 #include <mach/lm.h>
 #include <mach/irqs.h>
@@ -58,7 +56,6 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 #include <asm/mach/pci.h>
-#include <asm/mach/time.h>
 
 #include "common.h"
 
@@ -296,174 +293,12 @@ struct amba_pl010_data ap_uart_data = {
 #define TIMER1_VA_BASE __io_address(INTEGRATOR_TIMER1_BASE)
 #define TIMER2_VA_BASE __io_address(INTEGRATOR_TIMER2_BASE)
 
-static unsigned long timer_reload;
-
-static u32 notrace integrator_read_sched_clock(void)
-{
-	return -readl((void __iomem *) TIMER2_VA_BASE + TIMER_VALUE);
-}
-
-static void integrator_clocksource_init(unsigned long inrate,
-					void __iomem *base)
-{
-	u32 ctrl = TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC;
-	unsigned long rate = inrate;
-
-	if (rate >= 1500000) {
-		rate /= 16;
-		ctrl |= TIMER_CTRL_DIV16;
-	}
-
-	writel(0xffff, base + TIMER_LOAD);
-	writel(ctrl, base + TIMER_CTRL);
-
-	clocksource_mmio_init(base + TIMER_VALUE, "timer2",
-			rate, 200, 16, clocksource_mmio_readl_down);
-	setup_sched_clock(integrator_read_sched_clock, 16, rate);
-}
-
-static void __iomem * clkevt_base;
-
-/*
- * IRQ handler for the timer
- */
-static irqreturn_t integrator_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	/* clear the interrupt */
-	writel(1, clkevt_base + TIMER_INTCLR);
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static void clkevt_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
-{
-	u32 ctrl = readl(clkevt_base + TIMER_CTRL) & ~TIMER_CTRL_ENABLE;
-
-	/* Disable timer */
-	writel(ctrl, clkevt_base + TIMER_CTRL);
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		/* Enable the timer and start the periodic tick */
-		writel(timer_reload, clkevt_base + TIMER_LOAD);
-		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
-		writel(ctrl, clkevt_base + TIMER_CTRL);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* Leave the timer disabled, .set_next_event will enable it */
-		ctrl &= ~TIMER_CTRL_PERIODIC;
-		writel(ctrl, clkevt_base + TIMER_CTRL);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-	default:
-		/* Just leave in disabled state */
-		break;
-	}
-
-}
-
-static int clkevt_set_next_event(unsigned long next, struct clock_event_device *evt)
-{
-	unsigned long ctrl = readl(clkevt_base + TIMER_CTRL);
-
-	writel(ctrl & ~TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
-	writel(next, clkevt_base + TIMER_LOAD);
-	writel(ctrl | TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
-
-	return 0;
-}
-
-static struct clock_event_device integrator_clockevent = {
-	.name		= "timer1",
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= clkevt_set_mode,
-	.set_next_event	= clkevt_set_next_event,
-	.rating		= 300,
-};
-
-static struct irqaction integrator_timer_irq = {
-	.name		= "timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= integrator_timer_interrupt,
-	.dev_id		= &integrator_clockevent,
-};
-
-static void integrator_clockevent_init(unsigned long inrate,
-				void __iomem *base, int irq)
-{
-	unsigned long rate = inrate;
-	unsigned int ctrl = 0;
-
-	clkevt_base = base;
-	/* Calculate and program a divisor */
-	if (rate > 0x100000 * HZ) {
-		rate /= 256;
-		ctrl |= TIMER_CTRL_DIV256;
-	} else if (rate > 0x10000 * HZ) {
-		rate /= 16;
-		ctrl |= TIMER_CTRL_DIV16;
-	}
-	timer_reload = rate / HZ;
-	writel(ctrl, clkevt_base + TIMER_CTRL);
-
-	setup_irq(irq, &integrator_timer_irq);
-	clockevents_config_and_register(&integrator_clockevent,
-					rate,
-					1,
-					0xffffU);
-}
-
 void __init ap_init_early(void)
 {
 }
 
 #ifdef CONFIG_OF
 
-static void __init ap_of_timer_init(void)
-{
-	struct device_node *node;
-	const char *path;
-	void __iomem *base;
-	int err;
-	int irq;
-	struct clk *clk;
-	unsigned long rate;
-
-	clk = clk_get_sys("ap_timer", NULL);
-	BUG_ON(IS_ERR(clk));
-	clk_prepare_enable(clk);
-	rate = clk_get_rate(clk);
-
-	err = of_property_read_string(of_aliases,
-				"arm,timer-primary", &path);
-	if (WARN_ON(err))
-		return;
-	node = of_find_node_by_path(path);
-	base = of_iomap(node, 0);
-	if (WARN_ON(!base))
-		return;
-	writel(0, base + TIMER_CTRL);
-	integrator_clocksource_init(rate, base);
-
-	err = of_property_read_string(of_aliases,
-				"arm,timer-secondary", &path);
-	if (WARN_ON(err))
-		return;
-	node = of_find_node_by_path(path);
-	base = of_iomap(node, 0);
-	if (WARN_ON(!base))
-		return;
-	irq = irq_of_parse_and_map(node, 0);
-	writel(0, base + TIMER_CTRL);
-	integrator_clockevent_init(rate, base, irq);
-}
-
 static const struct of_device_id fpga_irq_of_match[] __initconst = {
 	{ .compatible = "arm,versatile-fpga-irq", .data = fpga_irq_of_init, },
 	{ /* Sentinel */ }
@@ -582,7 +417,6 @@ DT_MACHINE_START(INTEGRATOR_AP_DT, "ARM Integrator/AP (Device Tree)")
 	.init_early	= ap_init_early,
 	.init_irq	= ap_init_irq_of,
 	.handle_irq	= fpga_handle_irq,
-	.init_time	= ap_of_timer_init,
 	.init_machine	= ap_init_of,
 	.restart	= integrator_restart,
 	.dt_compat      = ap_dt_board_compat,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 5781f3c..19e2497 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -28,12 +28,13 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/sys_soc.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 
 #include <mach/cm.h>
@@ -45,8 +46,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <asm/hardware/timer-sp.h>
-
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
 
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 1d5ee5c..ac59770 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -31,21 +31,20 @@
 #include <linux/amba/mmci.h>
 #include <linux/gfp.h>
 #include <linux/mtd/physmap.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 
-
 #include <mach/platform.h>
 #include <mach/irqs.h>
-#include <asm/hardware/timer-sp.h>
 
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 54bb80b..84f26c7 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -38,9 +38,10 @@
 #include <linux/clkdev.h>
 #include <linux/mtd/physmap.h>
 #include <linux/bitops.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <asm/irq.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 #include <asm/mach-types.h>
 
@@ -50,7 +51,6 @@
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <asm/hardware/timer-sp.h>
 
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 6f34497..8cce326 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -11,16 +11,14 @@
 #include <linux/clkdev.h>
 #include <linux/vexpress.h>
 #include <linux/irqchip/arm-gic.h>
+#include <clocksource/timer-sp.h>
 
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 
 #include <mach/ct-ca9x4.h>
 
-#include <asm/hardware/timer-sp.h>
-
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 09e571d..dc15485 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -23,15 +23,15 @@
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/vexpress.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <asm/mach-types.h>
 #include <asm/sizes.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/hardware/timer-sp.h>
 
 #include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index d98e7e1..00aa4cd 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -25,6 +25,18 @@ config DW_APB_TIMER_OF
 config ARMADA_370_XP_TIMER
 	bool
 
+config ARM_TIMER_SP804
+	bool
+	depends on ARM
+	select CLKSRC_MMIO
+	select CLKSRC_OF if OF
+	select HAVE_SCHED_CLOCK
+
+config INTEGRATOR_AP_TIMER
+	bool
+	depends on ARM
+	select CLKSRC_OF if OF
+
 config SUNXI_TIMER
 	bool
 
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 4d8283a..9f3b62b 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -14,8 +14,10 @@ obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
+obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
+obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= integrator_ap_timer.o
 obj-$(CONFIG_SUNXI_TIMER)	+= sunxi_timer.o
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
 obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
diff --git a/drivers/clocksource/integrator_ap_timer.c b/drivers/clocksource/integrator_ap_timer.c
new file mode 100644
index 0000000..05e6204
--- /dev/null
+++ b/drivers/clocksource/integrator_ap_timer.c
@@ -0,0 +1,189 @@
+/*
+ *  Copyright (C) 2000-2003 Deep Blue Solutions Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <clocksource/timer-sp.h>
+#include <clocksource/arm_timer.h>
+
+#include <asm/sched_clock.h>
+
+static unsigned long timer_reload;
+static void __iomem *clksrc_base;
+
+static u32 notrace integrator_read_sched_clock(void)
+{
+	return -readl(clksrc_base + TIMER_VALUE);
+}
+
+void __init integrator_clocksource_init(unsigned long inrate,
+					void __iomem *base)
+{
+	u32 ctrl = TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC;
+	unsigned long rate = inrate;
+
+	clksrc_base = base;
+
+	if (rate >= 1500000) {
+		rate /= 16;
+		ctrl |= TIMER_CTRL_DIV16;
+	}
+
+	writel(0xffff, base + TIMER_LOAD);
+	writel(ctrl, base + TIMER_CTRL);
+
+	clocksource_mmio_init(base + TIMER_VALUE, "timer2",
+			rate, 200, 16, clocksource_mmio_readl_down);
+	setup_sched_clock(integrator_read_sched_clock, 16, rate);
+}
+
+static void __iomem * clkevt_base;
+
+/*
+ * IRQ handler for the timer
+ */
+static irqreturn_t integrator_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	/* clear the interrupt */
+	writel(1, clkevt_base + TIMER_INTCLR);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static void clkevt_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
+{
+	u32 ctrl = readl(clkevt_base + TIMER_CTRL) & ~TIMER_CTRL_ENABLE;
+
+	/* Disable timer */
+	writel(ctrl, clkevt_base + TIMER_CTRL);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		/* Enable the timer and start the periodic tick */
+		writel(timer_reload, clkevt_base + TIMER_LOAD);
+		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
+		writel(ctrl, clkevt_base + TIMER_CTRL);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* Leave the timer disabled, .set_next_event will enable it */
+		ctrl &= ~TIMER_CTRL_PERIODIC;
+		writel(ctrl, clkevt_base + TIMER_CTRL);
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
+	default:
+		/* Just leave in disabled state */
+		break;
+	}
+
+}
+
+static int clkevt_set_next_event(unsigned long next, struct clock_event_device *evt)
+{
+	unsigned long ctrl = readl(clkevt_base + TIMER_CTRL);
+
+	writel(ctrl & ~TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
+	writel(next, clkevt_base + TIMER_LOAD);
+	writel(ctrl | TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
+
+	return 0;
+}
+
+static struct clock_event_device integrator_clockevent = {
+	.name		= "timer1",
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_mode	= clkevt_set_mode,
+	.set_next_event	= clkevt_set_next_event,
+	.rating		= 300,
+};
+
+static struct irqaction integrator_timer_irq = {
+	.name		= "timer",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= integrator_timer_interrupt,
+	.dev_id		= &integrator_clockevent,
+};
+
+void __init integrator_clockevent_init(unsigned long inrate,
+				       void __iomem *base, int irq)
+{
+	unsigned long rate = inrate;
+	unsigned int ctrl = 0;
+
+	clkevt_base = base;
+	/* Calculate and program a divisor */
+	if (rate > 0x100000 * HZ) {
+		rate /= 256;
+		ctrl |= TIMER_CTRL_DIV256;
+	} else if (rate > 0x10000 * HZ) {
+		rate /= 16;
+		ctrl |= TIMER_CTRL_DIV16;
+	}
+	timer_reload = rate / HZ;
+	writel(ctrl, clkevt_base + TIMER_CTRL);
+
+	setup_irq(irq, &integrator_timer_irq);
+	clockevents_config_and_register(&integrator_clockevent,
+					rate,
+					1,
+					0xffffU);
+}
+
+static void __init ap_of_timer_init(struct device_node *node)
+{
+	void __iomem *base;
+	int irq;
+	struct clk *clk;
+	unsigned long rate;
+
+	clk = clk_get_sys("ap_timer", NULL);
+	BUG_ON(IS_ERR(clk));
+	clk_prepare_enable(clk);
+	rate = clk_get_rate(clk);
+
+	base = of_iomap(node, 0);
+	if (WARN_ON(!base))
+		return;
+
+	writel(0, base + TIMER_CTRL);
+
+	if ((clksrc_base && clkevt_base) || !of_device_is_available(node)) {
+		iounmap(base);
+		return;
+	}
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (!clkevt_base && (irq > 0))
+		integrator_clockevent_init(rate, base, irq);
+	else
+		integrator_clocksource_init(rate, base);
+}
+CLOCKSOURCE_OF_DECLARE(integrator_ap, "integrator-timer", ap_of_timer_init);
diff --git a/arch/arm/common/timer-sp.c b/drivers/clocksource/timer-sp.c
similarity index 98%
rename from arch/arm/common/timer-sp.c
rename to drivers/clocksource/timer-sp.c
index ddc7407..b0fc7f0 100644
--- a/arch/arm/common/timer-sp.c
+++ b/drivers/clocksource/timer-sp.c
@@ -1,6 +1,4 @@
 /*
- *  linux/arch/arm/common/timer-sp.c
- *
  *  Copyright (C) 1999 - 2003 ARM Limited
  *  Copyright (C) 2000 Deep Blue Solutions Ltd
  *
@@ -28,10 +26,10 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <asm/sched_clock.h>
-#include <asm/hardware/arm_timer.h>
-#include <asm/hardware/timer-sp.h>
 
 static long __init sp804_get_clock_rate(struct clk *clk)
 {
diff --git a/arch/arm/include/asm/hardware/arm_timer.h b/include/clocksource/arm_timer.h
similarity index 93%
rename from arch/arm/include/asm/hardware/arm_timer.h
rename to include/clocksource/arm_timer.h
index d6030ff..f4a443a 100644
--- a/arch/arm/include/asm/hardware/arm_timer.h
+++ b/include/clocksource/arm_timer.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_ARM_HARDWARE_ARM_TIMER_H
-#define __ASM_ARM_HARDWARE_ARM_TIMER_H
+#ifndef __CLOCKSOURCE_ARM_TIMER_H
+#define __CLOCKSOURCE_ARM_TIMER_H
 
 /*
  * ARM timer implementation, found in Integrator, Versatile and Realview
diff --git a/include/clocksource/integrator_ap_timer.h b/include/clocksource/integrator_ap_timer.h
new file mode 100644
index 0000000..2f585fc
--- /dev/null
+++ b/include/clocksource/integrator_ap_timer.h
@@ -0,0 +1,7 @@
+#ifndef __CLOCKSOURCE_INTEGRATOR_AP_TIMER
+#define __CLOCKSOURCE_INTEGRATOR_AP_TIMER
+
+void integrator_clocksource_init(unsigned long inrate, void __iomem *base);
+void integrator_clockevent_init(unsigned long inrate, void __iomem *base, int irq);
+
+#endif
diff --git a/arch/arm/include/asm/hardware/timer-sp.h b/include/clocksource/timer-sp.h
similarity index 100%
rename from arch/arm/include/asm/hardware/timer-sp.h
rename to include/clocksource/timer-sp.h
-- 
1.7.10.4
