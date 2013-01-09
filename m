From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  9 Jan 2013 10:06:03 +0000
Subject: [PATCH 1/3] mfd: Fix compile errors and warnings when
 !CONFIG_AB8500_BM
Message-ID: <1357725965-27342-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/mfd/ab8500-core.c:1015:21: error: ?ab8500_bm_data? undeclared here

include/linux/mfd/abx500/ab8500-bm.h:445:13: warning: ?ab8500_fg_reinit? defined but not used
include/linux/mfd/abx500/ab8500-bm.h:448:13: warning: ?ab8500_charger_usb_state_changed? defined but not used
include/linux/mfd/abx500/ab8500-bm.h:451:29: warning: ?ab8500_btemp_get? defined but not used
include/linux/mfd/abx500/ab8500-bm.h:455:12: warning: ?ab8500_btemp_get_batctrl_temp? defined but not used
include/linux/mfd/abx500/ab8500-bm.h:463:12: warning: ?ab8500_fg_inst_curr_blocking? defined but not used
include/linux/mfd/abx500/ab8500-bm.h:442:12: warning: ?ab8500_fg_inst_curr_done? defined but not used
include/linux/mfd/abx500/ab8500-bm.h:447:26: warning: ?ab8500_fg_get? defined but not used

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c            |    1 +
 include/linux/mfd/abx500.h           |    2 --
 include/linux/mfd/abx500/ab8500-bm.h |   29 ++++-------------------------
 3 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index e1650ba..4778bb1 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -19,6 +19,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
+#include <linux/mfd/abx500/ab8500-bm.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/regulator/ab8500.h>
 #include <linux/of.h>
diff --git a/include/linux/mfd/abx500.h b/include/linux/mfd/abx500.h
index 2138bd3..e53dcfe 100644
--- a/include/linux/mfd/abx500.h
+++ b/include/linux/mfd/abx500.h
@@ -272,8 +272,6 @@ struct abx500_bm_data {
 	const struct abx500_fg_parameters *fg_params;
 };
 
-extern struct abx500_bm_data ab8500_bm_data;
-
 enum {
 	NTC_EXTERNAL = 0,
 	NTC_INTERNAL,
diff --git a/include/linux/mfd/abx500/ab8500-bm.h b/include/linux/mfd/abx500/ab8500-bm.h
index 44310c9..9bd037d 100644
--- a/include/linux/mfd/abx500/ab8500-bm.h
+++ b/include/linux/mfd/abx500/ab8500-bm.h
@@ -422,7 +422,10 @@ struct ab8500_chargalg_platform_data {
 struct ab8500_btemp;
 struct ab8500_gpadc;
 struct ab8500_fg;
+
 #ifdef CONFIG_AB8500_BM
+extern struct abx500_bm_data ab8500_bm_data;
+
 void ab8500_fg_reinit(void);
 void ab8500_charger_usb_state_changed(u8 bm_usb_state, u16 mA);
 struct ab8500_btemp *ab8500_btemp_get(void);
@@ -434,31 +437,7 @@ int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *res);
 int ab8500_fg_inst_curr_done(struct ab8500_fg *di);
 
 #else
-int ab8500_fg_inst_curr_done(struct ab8500_fg *di)
-{
-}
-static void ab8500_fg_reinit(void)
-{
-}
-static void ab8500_charger_usb_state_changed(u8 bm_usb_state, u16 mA)
-{
-}
-static struct ab8500_btemp *ab8500_btemp_get(void)
-{
-	return NULL;
-}
-static int ab8500_btemp_get_batctrl_temp(struct ab8500_btemp *btemp)
-{
-	return 0;
-}
-struct ab8500_fg *ab8500_fg_get(void)
-{
-	return NULL;
-}
-static int ab8500_fg_inst_curr_blocking(struct ab8500_fg *dev)
-{
-	return -ENODEV;
-}
+static struct abx500_bm_data ab8500_bm_data;
 
 static inline int ab8500_fg_inst_curr_start(struct ab8500_fg *di)
 {
-- 
1.7.9.5
