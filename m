From: blogic@openwrt.org (John Crispin)
Date: Sun,  7 Feb 2016 11:42:53 +0100
Subject: [PATCH V5 06/11] soc: mediatek: PMIC wrap: SPI_WRITE needs a
 different bitmask for MT2701/7623
In-Reply-To: <1454841778-35529-1-git-send-email-blogic@openwrt.org>
References: <1454841778-35529-1-git-send-email-blogic@openwrt.org>
Message-ID: <1454841778-35529-7-git-send-email-blogic@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT2701 and MT7623 use a different bitmask for the SPI_WRITE command.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
Changes in V4
* fix typo in the subject

 drivers/soc/mediatek/mtk-pmic-wrap.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 2fd795f..1653e64 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -372,6 +372,7 @@ struct pmic_wrapper_type {
 	enum pwrap_type type;
 	u32 arb_en_all;
 	u32 int_en_all;
+	u32 spi_w;
 	int (*init_reg_clock)(struct pmic_wrapper *wrp);
 	int (*init_special)(struct pmic_wrapper *wrp);
 };
@@ -511,15 +512,15 @@ static int pwrap_reset_spislave(struct pmic_wrapper *wrp)
 	pwrap_writel(wrp, 1, PWRAP_MAN_EN);
 	pwrap_writel(wrp, 0, PWRAP_DIO_EN);
 
-	pwrap_writel(wrp, PWRAP_MAN_CMD_SPI_WRITE | PWRAP_MAN_CMD_OP_CSL,
+	pwrap_writel(wrp, wrp->master->spi_w | PWRAP_MAN_CMD_OP_CSL,
 			PWRAP_MAN_CMD);
-	pwrap_writel(wrp, PWRAP_MAN_CMD_SPI_WRITE | PWRAP_MAN_CMD_OP_OUTS,
+	pwrap_writel(wrp, wrp->master->spi_w | PWRAP_MAN_CMD_OP_OUTS,
 			PWRAP_MAN_CMD);
-	pwrap_writel(wrp, PWRAP_MAN_CMD_SPI_WRITE | PWRAP_MAN_CMD_OP_CSH,
+	pwrap_writel(wrp, wrp->master->spi_w | PWRAP_MAN_CMD_OP_CSH,
 			PWRAP_MAN_CMD);
 
 	for (i = 0; i < 4; i++)
-		pwrap_writel(wrp, PWRAP_MAN_CMD_SPI_WRITE | PWRAP_MAN_CMD_OP_OUTS,
+		pwrap_writel(wrp, wrp->master->spi_w | PWRAP_MAN_CMD_OP_OUTS,
 				PWRAP_MAN_CMD);
 
 	ret = pwrap_wait_for_state(wrp, pwrap_is_sync_idle);
@@ -827,6 +828,7 @@ static struct pmic_wrapper_type pwrap_mt8135 = {
 	.type = PWRAP_MT8135,
 	.arb_en_all = 0x1ff,
 	.int_en_all = ~(BIT(31) | BIT(1)),
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.init_reg_clock = pwrap_mt8135_init_reg_clock,
 	.init_special = pwrap_mt8135_init_special,
 };
@@ -836,6 +838,7 @@ static struct pmic_wrapper_type pwrap_mt8173 = {
 	.type = PWRAP_MT8173,
 	.arb_en_all = 0x3f,
 	.int_en_all = ~(BIT(31) | BIT(1)),
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.init_reg_clock = pwrap_mt8173_init_reg_clock,
 	.init_special = pwrap_mt8173_init_special,
 };
-- 
1.7.10.4
