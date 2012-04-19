From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 19 Apr 2012 18:58:18 +0530
Subject: [PATCHv8 07/10] I2C: OMAP: Handle error check for pm runtime
In-Reply-To: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1334842101-20670-8-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If PM runtime get_sync fails return with the error
so that no further reads/writes goes through the interface.
This will avoid possible abort. Add a error message in case
of failure with the cause of the failure.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 44e8cfa..d555dcd 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -585,7 +585,11 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	int i;
 	int r;
 
-	pm_runtime_get_sync(dev->dev);
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0) {
+		dev_err(dev->dev, "pm_runtime_get_sync failed %d\n", r);
+		return r;
+	}
 
 	r = omap_i2c_wait_for_bb(dev);
 	if (r < 0)
@@ -1011,7 +1015,11 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->regs = (u8 *)reg_map_ip_v1;
 
 	pm_runtime_enable(dev->dev);
-	pm_runtime_get_sync(dev->dev);
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0) {
+		dev_err(dev->dev, "pm_runtime_get_sync failed:%d\n", r);
+		return r;
+	}
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
@@ -1103,12 +1111,17 @@ omap_i2c_remove(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
 	struct resource		*mem;
+	int ret;
 
 	platform_set_drvdata(pdev, NULL);
 
 	free_irq(dev->irq, dev);
 	i2c_del_adapter(&dev->adapter);
-	pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		dev_err(dev->dev, "pm_runtime_get_sync failed %d\n", ret);
+		return ret;
+	}
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.5.4
