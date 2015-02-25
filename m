From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 25 Feb 2015 17:02:03 +0100
Subject: [RFC V2 12/12] i2c: bcm-iproc: make use of the new infrastructure for
 quirks
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1424880126-15047-13-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index d3c89157b33774..f9f2c2082151e2 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -160,14 +160,6 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	u32 val;
 	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MESC);
 
-	/* need to reserve one byte in the FIFO for the slave address */
-	if (msg->len > M_TX_RX_FIFO_SIZE - 1) {
-		dev_err(iproc_i2c->device,
-			"only support data length up to %u bytes\n",
-			M_TX_RX_FIFO_SIZE - 1);
-		return -EOPNOTSUPP;
-	}
-
 	/* check if bus is busy */
 	if (!!(readl(iproc_i2c->base + M_CMD_OFFSET) &
 	       BIT(M_CMD_START_BUSY_SHIFT))) {
@@ -287,6 +279,12 @@ static const struct i2c_algorithm bcm_iproc_algo = {
 	.functionality = bcm_iproc_i2c_functionality,
 };
 
+static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
+	/* need to reserve one byte in the FIFO for the slave address */
+	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
+	.max_write_len = M_TX_RX_FIFO_SIZE - 1,
+};
+
 static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
 {
 	unsigned int bus_speed;
@@ -413,6 +411,7 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(adap, iproc_i2c);
 	strlcpy(adap->name, "Broadcom iProc I2C adapter", sizeof(adap->name));
 	adap->algo = &bcm_iproc_algo;
+	adap->quirks = &bcm_iproc_i2c_quirks;
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
 
-- 
2.1.4
