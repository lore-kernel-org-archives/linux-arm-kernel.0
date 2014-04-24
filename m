From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 24 Apr 2014 12:26:35 +0200
Subject: [PATCH 3/6] ARM: keystone: Use generic runtime and clock helpers
In-Reply-To: <1398335198-26555-1-git-send-email-geert+renesas@glider.be>
References: <1398335198-26555-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1398335198-26555-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-keystone/pm_domain.c |   35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index ca79ddac38bc..f9e36c73b6fc 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -13,46 +13,15 @@
  */
 
 #include <linux/init.h>
-#include <linux/pm_runtime.h>
 #include <linux/pm_clock.h>
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 
-#ifdef CONFIG_PM_RUNTIME
-static int keystone_pm_runtime_suspend(struct device *dev)
-{
-	int ret;
-
-	dev_dbg(dev, "%s\n", __func__);
-
-	ret = pm_generic_runtime_suspend(dev);
-	if (ret)
-		return ret;
-
-	ret = pm_clk_suspend(dev);
-	if (ret) {
-		pm_generic_runtime_resume(dev);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int keystone_pm_runtime_resume(struct device *dev)
-{
-	dev_dbg(dev, "%s\n", __func__);
-
-	pm_clk_resume(dev);
-
-	return pm_generic_runtime_resume(dev);
-}
-#endif
-
 static struct dev_pm_domain keystone_pm_domain = {
 	.ops = {
-		SET_RUNTIME_PM_OPS(keystone_pm_runtime_suspend,
-				   keystone_pm_runtime_resume, NULL)
+		SET_RUNTIME_PM_OPS(pm_generic_runtime_clk_suspend,
+				   pm_generic_clk_runtime_resume, NULL)
 		USE_PLATFORM_PM_SLEEP_OPS
 	},
 };
-- 
1.7.9.5
