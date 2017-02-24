From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 24 Feb 2017 04:40:42 +0100
Subject: [PATCH v2 04/17] clocksource: Add Owl timer
In-Reply-To: <20170224034055.18807-1-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
Message-ID: <20170224034055.18807-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement clocksource and clockevents for Actions Semi S500.

Based on LeMaker linux-actions tree.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: new
 
 drivers/clocksource/Kconfig     |   7 ++
 drivers/clocksource/Makefile    |   1 +
 drivers/clocksource/owl-timer.c | 146 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 drivers/clocksource/owl-timer.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3356ab8..2551365 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -107,6 +107,13 @@ config ORION_TIMER
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
index d227d13..801b65a 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
 obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
 obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
+obj-$(CONFIG_OWL_TIMER)		+= owl-timer.o
 
 obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
new file mode 100644
index 0000000..e218ad7
--- /dev/null
+++ b/drivers/clocksource/owl-timer.c
@@ -0,0 +1,146 @@
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
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define OWL_T0_CTL		0x08
+#define OWL_T0_CMP		0x0c
+#define OWL_T0_VAL		0x10
+#define OWL_T1_CTL		0x14
+#define OWL_T1_CMP		0x18
+#define OWL_T1_VAL		0x1c
+
+#define OWL_Tx_CTL_INTEN	(1 << 1)
+#define OWL_Tx_CTL_EN		(1 << 2)
+
+static void __iomem *owl_timer_base;
+
+static u64 notrace owl_timer_sched_read(void)
+{
+	return (u64)readl(owl_timer_base + OWL_T0_VAL);
+}
+
+static int owl_timer_set_state_shutdown(struct clock_event_device *evt)
+{
+	writel(0, owl_timer_base + OWL_T1_CTL);
+
+	return 0;
+}
+
+static int owl_timer_set_state_oneshot(struct clock_event_device *evt)
+{
+	writel(0, owl_timer_base + OWL_T1_CTL);
+	writel(0, owl_timer_base + OWL_T1_VAL);
+	writel(0, owl_timer_base + OWL_T1_CMP);
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
+	writel(0, owl_timer_base + OWL_T1_CTL);
+
+	writel(0, owl_timer_base + OWL_T1_VAL);
+	writel(evt, owl_timer_base + OWL_T1_CMP);
+
+	writel(OWL_Tx_CTL_EN | OWL_Tx_CTL_INTEN, owl_timer_base + OWL_T1_CTL);
+
+	return 0;
+}
+
+static struct clock_event_device owl_clockevent = {
+	.name			= "owl_tick",
+	.rating			= 200,
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= owl_timer_set_state_shutdown,
+	.set_state_oneshot	= owl_timer_set_state_oneshot,
+	.tick_resume		= owl_timer_tick_resume,
+	.set_next_event		= owl_timer_set_next_event,
+};
+
+static irqreturn_t owl_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction owl_timer_irq = {
+	.name = "owl-timer",
+	.flags = IRQF_TIMER,
+	.handler = owl_timer_interrupt,
+	.dev_id = &owl_clockevent,
+};
+
+static int __init owl_timer_init(struct device_node *node)
+{
+	const unsigned long rate = 24000000;
+	int irq1, ret;
+
+	owl_timer_base = of_io_request_and_map(node, 0, "owl-timer");
+	if (IS_ERR(owl_timer_base)) {
+		pr_err("Can't map timer registers");
+		return -ENXIO;
+	}
+
+	irq1 = irq_of_parse_and_map(node, 1);
+	if (irq1 <= 0) {
+		pr_err("Can't parse timer1 IRQ");
+		return -EINVAL;
+	}
+
+	writel(0, owl_timer_base + OWL_T0_CTL);
+	writel(0, owl_timer_base + OWL_T0_VAL);
+	writel(0, owl_timer_base + OWL_T0_CMP);
+	writel(OWL_Tx_CTL_EN, owl_timer_base + OWL_T0_CTL);
+
+	sched_clock_register(owl_timer_sched_read, 32, rate);
+	clocksource_mmio_init(owl_timer_base + OWL_T0_VAL, node->name,
+			      rate, 200, 32, clocksource_mmio_readl_up);
+
+	writel(0, owl_timer_base + OWL_T1_CTL);
+	writel(0, owl_timer_base + OWL_T1_VAL);
+	writel(0, owl_timer_base + OWL_T1_CMP);
+
+	ret = setup_irq(irq1, &owl_timer_irq);
+	if (ret) {
+		pr_warn("failed to setup irq %d\n", irq1);
+		return ret;
+	}
+
+	owl_clockevent.cpumask = cpumask_of(0);
+	owl_clockevent.irq = irq1;
+
+	clockevents_config_and_register(&owl_clockevent, rate,
+					0xf, 0xffffffff);
+
+	return 0;
+}
+CLOCKSOURCE_OF_DECLARE(owl, "actions,owl-timer", owl_timer_init);
-- 
2.10.2
