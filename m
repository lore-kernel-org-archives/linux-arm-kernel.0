From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 14 Apr 2016 20:53:31 +0800
Subject: [PATCH 1/4] i2c: designware-platdrv: Fix runtime PM initialization
In-Reply-To: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
References: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
Message-ID: <1460638414-5987-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When pm_runtime_enable() was being called, the device's usage counter
was 0, causing the PM layer to runtime-suspend the device.  We then
went on to call i2c_dw_probe() on a suspended device, which could hung.

Fix this by incrementing the usage counter before pm_runtime_enable().

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index d656657..00f9e99 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -246,6 +246,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (dev->pm_runtime_disabled) {
 		pm_runtime_forbid(&pdev->dev);
 	} else {
+		pm_runtime_get_noresume(&pdev->dev);
 		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
 		pm_runtime_use_autosuspend(&pdev->dev);
 		pm_runtime_set_active(&pdev->dev);
@@ -253,8 +254,19 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	}
 
 	r = i2c_dw_probe(dev);
-	if (r && !dev->pm_runtime_disabled)
+	if (r)
+		goto rpm_disable;
+
+	if (!dev->pm_runtime_disabled)
+		pm_runtime_put_autosuspend(&pdev->dev);
+
+	return 0;
+
+rpm_disable:
+	if (!dev->pm_runtime_disabled) {
 		pm_runtime_disable(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+	}
 
 	return r;
 }
-- 
2.8.0.rc3
