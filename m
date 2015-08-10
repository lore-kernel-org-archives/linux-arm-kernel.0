From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 10 Aug 2015 11:51:25 +0200
Subject: [PATCH 08/74] clockevents/drivers/exynos_mct: Remove unneeded
 container_of()
In-Reply-To: <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
References: <55C87382.4070309@linaro.org>
 <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1439200352-26767-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexey Klimov <klimov.linux@gmail.com>

Patch removes unneeded container_of() macro in exynos4_local_timer_setup().
Instead let's pass mevt pointer to setup and stop functions from
exynos4_mct_cpu_notify() and let them get evt pointer.

Tested on odroid-xu3.

Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 9064ff7..4d2330a 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -442,13 +442,11 @@ static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int exynos4_local_timer_setup(struct clock_event_device *evt)
+static int exynos4_local_timer_setup(struct mct_clock_event_device *mevt)
 {
-	struct mct_clock_event_device *mevt;
+	struct clock_event_device *evt = &mevt->evt;
 	unsigned int cpu = smp_processor_id();
 
-	mevt = container_of(evt, struct mct_clock_event_device, evt);
-
 	mevt->base = EXYNOS4_MCT_L_BASE(cpu);
 	snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d", cpu);
 
@@ -477,8 +475,10 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
 	return 0;
 }
 
-static void exynos4_local_timer_stop(struct clock_event_device *evt)
+static void exynos4_local_timer_stop(struct mct_clock_event_device *mevt)
 {
+	struct clock_event_device *evt = &mevt->evt;
+
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
 	if (mct_int_type == MCT_INT_SPI) {
 		if (evt->irq != -1)
@@ -500,11 +500,11 @@ static int exynos4_mct_cpu_notify(struct notifier_block *self,
 	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_STARTING:
 		mevt = this_cpu_ptr(&percpu_mct_tick);
-		exynos4_local_timer_setup(&mevt->evt);
+		exynos4_local_timer_setup(mevt);
 		break;
 	case CPU_DYING:
 		mevt = this_cpu_ptr(&percpu_mct_tick);
-		exynos4_local_timer_stop(&mevt->evt);
+		exynos4_local_timer_stop(mevt);
 		break;
 	}
 
@@ -570,7 +570,7 @@ static void __init exynos4_timer_resources(struct device_node *np, void __iomem
 		goto out_irq;
 
 	/* Immediately configure the timer on the boot CPU */
-	exynos4_local_timer_setup(&mevt->evt);
+	exynos4_local_timer_setup(mevt);
 	return;
 
 out_irq:
-- 
1.9.1
