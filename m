From: enrico.scholz@sigma-chemnitz.de (Enrico Scholz)
Date: Wed, 13 Feb 2013 14:48:56 +0100
Subject: [PATCH 1/3] i2c: mxs: support non-dma mapable buffers
Message-ID: <1360763336-1931-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Internal transfer routine of the mxs i2c drivers assume that buffers
in i2c messages are dma mapable. That's not always the case when
e.g. string constants located in module memory are going to be
transmitted.

Patch checks whether buffers are dma mapable and in case they are
not, a temporary buffer is used instead of.  Usually, this buffer is
kmalloc()ed, but to optimize things for small sizes, preallocated
space might be used too.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 drivers/i2c/busses/i2c-mxs.c | 47 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index d6abaf2..c995393 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -139,6 +139,13 @@ struct mxs_i2c_dev {
 	uint32_t			addr_data;
 	struct scatterlist		sg_io[2];
 	bool				dma_read;
+
+	/*
+	 * internal buffer for handling non-dma mapable buffers; when message
+	 * exceeds the (arbitrary) size of '8', a buffer will be kmalloc()'ed
+	 * instead of using this attribute
+	 */
+	unsigned char			xfer_buf[8];
 };
 
 static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
@@ -171,7 +178,8 @@ static void mxs_i2c_dma_irq_callback(void *param)
 }
 
 static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
-			struct i2c_msg *msg, uint32_t flags)
+			struct i2c_msg *msg, uint32_t flags,
+			void *xfer_buf)
 {
 	struct dma_async_tx_descriptor *desc;
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
@@ -224,7 +232,7 @@ static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
 		}
 
 		/* Queue the DMA data transfer. */
-		sg_init_one(&i2c->sg_io[1], msg->buf, msg->len);
+		sg_init_one(&i2c->sg_io[1], xfer_buf, msg->len);
 		dma_map_sg(i2c->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
 		desc = dmaengine_prep_slave_sg(i2c->dmach, &i2c->sg_io[1], 1,
 					DMA_DEV_TO_MEM,
@@ -257,7 +265,7 @@ static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
 		/* Queue the DMA data transfer. */
 		sg_init_table(i2c->sg_io, 2);
 		sg_set_buf(&i2c->sg_io[0], &i2c->addr_data, 1);
-		sg_set_buf(&i2c->sg_io[1], msg->buf, msg->len);
+		sg_set_buf(&i2c->sg_io[1], xfer_buf, msg->len);
 		dma_map_sg(i2c->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
 		desc = dmaengine_prep_slave_sg(i2c->dmach, i2c->sg_io, 2,
 					DMA_MEM_TO_DEV,
@@ -307,6 +315,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
 	int ret;
 	int flags;
+	unsigned char *xfer_buf = NULL;
 
 	flags = stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
 
@@ -316,30 +325,56 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	if (msg->len == 0)
 		return -EINVAL;
 
+	if (!virt_addr_valid(msg->buf)) {
+		if (msg->len <= sizeof(i2c->xfer_buf))
+			xfer_buf = i2c->xfer_buf;
+		else
+			xfer_buf = kmalloc(msg->len, GFP_KERNEL | GFP_DMA);
+
+		if (!xfer_buf)
+			return -ENOMEM;
+	}
+
 	INIT_COMPLETION(i2c->cmd_complete);
 	i2c->cmd_err = 0;
 
-	ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
+	if (xfer_buf && !(msg->flags & I2C_M_RD))
+		memcpy(xfer_buf, msg->buf, msg->len);
+
+	ret = mxs_i2c_dma_setup_xfer(adap, msg, flags,
+				     xfer_buf ? xfer_buf : msg->buf);
 	if (ret)
-		return ret;
+		goto err;
 
 	ret = wait_for_completion_timeout(&i2c->cmd_complete,
 						msecs_to_jiffies(1000));
 	if (ret == 0)
 		goto timeout;
 
+	if (xfer_buf && (msg->flags & I2C_M_RD))
+		memcpy(msg->buf, xfer_buf, msg->len);
+
 	if (i2c->cmd_err == -ENXIO)
 		mxs_i2c_reset(i2c);
 
+	if (xfer_buf != i2c->xfer_buf)
+		kfree(xfer_buf);
+
 	dev_dbg(i2c->dev, "Done with err=%d\n", i2c->cmd_err);
 
 	return i2c->cmd_err;
 
 timeout:
+	ret = -ETIMEDOUT;
 	dev_dbg(i2c->dev, "Timeout!\n");
 	mxs_i2c_dma_finish(i2c);
 	mxs_i2c_reset(i2c);
-	return -ETIMEDOUT;
+
+err:
+	if (xfer_buf != i2c->xfer_buf)
+		kfree(xfer_buf);
+
+	return ret;
 }
 
 static int mxs_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
-- 
1.7.11.7
