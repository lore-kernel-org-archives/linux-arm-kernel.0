From: dianders@chromium.org (Doug Anderson)
Date: Mon, 15 Aug 2011 18:32:16 -0700
Subject: [PATCH v2] i2c: tegra: Check for overflow errors with BUG_ON.
In-Reply-To: <1313434172-18319-1-git-send-email-dianders@chromium.org>
References: <1313434172-18319-1-git-send-email-dianders@chromium.org>
Message-ID: <1313458336-31456-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change doesn't fix any known problems but turns
on the overflow detection feature of the i2c controller
in the hopes of flushing out any current (or future)
bugs in the i2c driver.

Inspired by a change on nvidia's git server:
  http://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=commit;h=266d1b7397284505e55d06254b497cb32be07b69

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
This takes Felipe Balbi's suggestion of making the overflow
error non-fatal.

 drivers/i2c/busses/i2c-tegra.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 2440b74..34634b7 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -83,6 +83,7 @@
 #define I2C_ERR_NO_ACK				0x01
 #define I2C_ERR_ARBITRATION_LOST		0x02
 #define I2C_ERR_UNKNOWN_INTERRUPT		0x04
+#define I2C_ERR_FIFO_OVERFLOW			0x08
 
 #define PACKET_HEADER0_HEADER_SIZE_SHIFT	28
 #define PACKET_HEADER0_PACKET_ID_SHIFT		16
@@ -367,7 +368,8 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 {
 	u32 status;
-	const u32 status_err = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
+	const u32 status_err = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST |
+		I2C_INT_TX_FIFO_OVERFLOW;
 	struct tegra_i2c_dev *i2c_dev = dev_id;
 
 	status = i2c_readl(i2c_dev, I2C_INT_STATUS);
@@ -389,6 +391,14 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	}
 
 	if (unlikely(status & status_err)) {
+		/*
+		 * Overflow should be impossible unless we've got a
+		 * bug in the driver, but check anyway.
+		 */
+		if (status & I2C_INT_TX_FIFO_OVERFLOW) {
+			WARN_ON(1);
+			i2c_dev->msg_err |= I2C_ERR_FIFO_OVERFLOW;
+		}
 		if (status & I2C_INT_NO_ACK)
 			i2c_dev->msg_err |= I2C_ERR_NO_ACK;
 		if (status & I2C_INT_ARBITRATION_LOST)
@@ -423,7 +433,7 @@ err:
 	/* An error occurred, mask all interrupts */
 	tegra_i2c_mask_irq(i2c_dev, I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST |
 		I2C_INT_PACKET_XFER_COMPLETE | I2C_INT_TX_FIFO_DATA_REQ |
-		I2C_INT_RX_FIFO_DATA_REQ);
+		I2C_INT_RX_FIFO_DATA_REQ | I2C_INT_TX_FIFO_OVERFLOW);
 	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
 	if (i2c_dev->is_dvc)
 		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
@@ -473,7 +483,8 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	if (!(msg->flags & I2C_M_RD))
 		tegra_i2c_fill_tx_fifo(i2c_dev);
 
-	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
+	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST |
+		I2C_INT_TX_FIFO_OVERFLOW;
 	if (msg->flags & I2C_M_RD)
 		int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
 	else if (i2c_dev->msg_buf_remaining)
-- 
1.7.3.1
