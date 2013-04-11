From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 11 Apr 2013 22:42:32 +0200
Subject: [V2 patch 02/19] ARM: OMAP3: remove cpuidle_wrap_enter
In-Reply-To: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
References: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1365712969-7541-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a previous commit the en_core_tk_irqen flag has been added but we missed
the cpuidle_wrap_enter which was doing the job to measure the time for the
'omap3_enter_idle' function.

Actually, I don't see any reason to use this wrapper in the code. In the better
case, the time computation is not correctly done because of the different
operations done in omap3_enter_idle_bm which were not taken into account
before the en_core_tk_irqen flag was set.

As the time is reflected for the state overridden by the omap3_enter_idle_bm,
using the wrapper is pointless now, so removing it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 4f67a5b..a56310a 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -99,11 +99,15 @@ static struct omap3_idle_statedata omap3_idle_data[] = {
 	},
 };
 
-/* Private functions */
-
-static int __omap3_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
+/**
+ * omap3_enter_idle - Programs OMAP3 to enter the specified state
+ * @dev: cpuidle device
+ * @drv: cpuidle driver
+ * @index: the index of state to be entered
+ */
+static int omap3_enter_idle(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv,
+			    int index)
 {
 	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 
@@ -149,22 +153,6 @@ return_sleep_time:
 }
 
 /**
- * omap3_enter_idle - Programs OMAP3 to enter the specified state
- * @dev: cpuidle device
- * @drv: cpuidle driver
- * @index: the index of state to be entered
- *
- * Called from the CPUidle framework to program the device to the
- * specified target state selected by the governor.
- */
-static inline int omap3_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
-{
-	return cpuidle_wrap_enter(dev, drv, index, __omap3_enter_idle);
-}
-
-/**
  * next_valid_state - Find next valid C-state
  * @dev: cpuidle device
  * @drv: cpuidle driver
-- 
1.7.9.5
