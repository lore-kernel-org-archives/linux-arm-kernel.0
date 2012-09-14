From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Sep 2012 22:41:22 -0600
Subject: [PATCH V4 3/5] ARM: bcm2835: add system timer
In-Reply-To: <1347597684-30805-1-git-send-email-swarren@wwwdotorg.org>
References: <1347597684-30805-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1347597684-30805-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Arlott <simon@fire.lp0.eu>

The System Timer peripheral provides four 32-bit timer channels and a
single 64-bit free running counter. Each channel has an output compare
register, which is compared against the 32 least significant bits of the
free running counter values, and generates an interrupt.

Timer 3 is used as the Linux timer.

The BCM2835 also contains an SP804-based timer module. However, it
apparently has significant differences from the standard SP804 IP block,
and Broadcom's documentation recommends using the system timer instead.

This patch was extracted from git://github.com/lp0/linux.git branch
rpi-split as of 2012/09/08, and modified as follows:

* s/bcm2708/bcm2835/.
* Modified device tree vendor prefix.
* Moved to drivers/clocksource/. This looks like the desired location for
  such code now.
* Added DT binding docs.
* Moved struct sys_timer bcm2835_timer into time.c to encapsulate it more.
* Simplified bcm2835_time_init() to find one matching node and operate on
  it, rather than looping over all matching nodes. This seems more
  consistent with other clocksource code.
* Simplified bcm2835_time_init() using of_iomap().
* Renamed struct bcm2835_timer.index to match_mask to better represent its
  purpose.
* s/printk(PR_INFO/pr_info(/

Signed-off-by: Chris Boot <bootc@bootc.net>
Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Dom Cobley <dc4@broadcom.com>
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v4:
* Simplified bcm2835_time_init() using of_iomap().
* s/bcm2708/bcm2835/.
* Updated for new device tree vendor prefix.
v3:
* New patch.
---
 .../bindings/timer/brcm,bcm2835-system-timer.txt   |   22 +++
 arch/arm/boot/dts/bcm2835.dtsi                     |    7 +
 arch/arm/mach-bcm2835/bcm2835.c                    |   10 +-
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/bcm2835_timer.c                |  161 ++++++++++++++++++++
 include/linux/bcm2835_timer.h                      |   22 +++
 6 files changed, 214 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
 create mode 100644 drivers/clocksource/bcm2835_timer.c
 create mode 100644 include/linux/bcm2835_timer.h

diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
new file mode 100644
index 0000000..a0b727f
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
@@ -0,0 +1,22 @@
+BCM2835 System Timer
+
+The System Timer peripheral provides four 32-bit timer channels and a
+single 64-bit free running counter. Each channel has an output compare
+register, which is compared against the 32 least significant bits of the
+free running counter values, and generates an interrupt.
+
+Required properties:
+
+- compatible : should be "brcm,bcm2835-system-timer.txt"
+- reg : Specifies base physical address and size of the registers.
+- interrupts : A list of 4 interrupt sinks; one per timer channel.
+- clock-frequency : The frequency of the clock that drives the counter, in Hz.
+
+Example:
+
+timer {
+	compatible = "brcm,bcm2835-system-timer";
+	reg = <0x20003000 0x1000>;
+	interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
+	clock-frequency = <1000000>;
+};
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 33e8d533..c7ac399 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -9,6 +9,13 @@
 		bootargs = "earlyprintk";
 	};
 
+	timer {
+		compatible = "brcm,bcm2835-system-timer";
+		reg = <0x20003000 0x1000>;
+		interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
+		clock-frequency = <1000000>;
+	};
+
 	intc: interrupt-controller {
 		compatible = "brcm,bcm2835-armctrl-ic";
 		reg = <0x2000b200 0x200>;
diff --git a/arch/arm/mach-bcm2835/bcm2835.c b/arch/arm/mach-bcm2835/bcm2835.c
index 72c4b5f..e3f2968 100644
--- a/arch/arm/mach-bcm2835/bcm2835.c
+++ b/arch/arm/mach-bcm2835/bcm2835.c
@@ -15,10 +15,10 @@
 #include <linux/init.h>
 #include <linux/irqchip/bcm2835.h>
 #include <linux/of_platform.h>
+#include <linux/bcm2835_timer.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/time.h>
 
 #include <mach/bcm2835_soc.h>
 
@@ -46,14 +46,6 @@ void __init bcm2835_init(void)
 	}
 }
 
-static void __init bcm2835_timer_init(void)
-{
-}
-
-struct sys_timer bcm2835_timer = {
-	.init = bcm2835_timer_init
-};
-
 static const char * const bcm2835_compat[] = {
 	"brcm,bcm2835",
 	NULL
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 6591990..cccde85 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_CLKSRC_ARM_GENERIC)	+= arm_generic.o
+obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
new file mode 100644
index 0000000..bc19f12
--- /dev/null
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -0,0 +1,161 @@
+/*
+ * Copyright 2012 Simon Arlott
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
+
+#include <linux/bcm2835_timer.h>
+#include <linux/bitops.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include <asm/sched_clock.h>
+#include <asm/irq.h>
+
+#define REG_CONTROL	0x00
+#define REG_COUNTER_LO	0x04
+#define REG_COUNTER_HI	0x08
+#define REG_COMPARE(n)	(0x0c + (n) * 4)
+#define MAX_TIMER	3
+#define DEFAULT_TIMER	3
+
+struct bcm2835_timer {
+	void __iomem *control;
+	void __iomem *compare;
+	int match_mask;
+	struct clock_event_device evt;
+	struct irqaction act;
+};
+
+static void __iomem *system_clock __read_mostly;
+
+static u32 notrace bcm2835_sched_read(void)
+{
+	return readl_relaxed(system_clock);
+}
+
+static void bcm2835_time_set_mode(enum clock_event_mode mode,
+	struct clock_event_device *evt_dev)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	default:
+		WARN(1, "%s: unhandled event mode %d\n", __func__, mode);
+		break;
+	}
+}
+
+static int bcm2835_time_set_next_event(unsigned long event,
+	struct clock_event_device *evt_dev)
+{
+	struct bcm2835_timer *timer = container_of(evt_dev,
+		struct bcm2835_timer, evt);
+	writel_relaxed(readl_relaxed(system_clock) + event,
+		timer->compare);
+	return 0;
+}
+
+static irqreturn_t bcm2835_time_interrupt(int irq, void *dev_id)
+{
+	struct bcm2835_timer *timer = dev_id;
+	void (*event_handler)(struct clock_event_device *);
+	if (readl_relaxed(timer->control) & timer->match_mask) {
+		writel_relaxed(timer->match_mask, timer->control);
+
+		event_handler = ACCESS_ONCE(timer->evt.event_handler);
+		if (event_handler)
+			event_handler(&timer->evt);
+		return IRQ_HANDLED;
+	} else {
+		return IRQ_NONE;
+	}
+}
+
+static struct of_device_id bcm2835_time_match[] __initconst = {
+	{ .compatible = "brcm,bcm2835-system-timer" },
+	{}
+};
+
+static void __init bcm2835_time_init(void)
+{
+	struct device_node *node;
+	void __iomem *base;
+	u32 freq;
+	int irq;
+	struct bcm2835_timer *timer;
+
+	node = of_find_matching_node(NULL, bcm2835_time_match);
+	if (!node)
+		panic("No bcm2835 timer node");
+
+	base = of_iomap(node, 0);
+	if (!base)
+		panic("Can't remap registers");
+
+	if (of_property_read_u32(node, "clock-frequency", &freq))
+		panic("Can't read clock-frequency");
+
+	system_clock = base + REG_COUNTER_LO;
+	setup_sched_clock(bcm2835_sched_read, 32, freq);
+
+	clocksource_mmio_init(base + REG_COUNTER_LO, node->name,
+		freq, 300, 32, clocksource_mmio_readl_up);
+
+	irq = irq_of_parse_and_map(node, DEFAULT_TIMER);
+	if (irq <= 0)
+		panic("Can't parse IRQ");
+
+	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
+	if (!timer)
+		panic("Can't allocate timer struct\n");
+
+	timer->control = base + REG_CONTROL;
+	timer->compare = base + REG_COMPARE(DEFAULT_TIMER);
+	timer->match_mask = BIT(DEFAULT_TIMER);
+	timer->evt.name = node->name;
+	timer->evt.rating = 300;
+	timer->evt.features = CLOCK_EVT_FEAT_ONESHOT;
+	timer->evt.set_mode = bcm2835_time_set_mode;
+	timer->evt.set_next_event = bcm2835_time_set_next_event;
+	timer->evt.cpumask = cpumask_of(0);
+	timer->act.name = node->name;
+	timer->act.flags = IRQF_TIMER | IRQF_SHARED;
+	timer->act.dev_id = timer;
+	timer->act.handler = bcm2835_time_interrupt;
+
+	if (setup_irq(irq, &timer->act))
+		panic("Can't set up timer IRQ\n");
+
+	clockevents_config_and_register(&timer->evt, freq, 0xf, 0xffffffff);
+
+	pr_info("bcm2835: system timer (irq = %d)\n", irq);
+}
+
+struct sys_timer bcm2835_timer = {
+	.init = bcm2835_time_init,
+};
diff --git a/include/linux/bcm2835_timer.h b/include/linux/bcm2835_timer.h
new file mode 100644
index 0000000..25680fe
--- /dev/null
+++ b/include/linux/bcm2835_timer.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright 2012 Simon Arlott
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
+ */
+
+#ifndef __BCM2835_TIMER_H
+#define __BCM2835_TIMER_H
+
+#include <asm/mach/time.h>
+
+extern struct sys_timer bcm2835_timer;
+
+#endif
-- 
1.7.9.5
