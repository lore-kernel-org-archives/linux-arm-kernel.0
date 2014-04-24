From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 24 Apr 2014 12:26:38 +0200
Subject: [PATCH 6/6] of/clk: Use generic runtime and clock helpers
In-Reply-To: <1398335198-26555-1-git-send-email-geert+renesas@glider.be>
References: <1398335198-26555-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1398335198-26555-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "of/clk: Register clocks suitable for Runtime PM with the
PM core"
---
 drivers/of/of_clk.c |   28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/of/of_clk.c b/drivers/of/of_clk.c
index 35f5e9f3dd42..3e8561dce998 100644
--- a/drivers/of/of_clk.c
+++ b/drivers/of/of_clk.c
@@ -8,38 +8,14 @@
 #include <linux/of_clk.h>
 #include <linux/platform_device.h>
 #include <linux/pm_clock.h>
-#include <linux/pm_runtime.h>
 
 
 #ifdef CONFIG_PM_RUNTIME
 
-static int of_clk_pm_runtime_suspend(struct device *dev)
-{
-	int ret;
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
-static int of_clk_pm_runtime_resume(struct device *dev)
-{
-	pm_clk_resume(dev);
-	return pm_generic_runtime_resume(dev);
-}
-
 static struct dev_pm_domain of_clk_pm_domain = {
 	.ops = {
-		.runtime_suspend = of_clk_pm_runtime_suspend,
-		.runtime_resume = of_clk_pm_runtime_resume,
+		.runtime_suspend = pm_generic_runtime_clk_suspend,
+		.runtime_resume = pm_generic_clk_runtime_resume,
 		USE_PLATFORM_PM_SLEEP_OPS
 	},
 };
-- 
1.7.9.5
