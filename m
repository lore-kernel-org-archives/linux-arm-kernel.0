From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:38 +0100
Subject: [RFC PATCH 10/16] ARM: local timers: add exynos_mct driver to
	driver/clocksource
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308251204-16719-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a "new" driver to driver/clocksource to support the Samsung MCT
hardware. This is basically the local timer part of
arch/arm/mach-exynos4/mct.c, turned into a platform driver, and
with a CPU notifier being used to start/stop timers on secondary
cores.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/Makefile      |    1 +
 drivers/clocksource/exynos4_mct.c |  283 +++++++++++++++++++++++++++++++++++++
 2 files changed, 284 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clocksource/exynos4_mct.c

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index b7e6397..7b30585 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
 obj-$(CONFIG_ARM_SMP_TWD)	+= arm_smp_twd.o
+obj-$(CONFIG_EXYNOS4_MCT)	+= exynos4_mct.o
diff --git a/drivers/clocksource/exynos4_mct.c b/drivers/clocksource/exynos4_mct.c
new file mode 100644
index 0000000..b07a9a9
--- /dev/null
+++ b/drivers/clocksource/exynos4_mct.c
@@ -0,0 +1,283 @@
+/*
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * EXYNOS4 MCT(Multi-Core Timer) support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/cpu.h>
+
+#include <mach/regs-mct.h>
+
+static unsigned long clk_cnt_per_tick;
+static unsigned long clk_rate;
+
+struct mct_clock_event_device {
+	struct clock_event_device evt;
+	void __iomem *base;
+};
+
+static struct mct_clock_event_device __percpu *mct_tick;
+
+static void exynos4_mct_write(unsigned int value, void *addr)
+{
+	void __iomem *stat_addr;
+	u32 mask;
+	u32 i;
+
+	__raw_writel(value, addr);
+
+	switch ((u32) addr) {
+	case (u32)(EXYNOS4_MCT_L0_BASE + MCT_L_TCON_OFFSET):
+		stat_addr = EXYNOS4_MCT_L0_BASE + MCT_L_WSTAT_OFFSET;
+		mask = 1 << 3;		/* L0_TCON write status */
+		break;
+	case (u32)(EXYNOS4_MCT_L1_BASE + MCT_L_TCON_OFFSET):
+		stat_addr = EXYNOS4_MCT_L1_BASE + MCT_L_WSTAT_OFFSET;
+		mask = 1 << 3;		/* L1_TCON write status */
+		break;
+	case (u32)(EXYNOS4_MCT_L0_BASE + MCT_L_TCNTB_OFFSET):
+		stat_addr = EXYNOS4_MCT_L0_BASE + MCT_L_WSTAT_OFFSET;
+		mask = 1 << 0;		/* L0_TCNTB write status */
+		break;
+	case (u32)(EXYNOS4_MCT_L1_BASE + MCT_L_TCNTB_OFFSET):
+		stat_addr = EXYNOS4_MCT_L1_BASE + MCT_L_WSTAT_OFFSET;
+		mask = 1 << 0;		/* L1_TCNTB write status */
+		break;
+	case (u32)(EXYNOS4_MCT_L0_BASE + MCT_L_ICNTB_OFFSET):
+		stat_addr = EXYNOS4_MCT_L0_BASE + MCT_L_WSTAT_OFFSET;
+		mask = 1 << 1;		/* L0_ICNTB write status */
+		break;
+	case (u32)(EXYNOS4_MCT_L1_BASE + MCT_L_ICNTB_OFFSET):
+		stat_addr = EXYNOS4_MCT_L1_BASE + MCT_L_WSTAT_OFFSET;
+		mask = 1 << 1;		/* L1_ICNTB write status */
+		break;
+	default:
+		return;
+	}
+
+	/* Wait maximum 1 ms until written values are applied */
+	for (i = 0; i < loops_per_jiffy / 1000 * HZ; i++)
+		if (__raw_readl(stat_addr) & mask) {
+			__raw_writel(mask, stat_addr);
+			return;
+		}
+
+	panic("MCT hangs after writing %d (addr:0x%08x)\n", value, (u32)addr);
+}
+
+/* Clock event handling */
+static void exynos4_mct_tick_stop(void *data)
+{
+	struct mct_clock_event_device *mevt = data;
+	unsigned long tmp;
+	unsigned long mask = MCT_L_TCON_INT_START | MCT_L_TCON_TIMER_START;
+	void __iomem *addr = mevt->base + MCT_L_TCON_OFFSET;
+
+	tmp = __raw_readl(addr);
+	if (tmp & mask) {
+		tmp &= ~mask;
+		exynos4_mct_write(tmp, addr);
+	}
+}
+
+static void exynos4_mct_tick_start(unsigned long cycles,
+				   struct mct_clock_event_device *mevt)
+{
+	unsigned long tmp;
+
+	exynos4_mct_tick_stop(mevt);
+
+	tmp = (1 << 31) | cycles;	/* MCT_L_UPDATE_ICNTB */
+
+	/* update interrupt count buffer */
+	exynos4_mct_write(tmp, mevt->base + MCT_L_ICNTB_OFFSET);
+
+	/* enable MCT tick interrupt */
+	exynos4_mct_write(0x1, mevt->base + MCT_L_INT_ENB_OFFSET);
+
+	tmp = __raw_readl(mevt->base + MCT_L_TCON_OFFSET);
+	tmp |= MCT_L_TCON_INT_START | MCT_L_TCON_TIMER_START |
+	       MCT_L_TCON_INTERVAL_MODE;
+	exynos4_mct_write(tmp, mevt->base + MCT_L_TCON_OFFSET);
+}
+
+static int exynos4_tick_set_next_event(unsigned long cycles,
+				       struct clock_event_device *evt)
+{
+	struct mct_clock_event_device *mevt;
+
+	mevt = container_of(evt, struct mct_clock_event_device, evt);
+	exynos4_mct_tick_start(cycles, mevt);
+
+	return 0;
+}
+
+static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
+					 struct clock_event_device *evt)
+{
+	struct mct_clock_event_device *mevt;
+
+	mevt = container_of(evt, struct mct_clock_event_device, evt);
+	exynos4_mct_tick_stop(mevt);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		exynos4_mct_tick_start(clk_cnt_per_tick, mevt);
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
+{
+	struct mct_clock_event_device *mevt = dev_id;
+	struct clock_event_device *evt = &mevt->evt;
+
+	/*
+	 * This is for supporting oneshot mode.
+	 * Mct would generate interrupt periodically
+	 * without explicit stopping.
+	 */
+	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
+		exynos4_mct_tick_stop(mevt);
+
+	/* Clear the MCT tick interrupt */
+	exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction mct_tick0_event_irq = {
+	.name		= "mct_tick0_irq",
+	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
+	.handler	= exynos4_mct_tick_isr,
+};
+
+static struct irqaction mct_tick1_event_irq = {
+	.name		= "mct_tick1_irq",
+	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
+	.handler	= exynos4_mct_tick_isr,
+};
+
+static void exynos4_mct_tick_init(void *data)
+{
+	struct mct_clock_event_device *mevt = data;
+	struct clock_event_device *evt = &mevt->evt;
+	unsigned int cpu = smp_processor_id();
+
+	if (cpu == 0) {
+		mevt->base = EXYNOS4_MCT_L0_BASE;
+		evt->name = "mct_tick0";
+	} else {
+		mevt->base = EXYNOS4_MCT_L1_BASE;
+		evt->name = "mct_tick1";
+	}
+
+	evt->cpumask = cpumask_of(cpu);
+	evt->set_next_event = exynos4_tick_set_next_event;
+	evt->set_mode = exynos4_tick_set_mode;
+	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	evt->rating = 450;
+
+	clockevents_calc_mult_shift(evt, clk_rate / 2, 5);
+	evt->max_delta_ns =
+		clockevent_delta2ns(0x7fffffff, evt);
+	evt->min_delta_ns =
+		clockevent_delta2ns(0xf, evt);
+
+	clockevents_register_device(evt);
+
+	exynos4_mct_write(0x1, mevt->base + MCT_L_TCNTB_OFFSET);
+
+	if (cpu == 0) {
+		mct_tick0_event_irq.dev_id = mevt;
+		setup_irq(IRQ_MCT_L0, &mct_tick0_event_irq);
+	} else {
+		mct_tick1_event_irq.dev_id = mevt;
+		irq_set_affinity(IRQ_MCT1, cpumask_of(1));
+		setup_irq(IRQ_MCT_L1, &mct_tick1_event_irq);
+	}
+}
+
+static int __cpuinit exynos4_mct_cpu_notify(struct notifier_block *self,
+					    unsigned long action, void *data)
+{
+	int cpu = (int)data;
+	struct mct_clock_event_device *mevt = per_cpu_ptr(mct_tick, cpu);
+
+	switch (action) {
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		smp_call_function_single(cpu, exynos4_mct_tick_init, mevt, 1);
+		break;
+
+	case CPU_DOWN_PREPARE:
+	case CPU_DOWN_PREPARE_FROZEN:
+		smp_call_function_single(cpu, exynos4_mct_tick_stop, mevt, 1);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata exynos4_mct_cpu_nb = {
+	.notifier_call = exynos4_mct_cpu_notify,
+};
+
+static int exynos4_mct_probe(struct platform_device *pdev)
+{
+	struct clk *mct_clk;
+	struct mct_clock_event_device *mevt;
+
+	if (mct_tick)
+		return -EBUSY;
+
+	mct_tick = alloc_percpu(struct mct_clock_event_device);
+	if (!mct_tick)
+		return -ENOMEM;
+
+	mct_clk = clk_get(NULL, "xtal");
+	clk_rate = clk_get_rate(mct_clk);
+
+	/* Immediately configure the timer on the boot CPU */
+	mevt = per_cpu_ptr(mct_tick, smp_processor_id());
+	exynos4_mct_tick_init(mevt);
+
+	register_cpu_notifier(&exynos4_mct_cpu_nb);
+
+	return 0;
+}
+
+static int exynos4_mct_remove(struct platform_device *pdev)
+{
+	return -EBUSY;
+}
+
+static struct platform_driver exynos4_mct_driver = {
+	.probe	= exynos4_mct_probe,
+	.remove = __devexit_p(exynos4_mct_remove),
+	.driver = {
+		.name	= "exynos4_mct",
+	},
+};
+
+early_platform_init("localtimer", &exynos4_mct_driver);
-- 
1.7.0.4
