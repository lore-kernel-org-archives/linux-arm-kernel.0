From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 21 Mar 2012 10:27:49 +0100
Subject: [RFC][PATCH 6/7] ARM: OMAP4: cpuidle - use the omap4_idle_data
 variable directly
In-Reply-To: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1332322070-24577-7-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are storing the 'omap4_idle_data' in the private data field
if the cpuidle device. As we are using this variable only in this file,
that does not really make sense. Let's use the global variable directly
instead dereferencing pointers in an idle critical loop.

Also, that simplfies the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index e14cd56..cb91d1f 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -24,7 +24,7 @@
 
 #ifdef CONFIG_CPU_IDLE
 
-/* Machine specific information to be recorded in the C-state driver_data */
+/* Machine specific information */
 struct omap4_idle_statedata {
 	u32 cpu_state;
 	u32 mpu_logic_state;
@@ -67,8 +67,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
-	struct omap4_idle_statedata *cx =
-			cpuidle_get_statedata(&dev->states_usage[index]);
+	struct omap4_idle_statedata *cx = &omap4_idle_data[index];
 	struct timespec ts_preidle, ts_postidle, ts_idle;
 	u32 cpu1_state;
 	int idle_time;
@@ -92,7 +91,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
 	if (cpu1_state != PWRDM_POWER_OFF) {
 		new_state_idx = drv->safe_state_index;
-		cx = cpuidle_get_statedata(&dev->states_usage[new_state_idx]);
+		cx = &omap4_idle_data[new_state_idx]
 	}
 
 	if (index > 0)
@@ -193,15 +192,9 @@ static inline struct omap4_idle_statedata *_fill_cstate_usage(
 					int idx)
 {
 	struct omap4_idle_statedata *cx = &omap4_idle_data[idx];
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[idx];
-
-	cpuidle_set_statedata(state_usage, cx);
-
 	return cx;
 }
 
-
-
 /**
  * omap4_idle_init - Init routine for OMAP4 idle
  *
@@ -210,9 +203,9 @@ static inline struct omap4_idle_statedata *_fill_cstate_usage(
  */
 int __init omap4_idle_init(void)
 {
-	struct omap4_idle_statedata *cx;
-	struct cpuidle_device *dev;
+	struct omap4_idle_statedata *cx = &omap4_idle_data[index];
 	struct cpuidle_driver *drv = &omap4_idle_driver;
+	struct cpuidle_device *dev;
 	unsigned int cpu_id = 0;
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
-- 
1.7.5.4
