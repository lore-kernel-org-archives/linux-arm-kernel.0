From: balbi@ti.com (Felipe Balbi)
Date: Fri, 14 Dec 2012 18:34:04 +0200
Subject: [PATCH REBASE 1/6] i2c: omap: no need to access platform_device
In-Reply-To: <1355502849-9289-1-git-send-email-balbi@ti.com>
References: <1355502849-9289-1-git-send-email-balbi@ti.com>
Message-ID: <1355502849-9289-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PM callbacks pass our device pointer as argument
and we don't need to access the platform_device
just to dereference that down to dev->drvdata.

instead, just use dev_get_drvdata() directly.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 7a62acb..9a9cf7c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1289,8 +1289,7 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_RUNTIME
 static int omap_i2c_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
 
 	_dev->iestate = omap_i2c_read_reg(_dev, OMAP_I2C_IE_REG);
 
@@ -1310,8 +1309,7 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 
 static int omap_i2c_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
 
 	if (!_dev->regs)
 		return 0;
-- 
1.8.1.rc1.5.g7e0651a
