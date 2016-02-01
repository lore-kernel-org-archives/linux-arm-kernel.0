From: liguo.zhang@mediatek.com (Liguo Zhang)
Date: Mon, 1 Feb 2016 09:58:30 +0800
Subject: [PATCH v5] i2c: mt8173: add 4GB mode support in i2c driver.
Message-ID: <1454291910-19870-1-git-send-email-liguo.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If 4GB mode is enable, we should add 4gb mode support in i2c driver.
Set 4GB mode register to support 4GB mode.

Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
---
change in v5:
Use BIT_ULL() to fix kernel building warning.
change in v4:
Use BIT_ULL() to fix kernel building warning.
change in v3:
Only inline the computation of reg_4g_mode in mtk_i2c_set_4g_mode().
change in v2:
Define a static inline function mtk_i2c_set_4g_mode() for support 4g mode.
---
 drivers/i2c/busses/i2c-mt65xx.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index aec8e6c..e054205 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -60,6 +60,7 @@
 #define I2C_DMA_INT_FLAG_NONE		0x0000
 #define I2C_DMA_CLR_FLAG		0x0000
 #define I2C_DMA_HARD_RST		0x0002
+#define I2C_DMA_4G_MODE			0x0001
 
 #define I2C_DEFAULT_SPEED		100000	/* hz */
 #define MAX_FS_MODE_SPEED		400000
@@ -88,6 +89,8 @@ enum DMA_REGS_OFFSET {
 	OFFSET_RX_MEM_ADDR = 0x20,
 	OFFSET_TX_LEN = 0x24,
 	OFFSET_RX_LEN = 0x28,
+	OFFSET_TX_4G_MODE = 0x54,
+	OFFSET_RX_4G_MODE = 0x58,
 };
 
 enum i2c_trans_st_rs {
@@ -133,6 +136,7 @@ struct mtk_i2c_compatible {
 	unsigned char dcm: 1;
 	unsigned char auto_restart: 1;
 	unsigned char aux_len_reg: 1;
+	unsigned char support_33bits: 1;
 };
 
 struct mtk_i2c {
@@ -182,6 +186,7 @@ static const struct mtk_i2c_compatible mt6577_compat = {
 	.dcm = 1,
 	.auto_restart = 0,
 	.aux_len_reg = 0,
+	.support_33bits = 0,
 };
 
 static const struct mtk_i2c_compatible mt6589_compat = {
@@ -190,6 +195,7 @@ static const struct mtk_i2c_compatible mt6589_compat = {
 	.dcm = 0,
 	.auto_restart = 0,
 	.aux_len_reg = 0,
+	.support_33bits = 0,
 };
 
 static const struct mtk_i2c_compatible mt8173_compat = {
@@ -198,6 +204,7 @@ static const struct mtk_i2c_compatible mt8173_compat = {
 	.dcm = 1,
 	.auto_restart = 1,
 	.aux_len_reg = 1,
+	.support_33bits = 1,
 };
 
 static const struct of_device_id mtk_i2c_of_match[] = {
@@ -366,6 +373,11 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk,
 	return 0;
 }
 
+static inline u32 mtk_i2c_set_4g_mode(dma_addr_t addr)
+{
+	return (addr & BIT_ULL(32)) ? I2C_DMA_4G_MODE : I2C_DMA_CLR_FLAG;
+}
+
 static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 			       int num, int left_num)
 {
@@ -373,6 +385,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	u16 start_reg;
 	u16 control_reg;
 	u16 restart_flag = 0;
+	u32 reg_4g_mode = 0;
 	dma_addr_t rpaddr = 0;
 	dma_addr_t wpaddr = 0;
 	int ret;
@@ -439,6 +452,12 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 					msgs->len, DMA_FROM_DEVICE);
 		if (dma_mapping_error(i2c->dev, rpaddr))
 			return -ENOMEM;
+
+		if (i2c->dev_comp->support_33bits) {
+			reg_4g_mode = mtk_i2c_set_4g_mode(rpaddr);
+			writel(reg_4g_mode, i2c->pdmabase + OFFSET_RX_4G_MODE);
+		}
+
 		writel((u32)rpaddr, i2c->pdmabase + OFFSET_RX_MEM_ADDR);
 		writel(msgs->len, i2c->pdmabase + OFFSET_RX_LEN);
 	} else if (i2c->op == I2C_MASTER_WR) {
@@ -448,6 +467,12 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 					msgs->len, DMA_TO_DEVICE);
 		if (dma_mapping_error(i2c->dev, wpaddr))
 			return -ENOMEM;
+
+		if (i2c->dev_comp->support_33bits) {
+			reg_4g_mode = mtk_i2c_set_4g_mode(wpaddr);
+			writel(reg_4g_mode, i2c->pdmabase + OFFSET_TX_4G_MODE);
+		}
+
 		writel((u32)wpaddr, i2c->pdmabase + OFFSET_TX_MEM_ADDR);
 		writel(msgs->len, i2c->pdmabase + OFFSET_TX_LEN);
 	} else {
@@ -465,6 +490,15 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 					 msgs->len, DMA_TO_DEVICE);
 			return -ENOMEM;
 		}
+
+		if (i2c->dev_comp->support_33bits) {
+			reg_4g_mode = mtk_i2c_set_4g_mode(wpaddr);
+			writel(reg_4g_mode, i2c->pdmabase + OFFSET_TX_4G_MODE);
+
+			reg_4g_mode = mtk_i2c_set_4g_mode(rpaddr);
+			writel(reg_4g_mode, i2c->pdmabase + OFFSET_RX_4G_MODE);
+		}
+
 		writel((u32)wpaddr, i2c->pdmabase + OFFSET_TX_MEM_ADDR);
 		writel((u32)rpaddr, i2c->pdmabase + OFFSET_RX_MEM_ADDR);
 		writel(msgs->len, i2c->pdmabase + OFFSET_TX_LEN);
@@ -729,6 +763,14 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (i2c->dev_comp->support_33bits) {
+		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(33));
+		if (ret) {
+			dev_err(&pdev->dev, "dma_set_mask return error.\n");
+			return ret;
+		}
+	}
+
 	ret = mtk_i2c_clock_enable(i2c);
 	if (ret) {
 		dev_err(&pdev->dev, "clock enable failed!\n");
-- 
1.8.1.1.dirty
