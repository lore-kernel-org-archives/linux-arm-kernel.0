From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 21 Mar 2012 10:27:50 +0100
Subject: [RFC][PATCH 7/7] ARM: OMAP4: cpuidle - remove omap4_idle_data
 initialization at boot time
In-Reply-To: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1332322070-24577-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We initialized it at compile time, no need to do that at boot
time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   26 +-------------------------
 1 files changed, 1 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index cb91d1f..fd220f9 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -33,7 +33,7 @@ struct omap4_idle_statedata {
 
 #define OMAP4_NUM_STATES 3
 
-static struct omap4_idle_statedata omap4_idle_data[] = {
+static struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES] = {
 	{
 		.cpu_state = PWRDM_POWER_ON,
 		.mpu_state = PWRDM_POWER_ON,
@@ -187,14 +187,6 @@ struct cpuidle_driver omap4_idle_driver = {
 	.state_count = OMAP4_NUM_STATES,
 };
 
-static inline struct omap4_idle_statedata *_fill_cstate_usage(
-					struct cpuidle_device *dev,
-					int idx)
-{
-	struct omap4_idle_statedata *cx = &omap4_idle_data[idx];
-	return cx;
-}
-
 /**
  * omap4_idle_init - Init routine for OMAP4 idle
  *
@@ -203,7 +195,6 @@ static inline struct omap4_idle_statedata *_fill_cstate_usage(
  */
 int __init omap4_idle_init(void)
 {
-	struct omap4_idle_statedata *cx = &omap4_idle_data[index];
 	struct cpuidle_driver *drv = &omap4_idle_driver;
 	struct cpuidle_device *dev;
 	unsigned int cpu_id = 0;
@@ -217,21 +208,6 @@ int __init omap4_idle_init(void)
 	dev = &per_cpu(omap4_idle_dev, cpu_id);
 	dev->cpu = cpu_id;
 
-	cx = _fill_cstate_usage(dev, 0);
-	cx->cpu_state = PWRDM_POWER_ON;
-	cx->mpu_state = PWRDM_POWER_ON;
-	cx->mpu_logic_state = PWRDM_POWER_RET;
-
-	cx = _fill_cstate_usage(dev, 1);
-	cx->cpu_state = PWRDM_POWER_OFF;
-	cx->mpu_state = PWRDM_POWER_RET;
-	cx->mpu_logic_state = PWRDM_POWER_RET;
-
-	cx = _fill_cstate_usage(dev, 2);
-	cx->cpu_state = PWRDM_POWER_OFF;
-	cx->mpu_state = PWRDM_POWER_RET;
-	cx->mpu_logic_state = PWRDM_POWER_OFF;
-
 	cpuidle_register_driver(&omap4_idle_driver);
 
 	dev->state_count = drv->state_count;
-- 
1.7.5.4
