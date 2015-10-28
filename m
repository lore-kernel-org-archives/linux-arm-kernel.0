From: shubhrajyoti.datta@xilinx.com (Shubhrajyoti Datta)
Date: Wed, 28 Oct 2015 11:34:39 +0530
Subject: [PATCHv2] i2c: cadence: Enable power management
Message-ID: <1446012279-2578-1-git-send-email-shubhraj@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the clocks are enabled at probe and disabled at remove.
This patch enables the clocks at the start of transfer and disables
after it.

Also adapts to runtime pm.
Remove xi2c->suspended and use pm runtime status instead.

converts dev pm to const to silence a checkpatch warning.

Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
---
changes since v1:
update the cc list.

 drivers/i2c/busses/i2c-cadence.c |   74 ++++++++++++++++++++++++--------------
 1 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index f5227c5..ba3c67c 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 
 /* Register offsets for the I2C device. */
 #define CDNS_I2C_CR_OFFSET		0x00 /* Control Register, RW */
@@ -98,6 +99,8 @@
 					 CDNS_I2C_IXR_COMP)
 
 #define CDNS_I2C_TIMEOUT		msecs_to_jiffies(1000)
+/* timeout for pm runtime autosuspend */
+#define CNDS_I2C_PM_TIMEOUT		1000	/* ms */
 
 #define CDNS_I2C_FIFO_DEPTH		16
 /* FIFO depth at which the DATA interrupt occurs */
@@ -130,7 +133,6 @@
  * @xfer_done:		Transfer complete status
  * @p_send_buf:		Pointer to transmit buffer
  * @p_recv_buf:		Pointer to receive buffer
- * @suspended:		Flag holding the device's PM status
  * @send_count:		Number of bytes still expected to send
  * @recv_count:		Number of bytes still expected to receive
  * @curr_recv_count:	Number of bytes to be received in current transfer
@@ -143,6 +145,7 @@
  * @quirks:		flag for broken hold bit usage in r1p10
  */
 struct cdns_i2c {
+	struct device		*dev;
 	void __iomem *membase;
 	struct i2c_adapter adap;
 	struct i2c_msg *p_msg;
@@ -150,7 +153,6 @@ struct cdns_i2c {
 	struct completion xfer_done;
 	unsigned char *p_send_buf;
 	unsigned char *p_recv_buf;
-	u8 suspended;
 	unsigned int send_count;
 	unsigned int recv_count;
 	unsigned int curr_recv_count;
@@ -623,10 +625,16 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	u32 reg;
 	struct cdns_i2c *id = adap->algo_data;
 	bool hold_quirk;
+
+	ret = pm_runtime_get_sync(id->dev);
+	if (ret < 0)
+		return ret;
 	/* Check if the bus is free */
 	if (msgs->len)
-		if (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) & CDNS_I2C_SR_BA)
-			return -EAGAIN;
+		if (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) & CDNS_I2C_SR_BA) {
+			ret = -EAGAIN;
+			goto out;
+		}
 
 	hold_quirk = !!(id->quirks & CDNS_I2C_BROKEN_HOLD_BIT);
 	/*
@@ -645,7 +653,8 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			if (msgs[count].flags & I2C_M_RD) {
 				dev_warn(adap->dev.parent,
 					 "Can't do repeated start after a receive message\n");
-				return -EOPNOTSUPP;
+				ret = -EOPNOTSUPP;
+				goto out;
 			}
 		}
 		id->bus_hold_flag = 1;
@@ -663,20 +672,26 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 		ret = cdns_i2c_process_msg(id, msgs, adap);
 		if (ret)
-			return ret;
+			goto out;
 
 		/* Report the other error interrupts to application */
 		if (id->err_status) {
 			cdns_i2c_master_reset(adap);
 
-			if (id->err_status & CDNS_I2C_IXR_NACK)
-				return -ENXIO;
-
-			return -EIO;
+			if (id->err_status & CDNS_I2C_IXR_NACK) {
+				ret = -ENXIO;
+				goto out;
+			}
+			ret = -EIO;
+			goto out;
 		}
 	}
 
-	return num;
+	ret = num;
+out:
+	pm_runtime_mark_last_busy(id->dev);
+	pm_runtime_put_autosuspend(id->dev);
+	return ret;
 }
 
 /**
@@ -815,7 +830,7 @@ static int cdns_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
 	struct clk_notifier_data *ndata = data;
 	struct cdns_i2c *id = to_cdns_i2c(nb);
 
-	if (id->suspended)
+	if (pm_runtime_suspended(id->dev))
 		return NOTIFY_OK;
 
 	switch (event) {
@@ -863,14 +878,12 @@ static int cdns_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
  *
  * Return: 0 always
  */
-static int __maybe_unused cdns_i2c_suspend(struct device *_dev)
+static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = container_of(_dev,
-			struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct cdns_i2c *xi2c = platform_get_drvdata(pdev);
 
 	clk_disable(xi2c->clk);
-	xi2c->suspended = 1;
 
 	return 0;
 }
@@ -883,26 +896,25 @@ static int __maybe_unused cdns_i2c_suspend(struct device *_dev)
  *
  * Return: 0 on success and error value on error
  */
-static int __maybe_unused cdns_i2c_resume(struct device *_dev)
+static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = container_of(_dev,
-			struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct cdns_i2c *xi2c = platform_get_drvdata(pdev);
 	int ret;
 
 	ret = clk_enable(xi2c->clk);
 	if (ret) {
-		dev_err(_dev, "Cannot enable clock.\n");
+		dev_err(dev, "Cannot enable clock.\n");
 		return ret;
 	}
 
-	xi2c->suspended = 0;
-
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(cdns_i2c_dev_pm_ops, cdns_i2c_suspend,
-			 cdns_i2c_resume);
+static const struct dev_pm_ops cdns_i2c_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(cdns_i2c_runtime_suspend,
+			   cdns_i2c_runtime_resume, NULL)
+};
 
 static const struct cdns_platform_data r1p10_i2c_def = {
 				.quirks = CDNS_I2C_BROKEN_HOLD_BIT, };
@@ -935,6 +947,7 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 	if (!id)
 		return -ENOMEM;
 
+	id->dev = &pdev->dev;
 	platform_set_drvdata(pdev, id);
 
 	match = of_match_node(cdns_i2c_of_match, pdev->dev.of_node);
@@ -966,10 +979,14 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(id->clk);
 	}
 	ret = clk_prepare_enable(id->clk);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "Unable to enable clock.\n");
-		return ret;
-	}
+
+	pm_runtime_enable(id->dev);
+	pm_runtime_set_autosuspend_delay(id->dev, CNDS_I2C_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(id->dev);
+	pm_runtime_set_active(id->dev);
+
 	id->clk_rate_change_nb.notifier_call = cdns_i2c_clk_notifier_cb;
 	if (clk_notifier_register(id->clk, &id->clk_rate_change_nb))
 		dev_warn(&pdev->dev, "Unable to register clock notifier.\n");
@@ -1019,6 +1036,8 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 
 err_clk_dis:
 	clk_disable_unprepare(id->clk);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
 
@@ -1037,6 +1056,7 @@ static int cdns_i2c_remove(struct platform_device *pdev)
 	i2c_del_adapter(&id->adap);
 	clk_notifier_unregister(id->clk, &id->clk_rate_change_nb);
 	clk_disable_unprepare(id->clk);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
1.7.1
