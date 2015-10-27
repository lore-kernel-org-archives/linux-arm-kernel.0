From: liguo.zhang@mediatek.com (Liguo Zhang)
Date: Tue, 27 Oct 2015 16:59:27 +0800
Subject: [PATCH 2/2] i2c: mediatek: fix i2c multi transfer issue in high speed
 mode
In-Reply-To: <1445936367-30141-1-git-send-email-liguo.zhang@mediatek.com>
References: <1445936367-30141-1-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <1445936367-30141-3-git-send-email-liguo.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For platform with auto restart support, when doing i2c multi transfer
in high speed, for example, doing write-then-read transfer, the master
code will occupy the first transfer, and the second transfer will be
the read transfer, the write transfer will be discarded. So we should
first send the master code, and then start i2c multi transfer.

Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index dc4aac6..0b9e9f5 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -53,6 +53,8 @@
 #define I2C_FS_TIME_INIT_VALUE		0x1303
 #define I2C_WRRD_TRANAC_VALUE		0x0002
 #define I2C_RD_TRANAC_VALUE		0x0001
+#define I2C_TRAN_DEFAULT_VALUE		0x0001
+#define I2C_TRANAC_DEFAULT_VALUE	0x0001
 
 #define I2C_DMA_CON_TX			0x0000
 #define I2C_DMA_CON_RX			0x0001
@@ -365,6 +367,42 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk,
 	return 0;
 }
 
+static int mtk_i2c_send_master_code(struct mtk_i2c *i2c)
+{
+	int ret = 0;
+
+	reinit_completion(&i2c->msg_complete);
+
+	writew(I2C_CONTROL_RS | I2C_CONTROL_ACKERR_DET_EN |
+	       I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN,
+	       i2c->base + OFFSET_CONTROL);
+
+	/* Clear interrupt status */
+	writew(I2C_RS_TRANSFER | I2C_TRANSAC_COMP | I2C_HS_NACKERR | I2C_ACKERR,
+	       i2c->base + OFFSET_INTR_STAT);
+
+	/* Enable interrupt */
+	writew(I2C_RS_TRANSFER | I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_MASK);
+
+	writew(I2C_TRAN_DEFAULT_VALUE, i2c->base + OFFSET_TRANSFER_LEN);
+	writew(I2C_TRANAC_DEFAULT_VALUE, i2c->base + OFFSET_TRANSAC_LEN);
+
+	writew(I2C_TRANSAC_START | I2C_RS_MUL_CNFG, i2c->base + OFFSET_START);
+
+	ret = wait_for_completion_timeout(&i2c->msg_complete,
+					  i2c->adap.timeout);
+
+	completion_done(&i2c->msg_complete);
+
+	if (ret == 0) {
+		dev_dbg(i2c->dev, "send master code timeout.\n");
+		mtk_i2c_init_hw(i2c);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 			       int num, int left_num)
 {
@@ -539,6 +577,12 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 		}
 	}
 
+	if (i2c->auto_restart && i2c->speed_hz > 400000) {
+		ret = mtk_i2c_send_master_code(i2c);
+		if (ret)
+			return ret;
+	}
+
 	while (left_num--) {
 		if (!msgs->buf) {
 			dev_dbg(i2c->dev, "data buffer is NULL.\n");
-- 
1.8.1.1.dirty
