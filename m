From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 24 Apr 2014 12:26:37 +0200
Subject: [PATCH 5/6] drivers: sh: Use generic runtime and clock helpers
In-Reply-To: <1398335198-26555-1-git-send-email-geert+renesas@glider.be>
References: <1398335198-26555-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1398335198-26555-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "drivers: sh: pm_runtime does not need idle callback" and
"drivers: sh: pm_runtime implementation needs to suspend and resume devices"
---
 drivers/sh/pm_runtime.c |   38 ++------------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index f0c4a384d49f..05b719637dd4 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_clock.h>
 #include <linux/platform_device.h>
@@ -21,43 +20,10 @@
 #include <linux/slab.h>
 
 #ifdef CONFIG_PM_RUNTIME
-static int sh_pm_runtime_suspend(struct device *dev)
-{
-	int ret;
-
-	ret = pm_generic_runtime_suspend(dev);
-	if (ret) {
-		dev_err(dev, "failed to suspend device\n");
-		return ret;
-	}
-
-	ret = pm_clk_suspend(dev);
-	if (ret) {
-		dev_err(dev, "failed to suspend clock\n");
-		pm_generic_runtime_resume(dev);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int sh_pm_runtime_resume(struct device *dev)
-{
-	int ret;
-
-	ret = pm_clk_resume(dev);
-	if (ret) {
-		dev_err(dev, "failed to resume clock\n");
-		return ret;
-	}
-
-	return pm_generic_runtime_resume(dev);
-}
-
 static struct dev_pm_domain default_pm_domain = {
 	.ops = {
-		.runtime_suspend = sh_pm_runtime_suspend,
-		.runtime_resume = sh_pm_runtime_resume,
+		.runtime_suspend = pm_generic_runtime_clk_suspend,
+		.runtime_resume = pm_generic_clk_runtime_resume,
 		USE_PLATFORM_PM_SLEEP_OPS
 	},
 };
-- 
1.7.9.5
