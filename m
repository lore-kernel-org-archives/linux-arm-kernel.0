From: davidb@codeaurora.org (David Brown)
Date: Fri, 20 Dec 2013 11:09:14 -0800
Subject: [PATCH 1/7] ARM: msm: trout: fix uninit var warning
In-Reply-To: <1387566560-23948-1-git-send-email-davidb@codeaurora.org>
References: <1387566560-23948-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1387566560-23948-2-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Cartwright <joshc@codeaurora.org>

Fix the following warning when !CONFIG_MMC:

arch/arm/mach-msm/board-trout.c: In function 'trout_init':
arch/arm/mach-msm/board-trout.c:67:6: warning: unused variable 'rc' [-Wunused-variable]
  int rc;
      ^

Also, while we're here, rework explicit printk(KERN_CRIT..) to use
pr_crit.

Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/board-trout.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index ccf6621..015d544 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -13,6 +13,7 @@
  * GNU General Public License for more details.
  *
  */
+#define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -68,12 +69,11 @@ static void __init trout_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-#ifdef CONFIG_MMC
-        rc = trout_init_mmc(system_rev);
-        if (rc)
-                printk(KERN_CRIT "%s: MMC init failure (%d)\n", __func__, rc);
-#endif
-
+	if (IS_ENABLED(CONFIG_MMC)) {
+		rc = trout_init_mmc(system_rev);
+		if (rc)
+			pr_crit("MMC init failure (%d)\n", rc);
+	}
 }
 
 static struct map_desc trout_io_desc[] __initdata = {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
