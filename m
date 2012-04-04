From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  4 Apr 2012 22:12:41 +0200
Subject: [PATCH 07/17][V2] ARM: OMAP4: cpuidle - remove omap4_idle_data
 initialization at boot time
In-Reply-To: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1333570371-1389-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We initialized it at compile time, no need to do that at boot
time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   26 +-------------------------
 1 files changed, 1 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index b82f9fe..b0dd220 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -33,7 +33,7 @@ struct omap4_idle_statedata {
 
 #define OMAP4_NUM_STATES 3
 
-static struct omap4_idle_statedata omap4_idle_data[] = {
+static struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES] = {
 	{
 		.cpu_state = PWRDM_POWER_ON,
 		.mpu_state = PWRDM_POWER_ON,
@@ -172,14 +172,6 @@ struct cpuidle_driver omap4_idle_driver = {
 	.safe_state_index = 0,
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
@@ -188,7 +180,6 @@ static inline struct omap4_idle_statedata *_fill_cstate_usage(
  */
 int __init omap4_idle_init(void)
 {
-	struct omap4_idle_statedata *cx;
 	struct cpuidle_driver *drv = &omap4_idle_driver;
 	struct cpuidle_device *dev;
 	unsigned int cpu_id = 0;
@@ -202,21 +193,6 @@ int __init omap4_idle_init(void)
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
