From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 17 May 2013 18:24:29 +0200
Subject: [PATCH 3/6] ARM: SAMSUNG: pm: Adjust for pinctrl- and DT-enabled
 platforms
In-Reply-To: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
Message-ID: <1368807872-2601-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes legacy code on suspend/resume path being executed
conditionally, on non-DT platforms only, to fix suspend/resume of
DT-enabled systems, for which the code is inappropriate.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/pm.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 53210ec..8ac2b2d 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -261,7 +261,8 @@ static int s3c_pm_enter(suspend_state_t state)
 	 * require a full power-cycle)
 	*/
 
-	if (!any_allowed(s3c_irqwake_intmask, s3c_irqwake_intallow) &&
+	if (!of_have_populated_dt() &&
+	    !any_allowed(s3c_irqwake_intmask, s3c_irqwake_intallow) &&
 	    !any_allowed(s3c_irqwake_eintmask, s3c_irqwake_eintallow)) {
 		printk(KERN_ERR "%s: No wake-up sources!\n", __func__);
 		printk(KERN_ERR "%s: Aborting sleep\n", __func__);
@@ -270,8 +271,11 @@ static int s3c_pm_enter(suspend_state_t state)
 
 	/* save all necessary core registers not covered by the drivers */
 
-	samsung_pm_save_gpios();
-	samsung_pm_saved_gpios();
+	if (!of_have_populated_dt()) {
+		samsung_pm_save_gpios();
+		samsung_pm_saved_gpios();
+	}
+
 	s3c_pm_save_uarts();
 	s3c_pm_save_core();
 
@@ -310,8 +314,11 @@ static int s3c_pm_enter(suspend_state_t state)
 
 	s3c_pm_restore_core();
 	s3c_pm_restore_uarts();
-	samsung_pm_restore_gpios();
-	s3c_pm_restored_gpios();
+
+	if (!of_have_populated_dt()) {
+		samsung_pm_restore_gpios();
+		s3c_pm_restored_gpios();
+	}
 
 	s3c_pm_debug_init();
 
-- 
1.8.2.1
