From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 10:54:38 +0200
Subject: [PATCH 2/8] arm: mach-armada: add source files
In-Reply-To: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1337072084-21967-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic source files for Marvell Armada SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/boot/dts/a370.dtsi        |   23 ++++
 arch/arm/boot/dts/armada.dtsi      |   67 ++++++++++
 arch/arm/boot/dts/axp.dtsi         |   43 +++++++
 arch/arm/mach-armada/Kconfig       |    5 +
 arch/arm/mach-armada/Makefile      |    2 +
 arch/arm/mach-armada/Makefile.boot |    1 +
 arch/arm/mach-armada/common.c      |   56 +++++++++
 arch/arm/mach-armada/common.h      |   27 ++++
 arch/arm/mach-armada/irq.c         |  116 +++++++++++++++++
 arch/arm/mach-armada/time.c        |  243 ++++++++++++++++++++++++++++++++++++
 10 files changed, 583 insertions(+)
 create mode 100644 arch/arm/boot/dts/a370.dtsi
 create mode 100644 arch/arm/boot/dts/armada.dtsi
 create mode 100644 arch/arm/boot/dts/axp.dtsi
 create mode 100644 arch/arm/mach-armada/Kconfig
 create mode 100644 arch/arm/mach-armada/Makefile
 create mode 100644 arch/arm/mach-armada/Makefile.boot
 create mode 100644 arch/arm/mach-armada/common.c
 create mode 100644 arch/arm/mach-armada/common.h
 create mode 100644 arch/arm/mach-armada/irq.c
 create mode 100644 arch/arm/mach-armada/time.c

diff --git a/arch/arm/boot/dts/a370.dtsi b/arch/arm/boot/dts/a370.dtsi
new file mode 100644
index 0000000..f11e56a
--- /dev/null
+++ b/arch/arm/boot/dts/a370.dtsi
@@ -0,0 +1,23 @@
+/*
+ * Device Tree Include file for Marvell Armada 370 family SoC
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Contains definitions specific to the Armada 370 SoC that are not
+ * common to all Armada SoCs.
+ */
+
+/include/ "armada.dtsi"
+
+/ {
+	model = "Marvell Armada 370 family SoC";
+	compatible = "marvell,armada370", "marvell,armada";
+ };
diff --git a/arch/arm/boot/dts/armada.dtsi b/arch/arm/boot/dts/armada.dtsi
new file mode 100644
index 0000000..3c99c30
--- /dev/null
+++ b/arch/arm/boot/dts/armada.dtsi
@@ -0,0 +1,67 @@
+/*
+ * Device Tree Include file for Marvell Armada family SoC
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * This file contains the definitions that are common to the Armada
+ * 370 and Armada XP SoC.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Marvell Armada family SoC";
+	compatible = "marvell,armada";
+
+	cpus {
+		cpu at 0 {
+			compatible = "marvell,sheeva-v7";
+		};
+	};
+
+	mpic: interrupt-controller at d0020000 {
+	      compatible = "marvell,mpic";
+	      #interrupt-cells = <1>;
+	      #address-cells = <1>;
+	      #size-cells = <1>;
+	      interrupt-controller;
+	      reg = <0xd0020000 0x1000>,
+		    <0xd0021000 0x1000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&mpic>;
+		ranges;
+
+		serial at d0012000 {
+				compatible = "ns16550";
+				reg = <0xd0012000 0x100>;
+				reg-shift = <2>;
+				interrupts = <41>;
+		};
+		serial at d0012100 {
+				compatible = "ns16550";
+				reg = <0xd0012100 0x100>;
+				reg-shift = <2>;
+				interrupts = <42>;
+		};
+
+		timer at d0020300 {
+			       compatible = "marvell,timer";
+			       reg = <0xd0020300 0x30>;
+			       interrupts = <37>, <38>, <39>, <40>;
+		};
+	};
+};
+
diff --git a/arch/arm/boot/dts/axp.dtsi b/arch/arm/boot/dts/axp.dtsi
new file mode 100644
index 0000000..6427268
--- /dev/null
+++ b/arch/arm/boot/dts/axp.dtsi
@@ -0,0 +1,43 @@
+/*
+ * Device Tree Include file for Marvell Armada XP family SoC
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Contains definitions specific to the Armada 370 SoC that are not
+ * common to all Armada SoCs.
+ */
+
+/include/ "armada.dtsi"
+
+/ {
+	model = "Marvell Armada XP family SoC";
+	compatible = "marvell,armadaxp", "marvell,armada";
+
+	soc {
+		serial at d0012200 {
+				compatible = "ns16550";
+				reg = <0xd0012200 0x100>;
+				reg-shift = <2>;
+				interrupts = <43>;
+		};
+		serial at d0012300 {
+				compatible = "ns16550";
+				reg = <0xd0012300 0x100>;
+				reg-shift = <2>;
+				interrupts = <44>;
+		};
+
+		timer at d0020300 {
+				marvell,timer-25Mhz;
+		};
+	};
+ };
+
diff --git a/arch/arm/mach-armada/Kconfig b/arch/arm/mach-armada/Kconfig
new file mode 100644
index 0000000..010a6a3
--- /dev/null
+++ b/arch/arm/mach-armada/Kconfig
@@ -0,0 +1,5 @@
+if ARCH_ARMADA
+
+menu "Marvell Armada Implementations"
+
+endif
diff --git a/arch/arm/mach-armada/Makefile b/arch/arm/mach-armada/Makefile
new file mode 100644
index 0000000..6765961
--- /dev/null
+++ b/arch/arm/mach-armada/Makefile
@@ -0,0 +1,2 @@
+obj-y += common.o irq.o time.o
+
diff --git a/arch/arm/mach-armada/Makefile.boot b/arch/arm/mach-armada/Makefile.boot
new file mode 100644
index 0000000..b327175
--- /dev/null
+++ b/arch/arm/mach-armada/Makefile.boot
@@ -0,0 +1 @@
+zreladdr-y := 0x00008000
diff --git a/arch/arm/mach-armada/common.c b/arch/arm/mach-armada/common.c
new file mode 100644
index 0000000..92d9ec2
--- /dev/null
+++ b/arch/arm/mach-armada/common.c
@@ -0,0 +1,56 @@
+/*
+ * Core functions for Marvell Armada System On Chip
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/timex.h>
+#include <asm/page.h>
+#include <asm/setup.h>
+#include <asm/mach/map.h>
+#include <plat/addr-map.h>
+#include <mach/armada.h>
+#include <mach/bridge-regs.h>
+#include "common.h"
+
+static struct map_desc armada_io_desc[] __initdata = {
+	{
+		.virtual	= ARMADA_REGS_VIRT_BASE,
+		.pfn		= __phys_to_pfn(ARMADA_REGS_PHYS_BASE),
+		.length		= ARMADA_REGS_SIZE,
+		.type		= MT_DEVICE,
+	},
+};
+
+void __init armada_map_io(void)
+{
+	iotable_init(armada_io_desc, ARRAY_SIZE(armada_io_desc));
+}
+
+void armada_restart(char mode, const char *cmd)
+{
+	/*
+	 * Enable soft reset to assert RSTOUTn.
+	 */
+	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
+
+	/*
+	 * Assert soft reset.
+	 */
+	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
+	while (1)
+		;
+}
diff --git a/arch/arm/mach-armada/common.h b/arch/arm/mach-armada/common.h
new file mode 100644
index 0000000..e453161
--- /dev/null
+++ b/arch/arm/mach-armada/common.h
@@ -0,0 +1,27 @@
+/*
+ * Core functions for Marvell Armada System On Chip
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ARCH_ARMADA_COMMON_H
+#define __ARCH_ARMADA_COMMON_H
+
+#include <asm/exception.h>
+
+extern struct sys_timer armada_timer;
+
+void armada_map_io(void);
+void armada_init_irq(void);
+void armada_restart(char, const char *);
+asmlinkage void __exception_irq_entry armada_handle_irq(struct pt_regs *regs);
+
+#endif
diff --git a/arch/arm/mach-armada/irq.c b/arch/arm/mach-armada/irq.c
new file mode 100644
index 0000000..7006429
--- /dev/null
+++ b/arch/arm/mach-armada/irq.c
@@ -0,0 +1,116 @@
+/*
+ * Marvall Armada SoC IRQ handling
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <asm/mach/arch.h>
+#include <asm/exception.h>
+
+/* Interrupt Controller Registers Map */
+#define ARMADA_INT_SET_MASK_OFFS             (0xBC)
+#define ARMADA_INT_CLEAR_MASK_OFFS           (0xB8)
+
+#define ARMADA_INT_SET_ENABLE_OFFS           (0xA30)
+#define ARMADA_INT_CLEAR_ENABLE_OFFS         (0xA34)
+
+#define ARMADA_CPU_INTACK_OFFS               (0xB4)
+
+static void __iomem *per_cpu_int_base;
+static void __iomem *main_int_base;
+static struct irq_domain *armada_mpic_domain;
+
+static void armada_irq_mask(struct irq_data *d)
+{
+	writel(d->irq, per_cpu_int_base + ARMADA_INT_CLEAR_MASK_OFFS);
+}
+
+static void armada_irq_unmask(struct irq_data *d)
+{
+	writel(d->irq, per_cpu_int_base + ARMADA_INT_SET_MASK_OFFS);
+}
+
+static struct irq_chip armada_irq_chip = {
+	.name		= "armada_irq",
+	.irq_mask       = armada_irq_mask,
+	.irq_mask_ack   = armada_irq_mask,
+	.irq_unmask     = armada_irq_unmask,
+};
+
+static int armada_mpic_irq_map(struct irq_domain *h,
+			       unsigned int virq,
+			       irq_hw_number_t hw)
+{
+	armada_irq_mask(irq_get_irq_data(virq));
+	writel(virq, main_int_base + ARMADA_INT_SET_ENABLE_OFFS);
+
+	irq_set_chip_and_handler(virq, &armada_irq_chip,
+				 handle_level_irq);
+	irq_set_status_flags(virq, IRQ_LEVEL);
+	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
+	return 0;
+}
+
+static struct irq_domain_ops armada_mpic_irq_ops = {
+	.map = armada_mpic_irq_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static void __init armada_mpic_of_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	main_int_base = of_iomap(node, 0);
+	per_cpu_int_base = of_iomap(node, 1);
+
+	armada_mpic_domain = irq_domain_add_linear(node, NR_IRQS,
+						   &armada_mpic_irq_ops, NULL);
+	if (!armada_mpic_domain)
+		panic("Unable to add Armada MPIC irq domain (DT)\n");
+
+	irq_set_default_host(armada_mpic_domain);
+}
+
+asmlinkage void __exception_irq_entry armada_handle_irq(struct pt_regs *regs)
+{
+	u32 irqstat, irqnr;
+
+	do {
+		irqstat = readl_relaxed(per_cpu_int_base +
+					ARMADA_CPU_INTACK_OFFS);
+		irqnr = irqstat & 0x3FF;
+
+		if (irqnr < 1023) {
+			irqnr = irq_find_mapping(armada_mpic_domain, irqnr);
+			handle_IRQ(irqnr, regs);
+			continue;
+		}
+
+		break;
+	} while (1);
+}
+
+static const struct of_device_id mpic_of_match[] __initconst = {
+	{ .compatible = "marvell,mpic", .data = armada_mpic_of_init },
+	{},
+};
+
+void __init armada_init_irq(void)
+{
+	of_irq_init(mpic_of_match);
+}
diff --git a/arch/arm/mach-armada/time.c b/arch/arm/mach-armada/time.c
new file mode 100644
index 0000000..73817ea
--- /dev/null
+++ b/arch/arm/mach-armada/time.c
@@ -0,0 +1,243 @@
+/*
+ * Marvell Armada SoC timer handling.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Timer 0 is used as free-running clocksource, while timer 1 is
+ * used as clock_event_device.
+ */
+
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/irq.h>
+#include <asm/sched_clock.h>
+#include <asm/mach/time.h>
+
+/*
+ * Timer block registers.
+ */
+#define TIMER_CTRL_OFF		0x0000
+#define  TIMER0_EN		 0x0001
+#define  TIMER0_RELOAD_EN	 0x0002
+#define  TIMER0_25MHZ            0x0800
+#define  TIMER0_DIV(div)         ((div) << 19)
+#define  TIMER1_EN		 0x0004
+#define  TIMER1_RELOAD_EN	 0x0008
+#define  TIMER1_25MHZ            0x1000
+#define  TIMER1_DIV(div)         ((div) << 22)
+#define TIMER_EVENTS_STATUS	0x0004
+#define  TIMER0_CLR_MASK         (~0x1)
+#define  TIMER1_CLR_MASK         (~0x100)
+#define TIMER0_RELOAD_OFF	0x0010
+#define TIMER0_VAL_OFF		0x0014
+#define TIMER1_RELOAD_OFF	0x0018
+#define TIMER1_VAL_OFF		0x001c
+
+/* Global timers are connected to the coherency fabric clock, and the
+   below divider reduces their incrementing frequency. */
+#define TIMER_DIVIDER_SHIFT     5
+#define TIMER_DIVIDER           (1 << TIMER_DIVIDER_SHIFT)
+
+/*
+ * SoC-specific data.
+ */
+static void __iomem *timer_base;
+static int timer_irq;
+
+/*
+ * Number of timer ticks per jiffy.
+ */
+static u32 ticks_per_jiffy;
+
+static u32 notrace armada_read_sched_clock(void)
+{
+	return ~readl(timer_base + TIMER0_VAL_OFF);
+}
+
+/*
+ * Clockevent handling.
+ */
+static int
+armada_clkevt_next_event(unsigned long delta, struct clock_event_device *dev)
+{
+	unsigned long flags;
+	u32 u;
+
+	if (delta == 0)
+		return -ETIME;
+
+	local_irq_save(flags);
+
+	/*
+	 * Clear clockevent timer interrupt.
+	 */
+	writel(TIMER1_CLR_MASK, timer_base + TIMER_EVENTS_STATUS);
+
+	/*
+	 * Setup new clockevent timer value.
+	 */
+	writel(delta, timer_base + TIMER1_VAL_OFF);
+
+	/*
+	 * Enable the timer.
+	 */
+	u = readl(timer_base + TIMER_CTRL_OFF);
+	u = ((u & ~TIMER1_RELOAD_EN) | TIMER1_EN |
+	     TIMER1_DIV(TIMER_DIVIDER_SHIFT));
+	writel(u, timer_base + TIMER_CTRL_OFF);
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static void
+armada_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
+{
+	unsigned long flags;
+	u32 u;
+
+	local_irq_save(flags);
+	if (mode == CLOCK_EVT_MODE_PERIODIC) {
+		/*
+		 * Setup timer to fire@1/HZ intervals.
+		 */
+		writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD_OFF);
+		writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL_OFF);
+
+		/*
+		 * Enable timer.
+		 */
+		u = readl(timer_base + TIMER_CTRL_OFF);
+
+		writel((u | TIMER1_EN | TIMER1_RELOAD_EN |
+			TIMER1_DIV(TIMER_DIVIDER_SHIFT)),
+		       timer_base + TIMER_CTRL_OFF);
+	} else {
+		/*
+		 * Disable timer.
+		 */
+		u = readl(timer_base + TIMER_CTRL_OFF);
+		writel(u & ~TIMER1_EN, timer_base + TIMER_CTRL_OFF);
+
+		/*
+		 * ACK pending timer interrupt.
+		 */
+		writel(TIMER1_CLR_MASK,
+		       timer_base + TIMER_EVENTS_STATUS);
+
+	}
+	local_irq_restore(flags);
+}
+
+static struct clock_event_device armada_clkevt = {
+	.name		= "armada_tick",
+	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+	.shift		= 32,
+	.rating		= 300,
+	.set_next_event	= armada_clkevt_next_event,
+	.set_mode	= armada_clkevt_mode,
+};
+
+static irqreturn_t armada_timer_interrupt(int irq, void *dev_id)
+{
+	/*
+	 * ACK timer interrupt and call event handler.
+	 */
+
+	writel(TIMER1_CLR_MASK, timer_base + TIMER_EVENTS_STATUS);
+	armada_clkevt.event_handler(&armada_clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction armada_timer_irq = {
+	.name		= "armada_tick",
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.handler	= armada_timer_interrupt
+};
+
+static void __init armada_time_init(void)
+{
+	u32 u;
+	struct device_node *np;
+	unsigned int timer_clk;
+
+	np = of_find_compatible_node(NULL, NULL, "marvell,timer");
+	timer_base = of_iomap(np, 0);
+	WARN_ON(!timer_base);
+
+	if (of_find_property(np, "marvell,timer-25Mhz", NULL)) {
+		/* The fixed 25MHz timer is available so let's use it*/
+		u = readl(timer_base + TIMER_CTRL_OFF);
+		writel(u | TIMER0_25MHZ | TIMER1_25MHZ,
+		       timer_base + TIMER_CTRL_OFF);
+		timer_clk = 25000000;
+	} else {
+		u32 clk;
+		of_property_read_u32(np, "clock-frequency", &clk);
+		WARN_ON(!clk);
+		u = readl(timer_base + TIMER_CTRL_OFF);
+		writel(u & ~(TIMER0_25MHZ | TIMER1_25MHZ),
+		       timer_base + TIMER_CTRL_OFF);
+		timer_clk = clk / TIMER_DIVIDER;
+	}
+
+	/* We use timer 0 as clocksource, and timer 1 for
+	   clockevents */
+	timer_irq = irq_of_parse_and_map(np, 1);
+
+	ticks_per_jiffy = (timer_clk + HZ/2) / HZ;
+
+	/*
+	 * Set scale and timer for sched_clock.
+	 */
+	setup_sched_clock(armada_read_sched_clock, 32, timer_clk);
+
+	/*
+	 * Setup free-running clocksource timer (interrupts
+	 * disabled).
+	 */
+	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
+	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
+
+	u = readl(timer_base + TIMER_CTRL_OFF);
+
+	writel((u | TIMER0_EN | TIMER0_RELOAD_EN |
+		TIMER0_DIV(TIMER_DIVIDER_SHIFT)),
+	       timer_base + TIMER_CTRL_OFF);
+
+	clocksource_mmio_init(timer_base + TIMER0_VAL_OFF,
+			      "armada_clocksource",
+			      timer_clk, 300, 32,
+			      clocksource_mmio_readl_down);
+
+	/*
+	 * Setup clockevent timer (interrupt-driven).
+	 */
+	setup_irq(timer_irq, &armada_timer_irq);
+	armada_clkevt.mult = div_sc(timer_clk, NSEC_PER_SEC,
+				    armada_clkevt.shift);
+	armada_clkevt.max_delta_ns = clockevent_delta2ns(0xfffffffe,
+							 &armada_clkevt);
+	armada_clkevt.min_delta_ns = clockevent_delta2ns(1, &armada_clkevt);
+	armada_clkevt.cpumask = cpumask_of(0);
+	clockevents_register_device(&armada_clkevt);
+}
+
+struct sys_timer armada_timer = {
+	.init = armada_time_init,
+};
-- 
1.7.9.5
