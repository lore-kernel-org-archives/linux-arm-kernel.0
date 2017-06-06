From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue,  6 Jun 2017 14:44:11 +0200
Subject: [PATCH 1/2] clocksource/drivers: Add timer-of common init routine
Message-ID: <1496753054-7489-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The different drivers are all using the same pattern when initializing.

 1. Get the base address
 2. Get the irq number
 3. Get the clock
 4. Prepare and enable the clock
 5. Get the rate
 6. Request an interrupt

Instead of repeating again and again these steps in all the drivers, let's
provide a common init routine to give the opportunity to factor all of them
out.

We can expect a significant kernel size improvement when the common routine
will be used in all the drivers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Makefile   |   1 +
 drivers/clocksource/timer-of.c | 168 +++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/timer-of.h |  67 ++++++++++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 drivers/clocksource/timer-of.c
 create mode 100644 drivers/clocksource/timer-of.h

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index ec55921..72bfd00 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_TIMER_OF)		+= timer-of.o
 obj-$(CONFIG_TIMER_PROBE)	+= timer-probe.o
 obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
 obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
new file mode 100644
index 0000000..f25dc72
--- /dev/null
+++ b/drivers/clocksource/timer-of.c
@@ -0,0 +1,168 @@
+/*
+ * Copyright (c) 2017, Linaro Ltd.  All rights reserved.
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+
+#include "timer-of.h"
+
+static __init void timer_irq_exit(struct of_timer_irq *of_irq)
+{
+	struct timer_of *to = container_of(of_irq, struct timer_of, of_irq);
+
+	struct clock_event_device *clkevt = &to->clkevt;
+
+	of_irq->percpu ? free_percpu_irq(of_irq->irq, clkevt) :
+		free_irq(of_irq->irq, clkevt);
+}
+
+static __init int timer_irq_init(struct device_node *np,
+				 struct of_timer_irq *of_irq)
+{
+	int ret;
+	struct timer_of *to = container_of(of_irq, struct timer_of, of_irq);
+	struct clock_event_device *clkevt = &to->clkevt;
+
+	of_irq->irq = of_irq->name ? of_irq_get_byname(np, of_irq->name):
+		irq_of_parse_and_map(np, of_irq->index);
+	if (!of_irq->irq) {
+		pr_err("Failed to map interrupt for %s\n", np->full_name);
+		return -EINVAL;
+	}
+
+	ret = of_irq->percpu ?
+		request_percpu_irq(of_irq->irq, of_irq->handler,
+				   np->full_name, clkevt) :
+		request_irq(of_irq->irq, of_irq->handler, IRQF_TIMER,
+			    np->full_name, clkevt);
+	if (ret) {
+		pr_err("Failed to request irq %d for %s\n", of_irq->irq,
+		       np->full_name);
+		return ret;
+	}
+
+	clkevt->irq = of_irq->irq;
+
+	return 0;
+}
+
+static __init void timer_clk_exit(struct of_timer_clk *of_clk)
+{
+	of_clk->rate = 0;
+	clk_disable_unprepare(of_clk->clk);
+	clk_put(of_clk->clk);
+}
+
+static __init int timer_clk_init(struct device_node *np,
+				 struct of_timer_clk *of_clk)
+{
+	int ret;
+
+	of_clk->clk = of_clk->name ? of_clk_get_by_name(np, of_clk->name) :
+		of_clk_get(np, of_clk->index);
+	if (IS_ERR(of_clk->clk)) {
+		pr_err("Failed to get clock for %s\n", np->full_name);
+		return PTR_ERR(of_clk->clk);
+	}
+
+	ret = clk_prepare_enable(of_clk->clk);
+	if (ret) {
+		pr_err("Failed for enable clock for %s\n", np->full_name);
+		goto out_clk_put;
+	}
+
+	of_clk->rate = clk_get_rate(of_clk->clk);
+	if (!of_clk->rate) {
+		ret = -EINVAL;
+		pr_err("Failed to get clock rate for %s\n", np->full_name);
+		goto out_clk_disable;
+	}
+
+	of_clk->period = DIV_ROUND_UP(of_clk->rate, HZ);
+out:
+	return ret;
+
+out_clk_disable:
+	clk_disable_unprepare(of_clk->clk);
+out_clk_put:
+	clk_put(of_clk->clk);
+
+	goto out;
+}
+
+static __init void timer_base_exit(struct of_timer_base *of_base)
+{
+	iounmap(of_base->base);
+}
+
+static __init int timer_base_init(struct device_node *np,
+				  struct of_timer_base *of_base)
+{
+	const char *name = of_base->name ? of_base->name : np->full_name;
+
+	of_base->base = of_io_request_and_map(np, of_base->index, name);
+	if (of_base->base) {
+		pr_err("Failed to iomap (%s)\n", name);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+int __init timer_of_init(struct device_node *np, struct timer_of *to)
+{
+	int ret;
+	int flags = 0;
+
+	if (to->flags & TIMER_OF_BASE) {
+		ret = timer_base_init(np, &to->of_base);
+		if (ret)
+			goto out_fail;
+		flags |= TIMER_OF_BASE;
+	}
+
+	if (to->flags & TIMER_OF_CLOCK) {
+		ret = timer_clk_init(np, &to->of_clk);
+		if (ret)
+			goto out_fail;
+		flags |= TIMER_OF_CLOCK;
+	}
+
+	if (to->flags & TIMER_OF_IRQ) {
+		ret = timer_irq_init(np, &to->of_irq);
+		if (ret)
+			goto out_fail;
+		flags |= TIMER_OF_IRQ;
+	}
+out:
+	return ret;
+
+out_fail:
+	if (flags & TIMER_OF_IRQ)
+		timer_irq_exit(&to->of_irq);
+
+	if (flags & TIMER_OF_CLOCK)
+		timer_clk_exit(&to->of_clk);
+
+	if (flags & TIMER_OF_BASE)
+		timer_base_exit(&to->of_base);
+	goto out;
+}
diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
new file mode 100644
index 0000000..70b55aee
--- /dev/null
+++ b/drivers/clocksource/timer-of.h
@@ -0,0 +1,67 @@
+#ifndef __TIMER_OF_H__
+#define __TIMER_OF_H__
+
+#include <linux/clockchips.h>
+
+#define TIMER_OF_BASE	0x1
+#define TIMER_OF_CLOCK	0x2
+#define TIMER_OF_IRQ	0x4
+
+struct of_timer_irq {
+	int irq;
+	int index;
+	int percpu;
+	const char *name;
+	irq_handler_t handler;
+};
+
+struct of_timer_base {
+	void __iomem *base;
+	const char *name;
+	int index;
+};
+
+struct of_timer_clk {
+	struct clk *clk;
+	const char *name;
+	int index;
+	unsigned long rate;
+	unsigned long period;
+};
+
+struct timer_of {
+	unsigned int flags;
+	struct clock_event_device clkevt;
+	struct of_timer_base of_base;
+	struct of_timer_irq  of_irq;
+	struct of_timer_clk  of_clk;
+};
+
+static inline struct timer_of *to_timer_of(struct clock_event_device *clkevt)
+{
+	return container_of(clkevt, struct timer_of, clkevt);
+}
+
+static inline void __iomem *timer_of_base(struct timer_of *to)
+{
+	return to->of_base.base;
+}
+
+static inline int timer_of_irq(struct timer_of *to)
+{
+	return to->of_irq.irq;
+}
+
+static inline unsigned long timer_of_rate(struct timer_of *to)
+{
+	return to->of_clk.rate;
+}
+
+static inline unsigned long timer_of_period(struct timer_of *to)
+{
+	return to->of_clk.period;
+}
+
+extern int __init timer_of_init(struct device_node *np,
+				struct timer_of *to);
+#endif
-- 
2.7.4
