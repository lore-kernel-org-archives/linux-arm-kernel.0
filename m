From: jun.gao@mediatek.com (Jun Gao)
Date: Tue, 19 Dec 2017 14:51:02 +0800
Subject: [PATCH 2/3] i2c: mediatek: Add i2c compatible for MediaTek MT2712
In-Reply-To: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
References: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
Message-ID: <1513666263-6443-3-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Gao <jun.gao@mediatek.com>

Add i2c compatible for MT2712. Compare to MT8173 i2c controller,
internal divider of i2c source clock need to be configured for
MT2712 i2c speed calculation.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 09d288c..58d6401 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -61,6 +61,7 @@
 #define I2C_DMA_HARD_RST		0x0002
 #define I2C_DMA_4G_MODE			0x0001
 
+#define I2C_DEFAULT_CLK_DIV		5
 #define I2C_DEFAULT_SPEED		100000	/* hz */
 #define MAX_FS_MODE_SPEED		400000
 #define MAX_HS_MODE_SPEED		3400000
@@ -127,6 +128,7 @@ enum I2C_REGS_OFFSET {
 	OFFSET_DEBUGSTAT = 0x64,
 	OFFSET_DEBUGCTRL = 0x68,
 	OFFSET_TRANSFER_LEN_AUX = 0x6c,
+	OFFSET_CLOCK_DIV = 0x70,
 };
 
 struct mtk_i2c_compatible {
@@ -136,6 +138,7 @@ struct mtk_i2c_compatible {
 	unsigned char auto_restart: 1;
 	unsigned char aux_len_reg: 1;
 	unsigned char support_33bits: 1;
+	unsigned char timing_adjust: 1;
 };
 
 struct mtk_i2c {
@@ -176,6 +179,15 @@ struct mtk_i2c {
 	.max_num_msgs = 255,
 };
 
+static const struct mtk_i2c_compatible mt2712_compat = {
+	.pmic_i2c = 0,
+	.dcm = 1,
+	.auto_restart = 1,
+	.aux_len_reg = 1,
+	.support_33bits = 1,
+	.timing_adjust = 1,
+};
+
 static const struct mtk_i2c_compatible mt6577_compat = {
 	.quirks = &mt6577_i2c_quirks,
 	.pmic_i2c = 0,
@@ -183,6 +195,7 @@ struct mtk_i2c {
 	.auto_restart = 0,
 	.aux_len_reg = 0,
 	.support_33bits = 0,
+	.timing_adjust = 0,
 };
 
 static const struct mtk_i2c_compatible mt6589_compat = {
@@ -192,6 +205,7 @@ struct mtk_i2c {
 	.auto_restart = 0,
 	.aux_len_reg = 0,
 	.support_33bits = 0,
+	.timing_adjust = 0,
 };
 
 static const struct mtk_i2c_compatible mt7622_compat = {
@@ -201,6 +215,7 @@ struct mtk_i2c {
 	.auto_restart = 1,
 	.aux_len_reg = 1,
 	.support_33bits = 0,
+	.timing_adjust = 0,
 };
 
 static const struct mtk_i2c_compatible mt8173_compat = {
@@ -209,9 +224,11 @@ struct mtk_i2c {
 	.auto_restart = 1,
 	.aux_len_reg = 1,
 	.support_33bits = 1,
+	.timing_adjust = 0,
 };
 
 static const struct of_device_id mtk_i2c_of_match[] = {
+	{ .compatible = "mediatek,mt2712-i2c", .data = &mt2712_compat },
 	{ .compatible = "mediatek,mt6577-i2c", .data = &mt6577_compat },
 	{ .compatible = "mediatek,mt6589-i2c", .data = &mt6589_compat },
 	{ .compatible = "mediatek,mt7622-i2c", .data = &mt7622_compat },
@@ -271,6 +288,9 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
 	if (i2c->dev_comp->dcm)
 		writew(I2C_DCM_DISABLE, i2c->base + OFFSET_DCM_EN);
 
+	if (i2c->dev_comp->timing_adjust)
+		writew(I2C_DEFAULT_CLK_DIV - 1, i2c->base + OFFSET_CLOCK_DIV);
+
 	writew(i2c->timing_reg, i2c->base + OFFSET_TIMING);
 	writew(i2c->high_speed_reg, i2c->base + OFFSET_HS);
 
@@ -725,10 +745,6 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
-	ret = mtk_i2c_parse_dt(pdev->dev.of_node, i2c);
-	if (ret)
-		return -EINVAL;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2c->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(i2c->base))
@@ -759,6 +775,13 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 	i2c->adap.timeout = 2 * HZ;
 	i2c->adap.retries = 1;
 
+	ret = mtk_i2c_parse_dt(pdev->dev.of_node, i2c);
+	if (ret)
+		return -EINVAL;
+
+	if (i2c->dev_comp->timing_adjust)
+		i2c->clk_src_div *= I2C_DEFAULT_CLK_DIV;
+
 	if (i2c->have_pmic && !i2c->dev_comp->pmic_i2c)
 		return -EINVAL;
 
-- 
1.8.1.1
