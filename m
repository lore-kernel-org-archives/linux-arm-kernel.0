From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 21 Sep 2017 16:26:54 +0800
Subject: [PATCH v4 4/7] soc: mediatek: pwrap: update pwrap_init without slave
 programming
In-Reply-To: <cover.1505980364.git.sean.wang@mediatek.com>
References: <cover.1505980364.git.sean.wang@mediatek.com>
Message-ID: <604078485ca9ab04cea5bc531425d6035b27bc88.1505980364.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

pwrap initialization is highly associated with the base SoC, so
update here for allowing pwrap_init without slave program which would be
used to those PMICs without extra encryption on bus such as MT6380.

Signed-off-by: Chenglin Xu <chenglin.xu@mediatek.com>
Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 91 +++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 37 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 27d7ccc..9c6d855 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -531,6 +531,7 @@ struct pmic_wrapper_type {
 	u32 spi_w;
 	u32 wdt_src;
 	int has_bridge:1;
+	int slv_program:1;
 	int (*init_reg_clock)(struct pmic_wrapper *wrp);
 	int (*init_soc_specific)(struct pmic_wrapper *wrp);
 };
@@ -999,9 +1000,12 @@ static int pwrap_init(struct pmic_wrapper *wrp)
 	}
 
 	/* Reset SPI slave */
-	ret = pwrap_reset_spislave(wrp);
-	if (ret)
-		return ret;
+
+	if (wrp->master->slv_program) {
+		ret = pwrap_reset_spislave(wrp);
+		if (ret)
+			return ret;
+	}
 
 	pwrap_writel(wrp, 1, PWRAP_WRAP_EN);
 
@@ -1013,45 +1017,52 @@ static int pwrap_init(struct pmic_wrapper *wrp)
 	if (ret)
 		return ret;
 
-	/* Setup serial input delay */
-	ret = pwrap_init_sidly(wrp);
-	if (ret)
-		return ret;
+	if (wrp->master->slv_program) {
+		/* Setup serial input delay */
+		ret = pwrap_init_sidly(wrp);
+		if (ret)
+			return ret;
 
-	/* Enable dual IO mode */
-	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_DIO_EN], 1);
+		/* Enable dual IO mode */
+		pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_DIO_EN], 1);
 
-	/* Check IDLE & INIT_DONE in advance */
-	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle_and_sync_idle);
-	if (ret) {
-		dev_err(wrp->dev, "%s fail, ret=%d\n", __func__, ret);
-		return ret;
-	}
+		/* Check IDLE & INIT_DONE in advance */
+		ret = pwrap_wait_for_state(wrp,
+					   pwrap_is_fsm_idle_and_sync_idle);
+		if (ret) {
+			dev_err(wrp->dev, "%s fail, ret=%d\n", __func__, ret);
+			return ret;
+		}
 
-	pwrap_writel(wrp, 1, PWRAP_DIO_EN);
+		pwrap_writel(wrp, 1, PWRAP_DIO_EN);
 
-	/* Read Test */
-	pwrap_read(wrp, wrp->slave->dew_regs[PWRAP_DEW_READ_TEST], &rdata);
-	if (rdata != PWRAP_DEW_READ_TEST_VAL) {
-		dev_err(wrp->dev, "Read test failed after switch to DIO mode: 0x%04x != 0x%04x\n",
+		/* Read Test */
+		pwrap_read(wrp,
+			   wrp->slave->dew_regs[PWRAP_DEW_READ_TEST], &rdata);
+		if (rdata != PWRAP_DEW_READ_TEST_VAL) {
+			dev_err(wrp->dev,
+				"Read failed on DIO mode: 0x%04x!=0x%04x\n",
 				PWRAP_DEW_READ_TEST_VAL, rdata);
-		return -EFAULT;
-	}
-
-	/* Enable encryption */
-	ret = pwrap_init_cipher(wrp);
-	if (ret)
-		return ret;
+			return -EFAULT;
+		}
 
-	/* Signature checking - using CRC */
-	if (pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CRC_EN], 0x1))
-		return -EFAULT;
+		/* Enable encryption */
+		ret = pwrap_init_cipher(wrp);
+		if (ret)
+			return ret;
 
-	pwrap_writel(wrp, 0x1, PWRAP_CRC_EN);
-	pwrap_writel(wrp, 0x0, PWRAP_SIG_MODE);
-	pwrap_writel(wrp, wrp->slave->dew_regs[PWRAP_DEW_CRC_VAL],
-		     PWRAP_SIG_ADR);
-	pwrap_writel(wrp, wrp->master->arb_en_all, PWRAP_HIPRIO_ARB_EN);
+		/* Signature checking - using CRC */
+		if (pwrap_write(wrp,
+				wrp->slave->dew_regs[PWRAP_DEW_CRC_EN], 0x1))
+			return -EFAULT;
+
+		pwrap_writel(wrp, 0x1, PWRAP_CRC_EN);
+		pwrap_writel(wrp, 0x0, PWRAP_SIG_MODE);
+		pwrap_writel(wrp, wrp->slave->dew_regs[PWRAP_DEW_CRC_VAL],
+			     PWRAP_SIG_ADR);
+		pwrap_writel(wrp,
+			     wrp->master->arb_en_all, PWRAP_HIPRIO_ARB_EN);
+	}
 
 	if (wrp->master->type == PWRAP_MT8135)
 		pwrap_writel(wrp, 0x7, PWRAP_RRARB_EN);
@@ -1059,8 +1070,11 @@ static int pwrap_init(struct pmic_wrapper *wrp)
 	pwrap_writel(wrp, 0x1, PWRAP_WACS0_EN);
 	pwrap_writel(wrp, 0x1, PWRAP_WACS1_EN);
 	pwrap_writel(wrp, 0x1, PWRAP_WACS2_EN);
-	pwrap_writel(wrp, 0x5, PWRAP_STAUPD_PRD);
-	pwrap_writel(wrp, 0xff, PWRAP_STAUPD_GRPEN);
+
+	if (wrp->master->slv_program) {
+		pwrap_writel(wrp, 0x5, PWRAP_STAUPD_PRD);
+		pwrap_writel(wrp, 0xff, PWRAP_STAUPD_GRPEN);
+	}
 
 	if (wrp->master->init_soc_specific) {
 		ret = wrp->master->init_soc_specific(wrp);
@@ -1146,6 +1160,7 @@ static const struct pmic_wrapper_type pwrap_mt2701 = {
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE_NEW,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
 	.has_bridge = 0,
+	.slv_program = 1,
 	.init_reg_clock = pwrap_mt2701_init_reg_clock,
 	.init_soc_specific = pwrap_mt2701_init_soc_specific,
 };
@@ -1158,6 +1173,7 @@ static const struct pmic_wrapper_type pwrap_mt8135 = {
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
 	.has_bridge = 1,
+	.slv_program = 1,
 	.init_reg_clock = pwrap_mt8135_init_reg_clock,
 	.init_soc_specific = pwrap_mt8135_init_soc_specific,
 };
@@ -1170,6 +1186,7 @@ static const struct pmic_wrapper_type pwrap_mt8173 = {
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_NO_STAUPD,
 	.has_bridge = 0,
+	.slv_program = 1,
 	.init_reg_clock = pwrap_mt8173_init_reg_clock,
 	.init_soc_specific = pwrap_mt8173_init_soc_specific,
 };
-- 
2.7.4
