From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri,  2 Apr 2010 14:15:09 +0100
Subject: [PATCH v2] i2c-s3c2410: Remove unconditional 1ms delay on each
	transfer
Message-ID: <1270214109-28226-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C I2C controller indicates completion of I2C transfers before
the bus has a stop condition on it. In order to ensure that we do not
attempt to start a new transfer before the bus is idle the driver
currently inserts a 1ms delay. This is vastly larger than is generally
required and has a visible effect on performance under load, such as
when bringing up audio CODECs or reading back status information with
non-bulk I2C reads.

Replace the sleep with a spin on the IIC status register for up to 1ms.
This will busy wait but testing on my SMDK6410 system indicates that
the overwhelming majority of transactions complete on the first spin,
with maximum latencies of less than 10 spins so the absolute overhead
of busy waiting should be at worst comprable to msleep(), and the
overall system performance is dramatically improved.

The main risk is poor interaction with multimaster systems where
we may miss the bus going idle before the next transaction. Defend
against this by falling back to the original 1ms delay after 20 spins.

The overall effect in my testing is an approximately 20% improvement
in kernel startup time.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/i2c/busses/i2c-s3c2410.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index d27072b..ec3256c 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -482,7 +482,8 @@ static int s3c24xx_i2c_set_master(struct s3c24xx_i2c *i2c)
 static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 			      struct i2c_msg *msgs, int num)
 {
-	unsigned long timeout;
+	unsigned long iicstat, timeout;
+	int spins = 20;
 	int ret;
 
 	if (i2c->suspended)
@@ -521,7 +522,21 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 
 	/* ensure the stop has been through the bus */
 
-	msleep(1);
+	dev_dbg(i2c->dev, "waiting for bus idle\n");
+
+	/* first, try busy waiting briefly */
+	do {
+		iicstat = readl(i2c->regs + S3C2410_IICSTAT);
+	} while ((iicstat & S3C2410_IICSTAT_START) && --spins);
+
+	/* if that timed out sleep */
+	if (!spins) {
+		msleep(1);
+		iicstat = readl(i2c->regs + S3C2410_IICSTAT);
+	}
+
+	if (iicstat & S3C2410_IICSTAT_START)
+		dev_warn(i2c->dev, "timeout waiting for bus idle\n");
 
  out:
 	return ret;
-- 
1.7.0.3
