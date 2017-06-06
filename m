From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:02 +0200
Subject: [PATCH v4 04/28] clocksource: Add Owl timer
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Actions Semi S500 SoC provides four timers, 2Hz0/1 and 32-bit TIMER0/1.

Use TIMER0 as clocksource and TIMER1 as clockevents.

Based on LeMaker linux-actions tree.

An S500 datasheet can be found on the LeMaker Guitar pages:
http://www.lemaker.org/product-guitar-download-29.html

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4:
 * Dropped DT-dependent node iteration (Daniel)
 * Introduced owl_timer_set_enabled() (Daniel)
 * Fixed one timer reset
 
 v2 -> v3:
 * Cleared interrupt pending flag for Timer1
 * Adopted named interrupts for Timer1
 * Extended commit message (Daniel)
 * Adopted BIT() macros (Daniel)
 * Adopted PTR_ERR() (Daniel)
 * Adopted request_irq() (Daniel)
 * Factored timer reset out (Daniel)
 * Adopted CLOCK_EVT_FEAT_DYNIRQ (Daniel)
 * Adopted clk input for rate (Daniel)
 * Prepared for S900, adopting S500 DT compatible
 
 v2: new
 
 drivers/clocksource/Kconfig     |   7 ++
 drivers/clocksource/Makefile    |   1 +
 drivers/clocksource/owl-timer.c | 171 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 drivers/clocksource/owl-timer.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4ba230d8e679..da3f1d926c6b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -102,6 +102,13 @@ config ORION_TIMER
 	help
 	  Enables the support for the Orion timer driver
 
+config OWL_TIMER
+	bool "Owl timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
+	help
+	  Enables the support for the Actions Semi Owl timer driver.
+
 config SUN4I_TIMER
 	bool "Sun4i timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index ec559212edf6..90309d4a719e 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
 obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
 obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
+obj-$(CONFIG_OWL_TIMER)		+= owl-timer.o
 
 obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
new file mode 100644
index 000000000000..4609363a79a6
--- /dev/null
+++ b/drivers/clocksource/owl-timer.c
@@ -0,0 +1,171 @@
+/*
+ * Actions Semi Owl timer
+ *
+ * Copyright 2012 Actions Semi Inc.
+ * Author: Actions Semi, Inc.
+ *
+ * Copyright (c) 2017 SUSE Linux GmbH
+ * Author: Andreas F?rber
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define OWL_Tx_CTL		0x0
+#define OWL_Tx_CMP		0x4
+#define OWL_Tx_VAL		0x8
+
+#define OWL_Tx_CTL_PD		BIT(0)
+#define OWL_Tx_CTL_INTEN	BIT(1)
+#define OWL_Tx_CTL_EN		BIT(2)
+
+static void __iomem *owl_timer_base;
+static void __iomem *owl_clksrc_base;
+static void __iomem *owl_clkevt_base;
+
+static inline void owl_timer_reset(void __iomem *base)
+{
+	writel(0, base + OWL_Tx_CTL);
+	writel(0, base + OWL_Tx_VAL);
+	writel(0, base + OWL_Tx_CMP);
+}
+
+static inline void owl_timer_set_enabled(void __iomem *base, bool enabled)
+{
+	u32 ctl = readl(base + OWL_Tx_CTL);
+
+	/* PD bit is cleared when set */
+	ctl &= ~OWL_Tx_CTL_PD;
+
+	if (enabled)
+		ctl |= OWL_Tx_CTL_EN;
+	else
+		ctl &= ~OWL_Tx_CTL_EN;
+
+	writel(ctl, base + OWL_Tx_CTL);
+}
+
+static u64 notrace owl_timer_sched_read(void)
+{
+	return (u64)readl(owl_clksrc_base + OWL_Tx_VAL);
+}
+
+static int owl_timer_set_state_shutdown(struct clock_event_device *evt)
+{
+	owl_timer_set_enabled(owl_clkevt_base, false);
+
+	return 0;
+}
+
+static int owl_timer_set_state_oneshot(struct clock_event_device *evt)
+{
+	owl_timer_reset(owl_clkevt_base);
+
+	return 0;
+}
+
+static int owl_timer_tick_resume(struct clock_event_device *evt)
+{
+	return 0;
+}
+
+static int owl_timer_set_next_event(unsigned long evt,
+				    struct clock_event_device *ev)
+{
+	void __iomem *base = owl_clkevt_base;
+
+	owl_timer_set_enabled(base, false);
+	writel(OWL_Tx_CTL_INTEN, base + OWL_Tx_CTL);
+	writel(0, base + OWL_Tx_VAL);
+	writel(evt, base + OWL_Tx_CMP);
+	owl_timer_set_enabled(base, true);
+
+	return 0;
+}
+
+static struct clock_event_device owl_clockevent = {
+	.name			= "owl_tick",
+	.rating			= 200,
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_DYNIRQ,
+	.set_state_shutdown	= owl_timer_set_state_shutdown,
+	.set_state_oneshot	= owl_timer_set_state_oneshot,
+	.tick_resume		= owl_timer_tick_resume,
+	.set_next_event		= owl_timer_set_next_event,
+};
+
+static irqreturn_t owl_timer1_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+
+	writel(OWL_Tx_CTL_PD, owl_clkevt_base + OWL_Tx_CTL);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init owl_timer_init(struct device_node *node)
+{
+	struct clk *clk;
+	unsigned long rate;
+	int timer1_irq, ret;
+
+	owl_timer_base = of_io_request_and_map(node, 0, "owl-timer");
+	if (IS_ERR(owl_timer_base)) {
+		pr_err("Can't map timer registers");
+		return PTR_ERR(owl_timer_base);
+	}
+
+	owl_clksrc_base = owl_timer_base + 0x08;
+	owl_clkevt_base = owl_timer_base + 0x14;
+
+	timer1_irq = of_irq_get_byname(node, "timer1");
+	if (timer1_irq <= 0) {
+		pr_err("Can't parse timer1 IRQ");
+		return -EINVAL;
+	}
+
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	rate = clk_get_rate(clk);
+
+	owl_timer_reset(owl_clksrc_base);
+	owl_timer_set_enabled(owl_clksrc_base, true);
+
+	sched_clock_register(owl_timer_sched_read, 32, rate);
+	clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
+			      rate, 200, 32, clocksource_mmio_readl_up);
+
+	owl_timer_reset(owl_clkevt_base);
+
+	ret = request_irq(timer1_irq, owl_timer1_interrupt, IRQF_TIMER,
+			  "owl-timer", &owl_clockevent);
+	if (ret) {
+		pr_err("failed to request irq %d\n", timer1_irq);
+		return ret;
+	}
+
+	owl_clockevent.cpumask = cpumask_of(0);
+	owl_clockevent.irq = timer1_irq;
+
+	clockevents_config_and_register(&owl_clockevent, rate,
+					0xf, 0xffffffff);
+
+	return 0;
+}
+CLOCKSOURCE_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
-- 
2.12.3
