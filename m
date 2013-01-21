From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 21 Jan 2013 02:02:17 -0800
Subject: [PATCH v4 2/7] ARM: Exynos: prepare an array of MCT interrupt numbers
 and use it
In-Reply-To: <1358762542-19008-1-git-send-email-thomas.abraham@linaro.org>
References: <1358762542-19008-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1358762542-19008-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using soc_is_xxx macro at more than one place in the MCT
controller driver to decide the MCT interrpt number to be setup, populate
a table of known MCT global and local timer interrupts and use the values
in table to setup the MCT interrupts.

This also helps in adding device tree support for MCT controller driver by
allowing the driver to retrieve interrupt numbers from device tree and
populating them into this table, thereby supporting both legacy and dt
functionality to co-exist.

Cc: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/mct.c |   57 +++++++++++++++++++++++++++----------------
 1 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index 6ceb1dd..3c91511 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -66,9 +66,22 @@ enum {
 	MCT_INT_PPI
 };
 
+enum {
+	MCT_G0_IRQ,
+	MCT_G1_IRQ,
+	MCT_G2_IRQ,
+	MCT_G3_IRQ,
+	MCT_L0_IRQ,
+	MCT_L1_IRQ,
+	MCT_L2_IRQ,
+	MCT_L3_IRQ,
+	MCT_NR_IRQS,
+};
+
 static void __iomem *reg_base;
 static unsigned long clk_rate;
 static unsigned int mct_int_type;
+static int mct_irqs[MCT_NR_IRQS];
 
 struct mct_clock_event_device {
 	struct clock_event_device *evt;
@@ -287,11 +300,7 @@ static void exynos4_clockevent_init(void)
 		clockevent_delta2ns(0xf, &mct_comp_device);
 	mct_comp_device.cpumask = cpumask_of(0);
 	clockevents_register_device(&mct_comp_device);
-
-	if (soc_is_exynos5250())
-		setup_irq(EXYNOS5_IRQ_MCT_G0, &mct_comp_event_irq);
-	else
-		setup_irq(EXYNOS4_IRQ_MCT_G0, &mct_comp_event_irq);
+	setup_irq(mct_irqs[MCT_G0_IRQ], &mct_comp_event_irq);
 }
 
 #ifdef CONFIG_LOCAL_TIMERS
@@ -415,7 +424,6 @@ static int __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
 {
 	struct mct_clock_event_device *mevt;
 	unsigned int cpu = smp_processor_id();
-	int mct_lx_irq;
 
 	mevt = this_cpu_ptr(&percpu_mct_tick);
 	mevt->evt = evt;
@@ -442,21 +450,17 @@ static int __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
 
 	if (mct_int_type == MCT_INT_SPI) {
 		if (cpu == 0) {
-			mct_lx_irq = soc_is_exynos4210() ? EXYNOS4_IRQ_MCT_L0 :
-						EXYNOS5_IRQ_MCT_L0;
 			mct_tick0_event_irq.dev_id = mevt;
-			evt->irq = mct_lx_irq;
-			setup_irq(mct_lx_irq, &mct_tick0_event_irq);
+			evt->irq = mct_irqs[MCT_L0_IRQ];
+			setup_irq(evt->irq, &mct_tick0_event_irq);
 		} else {
-			mct_lx_irq = soc_is_exynos4210() ? EXYNOS4_IRQ_MCT_L1 :
-						EXYNOS5_IRQ_MCT_L1;
 			mct_tick1_event_irq.dev_id = mevt;
-			evt->irq = mct_lx_irq;
-			setup_irq(mct_lx_irq, &mct_tick1_event_irq);
-			irq_set_affinity(mct_lx_irq, cpumask_of(1));
+			evt->irq = mct_irqs[MCT_L1_IRQ];
+			setup_irq(evt->irq, &mct_tick1_event_irq);
+			irq_set_affinity(evt->irq, cpumask_of(1));
 		}
 	} else {
-		enable_percpu_irq(EXYNOS_IRQ_MCT_LOCALTIMER, 0);
+		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
 	}
 
 	return 0;
@@ -472,7 +476,7 @@ static void exynos4_local_timer_stop(struct clock_event_device *evt)
 		else
 			remove_irq(evt->irq, &mct_tick1_event_irq);
 	else
-		disable_percpu_irq(EXYNOS_IRQ_MCT_LOCALTIMER);
+		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
 }
 
 static struct local_timer_ops exynos4_mct_tick_ops __cpuinitdata = {
@@ -494,11 +498,11 @@ static void __init exynos4_timer_resources(void)
 	if (mct_int_type == MCT_INT_PPI) {
 		int err;
 
-		err = request_percpu_irq(EXYNOS_IRQ_MCT_LOCALTIMER,
+		err = request_percpu_irq(mct_irqs[MCT_L0_IRQ],
 					 exynos4_mct_tick_isr, "MCT",
 					 &percpu_mct_tick);
 		WARN(err, "MCT: can't request IRQ %d (%d)\n",
-		     EXYNOS_IRQ_MCT_LOCALTIMER, err);
+		     mct_irqs[MCT_L0_IRQ], err);
 	}
 
 	local_timer_register(&exynos4_mct_tick_ops);
@@ -512,10 +516,21 @@ void __init exynos4_timer_init(void)
 		return;
 	}
 
-	if ((soc_is_exynos4210()) || (soc_is_exynos5250()))
+	if (soc_is_exynos4210()) {
+		mct_irqs[MCT_G0_IRQ] = EXYNOS4_IRQ_MCT_G0;
+		mct_irqs[MCT_L0_IRQ] = EXYNOS4_IRQ_MCT_L0;
+		mct_irqs[MCT_L1_IRQ] = EXYNOS4_IRQ_MCT_L1;
 		mct_int_type = MCT_INT_SPI;
-	else
+	} else if (soc_is_exynos5250()) {
+		mct_irqs[MCT_G0_IRQ] = EXYNOS5_IRQ_MCT_G0;
+		mct_irqs[MCT_L0_IRQ] = EXYNOS5_IRQ_MCT_L0;
+		mct_irqs[MCT_L1_IRQ] = EXYNOS5_IRQ_MCT_L1;
+		mct_int_type = MCT_INT_SPI;
+	} else {
+		mct_irqs[MCT_G0_IRQ] = EXYNOS4_IRQ_MCT_G0;
+		mct_irqs[MCT_L0_IRQ] = EXYNOS_IRQ_MCT_LOCALTIMER;
 		mct_int_type = MCT_INT_PPI;
+	}
 
 	exynos4_timer_resources();
 	exynos4_clocksource_init();
-- 
1.7.5.4
