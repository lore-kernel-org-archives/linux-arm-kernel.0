From: chuansheng.liu@intel.com (Chuansheng Liu)
Date: Wed, 07 Nov 2012 01:18:37 +0800
Subject: [PATCH 1/7] I2c-nomadik: Fix the usage of wait_for_completion_timeout
Message-ID: <1352222317.15558.1584.camel@cliu38-desktop-build>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The return value of wait_for_completion_timeout() is always
>= 0 with unsigned int type.

So the condition "ret < 0" or "ret >= 0" is pointless.

Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
---
 drivers/i2c/busses/i2c-nomadik.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 02c3115..8b2ffcf 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -435,13 +435,6 @@ static int read_i2c(struct nmk_i2c_dev *dev, u16 flags)
 	timeout = wait_for_completion_timeout(
 		&dev->xfer_complete, dev->adap.timeout);
 
-	if (timeout < 0) {
-		dev_err(&dev->adev->dev,
-			"wait_for_completion_timeout "
-			"returned %d waiting for event\n", timeout);
-		status = timeout;
-	}
-
 	if (timeout == 0) {
 		/* Controller timed out */
 		dev_err(&dev->adev->dev, "read from slave 0x%x timed out\n",
@@ -523,13 +516,6 @@ static int write_i2c(struct nmk_i2c_dev *dev, u16 flags)
 	timeout = wait_for_completion_timeout(
 		&dev->xfer_complete, dev->adap.timeout);
 
-	if (timeout < 0) {
-		dev_err(&dev->adev->dev,
-			"wait_for_completion_timeout "
-			"returned %d waiting for event\n", timeout);
-		status = timeout;
-	}
-
 	if (timeout == 0) {
 		/* Controller timed out */
 		dev_err(&dev->adev->dev, "write to slave 0x%x timed out\n",
-- 
1.7.0.4
