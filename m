From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 13 Feb 2014 15:09:06 +0100
Subject: [PATCH V2 16/17] i2c: nomadik: Remove busy check for transfers at
 suspend late
In-Reply-To: <1392300547-23365-1-git-send-email-ulf.hansson@linaro.org>
References: <1392300547-23365-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1392300547-23365-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should never be busy performing transfers at suspend late, thus
there are no reason to check for it.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	Rebased on top of latest i2c-nomadik branch.

---
 drivers/i2c/busses/i2c-nomadik.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 80b0fd3..8a5dc57b 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -167,7 +167,6 @@ struct i2c_nmk_client {
  * @stop: stop condition.
  * @xfer_complete: acknowledge completion for a I2C message.
  * @result: controller propogated result.
- * @busy: Busy doing transfer.
  */
 struct nmk_i2c_dev {
 	struct i2c_vendor_data		*vendor;
@@ -185,7 +184,6 @@ struct nmk_i2c_dev {
 	int				stop;
 	struct completion		xfer_complete;
 	int				result;
-	bool				busy;
 };
 
 /* controller's abort causes */
@@ -671,8 +669,6 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	struct nmk_i2c_dev *dev = i2c_get_adapdata(i2c_adap);
 	int j;
 
-	dev->busy = true;
-
 	pm_runtime_get_sync(&dev->adev->dev);
 
 	/* Attempt three times to send the message queue */
@@ -697,8 +693,6 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	pm_runtime_put_sync(&dev->adev->dev);
 
-	dev->busy = false;
-
 	/* return the no. messages processed */
 	if (status)
 		return status;
@@ -888,9 +882,6 @@ static int nmk_i2c_suspend_late(struct device *dev)
 	struct amba_device *adev = to_amba_device(dev);
 	struct nmk_i2c_dev *nmk_i2c = amba_get_drvdata(adev);
 
-	if (nmk_i2c->busy)
-		return -EBUSY;
-
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
@@ -997,7 +988,6 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_no_mem;
 	}
 	dev->vendor = vendor;
-	dev->busy = false;
 	dev->adev = adev;
 	nmk_i2c_of_probe(np, dev);
 
-- 
1.7.9.5
