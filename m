From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 23 Oct 2009 09:59:08 -0700
Subject: [PATCH 10/10] OMAP3: PM: Added resched check into idle calls
In-Reply-To: <1256317148-25506-10-git-send-email-khilman@deeprootsystems.com>
References: <1256317148-25506-1-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-2-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-3-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-4-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-5-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-6-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-7-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-8-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-9-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-10-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1256317148-25506-11-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <tero.kristo@nokia.com>

Fixes a bug where scheduling is delayed until next wakeup due to race
condition (e.g. interrupt requests scheduling just before omap_sram_idle
is entered.)

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    3 ++-
 arch/arm/mach-omap2/pm34xx.c      |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1d10c4a..a26d6a0 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -22,6 +22,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/sched.h>
 #include <linux/cpuidle.h>
 
 #include <plat/prcm.h>
@@ -113,7 +114,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	pwrdm_set_next_pwrst(core_pd, core_state);
 
-	if (omap_irq_pending())
+	if (omap_irq_pending() || need_resched())
 		goto return_sleep_time;
 
 	if (cx->type == OMAP3_STATE_C1) {
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 40cbba4..849c910 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -523,7 +523,7 @@ static void omap3_pm_idle(void)
 	if (!omap3_can_sleep())
 		goto out;
 
-	if (omap_irq_pending())
+	if (omap_irq_pending() || need_resched())
 		goto out;
 
 	omap_sram_idle();
-- 
1.6.4.3
