From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 16 Oct 2017 15:07:42 +0800
Subject: [PATCH v5 5/7] soc: mediatek: pwrap: add MediaTek MT6380 as one slave
 of pwrap
In-Reply-To: <cover.1508135937.git.sean.wang@mediatek.com>
References: <cover.1508135937.git.sean.wang@mediatek.com>
Message-ID: <a1cfdb274996bb36b545e01fb2e0c278e0c80b7e.1508135937.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add MediaTek MT6380 regulator becoming one of PMIC wrapper slave
and also add extra new regmap_config of 32-bit mode for MT6380
since old regmap_config of 16-bit mode can't be fit into the need.

Signed-off-by: Chenglin Xu <chenglin.xu@mediatek.com>
Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index f764908..a4cdc5f 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -507,6 +507,7 @@ struct pmic_wrapper;
 struct pwrap_slv_type {
 	const u32 *dew_regs;
 	enum pmic_type type;
+	const struct regmap_config *regmap;
 	/* Flags indicating the capability for the target slave */
 	u32 caps;
 	/* pwrap operations are highly associated with the PMIC types,
@@ -1146,7 +1147,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static const struct regmap_config pwrap_regmap_config = {
+static const struct regmap_config pwrap_regmap_config16 = {
 	.reg_bits = 16,
 	.val_bits = 16,
 	.reg_stride = 2,
@@ -1155,9 +1156,19 @@ static const struct regmap_config pwrap_regmap_config = {
 	.max_register = 0xffff,
 };
 
+static const struct regmap_config pwrap_regmap_config32 = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.reg_read = pwrap_regmap_read,
+	.reg_write = pwrap_regmap_write,
+	.max_register = 0xffff,
+};
+
 static const struct pwrap_slv_type pmic_mt6323 = {
 	.dew_regs = mt6323_regs,
 	.type = PMIC_MT6323,
+	.regmap = &pwrap_regmap_config16,
 	.caps = PWRAP_SLV_CAP_SPI | PWRAP_SLV_CAP_DUALIO |
 		PWRAP_SLV_CAP_SECURITY,
 	.pwrap_read = pwrap_read16,
@@ -1167,6 +1178,7 @@ static const struct pwrap_slv_type pmic_mt6323 = {
 static const struct pwrap_slv_type pmic_mt6380 = {
 	.dew_regs = NULL,
 	.type = PMIC_MT6380,
+	.regmap = &pwrap_regmap_config32,
 	.caps = 0,
 	.pwrap_read = pwrap_read32,
 	.pwrap_write = pwrap_write32,
@@ -1175,6 +1187,7 @@ static const struct pwrap_slv_type pmic_mt6380 = {
 static const struct pwrap_slv_type pmic_mt6397 = {
 	.dew_regs = mt6397_regs,
 	.type = PMIC_MT6397,
+	.regmap = &pwrap_regmap_config16,
 	.caps = PWRAP_SLV_CAP_SPI | PWRAP_SLV_CAP_DUALIO |
 		PWRAP_SLV_CAP_SECURITY,
 	.pwrap_read = pwrap_read16,
@@ -1186,9 +1199,14 @@ static const struct of_device_id of_slave_match_tbl[] = {
 		.compatible = "mediatek,mt6323",
 		.data = &pmic_mt6323,
 	}, {
+		/* The MT6380 PMIC only implements a regulator, so we bind it
+		 * directly instead of using a MFD.
+		 */
+		.compatible = "mediatek,mt6380-regulator",
+		.data = &pmic_mt6380,
+	}, {
 		.compatible = "mediatek,mt6397",
 		.data = &pmic_mt6397,
-	}, {
 		/* sentinel */
 	}
 };
@@ -1364,7 +1382,7 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_out2;
 
-	wrp->regmap = devm_regmap_init(wrp->dev, NULL, wrp, &pwrap_regmap_config);
+	wrp->regmap = devm_regmap_init(wrp->dev, NULL, wrp, wrp->slave->regmap);
 	if (IS_ERR(wrp->regmap)) {
 		ret = PTR_ERR(wrp->regmap);
 		goto err_out2;
-- 
2.7.4
