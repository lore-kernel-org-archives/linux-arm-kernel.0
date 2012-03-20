From: rob.lee@linaro.org (Robert Lee)
Date: Tue, 20 Mar 2012 15:22:47 -0500
Subject: [PATCH v8 6/8] ARM: omap: Consolidate OMAP4 time keeping and irq
 enable
In-Reply-To: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1332274969-15782-7-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable core cpuidle timekeeping and irq enabling and remove that
handling from this code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Jean Pihet<j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 72e018b..f386cbe 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -62,15 +62,9 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 {
 	struct omap4_idle_statedata *cx =
 			cpuidle_get_statedata(&dev->states_usage[index]);
-	struct timespec ts_preidle, ts_postidle, ts_idle;
 	u32 cpu1_state;
-	int idle_time;
 	int cpu_id = smp_processor_id();
 
-	/* Used to keep track of the total time in idle */
-	getnstimeofday(&ts_preidle);
-
-	local_irq_disable();
 	local_fiq_disable();
 
 	/*
@@ -128,26 +122,17 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	if (index > 0)
 		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
 
-	getnstimeofday(&ts_postidle);
-	ts_idle = timespec_sub(ts_postidle, ts_preidle);
-
-	local_irq_enable();
 	local_fiq_enable();
 
-	idle_time = ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * \
-								USEC_PER_SEC;
-
-	/* Update cpuidle counters */
-	dev->last_residency = idle_time;
-
 	return index;
 }
 
 DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
 
 struct cpuidle_driver omap4_idle_driver = {
-	.name =		"omap4_idle",
-	.owner =	THIS_MODULE,
+	.name				= "omap4_idle",
+	.owner				= THIS_MODULE,
+	.en_core_tk_irqen		= 1,
 };
 
 static inline void _fill_cstate(struct cpuidle_driver *drv,
-- 
1.7.9.4
