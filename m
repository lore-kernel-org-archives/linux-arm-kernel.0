From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Wed, 13 Jul 2016 11:29:33 +0530
Subject: [PATCH v2 09/15] net: thunderx: Add QSGMII interface type support
In-Reply-To: <1468389579-482-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1468389579-482-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <1468389579-482-10-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

This patch adds support for QSGMII interface type to
the BGX driver. This type of interface is supported by
81xx SOC.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 55 ++++++++++++++++++-----
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h |  1 +
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 9c3c273..3274430 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -379,8 +379,9 @@ void bgx_lmac_internal_loopback(int node, int bgx_idx,
 }
 EXPORT_SYMBOL(bgx_lmac_internal_loopback);
 
-static int bgx_lmac_sgmii_init(struct bgx *bgx, int lmacid)
+static int bgx_lmac_sgmii_init(struct bgx *bgx, struct lmac *lmac)
 {
+	int lmacid = lmac->lmacid;
 	u64 cfg;
 
 	bgx_reg_modify(bgx, lmacid, BGX_GMP_GMI_TXX_THRESH, 0x30);
@@ -409,6 +410,14 @@ static int bgx_lmac_sgmii_init(struct bgx *bgx, int lmacid)
 	cfg |= (PCS_MRX_CTL_RST_AN | PCS_MRX_CTL_AN_EN);
 	bgx_reg_write(bgx, lmacid, BGX_GMP_PCS_MRX_CTL, cfg);
 
+	if (lmac->lmac_type == BGX_MODE_QSGMII) {
+		/* Disable disparity check for QSGMII */
+		cfg = bgx_reg_read(bgx, lmacid, BGX_GMP_PCS_MISCX_CTL);
+		cfg &= ~PCS_MISC_CTL_DISP_EN;
+		bgx_reg_write(bgx, lmacid, BGX_GMP_PCS_MISCX_CTL, cfg);
+		return 0;
+	}
+
 	if (bgx_poll_reg(bgx, lmacid, BGX_GMP_PCS_MRX_STATUS,
 			 PCS_MRX_STATUS_AN_CPT, false)) {
 		dev_err(&bgx->pdev->dev, "BGX AN_CPT not completed\n");
@@ -658,9 +667,10 @@ static int bgx_lmac_enable(struct bgx *bgx, u8 lmacid)
 	lmac = &bgx->lmac[lmacid];
 	lmac->bgx = bgx;
 
-	if (lmac->lmac_type == BGX_MODE_SGMII) {
+	if ((lmac->lmac_type == BGX_MODE_SGMII) ||
+	    (lmac->lmac_type == BGX_MODE_QSGMII)) {
 		lmac->is_sgmii = 1;
-		if (bgx_lmac_sgmii_init(bgx, lmacid))
+		if (bgx_lmac_sgmii_init(bgx, lmac))
 			return -1;
 	} else {
 		lmac->is_sgmii = 0;
@@ -799,6 +809,11 @@ static void bgx_init_hw(struct bgx *bgx)
 		bgx_reg_write(bgx, 0, BGX_CMR_RX_STREERING + (i * 8), 0x00);
 }
 
+static u8 bgx_get_lane2sds_cfg(struct bgx *bgx, struct lmac *lmac)
+{
+	return (u8)(bgx_reg_read(bgx, lmac->lmacid, BGX_CMRX_CFG) & 0xFF);
+}
+
 static void bgx_print_qlm_mode(struct bgx *bgx, u8 lmacid)
 {
 	struct device *dev = &bgx->pdev->dev;
@@ -838,12 +853,22 @@ static void bgx_print_qlm_mode(struct bgx *bgx, u8 lmacid)
 		else
 			dev_info(dev, "%s: 40G_KR4\n", (char *)str);
 		break;
-	default:
-		dev_info(dev, "%s: INVALID\n", (char *)str);
+	case BGX_MODE_QSGMII:
+		if ((lmacid == 0) &&
+		    (bgx_get_lane2sds_cfg(bgx, lmac) != lmacid))
+			return;
+		if ((lmacid == 2) &&
+		    (bgx_get_lane2sds_cfg(bgx, lmac) == lmacid))
+			return;
+		dev_info(dev, "%s: QSGMII\n", (char *)str);
+		break;
+	case BGX_MODE_INVALID:
+		/* Nothing to do */
+		break;
 	}
 }
 
-static void lmac_set_lane2sds(struct lmac *lmac)
+static void lmac_set_lane2sds(struct bgx *bgx, struct lmac *lmac)
 {
 	switch (lmac->lmac_type) {
 	case BGX_MODE_SGMII:
@@ -857,6 +882,14 @@ static void lmac_set_lane2sds(struct lmac *lmac)
 	case BGX_MODE_RXAUI:
 		lmac->lane_to_sds = (lmac->lmacid) ? 0xE : 0x4;
 		break;
+	case BGX_MODE_QSGMII:
+		/* There is no way to determine if DLM0/2 is QSGMII or
+		 * DLM1/3 is configured to QSGMII as bootloader will
+		 * configure all LMACs, so take whatever is configured
+		 * by low level firmware.
+		 */
+		lmac->lane_to_sds = bgx_get_lane2sds_cfg(bgx, lmac);
+		break;
 	default:
 		lmac->lane_to_sds = 0;
 		break;
@@ -882,7 +915,7 @@ static void bgx_set_lmac_config(struct bgx *bgx, u8 idx)
 		lmac->use_training =
 			bgx_reg_read(bgx, 0, BGX_SPUX_BR_PMD_CRTL) &
 				SPU_PMD_CRTL_TRAIN_EN;
-		lmac_set_lane2sds(lmac);
+		lmac_set_lane2sds(bgx, lmac);
 		return;
 	}
 
@@ -901,7 +934,7 @@ static void bgx_set_lmac_config(struct bgx *bgx, u8 idx)
 		lmac->use_training =
 			bgx_reg_read(bgx, idx, BGX_SPUX_BR_PMD_CRTL) &
 				SPU_PMD_CRTL_TRAIN_EN;
-		lmac_set_lane2sds(lmac);
+		lmac_set_lane2sds(bgx, lmac);
 
 		/* Set LMAC type of other lmac on same DLM i.e LMAC 1/3 */
 		olmac = &bgx->lmac[idx + 1];
@@ -909,7 +942,7 @@ static void bgx_set_lmac_config(struct bgx *bgx, u8 idx)
 		olmac->use_training =
 		bgx_reg_read(bgx, idx + 1, BGX_SPUX_BR_PMD_CRTL) &
 			SPU_PMD_CRTL_TRAIN_EN;
-		lmac_set_lane2sds(olmac);
+		lmac_set_lane2sds(bgx, olmac);
 	}
 }
 
@@ -920,7 +953,7 @@ static bool is_dlm0_in_bgx_mode(struct bgx *bgx)
 	if (!bgx->is_81xx)
 		return true;
 
-	lmac = &bgx->lmac[1];
+	lmac = &bgx->lmac[0];
 	if (lmac->lmac_type == BGX_MODE_INVALID)
 		return false;
 
@@ -946,7 +979,7 @@ static void bgx_get_qlm_mode(struct bgx *bgx)
 	if (bgx->lmac_count > MAX_LMAC_PER_BGX)
 		bgx->lmac_count = MAX_LMAC_PER_BGX;
 
-	for (idx = 0; idx < bgx->lmac_count; idx++)
+	for (idx = 0; idx < MAX_LMAC_PER_BGX; idx++)
 		bgx_set_lmac_config(bgx, idx);
 
 	if (!bgx->is_81xx) {
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
index 38e9fb4..0705863 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
@@ -146,6 +146,7 @@
 #define BGX_GMP_PCS_ANX_AN_RESULTS	0x30020
 #define BGX_GMP_PCS_SGM_AN_ADV		0x30068
 #define BGX_GMP_PCS_MISCX_CTL		0x30078
+#define  PCS_MISC_CTL_DISP_EN			BIT_ULL(13)
 #define  PCS_MISC_CTL_GMX_ENO			BIT_ULL(11)
 #define  PCS_MISC_CTL_SAMP_PT_MASK	0x7Full
 #define BGX_GMP_GMI_PRTX_CFG		0x38020
-- 
2.7.4
