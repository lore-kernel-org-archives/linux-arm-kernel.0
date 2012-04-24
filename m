From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 24 Apr 2012 16:05:34 +0200
Subject: [PATCH 13/18][V3] ARM: OMAP3: define statically the omap3_idle_data
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1335276339-11135-14-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the omap3_idle_data array at compile time, that will allow
to remove the initialization at boot time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   37 ++++++++++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index a82a887..93e2450 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -44,9 +44,36 @@ struct omap3_idle_statedata {
 	u32 core_state;
 };
 
-#define OMAP3_NUM_STATES 7
-
-struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
+struct omap3_idle_statedata omap3_idle_data[] = {
+	{
+		.mpu_state = PWRDM_POWER_ON,
+		.core_state = PWRDM_POWER_ON,
+	},
+	{
+		.mpu_state = PWRDM_POWER_ON,
+		.core_state = PWRDM_POWER_ON,
+	},
+	{
+		.mpu_state = PWRDM_POWER_RET,
+		.core_state = PWRDM_POWER_ON,
+	},
+	{
+		.mpu_state = PWRDM_POWER_OFF,
+		.core_state = PWRDM_POWER_ON,
+	},
+	{
+		.mpu_state = PWRDM_POWER_RET,
+		.core_state = PWRDM_POWER_RET,
+	},
+	{
+		.mpu_state = PWRDM_POWER_OFF,
+		.core_state = PWRDM_POWER_RET,
+	},
+	{
+		.mpu_state = PWRDM_POWER_OFF,
+		.core_state = PWRDM_POWER_OFF,
+	},
+};
 
 struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
 
@@ -172,7 +199,7 @@ static int next_valid_state(struct cpuidle_device *dev,
 	    (cx->core_state >= core_deepest_state)) {
 		return index;
 	} else {
-		int idx = OMAP3_NUM_STATES - 1;
+		int idx = ARRAY_SIZE(omap3_idle_data) - 1;
 
 		/* Reach the current state starting at highest C-state */
 		for (; idx >= 0; idx--) {
@@ -334,7 +361,7 @@ struct cpuidle_driver omap3_idle_driver = {
 			.desc		  = "MPU OFF + CORE OFF",
 		},
 	},
-	.state_count = OMAP3_NUM_STATES,
+	.state_count = ARRAY_SIZE(omap3_idle_data),
 	.safe_state_index = 0,
 };
 
-- 
1.7.5.4
