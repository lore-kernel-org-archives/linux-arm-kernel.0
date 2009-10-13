From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Tue, 13 Oct 2009 11:50:28 +0900
Subject: [PATCH 06/16] i2c-designware: Remove an useless local variable "num"
In-Reply-To: <4AD3E974.8080200@necel.com>
References: <4AD3E974.8080200@necel.com>
Message-ID: <4AD3EAF4.1000500@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We couldn't know the original intent for this variable, but at this
point it's useless.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 205f691..9d81775 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -257,7 +257,6 @@ static void
 i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
-	int num = dev->msgs_num;
 	u32 ic_con, intr_mask;
 	int tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
 	int rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
@@ -283,7 +282,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 		writel(1, dev->base + DW_IC_ENABLE);
 	}
 
-	for (; dev->msg_write_idx < num; dev->msg_write_idx++) {
+	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
 		/* if target address has changed, we need to
 		 * reprogram the target address in the i2c
 		 * adapter when we are done with this transfer
@@ -330,11 +329,10 @@ static void
 i2c_dw_read(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
-	int num = dev->msgs_num;
 	u32 addr = msgs[dev->msg_read_idx].addr;
 	int rx_valid = readl(dev->base + DW_IC_RXFLR);
 
-	for (; dev->msg_read_idx < num; dev->msg_read_idx++) {
+	for (; dev->msg_read_idx < dev->msgs_num; dev->msg_read_idx++) {
 		u32 len;
 		u8 *buf;
 
-- 
1.6.5
