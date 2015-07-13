From: balbi@ti.com (Felipe Balbi)
Date: Mon, 13 Jul 2015 15:38:02 -0500
Subject: [PATCH 1/3] i2c: omap: switch to dev_get_drvdata()
In-Reply-To: <20150710172701.GB20408@saruman.tx.rr.com>
References: <20150710172701.GB20408@saruman.tx.rr.com>
Message-ID: <1436819884-1614-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

there's no need to fetch the platform_device
in order to dereference it back to the dev
pointer to access drvdata, we can use
dev_get_drvdata() instead.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d1c22e3fdd14..2dcf4cac663d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1465,8 +1465,7 @@ static int omap_i2c_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int omap_i2c_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
 
 	_dev->iestate = omap_i2c_read_reg(_dev, OMAP_I2C_IE_REG);
 
@@ -1492,8 +1491,7 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 
 static int omap_i2c_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
 
 	pinctrl_pm_select_default_state(dev);
 
-- 
2.4.4
