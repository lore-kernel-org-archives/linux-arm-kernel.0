From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 27 Apr 2012 16:23:51 +0200
Subject: [PATCH] i2c: mxs: disable QUEUE when sending is done
Message-ID: <1335536631-28202-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the last fixes to this driver ensure now the queue termination is
done correctly, we can finally disable the queue after a transfer
without problems. The gain is that it will only be reenabled after the
next transfer is fully set up. Before, the queue was running all the
time and if the setup of the next message was interrupted by another
thread, an incomplete buffer could have been sent, padded with zeroes.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

In case you are testing this patch, please donate Tested-by tags. Regular I2C
usage should do, a bit of stress testing (putting I2C bus and system under
load) would be great.

 drivers/i2c/busses/i2c-mxs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 4c37347..76b8af4 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -253,6 +253,9 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 
 	if (i2c->cmd_err == -ENXIO)
 		mxs_i2c_reset(i2c);
+	else
+		writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
+				i2c->regs + MXS_I2C_QUEUECTRL_CLR);
 
 	dev_dbg(i2c->dev, "Done with err=%d\n", i2c->cmd_err);
 
@@ -383,8 +386,6 @@ static int __devexit mxs_i2c_remove(struct platform_device *pdev)
 	if (ret)
 		return -EBUSY;
 
-	writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
-			i2c->regs + MXS_I2C_QUEUECTRL_CLR);
 	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
 
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.10
