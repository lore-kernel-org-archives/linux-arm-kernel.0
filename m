From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Tue, 13 Oct 2009 11:51:37 +0900
Subject: [PATCH 09/16] i2c-designware: i2c_dw_xfer_msg: Fix an i2c_msg search
	bug
In-Reply-To: <4AD3E974.8080200@necel.com>
References: <4AD3E974.8080200@necel.com>
Message-ID: <4AD3EB39.1020300@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case an i2c_msg, which is currently work-in-progress, has more bytes
to be written, we need to set STATUS_WRITE_IN_PROGRESS _and_ exit from
the msg_write_idx-search loop.  Otherwise, we'll overtake the current
index without waiting for transmission completed.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 26efd3a..6bfdc5f 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -386,17 +386,22 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 						dev->base + DW_IC_DATA_CMD);
 			tx_limit--; buf_len--;
 		}
+
+		dev->tx_buf_len = buf_len;
+
+		/* more bytes to be written? */
+		if (buf_len > 0) {
+			dev->status |= STATUS_WRITE_IN_PROGRESS;
+			break;
+		} else {
+			dev->status &= ~STATUS_WRITE_IN_PROGRESS;
+		}
 	}
 
 	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
-	if (buf_len > 0) { /* more bytes to be written */
+	if (buf_len > 0)
 		intr_mask |= DW_IC_INTR_TX_EMPTY;
-		dev->status |= STATUS_WRITE_IN_PROGRESS;
-	} else
-		dev->status &= ~STATUS_WRITE_IN_PROGRESS;
 	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
-
-	dev->tx_buf_len = buf_len;
 }
 
 static void
-- 
1.6.5
