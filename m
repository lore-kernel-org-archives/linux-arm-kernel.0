From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  4 Feb 2014 16:58:57 +0100
Subject: [PATCH 16/17] i2c: nomadik: Remove busy check for transfers at
 suspend late
In-Reply-To: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1391529538-21685-17-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should never be busy performing transfers at suspend late, thus
there are no reason to check for it.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index eda4f0d..2004eea 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -179,7 +179,6 @@ struct i2c_nmk_client {
  * @stop: stop condition.
  * @xfer_complete: acknowledge completion for a I2C message.
  * @result: controller propogated result.
- * @busy: Busy doing transfer.
  */
 struct nmk_i2c_dev {
 	struct i2c_vendor_data		*vendor;
@@ -193,7 +192,6 @@ struct nmk_i2c_dev {
 	int				stop;
 	struct completion		xfer_complete;
 	int				result;
-	bool				busy;
 };
 
 /* controller's abort causes */
@@ -679,8 +677,6 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	struct nmk_i2c_dev *dev = i2c_get_adapdata(i2c_adap);
 	int j;
 
-	dev->busy = true;
-
 	pm_runtime_get_sync(&dev->adev->dev);
 
 	/* Attempt three times to send the message queue */
@@ -705,8 +701,6 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	pm_runtime_put_sync(&dev->adev->dev);
 
-	dev->busy = false;
-
 	/* return the no. messages processed */
 	if (status)
 		return status;
@@ -896,9 +890,6 @@ static int nmk_i2c_suspend_late(struct device *dev)
 	struct amba_device *adev = to_amba_device(dev);
 	struct nmk_i2c_dev *nmk_i2c = amba_get_drvdata(adev);
 
-	if (nmk_i2c->busy)
-		return -EBUSY;
-
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
@@ -1019,7 +1010,6 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_no_mem;
 	}
 	dev->vendor = vendor;
-	dev->busy = false;
 	dev->adev = adev;
 	amba_set_drvdata(adev, dev);
 
-- 
1.7.9.5
