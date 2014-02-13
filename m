From: t.dakhran@samsung.com (Tarek Dakhran)
Date: Thu, 13 Feb 2014 12:08:42 +0900
Subject: [PATCH v1 1/2] clocksource: mct: remove request_irq from
 exynos4_local_timer_setup
In-Reply-To: <1392260923-31659-1-git-send-email-t.dakhran@samsung.com>
References: <1392260923-31659-1-git-send-email-t.dakhran@samsung.com>
Message-ID: <1392260923-31659-2-git-send-email-t.dakhran@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

exynos4_local_timer_setup called on the secondary cpu before
irqs are enabled. request_irq can sleep, which produces next warning:

	BUG: sleeping function called from invalid context at mm/slub.c:965
	in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/3

Call setup_irq for each local timer in exynos4_timer_resources,
and only call enable_irq during percpu timer setup.

Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
---
 drivers/clocksource/exynos_mct.c |   38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 48f76bc..1cde3de 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -82,6 +82,7 @@ static void __iomem *reg_base;
 static unsigned long clk_rate;
 static unsigned int mct_int_type;
 static int mct_irqs[MCT_NR_IRQS];
+static struct irqaction __percpu *mct_LX_irqaction;
 
 struct mct_clock_event_device {
 	struct clock_event_device evt;
@@ -402,6 +403,25 @@ static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void exynos4_setup_irqaction_spi(unsigned int cpu)
+{
+	struct irqaction *pcpu_irqaction = per_cpu_ptr(mct_LX_irqaction, cpu);
+	unsigned int irq = mct_irqs[MCT_L0_IRQ + cpu];
+	int err;
+
+	pcpu_irqaction->name = per_cpu(percpu_mct_tick, cpu).name;
+	pcpu_irqaction->flags  = IRQF_TIMER | IRQF_NOBALANCING;
+	pcpu_irqaction->handler = exynos4_mct_tick_isr;
+	pcpu_irqaction->dev_id = &per_cpu(percpu_mct_tick, cpu);
+
+	err = setup_irq(irq, pcpu_irqaction);
+	if (err) {
+		pr_err("MCT: can't setup IRQ %d (%d)\n", irq, err);
+		return;
+	}
+	disable_irq(irq);
+}
+
 static int exynos4_local_timer_setup(struct clock_event_device *evt)
 {
 	struct mct_clock_event_device *mevt;
@@ -425,13 +445,7 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
 
 	if (mct_int_type == MCT_INT_SPI) {
 		evt->irq = mct_irqs[MCT_L0_IRQ + cpu];
-		if (request_irq(evt->irq, exynos4_mct_tick_isr,
-				IRQF_TIMER | IRQF_NOBALANCING,
-				evt->name, mevt)) {
-			pr_err("exynos-mct: cannot register IRQ %d\n",
-				evt->irq);
-			return -EIO;
-		}
+		enable_irq(evt->irq);
 	} else {
 		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
 	}
@@ -443,7 +457,7 @@ static void exynos4_local_timer_stop(struct clock_event_device *evt)
 {
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
 	if (mct_int_type == MCT_INT_SPI)
-		free_irq(evt->irq, this_cpu_ptr(&percpu_mct_tick));
+		disable_irq(evt->irq);
 	else
 		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
 }
@@ -485,9 +499,12 @@ static struct notifier_block exynos4_mct_cpu_nb = {
 static void __init exynos4_timer_resources(struct device_node *np, void __iomem *base)
 {
 	int err;
+	u32 i, cpu, nr_irqs;
 	struct mct_clock_event_device *mevt = this_cpu_ptr(&percpu_mct_tick);
 	struct clk *mct_clk, *tick_clk;
 
+	nr_irqs = of_irq_count(np);
+
 	tick_clk = np ? of_clk_get_by_name(np, "fin_pll") :
 				clk_get(NULL, "fin_pll");
 	if (IS_ERR(tick_clk))
@@ -511,6 +528,11 @@ static void __init exynos4_timer_resources(struct device_node *np, void __iomem
 		WARN(err, "MCT: can't request IRQ %d (%d)\n",
 		     mct_irqs[MCT_L0_IRQ], err);
 	} else {
+		mct_LX_irqaction = alloc_percpu(struct irqaction);
+		BUG_ON(!mct_LX_irqaction);
+
+		for (i = MCT_L0_IRQ, cpu = 0; i < nr_irqs; i++, cpu++)
+			exynos4_setup_irqaction_spi(cpu);
 		irq_set_affinity(mct_irqs[MCT_L0_IRQ], cpumask_of(0));
 	}
 
-- 
1.7.10.4
