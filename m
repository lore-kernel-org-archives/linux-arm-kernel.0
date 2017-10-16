From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 16 Oct 2017 15:07:41 +0800
Subject: [PATCH v5 4/7] soc: mediatek: pwrap: refactor pwrap_init for the
 various PMIC types
In-Reply-To: <cover.1508135937.git.sean.wang@mediatek.com>
References: <cover.1508135937.git.sean.wang@mediatek.com>
Message-ID: <740aad1d877a32f162c3b18b45c019f32141ff0f.1508135937.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

pwrap initialization is highly associated with the base SoC and the
target PMICs, so slight refactorization is made here for allowing
pwrap_init to run on those PMICs with different capability from the
previous MediaTek PMICs and the determination for the enablement of the
pwrap capability depending on PMIC type. Apart from this, the patch
makes the driver more extensible especially when more PMICs join into
the pwrap driver.

Signed-off-by: Chenglin Xu <chenglin.xu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 130 ++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 40 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 2e435be..f764908 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -70,6 +70,12 @@
 					  PWRAP_WDT_SRC_EN_HARB_STAUPD_DLE | \
 					  PWRAP_WDT_SRC_EN_HARB_STAUPD_ALE)
 
+/* Group of bits used for shown slave capability */
+#define PWRAP_SLV_CAP_SPI	BIT(0)
+#define PWRAP_SLV_CAP_DUALIO	BIT(1)
+#define PWRAP_SLV_CAP_SECURITY	BIT(2)
+#define HAS_CAP(_c, _x)	(((_c) & (_x)) == (_x))
+
 /* defines for slave device wrapper registers */
 enum dew_regs {
 	PWRAP_DEW_BASE,
@@ -501,6 +507,8 @@ struct pmic_wrapper;
 struct pwrap_slv_type {
 	const u32 *dew_regs;
 	enum pmic_type type;
+	/* Flags indicating the capability for the target slave */
+	u32 caps;
 	/* pwrap operations are highly associated with the PMIC types,
 	 * so the pointers added increases flexibility allowing determination
 	 * which type is used by the detection through device tree.
@@ -785,6 +793,37 @@ static int pwrap_init_sidly(struct pmic_wrapper *wrp)
 	return 0;
 }
 
+static int pwrap_init_dual_io(struct pmic_wrapper *wrp)
+{
+	int ret;
+	u32 rdata;
+
+	/* Enable dual IO mode */
+	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_DIO_EN], 1);
+
+	/* Check IDLE & INIT_DONE in advance */
+	ret = pwrap_wait_for_state(wrp,
+				   pwrap_is_fsm_idle_and_sync_idle);
+	if (ret) {
+		dev_err(wrp->dev, "%s fail, ret=%d\n", __func__, ret);
+		return ret;
+	}
+
+	pwrap_writel(wrp, 1, PWRAP_DIO_EN);
+
+	/* Read Test */
+	pwrap_read(wrp,
+		   wrp->slave->dew_regs[PWRAP_DEW_READ_TEST], &rdata);
+	if (rdata != PWRAP_DEW_READ_TEST_VAL) {
+		dev_err(wrp->dev,
+			"Read failed on DIO mode: 0x%04x!=0x%04x\n",
+			PWRAP_DEW_READ_TEST_VAL, rdata);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int pwrap_mt8135_init_reg_clock(struct pmic_wrapper *wrp)
 {
 	pwrap_writel(wrp, 0x4, PWRAP_CSHEXT);
@@ -932,6 +971,30 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	return 0;
 }
 
+static int pwrap_init_security(struct pmic_wrapper *wrp)
+{
+	int ret;
+
+	/* Enable encryption */
+	ret = pwrap_init_cipher(wrp);
+	if (ret)
+		return ret;
+
+	/* Signature checking - using CRC */
+	if (pwrap_write(wrp,
+			wrp->slave->dew_regs[PWRAP_DEW_CRC_EN], 0x1))
+		return -EFAULT;
+
+	pwrap_writel(wrp, 0x1, PWRAP_CRC_EN);
+	pwrap_writel(wrp, 0x0, PWRAP_SIG_MODE);
+	pwrap_writel(wrp, wrp->slave->dew_regs[PWRAP_DEW_CRC_VAL],
+		     PWRAP_SIG_ADR);
+	pwrap_writel(wrp,
+		     wrp->master->arb_en_all, PWRAP_HIPRIO_ARB_EN);
+
+	return 0;
+}
+
 static int pwrap_mt8135_init_soc_specific(struct pmic_wrapper *wrp)
 {
 	/* enable pwrap events and pwrap bridge in AP side */
@@ -992,7 +1055,6 @@ static int pwrap_mt2701_init_soc_specific(struct pmic_wrapper *wrp)
 static int pwrap_init(struct pmic_wrapper *wrp)
 {
 	int ret;
-	u32 rdata;
 
 	reset_control_reset(wrp->rstc);
 	if (wrp->rstc_bridge)
@@ -1004,10 +1066,12 @@ static int pwrap_init(struct pmic_wrapper *wrp)
 		pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
 	}
 
-	/* Reset SPI slave */
-	ret = pwrap_reset_spislave(wrp);
-	if (ret)
-		return ret;
+	if (HAS_CAP(wrp->slave->caps, PWRAP_SLV_CAP_SPI)) {
+		/* Reset SPI slave */
+		ret = pwrap_reset_spislave(wrp);
+		if (ret)
+			return ret;
+	}
 
 	pwrap_writel(wrp, 1, PWRAP_WRAP_EN);
 
@@ -1019,45 +1083,26 @@ static int pwrap_init(struct pmic_wrapper *wrp)
 	if (ret)
 		return ret;
 
-	/* Setup serial input delay */
-	ret = pwrap_init_sidly(wrp);
-	if (ret)
-		return ret;
-
-	/* Enable dual IO mode */
-	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_DIO_EN], 1);
-
-	/* Check IDLE & INIT_DONE in advance */
-	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle_and_sync_idle);
-	if (ret) {
-		dev_err(wrp->dev, "%s fail, ret=%d\n", __func__, ret);
-		return ret;
+	if (HAS_CAP(wrp->slave->caps, PWRAP_SLV_CAP_SPI)) {
+		/* Setup serial input delay */
+		ret = pwrap_init_sidly(wrp);
+		if (ret)
+			return ret;
 	}
 
-	pwrap_writel(wrp, 1, PWRAP_DIO_EN);
-
-	/* Read Test */
-	pwrap_read(wrp, wrp->slave->dew_regs[PWRAP_DEW_READ_TEST], &rdata);
-	if (rdata != PWRAP_DEW_READ_TEST_VAL) {
-		dev_err(wrp->dev, "Read test failed after switch to DIO mode: 0x%04x != 0x%04x\n",
-				PWRAP_DEW_READ_TEST_VAL, rdata);
-		return -EFAULT;
+	if (HAS_CAP(wrp->slave->caps, PWRAP_SLV_CAP_DUALIO)) {
+		/* Enable dual I/O mode */
+		ret = pwrap_init_dual_io(wrp);
+		if (ret)
+			return ret;
 	}
 
-	/* Enable encryption */
-	ret = pwrap_init_cipher(wrp);
-	if (ret)
-		return ret;
-
-	/* Signature checking - using CRC */
-	if (pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CRC_EN], 0x1))
-		return -EFAULT;
-
-	pwrap_writel(wrp, 0x1, PWRAP_CRC_EN);
-	pwrap_writel(wrp, 0x0, PWRAP_SIG_MODE);
-	pwrap_writel(wrp, wrp->slave->dew_regs[PWRAP_DEW_CRC_VAL],
-		     PWRAP_SIG_ADR);
-	pwrap_writel(wrp, wrp->master->arb_en_all, PWRAP_HIPRIO_ARB_EN);
+	if (HAS_CAP(wrp->slave->caps, PWRAP_SLV_CAP_SECURITY)) {
+		/* Enable security on bus */
+		ret = pwrap_init_security(wrp);
+		if (ret)
+			return ret;
+	}
 
 	if (wrp->master->type == PWRAP_MT8135)
 		pwrap_writel(wrp, 0x7, PWRAP_RRARB_EN);
@@ -1113,6 +1158,8 @@ static const struct regmap_config pwrap_regmap_config = {
 static const struct pwrap_slv_type pmic_mt6323 = {
 	.dew_regs = mt6323_regs,
 	.type = PMIC_MT6323,
+	.caps = PWRAP_SLV_CAP_SPI | PWRAP_SLV_CAP_DUALIO |
+		PWRAP_SLV_CAP_SECURITY,
 	.pwrap_read = pwrap_read16,
 	.pwrap_write = pwrap_write16,
 };
@@ -1120,6 +1167,7 @@ static const struct pwrap_slv_type pmic_mt6323 = {
 static const struct pwrap_slv_type pmic_mt6380 = {
 	.dew_regs = NULL,
 	.type = PMIC_MT6380,
+	.caps = 0,
 	.pwrap_read = pwrap_read32,
 	.pwrap_write = pwrap_write32,
 };
@@ -1127,6 +1175,8 @@ static const struct pwrap_slv_type pmic_mt6380 = {
 static const struct pwrap_slv_type pmic_mt6397 = {
 	.dew_regs = mt6397_regs,
 	.type = PMIC_MT6397,
+	.caps = PWRAP_SLV_CAP_SPI | PWRAP_SLV_CAP_DUALIO |
+		PWRAP_SLV_CAP_SECURITY,
 	.pwrap_read = pwrap_read16,
 	.pwrap_write = pwrap_write16,
 };
-- 
2.7.4
