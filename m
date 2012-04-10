From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Tue, 10 Apr 2012 16:26:32 +0530
Subject: [PATCHv6 14/19] I2C: OMAP: Use SET_RUNTIME_PM_OPS
In-Reply-To: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com>
References: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1334055397-899-15-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use SET_RUNTIME_PM_OPS macro to set runtime functions.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 95f1b2f..a5b1ec1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1211,15 +1211,12 @@ static int omap_i2c_runtime_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static struct dev_pm_ops omap_i2c_pm_ops = {
-	.runtime_suspend = omap_i2c_runtime_suspend,
-	.runtime_resume = omap_i2c_runtime_resume,
+	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
+			   omap_i2c_runtime_resume, NULL)
 };
-#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
-#else
-#define OMAP_I2C_PM_OPS NULL
-#endif
 
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
@@ -1227,7 +1224,7 @@ static struct platform_driver omap_i2c_driver = {
 	.driver		= {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
-		.pm	= OMAP_I2C_PM_OPS,
+		.pm	= &omap_i2c_pm_ops,
 		.of_match_table = of_match_ptr(omap_i2c_of_match),
 	},
 };
-- 
1.7.4.1
