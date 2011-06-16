From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:30 +0100
Subject: [RFC PATCH 02/16] ARM: local timers: add arm_smp_twd driver to
	driver/clocksource
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308251204-16719-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a "new" driver to driver/clocksource to support the ARM TWD
hardware. This is basically a copy of arch/arm/kernel/smp_twd.c,
turned into a platform driver, with a CPU notifier being used
to start/stop timers on secondary cores.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/Kconfig       |    3 +
 drivers/clocksource/Makefile      |    1 +
 drivers/clocksource/arm_smp_twd.c |  265 +++++++++++++++++++++++++++++++++++++
 3 files changed, 269 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clocksource/arm_smp_twd.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 330343b..a436dd4 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -9,3 +9,6 @@ config CLKBLD_I8253
 
 config CLKSRC_MMIO
 	bool
+
+config ARM_SMP_TWD
+       bool
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 7922a0c..b7e6397 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_SH_TIMER_MTU2)	+= sh_mtu2.o
 obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
+obj-$(CONFIG_ARM_SMP_TWD)	+= arm_smp_twd.o
diff --git a/drivers/clocksource/arm_smp_twd.c b/drivers/clocksource/arm_smp_twd.c
new file mode 100644
index 0000000..5e2e8cc
--- /dev/null
+++ b/drivers/clocksource/arm_smp_twd.c
@@ -0,0 +1,265 @@
+/*
+ *  linux/arch/arm/kernel/smp_twd.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <linux/cpu.h>
+#include <linux/jiffies.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+
+#include <asm/hardware/gic.h>
+
+#define TWD_TIMER_LOAD			0x00
+#define TWD_TIMER_COUNTER		0x04
+#define TWD_TIMER_CONTROL		0x08
+#define TWD_TIMER_INTSTAT		0x0C
+
+#define TWD_TIMER_CONTROL_ENABLE	(1 << 0)
+#define TWD_TIMER_CONTROL_ONESHOT	(0 << 1)
+#define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
+#define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
+
+static void __iomem *twd_base;
+static int twd_ppi;
+
+static unsigned long twd_timer_rate;
+static DEFINE_PER_CPU(bool, irq_reqd);
+static struct clock_event_device __percpu *twd_evt;
+
+static void twd_set_mode(enum clock_event_mode mode,
+			 struct clock_event_device *clk)
+{
+	unsigned long ctrl;
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		/* timer load already set up */
+		ctrl = TWD_TIMER_CONTROL_ENABLE | TWD_TIMER_CONTROL_IT_ENABLE
+			| TWD_TIMER_CONTROL_PERIODIC;
+		__raw_writel(twd_timer_rate / HZ, twd_base + TWD_TIMER_LOAD);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* period set, and timer enabled in 'next_event' hook */
+		ctrl = TWD_TIMER_CONTROL_IT_ENABLE | TWD_TIMER_CONTROL_ONESHOT;
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	default:
+		ctrl = 0;
+	}
+
+	__raw_writel(ctrl, twd_base + TWD_TIMER_CONTROL);
+}
+
+static int twd_set_next_event(unsigned long evt,
+			      struct clock_event_device *unused)
+{
+	unsigned long ctrl = __raw_readl(twd_base + TWD_TIMER_CONTROL);
+
+	ctrl |= TWD_TIMER_CONTROL_ENABLE;
+
+	__raw_writel(evt, twd_base + TWD_TIMER_COUNTER);
+	__raw_writel(ctrl, twd_base + TWD_TIMER_CONTROL);
+
+	return 0;
+}
+
+static irqreturn_t twd_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	if (__raw_readl(twd_base + TWD_TIMER_INTSTAT)) {
+		__raw_writel(1, twd_base + TWD_TIMER_INTSTAT);
+		evt->event_handler(evt);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static void __cpuinit twd_calibrate_rate(void)
+{
+	unsigned long count;
+	u64 waitjiffies;
+
+	/*
+	 * If this is the first time round, we need to work out how fast
+	 * the timer ticks
+	 */
+	if (twd_timer_rate == 0) {
+		printk(KERN_INFO "Calibrating local timer... ");
+
+		/* Wait for a tick to start */
+		waitjiffies = get_jiffies_64() + 1;
+
+		while (get_jiffies_64() < waitjiffies)
+			udelay(10);
+
+		/* OK, now the tick has started, let's get the timer going */
+		waitjiffies += 5;
+
+				 /* enable, no interrupt or reload */
+		__raw_writel(0x1, twd_base + TWD_TIMER_CONTROL);
+
+				 /* maximum value */
+		__raw_writel(0xFFFFFFFFU, twd_base + TWD_TIMER_COUNTER);
+
+		while (get_jiffies_64() < waitjiffies)
+			udelay(10);
+
+		count = __raw_readl(twd_base + TWD_TIMER_COUNTER);
+
+		twd_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);
+
+		printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
+			(twd_timer_rate / 1000000) % 100);
+	}
+}
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+static void __cpuinit twd_setup(void *data)
+{
+	struct clock_event_device *clk = data;
+	int err;
+
+	twd_calibrate_rate();
+
+	clk->name = "arm_smp_twd";
+	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+			CLOCK_EVT_FEAT_C3STOP;
+	clk->rating = 450;
+	clk->set_mode = twd_set_mode;
+	clk->set_next_event = twd_set_next_event;
+	clk->shift = 20;
+	clk->mult = div_sc(twd_timer_rate, NSEC_PER_SEC, clk->shift);
+	clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
+	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
+	clk->irq = gic_ppi_to_vppi(twd_ppi);
+	clk->cpumask = cpumask_of(smp_processor_id());
+
+	pr_debug("Configuring %s on cpu #%d\n", clk->name, smp_processor_id());
+
+	err = request_irq(clk->irq, twd_handler,
+			  IRQF_PERCPU | IRQF_NOBALANCING | IRQF_TIMER,
+			  clk->name, clk);
+	if (err) {
+		pr_err("%s: can't register interrupt %d on cpu %d (%d)\n",
+		       clk->name, clk->irq, smp_processor_id(), err);
+		return;
+	}
+
+	clockevents_register_device(clk);
+}
+
+static void __cpuinit twd_teardown(void *data)
+{
+	struct clock_event_device *clk = data;
+	pr_debug("twd_teardown disable IRQ%d cpu #%d\n",
+		 clk->irq, smp_processor_id());
+	disable_irq(clk->irq);
+	twd_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
+}
+
+static void __cpuinit twd_restart(void *data)
+{
+	struct clock_event_device *clk = data;
+	pr_debug("twd_restart enable IRQ%d cpu #%d\n",
+		 clk->irq, smp_processor_id());
+	enable_irq(clk->irq);
+	clockevents_register_device(clk);
+}
+
+static int __cpuinit twd_cpu_notify(struct notifier_block *self,
+				    unsigned long action, void *data)
+{
+	int cpu = (int)data;
+	struct clock_event_device *clk = per_cpu_ptr(twd_evt, cpu);
+	bool *reqd = &per_cpu(irq_reqd, cpu);
+
+	switch (action) {
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		if (!*reqd) {
+			smp_call_function_single(cpu, twd_setup, clk, 1);
+			*reqd = true;
+		} else {
+			smp_call_function_single(cpu, twd_restart, clk, 1);
+		}
+		break;
+
+	case CPU_DOWN_PREPARE:
+	case CPU_DOWN_PREPARE_FROZEN:
+		smp_call_function_single(cpu, twd_teardown, clk, 1);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata twd_cpu_nb = {
+	.notifier_call = twd_cpu_notify,
+};
+
+static int twd_probe(struct platform_device *pdev)
+{
+	struct resource *mem;
+	struct clock_event_device *clk;
+	int irq;
+
+	if (twd_base)
+		return -EBUSY;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (!mem || irq < 0)
+		return -EINVAL;
+
+	twd_base	= ioremap(mem->start, resource_size(mem));
+	twd_evt		= alloc_percpu(struct clock_event_device);
+	if (!twd_base || !twd_evt) {
+		iounmap(twd_base);
+		twd_base = NULL;
+		free_percpu(twd_evt);
+		return -ENOMEM;
+	}
+
+	twd_ppi = irq;
+
+	/* Immediately configure the timer on the boot CPU */
+	clk = per_cpu_ptr(twd_evt, smp_processor_id());
+	twd_setup(clk);
+
+	register_cpu_notifier(&twd_cpu_nb);
+
+	return 0;
+}
+
+static int twd_remove(struct platform_device *pdev)
+{
+	return -EBUSY;
+}
+
+static struct platform_driver twd_driver = {
+	.probe	= twd_probe,
+	.remove = __devexit_p(twd_remove),
+	.driver = {
+		.name	= "arm_smp_twd",
+	},
+};
+
+early_platform_init("localtimer", &twd_driver);
-- 
1.7.0.4
