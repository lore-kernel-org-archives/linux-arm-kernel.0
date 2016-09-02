From: yt.shen@mediatek.com (YT Shen)
Date: Fri, 2 Sep 2016 19:24:43 +0800
Subject: [PATCH v7 8/9] drm/mediatek: update DSI sub driver flow
In-Reply-To: <1472815484-43821-1-git-send-email-yt.shen@mediatek.com>
References: <1472815484-43821-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1472815484-43821-9-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch update enable/disable flow of DSI module and MIPI TX module

Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c     | 102 +++++++++++++++++++++++++++------
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c |  32 ++++++-----
 2 files changed, 101 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 1103ff4..f807621 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -95,6 +95,8 @@
 #define DSI_RACK		0x84
 #define RACK				BIT(0)
 
+#define DSI_MEM_CONTI		0x90
+
 #define DSI_PHY_LCCON		0x104
 #define LC_HS_TX_EN			BIT(0)
 #define LC_ULPM_EN			BIT(1)
@@ -127,6 +129,10 @@
 #define CLK_HS_POST			(0xff << 8)
 #define CLK_HS_EXIT			(0xff << 16)
 
+#define DSI_VM_CMD_CON		0x130
+#define VM_CMD_EN			BIT(0)
+#define TS_VFP_EN			BIT(5)
+
 #define DSI_CMDQ0		0x180
 #define CONFIG				(0xff << 0)
 #define SHORT_PACKET			0
@@ -251,7 +257,9 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	 * mipi_ratio is mipi clk coefficient for balance the pixel clk in mipi.
 	 * we set mipi_ratio is 1.05.
 	 */
-	dsi->data_rate = dsi->vm.pixelclock * 3 * 21 / (1 * 1000 * 10);
+	dsi->data_rate = dsi->vm.pixelclock * 12 * 21;
+	dsi->data_rate /= (dsi->lanes * 1000 * 10);
+	dev_info(dev, "set mipitx's data rate: %dMHz\n", dsi->data_rate);
 
 	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate * 1000000);
 	if (ret < 0) {
@@ -273,10 +281,6 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 		goto err_disable_engine_clk;
 	}
 
-	mtk_dsi_enable(dsi);
-	mtk_dsi_reset_engine(dsi);
-	mtk_dsi_phy_timconfig(dsi);
-
 	return 0;
 
 err_disable_engine_clk:
@@ -291,7 +295,7 @@ err_refcount:
 static void mtk_dsi_clk_ulp_mode_enter(struct mtk_dsi *dsi)
 {
 	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_HS_TX_EN, 0);
-	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_ULPM_EN, 0);
+	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_ULPM_EN, LC_ULPM_EN);
 }
 
 static void mtk_dsi_clk_ulp_mode_leave(struct mtk_dsi *dsi)
@@ -304,7 +308,7 @@ static void mtk_dsi_clk_ulp_mode_leave(struct mtk_dsi *dsi)
 static void mtk_dsi_lane0_ulp_mode_enter(struct mtk_dsi *dsi)
 {
 	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_HS_TX_EN, 0);
-	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_ULPM_EN, 0);
+	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_ULPM_EN, LD0_ULPM_EN);
 }
 
 static void mtk_dsi_lane0_ulp_mode_leave(struct mtk_dsi *dsi)
@@ -340,11 +344,21 @@ static void mtk_dsi_set_mode(struct mtk_dsi *dsi)
 		if ((dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) &&
 		    !(dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE))
 			vid_mode = BURST_MODE;
+		else
+			vid_mode = SYNC_EVENT_MODE;
 	}
 
 	writel(vid_mode, dsi->regs + DSI_MODE_CTRL);
 }
 
+static void mtk_dsi_set_vm_cmd(struct mtk_dsi *dsi)
+{
+	writel(0x3c, dsi->regs + DSI_MEM_CONTI);
+
+	mtk_dsi_mask(dsi, DSI_VM_CMD_CON, VM_CMD_EN, VM_CMD_EN);
+	mtk_dsi_mask(dsi, DSI_VM_CMD_CON, TS_VFP_EN, TS_VFP_EN);
+}
+
 static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
 {
 	struct videomode *vm = &dsi->vm;
@@ -401,6 +415,9 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
 		break;
 	}
 
+	tmp_reg |= (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) << 6;
+	tmp_reg |= (dsi->mode_flags & MIPI_DSI_MODE_EOT_PACKET) >> 3;
+
 	writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
 }
 
@@ -479,6 +496,16 @@ static void mtk_dsi_start(struct mtk_dsi *dsi)
 	writel(1, dsi->regs + DSI_START);
 }
 
+static void mtk_dsi_stop(struct mtk_dsi *dsi)
+{
+	writel(0, dsi->regs + DSI_START);
+}
+
+static void mtk_dsi_set_cmd_mode(struct mtk_dsi *dsi)
+{
+	writel(CMD_MODE, dsi->regs + DSI_MODE_CTRL);
+}
+
 static void mtk_dsi_set_interrupt_enable(struct mtk_dsi *dsi)
 {
 	u32 inten = DSI_INT_ALL_BITS;
@@ -521,6 +548,25 @@ static irqreturn_t mtk_dsi_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void mtk_dsi_switch_to_cmd_mode(struct mtk_dsi *dsi)
+{
+	s32 ret = 0;
+	unsigned long timeout = msecs_to_jiffies(500);
+
+	mtk_dsi_irq_data_clear(dsi, VM_DONE_INT_FLAG);
+	mtk_dsi_set_cmd_mode(dsi);
+
+	ret = wait_event_interruptible_timeout(_dsi_irq_wait_queue,
+					       dsi->irq_data & VM_DONE_INT_FLAG,
+					       timeout);
+	if (ret == 0) {
+		dev_info(dsi->dev, "dsi wait engine idle timeout\n");
+
+		mtk_dsi_enable(dsi);
+		mtk_dsi_reset_engine(dsi);
+	}
+}
+
 static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
 {
 	if (WARN_ON(dsi->refcount == 0))
@@ -529,6 +575,17 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
 	if (--dsi->refcount != 0)
 		return;
 
+	mtk_dsi_switch_to_cmd_mode(dsi);
+
+	if (dsi->panel) {
+		if (drm_panel_unprepare(dsi->panel)) {
+			DRM_ERROR("failed to unprepare the panel\n");
+			return;
+		}
+	}
+
+	mtk_dsi_reset_engine(dsi);
+
 	mtk_dsi_lane0_ulp_mode_enter(dsi);
 	mtk_dsi_clk_ulp_mode_enter(dsi);
 
@@ -547,29 +604,37 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
 	if (dsi->enabled)
 		return;
 
-	if (dsi->panel) {
-		if (drm_panel_prepare(dsi->panel)) {
-			DRM_ERROR("failed to setup the panel\n");
-			return;
-		}
-	}
-
 	ret = mtk_dsi_poweron(dsi);
 	if (ret < 0) {
 		DRM_ERROR("failed to power on dsi\n");
 		return;
 	}
 
+	usleep_range(20000, 21000);
+
 	mtk_dsi_rxtx_control(dsi);
+	mtk_dsi_phy_timconfig(dsi);
+	mtk_dsi_ps_control_vact(dsi);
+	mtk_dsi_set_vm_cmd(dsi);
+	mtk_dsi_config_vdo_timing(dsi);
+	mtk_dsi_set_interrupt_enable(dsi);
 
+	mtk_dsi_enable(dsi);
 	mtk_dsi_clk_ulp_mode_leave(dsi);
 	mtk_dsi_lane0_ulp_mode_leave(dsi);
 	mtk_dsi_clk_hs_mode(dsi, 0);
-	mtk_dsi_set_mode(dsi);
 
-	mtk_dsi_ps_control_vact(dsi);
-	mtk_dsi_config_vdo_timing(dsi);
-	mtk_dsi_set_interrupt_enable(dsi);
+	if (dsi->panel) {
+		if (drm_panel_prepare(dsi->panel)) {
+			DRM_ERROR("failed to prepare the panel\n");
+			return;
+		}
+
+		if (drm_panel_enable(dsi->panel)) {
+			DRM_ERROR("failed to enable the panel\n");
+			return;
+		}
+	}
 
 	mtk_dsi_set_mode(dsi);
 	mtk_dsi_clk_hs_mode(dsi, 1);
@@ -591,6 +656,7 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
 		}
 	}
 
+	mtk_dsi_stop(dsi);
 	mtk_dsi_poweroff(dsi);
 
 	dsi->enabled = false;
diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
index 108d31a..34e95c6 100644
--- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
+++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
@@ -177,7 +177,9 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
 
 	dev_dbg(mipi_tx->dev, "prepare: %u Hz\n", mipi_tx->data_rate);
 
-	if (mipi_tx->data_rate >= 500000000) {
+	if (mipi_tx->data_rate > 1250000000) {
+		return -EINVAL;
+	} else if (mipi_tx->data_rate >= 500000000) {
 		txdiv = 1;
 		txdiv0 = 0;
 		txdiv1 = 0;
@@ -201,6 +203,10 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
 		return -EINVAL;
 	}
 
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_TOP_CON,
+				RG_DSI_LNT_IMP_CAL_CODE | RG_DSI_LNT_HS_BIAS_EN,
+				(8 << 4) | RG_DSI_LNT_HS_BIAS_EN);
+
 	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_BG_CON,
 				RG_DSI_VOUT_MSK |
 				RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN,
@@ -210,24 +216,18 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
 
 	usleep_range(30, 100);
 
-	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_TOP_CON,
-				RG_DSI_LNT_IMP_CAL_CODE | RG_DSI_LNT_HS_BIAS_EN,
-				(8 << 4) | RG_DSI_LNT_HS_BIAS_EN);
-
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_CON,
-			     RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN);
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_CON,
+				RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN,
+				RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN);
 
 	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_PWR,
 				RG_DSI_MPPLL_SDM_PWR_ON |
 				RG_DSI_MPPLL_SDM_ISO_EN,
 				RG_DSI_MPPLL_SDM_PWR_ON);
 
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
-			       RG_DSI_MPPLL_PLL_EN);
-
 	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
-				RG_DSI_MPPLL_TXDIV0 | RG_DSI_MPPLL_TXDIV1 |
-				RG_DSI_MPPLL_PREDIV,
+				RG_DSI_MPPLL_PREDIV | RG_DSI_MPPLL_TXDIV0 |
+				RG_DSI_MPPLL_TXDIV1 | RG_DSI_MPPLL_POSDIV,
 				(txdiv0 << 3) | (txdiv1 << 5));
 
 	/*
@@ -242,10 +242,12 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
 		      26000000);
 	writel(pcw, mipi_tx->regs + MIPITX_DSI_PLL_CON2);
 
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
-			     RG_DSI_MPPLL_SDM_FRA_EN);
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
+				RG_DSI_MPPLL_SDM_FRA_EN,
+				RG_DSI_MPPLL_SDM_FRA_EN);
 
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_PLL_CON0, RG_DSI_MPPLL_PLL_EN);
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
+				RG_DSI_MPPLL_PLL_EN, RG_DSI_MPPLL_PLL_EN);
 
 	usleep_range(20, 100);
 
-- 
1.9.1
