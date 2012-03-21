From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 21 Mar 2012 10:27:45 +0100
Subject: [RFC][PATCH 2/7] ARM: OMAP4: cpuidle - Declare the states with the
 driver declaration
In-Reply-To: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1332322070-24577-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpuidle API allows to declare statically the states in the driver
structure. Let's use it.
We do no longer need the fill_cstate function called at runtime and
by the way adding more instructions at boot time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   56 +++++++++++++++++++++----------------
 1 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 1210229..cd6bee7 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -148,21 +148,38 @@ DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
 struct cpuidle_driver omap4_idle_driver = {
 	.name =		"omap4_idle",
 	.owner =	THIS_MODULE,
+	.states = {
+		{
+			/* C1 - CPU0 ON + CPU1 ON + MPU ON */
+			.exit_latency = 2 + 2,
+			.target_residency = 5,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = omap4_enter_idle,
+			.name = "C1",
+			.desc = "MPUSS ON"
+		},
+		{
+                        /* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
+			.exit_latency = 328 + 440,
+			.target_residency = 960,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = omap4_enter_idle,
+			.name = "C2",
+			.desc = "MPUSS CSWR",
+		},
+		{
+			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
+			.exit_latency = 460 + 518,
+			.target_residency = 1100,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = omap4_enter_idle,
+			.name = "C3",
+			.desc = "MPUSS OSWR",
+		},
+	},
+	.state_count = OMAP4_NUM_STATES,
 };
 
-static inline void _fill_cstate(struct cpuidle_driver *drv,
-					int idx, const char *descr)
-{
-	struct cpuidle_state *state = &drv->states[idx];
-
-	state->exit_latency	= cpuidle_params_table[idx].exit_latency;
-	state->target_residency	= cpuidle_params_table[idx].target_residency;
-	state->flags		= CPUIDLE_FLAG_TIME_VALID;
-	state->enter		= omap4_enter_idle;
-	sprintf(state->name, "C%d", idx + 1);
-	strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
-}
-
 static inline struct omap4_idle_statedata *_fill_cstate_usage(
 					struct cpuidle_device *dev,
 					int idx)
@@ -196,37 +213,28 @@ int __init omap4_idle_init(void)
 	if ((!mpu_pd) || (!cpu0_pd) || (!cpu1_pd))
 		return -ENODEV;
 
-
-	drv->safe_state_index = -1;
 	dev = &per_cpu(omap4_idle_dev, cpu_id);
 	dev->cpu = cpu_id;
 
-	/* C1 - CPU0 ON + CPU1 ON + MPU ON */
-	_fill_cstate(drv, 0, "MPUSS ON");
-	drv->safe_state_index = 0;
 	cx = _fill_cstate_usage(dev, 0);
 	cx->cpu_state = PWRDM_POWER_ON;
 	cx->mpu_state = PWRDM_POWER_ON;
 	cx->mpu_logic_state = PWRDM_POWER_RET;
 
-	/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
-	_fill_cstate(drv, 1, "MPUSS CSWR");
 	cx = _fill_cstate_usage(dev, 1);
 	cx->cpu_state = PWRDM_POWER_OFF;
 	cx->mpu_state = PWRDM_POWER_RET;
 	cx->mpu_logic_state = PWRDM_POWER_RET;
 
-	/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
-	_fill_cstate(drv, 2, "MPUSS OSWR");
 	cx = _fill_cstate_usage(dev, 2);
 	cx->cpu_state = PWRDM_POWER_OFF;
 	cx->mpu_state = PWRDM_POWER_RET;
 	cx->mpu_logic_state = PWRDM_POWER_OFF;
 
-	drv->state_count = OMAP4_NUM_STATES;
 	cpuidle_register_driver(&omap4_idle_driver);
 
-	dev->state_count = OMAP4_NUM_STATES;
+	dev->state_count = drv->state_count;
+
 	if (cpuidle_register_device(dev)) {
 		pr_err("%s: CPUidle register device failed\n", __func__);
 			return -EIO;
-- 
1.7.5.4
