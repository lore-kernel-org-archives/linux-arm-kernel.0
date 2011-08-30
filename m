From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 30 Aug 2011 11:46:10 -0600
Subject: [PATCH REPOST 3/3] i2c: tegra: fix possible race condition after tx
In-Reply-To: <1314726370-8193-1-git-send-email-swarren@nvidia.com>
References: <1314726370-8193-1-git-send-email-swarren@nvidia.com>
Message-ID: <1314726370-8193-4-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Anderson <dianders@chromium.org>

In tegra_i2c_fill_tx_fifo, once we have finished pushing all the bytes
to the I2C hardware controller, the interrupt might happen before we
have updated i2c_dev->msg_buf_remaining at the end of the function.
Then, in tegra_i2c_isr, we will call again tegra_i2c_fill_tx_fifo
triggering weird behaviour. This has been shown to happen under real
conditions.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Tested-by: Vincent Palatin <vpalatin@chromium.org>
Acked-by: Rhyland Klein <rklein@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c |   46 +++++++++++++++++++++++++++------------
 1 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 8848a4b..b402435 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -271,14 +271,30 @@ static int tegra_i2c_fill_tx_fifo(struct tegra_i2c_dev *i2c_dev)
 
 	/* Rounds down to not include partial word at the end of buf */
 	words_to_transfer = buf_remaining / BYTES_PER_FIFO_WORD;
-	if (words_to_transfer > tx_fifo_avail)
-		words_to_transfer = tx_fifo_avail;
 
-	i2c_writesl(i2c_dev, buf, I2C_TX_FIFO, words_to_transfer);
-
-	buf += words_to_transfer * BYTES_PER_FIFO_WORD;
-	buf_remaining -= words_to_transfer * BYTES_PER_FIFO_WORD;
-	tx_fifo_avail -= words_to_transfer;
+	/* It's very common to have < 4 bytes, so optimize that case. */
+	if (words_to_transfer) {
+		if (words_to_transfer > tx_fifo_avail)
+			words_to_transfer = tx_fifo_avail;
+
+		/*
+		 * Update state before writing to FIFO.  If this casues us
+		 * to finish writing all bytes (AKA buf_remaining goes to 0) we
+		 * have a potential for an interrupt (PACKET_XFER_COMPLETE is
+		 * not maskable).  We need to make sure that the isr sees
+		 * buf_remaining as 0 and doesn't call us back re-entrantly.
+		 */
+		buf_remaining -= words_to_transfer * BYTES_PER_FIFO_WORD;
+		tx_fifo_avail -= words_to_transfer;
+		i2c_dev->msg_buf_remaining = buf_remaining;
+		i2c_dev->msg_buf = buf +
+			words_to_transfer * BYTES_PER_FIFO_WORD;
+		barrier();
+
+		i2c_writesl(i2c_dev, buf, I2C_TX_FIFO, words_to_transfer);
+
+		buf += words_to_transfer * BYTES_PER_FIFO_WORD;
+	}
 
 	/*
 	 * If there is a partial word at the end of buf, handle it manually to
@@ -288,14 +304,15 @@ static int tegra_i2c_fill_tx_fifo(struct tegra_i2c_dev *i2c_dev)
 	if (tx_fifo_avail > 0 && buf_remaining > 0) {
 		BUG_ON(buf_remaining > 3);
 		memcpy(&val, buf, buf_remaining);
+
+		/* Again update before writing to FIFO to make sure isr sees. */
+		i2c_dev->msg_buf_remaining = 0;
+		i2c_dev->msg_buf = NULL;
+		barrier();
+
 		i2c_writel(i2c_dev, val, I2C_TX_FIFO);
-		buf_remaining = 0;
-		tx_fifo_avail--;
 	}
 
-	BUG_ON(tx_fifo_avail > 0 && buf_remaining > 0);
-	i2c_dev->msg_buf_remaining = buf_remaining;
-	i2c_dev->msg_buf = buf;
 	return 0;
 }
 
@@ -412,9 +429,10 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 			tegra_i2c_mask_irq(i2c_dev, I2C_INT_TX_FIFO_DATA_REQ);
 	}
 
-	if ((status & I2C_INT_PACKET_XFER_COMPLETE) &&
-			!i2c_dev->msg_buf_remaining)
+	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
+		BUG_ON(i2c_dev->msg_buf_remaining);
 		complete(&i2c_dev->msg_complete);
+	}
 
 	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
 	if (i2c_dev->is_dvc)
-- 
1.7.0.4
