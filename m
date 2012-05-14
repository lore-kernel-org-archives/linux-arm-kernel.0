From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 14 May 2012 14:19:53 +0530
Subject: [PATCHv10 05/10] I2C: OMAP: Don't check if
 wait_for_completion_timeout() returns less than zero
In-Reply-To: <1336985398-3291-1-git-send-email-shubhrajyoti@ti.com>
References: <1336985398-3291-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1336985398-3291-6-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By definition, wait_for_completion_timeout() returns an unsigned value and
therefore, it is not necessary to check if the return value is less than zero
as this is not possible.

This is based on a patch from Jon Hunter <jon-hunter@ti.com>
Changes from his patch
- Declare a long as the wait_for_completion_timeout returns long.

Original patch is
http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=ea02cece7b0000bc736e60c4188a11aaa74bc6e6

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
- Added Jon's signoff 

 drivers/i2c/busses/i2c-omap.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 1777d79..fec8d5c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -473,7 +473,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 			     struct i2c_msg *msg, int stop)
 {
 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
-	int r;
+	unsigned long timeout;
 	u16 w;
 
 	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
@@ -541,12 +541,10 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	 * REVISIT: We should abort the transfer on signals, but the bus goes
 	 * into arbitration and we're currently unable to recover from it.
 	 */
-	r = wait_for_completion_timeout(&dev->cmd_complete,
-					OMAP_I2C_TIMEOUT);
+	timeout = wait_for_completion_timeout(&dev->cmd_complete,
+						OMAP_I2C_TIMEOUT);
 	dev->buf_len = 0;
-	if (r < 0)
-		return r;
-	if (r == 0) {
+	if (timeout == 0) {
 		dev_err(dev->dev, "controller timed out\n");
 		omap_i2c_init(dev);
 		return -ETIMEDOUT;
-- 
1.7.5.4
