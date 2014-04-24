From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 24 Apr 2014 12:26:36 +0200
Subject: [PATCH 4/6] ARM: omap: Use generic runtime and clock helpers
In-Reply-To: <1398335198-26555-1-git-send-email-geert+renesas@glider.be>
References: <1398335198-26555-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1398335198-26555-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-omap1/pm_bus.c |   32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
index 3f2d39672393..e2d4b93580d1 100644
--- a/arch/arm/mach-omap1/pm_bus.c
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <linux/pm_runtime.h>
 #include <linux/pm_clock.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
@@ -22,37 +21,10 @@
 #include "soc.h"
 
 #ifdef CONFIG_PM_RUNTIME
-static int omap1_pm_runtime_suspend(struct device *dev)
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
-static int omap1_pm_runtime_resume(struct device *dev)
-{
-	dev_dbg(dev, "%s\n", __func__);
-
-	pm_clk_resume(dev);
-	return pm_generic_runtime_resume(dev);
-}
-
 static struct dev_pm_domain default_pm_domain = {
 	.ops = {
-		.runtime_suspend = omap1_pm_runtime_suspend,
-		.runtime_resume = omap1_pm_runtime_resume,
+		.runtime_suspend = pm_generic_runtime_clk_suspend,
+		.runtime_resume = pm_generic_clk_runtime_resume,
 		USE_PLATFORM_PM_SLEEP_OPS
 	},
 };
-- 
1.7.9.5
