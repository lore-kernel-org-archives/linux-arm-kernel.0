From: blogic@openwrt.org (John Crispin)
Date: Sun,  7 Feb 2016 11:42:57 +0100
Subject: [PATCH V5 10/11] soc: mediatek: PMIC wrap: add mt6323 slave support
In-Reply-To: <1454841778-35529-1-git-send-email-blogic@openwrt.org>
References: <1454841778-35529-1-git-send-email-blogic@openwrt.org>
Message-ID: <1454841778-35529-11-git-send-email-blogic@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for MT6323 slaves. This PMIC can be found on MT2701 and MT7623
EVB. The only function that we need to touch is pwrap_init_cipher().

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c |   47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 2628271..5fbdd5c 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -91,6 +91,31 @@ enum dew_regs {
 	PWRAP_DEW_CIPHER_RDY,
 	PWRAP_DEW_CIPHER_MODE,
 	PWRAP_DEW_CIPHER_SWRST,
+
+	/* MT6323 only regs */
+	PWRAP_DEW_CRC_SWRST,
+	PWRAP_DEW_CIPHER_EN,
+	PWRAP_DEW_RDDMY_NO,
+	PWRAP_DEW_RDATA_DLY_SEL,
+};
+
+static const u32 mt6323_regs[] = {
+	[PWRAP_DEW_BASE] =		0x0000,
+	[PWRAP_DEW_DIO_EN] =		0x018a,
+	[PWRAP_DEW_READ_TEST] =		0x018c,
+	[PWRAP_DEW_WRITE_TEST] =	0x018e,
+	[PWRAP_DEW_CRC_SWRST] =		0x0190,
+	[PWRAP_DEW_CRC_EN] =		0x0192,
+	[PWRAP_DEW_CRC_VAL] =		0x0194,
+	[PWRAP_DEW_MON_GRP_SEL] =	0x0196,
+	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x0198,
+	[PWRAP_DEW_CIPHER_IV_SEL] =	0x019a,
+	[PWRAP_DEW_CIPHER_EN] =		0x019c,
+	[PWRAP_DEW_CIPHER_RDY] =	0x019e,
+	[PWRAP_DEW_CIPHER_MODE] =	0x01a0,
+	[PWRAP_DEW_CIPHER_SWRST] =	0x01a2,
+	[PWRAP_DEW_RDDMY_NO] =		0x01a4,
+	[PWRAP_DEW_RDATA_DLY_SEL] =	0x01a6,
 };
 
 static const u32 mt6397_regs[] = {
@@ -369,6 +394,7 @@ static int mt8135_regs[] = {
 };
 
 enum pmic_type {
+	PMIC_MT6323,
 	PMIC_MT6397,
 };
 
@@ -659,6 +685,19 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_LOAD], 0x1);
 	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_START], 0x1);
 
+	switch (wrp->slave->type) {
+	case PMIC_MT6397:
+		pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_LOAD],
+			    0x1);
+		pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_START],
+			    0x1);
+		break;
+	case PMIC_MT6323:
+		pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_EN],
+			    0x1);
+		break;
+	}
+
 	/* wait for cipher data ready at AP */
 	ret = pwrap_wait_for_state(wrp, pwrap_is_cipher_ready);
 	if (ret) {
@@ -856,6 +895,11 @@ static const struct regmap_config pwrap_regmap_config = {
 	.max_register = 0xffff,
 };
 
+static const struct pwrap_slv_type pmic_mt6323 = {
+	.dew_regs = mt6323_regs,
+	.type = PMIC_MT6323,
+};
+
 static const struct pwrap_slv_type pmic_mt6397 = {
 	.dew_regs = mt6397_regs,
 	.type = PMIC_MT6397,
@@ -863,6 +907,9 @@ static const struct pwrap_slv_type pmic_mt6397 = {
 
 static const struct of_device_id of_slave_match_tbl[] = {
 	{
+		.compatible = "mediatek,mt6323",
+		.data = &pmic_mt6323,
+	}, {
 		.compatible = "mediatek,mt6397",
 		.data = &pmic_mt6397,
 	}, {
-- 
1.7.10.4
