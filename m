From: tony@atomide.com (Tony Lindgren)
Date: Fri,  9 Feb 2018 09:47:39 -0800
Subject: [PATCH] ARM: OMAP2+: Handle errors from cpu_pm_enter()
Message-ID: <20180209174739.31072-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's add error handling since we actually might get some.

Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -125,6 +125,7 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 {
 	struct idle_statedata *cx = state_ptr + index;
 	u32 mpuss_can_lose_context = 0;
+	int error;
 
 	/*
 	 * CPU0 has to wait and stay ON until CPU1 is OFF state.
@@ -158,7 +159,9 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 	 * Call idle CPU PM enter notifier chain so that
 	 * VFP and per CPU interrupt context is saved.
 	 */
-	cpu_pm_enter();
+	error = cpu_pm_enter();
+	if (error)
+		goto cpu_pm_out;
 
 	if (dev->cpu == 0) {
 		pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
@@ -196,18 +199,18 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 		}
 	}
 
-	/*
-	 * Call idle CPU PM exit notifier chain to restore
-	 * VFP and per CPU IRQ context.
-	 */
-	cpu_pm_exit();
-
 	/*
 	 * Call idle CPU cluster PM exit notifier chain
 	 * to restore GIC and wakeupgen context.
 	 */
 	if (dev->cpu == 0 && mpuss_can_lose_context)
 		cpu_cluster_pm_exit();
+cpu_pm_out:
+	/*
+	 * Call idle CPU PM exit notifier chain to restore
+	 * VFP and per CPU IRQ context.
+	 */
+	cpu_pm_exit();
 
 	tick_broadcast_exit();
 
-- 
2.16.1
