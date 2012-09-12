From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 22:18:27 -0600
Subject: [PATCH V3 3/5] ARM: bcm2708: add system timer
In-Reply-To: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
References: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1347423509-30647-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Arlott <simon@fire.lp0.eu>

The System Timer peripheral provides four 32-bit timer channels and a
single 64-bit free running counter. Each channel has an output compare
register, which is compared against the 32 least significant bits of the
free running counter values, and generates an interrupt.

Timer 3 is used as the Linux timer.

The BCM2708 also contains an SP804-based timer module. However, it
apparently has significant differences from the standard SP804 IP block,
and Broadcom's documentation recommends using the system timer instead.

This patch was extracted from git://github.com/lp0/linux.git branch
rpi-split as of 2012/09/08, and modified as follows:

* Moved struct sys_timer bcm2708_timer into time.c to encapsulate it more.
* Added DT binding docs.
* Moved to drivers/clocksource/. This looks like the desired location for
  such code now.
* Simplified bcm2708_time_init() to find one matching node and operate on
  it, rather than looping over all matching nodes. This seems more
  consistent with other clocksource code.
* Renamed struct bcm2708_timer.index to match_mask to better represent its
  purpose.
* s/printk(PR_INFO/pr_info(/

Signed-off-by: Chris Boot <bootc@bootc.net>
Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Dom Cobley <dc4@broadcom.com>
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
v3: New patch.

TODO: Should of_address_to_resource(), ioremap(), request_mem_region()
in bcm2708_time_init() be collapsed into of_iomap(). This wouldn't request
the region, but a quick grep implies that's quite common with DT.
---
 .../arm/bcm2708/broadcom,bcm2708-system-timer.txt  |   22 +++
 arch/arm/boot/dts/bcm2835.dtsi                     |    7 +
 arch/arm/mach-bcm2708/bcm2708.c                    |   10 +-
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/bcm2708_timer.c                |  170 ++++++++++++++++++++
 include/linux/bcm2708_timer.h                      |   22 +++
 6 files changed, 223 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm2708/broadcom,bcm2708-system-timer.txt
 create mode 100644 drivers/clocksource/bcm2708_timer.c
 create mode 100644 include/linux/bcm2708_timer.h

diff --git a/Documentation/devicetree/bindings/arm/bcm2708/broadcom,bcm2708-system-timer.txt b/Documentation/devicetree/bindings/arm/bcm2708/broadcom,bcm2708-system-timer.txt
new file mode 100644
index 0000000..840e18b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm2708/broadcom,bcm2708-system-timer.txt
@@ -0,0 +1,22 @@
+BCM2708 System Timer
+
+The System Timer peripheral provides four 32-bit timer channels and a
+single 64-bit free running counter. Each channel has an output compare
+register, which is compared against the 32 least significant bits of the
+free running counter values, and generates an interrupt.
+
+Required properties:
+
+- compatible : should be "broadcom,bcm2708-system-timer.txt"
+- reg : Specifies base physical address and size of the registers.
+- interrupts : A list of 4 interrupt sinks; one per timer channel.
+- clock-frequency : The frequency of the clock that drives the counter, in Hz.
+
+Example:
+
+timer {
+	compatible = "broadcom,bcm2835-system-timer", "broadcom,bcm2708-system-timer";
+	reg = <0x20003000 0x1000>;
+	interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
+	clock-frequency = <1000000>;
+};
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 00eaf2b..3e8ea51 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -9,6 +9,13 @@
 		bootargs = "earlyprintk";
 	};
 
+	timer {
+		compatible = "broadcom,bcm2835-system-timer", "broadcom,bcm2708-system-timer";
+		reg = <0x20003000 0x1000>;
+		interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
+		clock-frequency = <1000000>;
+	};
+
 	intc: interrupt-controller {
 		compatible = "broadcom,bcm2708-armctrl-ic";
 		reg = <0x2000b200 0x200>;
diff --git a/arch/arm/mach-bcm2708/bcm2708.c b/arch/arm/mach-bcm2708/bcm2708.c
index ad6b7f8..8ee11d9 100644
--- a/arch/arm/mach-bcm2708/bcm2708.c
+++ b/arch/arm/mach-bcm2708/bcm2708.c
@@ -14,10 +14,10 @@
 
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <linux/bcm2708_timer.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/time.h>
 #include <asm/exception.h>
 
 #include <mach/bcm2708_soc.h>
@@ -48,14 +48,6 @@ void __init bcm2708_init(void)
 	}
 }
 
-static void __init bcm2708_timer_init(void)
-{
-}
-
-struct sys_timer bcm2708_timer = {
-	.init = bcm2708_timer_init
-};
-
 static const char * const bcm2708_compat[] = {
 	"broadcom,bcm2708",
 	NULL
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 6591990..342b72e 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_CLKSRC_ARM_GENERIC)	+= arm_generic.o
+obj-$(CONFIG_ARCH_BCM2708)	+= bcm2708_timer.o
diff --git a/drivers/clocksource/bcm2708_timer.c b/drivers/clocksource/bcm2708_timer.c
new file mode 100644
index 0000000..bc41381
--- /dev/null
+++ b/drivers/clocksource/bcm2708_timer.c
@@ -0,0 +1,170 @@
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
+#include <linux/bcm2708_timer.h>
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
+struct bcm2708_timer {
+	void __iomem *control;
+	void __iomem *compare;
+	int match_mask;
+	struct clock_event_device evt;
+	struct irqaction act;
+};
+
+static void __iomem *system_clock __read_mostly;
+
+static u32 notrace bcm2708_sched_read(void)
+{
+	return readl_relaxed(system_clock);
+}
+
+static void bcm2708_time_set_mode(enum clock_event_mode mode,
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
+static int bcm2708_time_set_next_event(unsigned long event,
+	struct clock_event_device *evt_dev)
+{
+	struct bcm2708_timer *timer = container_of(evt_dev,
+		struct bcm2708_timer, evt);
+	writel_relaxed(readl_relaxed(system_clock) + event,
+		timer->compare);
+	return 0;
+}
+
+static irqreturn_t bcm2708_time_interrupt(int irq, void *dev_id)
+{
+	struct bcm2708_timer *timer = dev_id;
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
+static struct of_device_id bcm2708_time_match[] __initconst = {
+	{ .compatible = "broadcom,bcm2708-system-timer" },
+	{}
+};
+
+static void __init bcm2708_time_init(void)
+{
+	struct device_node *node;
+	struct resource res;
+	void __iomem *base;
+	u32 freq;
+	int irq;
+	struct bcm2708_timer *timer;
+
+	node = of_find_matching_node(NULL, bcm2708_time_match);
+	if (!node)
+		panic("No bcm2708 timer node");
+
+	if (of_address_to_resource(node, 0, &res))
+		panic("Can't parse address");
+
+	if (!request_mem_region(res.start, resource_size(&res),
+			node->full_name))
+		panic("Can't request memory region");
+
+	base = ioremap(res.start, resource_size(&res));
+	if (!base)
+		panic("Can't remap registers");
+
+	if (of_property_read_u32(node, "clock-frequency", &freq))
+		panic("Can't read clock-frequency");
+
+	system_clock = base + REG_COUNTER_LO;
+	setup_sched_clock(bcm2708_sched_read, 32, freq);
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
+	timer->evt.set_mode = bcm2708_time_set_mode;
+	timer->evt.set_next_event = bcm2708_time_set_next_event;
+	timer->evt.cpumask = cpumask_of(0);
+	timer->act.name = node->name;
+	timer->act.flags = IRQF_TIMER | IRQF_SHARED;
+	timer->act.dev_id = timer;
+	timer->act.handler = bcm2708_time_interrupt;
+
+	if (setup_irq(irq, &timer->act))
+		panic("Can't set up timer IRQ\n");
+
+	clockevents_config_and_register(&timer->evt, freq, 0xf, 0xffffffff);
+
+	pr_info("bcm2708: system timer at MMIO %#lx (irq = %d)\n",
+		(unsigned long)res.start, irq);
+}
+
+struct sys_timer bcm2708_timer = {
+	.init = bcm2708_time_init,
+};
diff --git a/include/linux/bcm2708_timer.h b/include/linux/bcm2708_timer.h
new file mode 100644
index 0000000..1a433c1
--- /dev/null
+++ b/include/linux/bcm2708_timer.h
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
+#ifndef __BCM2708_TIMER_H
+#define __BCM2708_TIMER_H
+
+#include <asm/mach/time.h>
+
+extern struct sys_timer bcm2708_timer;
+
+#endif
-- 
1.7.9.5
