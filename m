From: csd@broadcom.com (Christian Daudt)
Date: Mon, 3 Dec 2012 19:55:24 -0800
Subject: [PATCH] ARM: bcm281xx: Add timer driver
Message-ID: <1354593324-21300-1-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the Broadcom timer, used in the following SoCs:
BCM11130, BCM11140, BCM11351, BCM28145, BCM28155

This patch needs the arm-soc/soc/next branch

Signed-off-by: Christian Daudt <csd@broadcom.com>

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index ad13588..8f71f40 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -47,4 +47,12 @@
 		    cache-unified;
 		    cache-level = <2>;
 	};
+
+	timer at 35006000 {
+		compatible = "bcm,kona-timer";
+		reg = <0x35006000 0x1000>;
+		interrupts = <0x0 7 0x4>;
+		clock-frequency = <32768>;
+	};
+
 };
diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c
index 3a62f1b..2457010 100644
--- a/arch/arm/mach-bcm/board_bcm.c
+++ b/arch/arm/mach-bcm/board_bcm.c
@@ -27,12 +27,10 @@ static const struct of_device_id irq_match[] = {
 	{}
 };
 
-static void timer_init(void)
-{
-}
+extern void bcm_timer_init(void);
 
 static struct sys_timer timer = {
-	.init = timer_init,
+	.init = bcm_timer_init,
 };
 
 static void __init init_irq(void)
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 603be36..fb4fc51 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -14,5 +14,6 @@ obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
+obj-$(CONFIG_ARCH_BCM)		+= bcm_timer.o
 
 obj-$(CONFIG_CLKSRC_ARM_GENERIC)	+= arm_generic.o
diff --git a/drivers/clocksource/bcm_timer.c b/drivers/clocksource/bcm_timer.c
new file mode 100644
index 0000000..85d1904
--- /dev/null
+++ b/drivers/clocksource/bcm_timer.c
@@ -0,0 +1,202 @@
+/*
+ * Copyright (C) 2012 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/clockchips.h>
+#include <linux/types.h>
+
+#include <linux/io.h>
+#include <asm/mach/time.h>
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include "bcm_timer.h"
+
+struct bcm_timers {
+	int tmr_irq;
+	void __iomem *tmr_regs;
+};
+
+struct bcm_timers timers;
+
+static u32 arch_timer_rate;
+
+/* We use the peripheral timers for system tick, the cpu global timer for
+ * profile tick
+ */
+static void timer_disable_and_clear(void __iomem *base)
+{
+	uint32_t reg;
+
+	/* clear and disable timer interrupts
+	 * We are using compare/match register 0 for
+	 * our system interrupts
+	 */
+	reg = 0;
+
+	/* Clear compare (0) interrupt */
+	reg |= 1 << KONA_GPTIMER_STCS_TIMER_MATCH_SHIFT;
+	/* disable compare */
+	reg &= ~(1 << KONA_GPTIMER_STCS_COMPARE_ENABLE_SHIFT);
+
+	writel(reg, base + KONA_GPTIMER_STCS_OFFSET);
+
+}
+
+static void
+timer_get_counter(void *timer_base, uint32_t *msw, uint32_t *lsw)
+{
+	void __iomem *base = IOMEM(timer_base);
+
+	/* Read 64-bit free running counter
+	 * 1. Read hi-word
+	 * 2. Read low-word
+	 * 3. Read hi-word again
+	 * 4.1
+	 *      if new hi-word is not equal to previously read hi-word, then
+	 *      start from #1
+	 * 4.2
+	 *      if new hi-word is equal to previously read hi-word then stop.
+	 */
+
+	while (1) {
+		*msw = readl(base + KONA_GPTIMER_STCHI_OFFSET);
+		*lsw = readl(base + KONA_GPTIMER_STCLO_OFFSET);
+		if (*msw == readl(base + KONA_GPTIMER_STCHI_OFFSET))
+			break;
+	}
+
+	return;
+}
+
+static const struct of_device_id bcm_timer_ids[] __initconst = {
+	{.compatible = "bcm,kona-timer"},
+	{},
+};
+
+static void __init timers_init(void)
+{
+	struct device_node *node;
+	u32 freq;
+
+	node = of_find_matching_node(NULL, bcm_timer_ids);
+
+	if (!node)
+		panic("No timer");
+
+	if (!of_property_read_u32(node, "clock-frequency", &freq))
+		arch_timer_rate = freq;
+	else
+		panic("clock-frequency not set in the .dts file");
+
+	/* Setup IRQ numbers */
+	timers.tmr_irq = irq_of_parse_and_map(node, 0);
+
+	/* Setup IO addresses */
+	timers.tmr_regs = of_iomap(node, 0);
+
+	timer_disable_and_clear(timers.tmr_regs);
+}
+
+static int timer_set_next_event(unsigned long clc,
+				  struct clock_event_device *unused)
+{
+	/* timer (0) is disabled by the timer interrupt already
+	 * so, here we reload the next event value and re-enable
+	 * the timer
+	 *
+	 * This way, we are potentially losing the time between
+	 * timer-interrupt->set_next_event. CPU local timers, when
+	 * they come in should get rid of skew
+	 */
+
+	uint32_t lsw, msw;
+	uint32_t reg;
+
+	timer_get_counter(timers.tmr_regs, &msw, &lsw);
+
+	/* Load the "next" event tick value */
+	writel(lsw + clc, timers.tmr_regs + KONA_GPTIMER_STCM0_OFFSET);
+
+	/* Enable compare */
+	reg = readl(timers.tmr_regs + KONA_GPTIMER_STCS_OFFSET);
+	reg |= (1 << KONA_GPTIMER_STCS_COMPARE_ENABLE_SHIFT);
+	writel(reg, timers.tmr_regs + KONA_GPTIMER_STCS_OFFSET);
+
+	return 0;
+}
+
+static void timer_set_mode(enum clock_event_mode mode,
+			     struct clock_event_device *unused)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* by default mode is one shot don't do any thing */
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	default:
+		timer_disable_and_clear(timers.tmr_regs);
+	}
+}
+
+static struct clock_event_device clockevent_timer = {
+	.name = "timer 1",
+	.features = CLOCK_EVT_FEAT_ONESHOT,
+	.shift = 32,
+	.set_next_event = timer_set_next_event,
+	.set_mode = timer_set_mode
+};
+
+static void __init timer_clockevents_init(void)
+{
+	clockevent_timer.mult = div_sc(arch_timer_rate, NSEC_PER_SEC,
+					 clockevent_timer.shift);
+
+	clockevent_timer.max_delta_ns =
+	    clockevent_delta2ns(0xffffffff, &clockevent_timer);
+
+	clockevent_timer.min_delta_ns =
+	    clockevent_delta2ns(6, &clockevent_timer);
+
+	clockevent_timer.cpumask = cpumask_of(0);
+	clockevents_register_device(&clockevent_timer);
+}
+
+static irqreturn_t timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = &clockevent_timer;
+
+	timer_disable_and_clear(timers.tmr_regs);
+	evt->event_handler(evt);
+	return IRQ_HANDLED;
+}
+
+static struct irqaction timer_irq = {
+	.name = "Kona Timer Tick",
+	.flags = IRQF_TIMER,
+	.handler = timer_interrupt,
+};
+
+void __init bcm_timer_init(void)
+{
+	timers_init();
+	timer_clockevents_init();
+	setup_irq(timers.tmr_irq, &timer_irq);
+	timer_set_next_event((arch_timer_rate / HZ), NULL);
+}
diff --git a/drivers/clocksource/bcm_timer.h b/drivers/clocksource/bcm_timer.h
new file mode 100644
index 0000000..96a6280
--- /dev/null
+++ b/drivers/clocksource/bcm_timer.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2012 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __KONA_TIMER_H__
+#define __KONA_TIMER_H__
+
+#define KONA_GPTIMER_STCS_OFFSET			0x00000000
+#define KONA_GPTIMER_STCLO_OFFSET			0x00000004
+#define KONA_GPTIMER_STCHI_OFFSET			0x00000008
+#define KONA_GPTIMER_STCM0_OFFSET			0x0000000C
+
+#define KONA_GPTIMER_STCS_TIMER_MATCH_SHIFT		0
+#define KONA_GPTIMER_STCS_COMPARE_ENABLE_SHIFT		4
+
+#endif /* __KONA_TIMER_H__ */
-- 
1.7.1
