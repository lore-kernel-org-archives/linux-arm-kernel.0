From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Tue, 13 Oct 2009 11:53:35 +0900
Subject: [PATCH 14/16] i2c-designware: Deferred FIFO-data-counting variables
	initialization
In-Reply-To: <4AD3E974.8080200@necel.com>
References: <4AD3E974.8080200@necel.com>
Message-ID: <4AD3EBAF.2040903@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the driver and hardware always process the given data in parallel,
it would be better to initialize those {tx,rx}_limit or rx_valid
variables just prior to be used.

This will help to send/receive data as much as possible.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index b3152c2..f7ea032 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -359,8 +359,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
 	u32 intr_mask;
-	int tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
-	int rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
+	int tx_limit, rx_limit;
 	u32 addr = msgs[dev->msg_write_idx].addr;
 	u32 buf_len = dev->tx_buf_len;
 	u8 *buf = dev->tx_buf;;
@@ -386,6 +385,9 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			buf_len = msgs[dev->msg_write_idx].len;
 		}
 
+		tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
+		rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
+
 		while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
 			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
 				writel(0x100, dev->base + DW_IC_DATA_CMD);
@@ -418,7 +420,7 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
 	u32 addr = msgs[dev->msg_read_idx].addr;
-	int rx_valid = readl(dev->base + DW_IC_RXFLR);
+	int rx_valid;
 
 	for (; dev->msg_read_idx < dev->msgs_num; dev->msg_read_idx++) {
 		u32 len;
@@ -439,6 +441,8 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 			buf = dev->rx_buf;
 		}
 
+		rx_valid = readl(dev->base + DW_IC_RXFLR);
+
 		for (; len > 0 && rx_valid > 0; len--, rx_valid--)
 			*buf++ = readl(dev->base + DW_IC_DATA_CMD);
 
-- 
1.6.5
