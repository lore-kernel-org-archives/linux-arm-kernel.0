From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Tue, 13 Oct 2009 11:49:42 +0900
Subject: [PATCH 04/16] i2c-designware: i2c_dw_read: Take "struct dw_i2c_dev"
	pointer
In-Reply-To: <4AD3E974.8080200@necel.com>
References: <4AD3E974.8080200@necel.com>
Message-ID: <4AD3EAC6.5030004@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to interface using with "struct i2c_adapter" pointer.
Let's use a local "struct dw_i2c_dev" pointer, instead.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 0164092..c6a35bf 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -328,9 +328,8 @@ i2c_dw_xfer_msg(struct i2c_adapter *adap)
 }
 
 static void
-i2c_dw_read(struct i2c_adapter *adap)
+i2c_dw_read(struct dw_i2c_dev *dev)
 {
-	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 	struct i2c_msg *msgs = dev->msgs;
 	int num = dev->msgs_num;
 	u32 addr = msgs[dev->msg_read_idx].addr;
@@ -416,7 +415,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (likely(!dev->cmd_err)) {
 		/* read rx fifo, and disable the adapter */
 		do {
-			i2c_dw_read(adap);
+			i2c_dw_read(dev);
 		} while (dev->status & STATUS_READ_IN_PROGRESS);
 		writel(0, dev->base + DW_IC_ENABLE);
 		ret = num;
@@ -450,7 +449,7 @@ static void dw_i2c_pump_msg(unsigned long data)
 	struct dw_i2c_dev *dev = (struct dw_i2c_dev *) data;
 	u32 intr_mask;
 
-	i2c_dw_read(&dev->adapter);
+	i2c_dw_read(dev);
 	i2c_dw_xfer_msg(&dev->adapter);
 
 	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
-- 
1.6.5
