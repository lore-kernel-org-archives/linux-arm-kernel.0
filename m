From: yt.shen@mediatek.com (YT Shen)
Date: Fri, 15 Jul 2016 18:07:53 +0800
Subject: [PATCH v4 7/8] drm/mediatek: add mipi panel support
In-Reply-To: <1468577274-6178-1-git-send-email-yt.shen@mediatek.com>
References: <1468577274-6178-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1468577274-6178-8-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: shaoming chen <shaoming.chen@mediatek.com>

add dsi and mipi tx driver for mipi panel support

Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c     |  169 ++++++++++++++++++++++----------
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c |   82 +++++++++++-----
 2 files changed, 173 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 1f99894..4eae63c 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -29,9 +29,6 @@
 
 #include "mtk_drm_ddp_comp.h"
 
-#define DSI_VIDEO_FIFO_DEPTH	(1920 / 4)
-#define DSI_HOST_FIFO_DEPTH	64
-
 #define DSI_START		0x00
 
 #define DSI_INTEN		0x08
@@ -55,7 +52,7 @@
 #define MIX_MODE			BIT(17)
 
 #define DSI_TXRX_CTRL		0x18
-#define VC_NUM				(2 << 0)
+#define VC_NUM				BIT(1)
 #define LANE_NUM			(0xf << 2)
 #define DIS_EOT				BIT(6)
 #define NULL_EN				BIT(7)
@@ -94,6 +91,8 @@
 #define DSI_RACK		0x84
 #define RACK			BIT(0)
 
+#define DSI_MEM_CONTI		0x90
+
 #define DSI_PHY_LCCON		0x104
 #define LC_HS_TX_EN			BIT(0)
 #define LC_ULPM_EN			BIT(1)
@@ -126,6 +125,10 @@
 #define CLK_HS_POST			(0xff << 8)
 #define CLK_HS_EXIT			(0xff << 16)
 
+#define DSI_VM_CMD_CON		0x130
+#define VM_CMD_EN		BIT(0)
+#define TS_VFP_EN		BIT(5)
+
 #define DSI_CMDQ0		0x180
 
 #define NS_TO_CYCLE(n, c)    ((n) / (c) + (((n) % (c)) ? 1 : 0))
@@ -239,11 +242,11 @@ static void mtk_dsi_mask(struct mtk_dsi *dsi, u32 offset, u32 mask, u32 data)
 	writel((temp & ~mask) | (data & mask), dsi->regs + offset);
 }
 
-static void dsi_phy_timconfig(struct mtk_dsi *dsi)
+static void mtk_dsi_phy_timconfig(struct mtk_dsi *dsi)
 {
 	u32 timcon0, timcon1, timcon2, timcon3;
-	unsigned int ui, cycle_time;
-	unsigned int lpx;
+	u32 ui, cycle_time;
+	u32 lpx;
 
 	ui = 1000 / dsi->data_rate + 0x01;
 	cycle_time = 8000 / dsi->data_rate + 0x01;
@@ -273,7 +276,7 @@ static void mtk_dsi_disable(struct mtk_dsi *dsi)
 	mtk_dsi_mask(dsi, DSI_CON_CTRL, DSI_EN, 0);
 }
 
-static void mtk_dsi_reset(struct mtk_dsi *dsi)
+static void mtk_dsi_reset_engine(struct mtk_dsi *dsi)
 {
 	mtk_dsi_mask(dsi, DSI_CON_CTRL, DSI_RESET, DSI_RESET);
 	mtk_dsi_mask(dsi, DSI_CON_CTRL, DSI_RESET, 0);
@@ -293,7 +296,9 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	 * mipi_ratio is mipi clk coefficient for balance the pixel clk in mipi.
 	 * we set mipi_ratio is 1.05.
 	 */
-	dsi->data_rate = dsi->vm.pixelclock * 3 * 21 / (1 * 1000 * 10);
+	dsi->data_rate = dsi->vm.pixelclock * 12 * 21;
+	dsi->data_rate /= (dsi->lanes * 1000 * 10);
+	dev_info(dev, "set mipitx's data rate: %dMHz\n", dsi->data_rate);
 
 	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate * 1000000);
 	if (ret < 0) {
@@ -315,10 +320,6 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 		goto err_disable_engine_clk;
 	}
 
-	mtk_dsi_enable(dsi);
-	mtk_dsi_reset(dsi);
-	dsi_phy_timconfig(dsi);
-
 	return 0;
 
 err_disable_engine_clk:
@@ -330,33 +331,33 @@ err_refcount:
 	return ret;
 }
 
-static void dsi_clk_ulp_mode_enter(struct mtk_dsi *dsi)
+static void mtk_dsi_clk_ulp_mode_enter(struct mtk_dsi *dsi)
 {
 	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_HS_TX_EN, 0);
-	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_ULPM_EN, 0);
+	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_ULPM_EN, LC_ULPM_EN);
 }
 
-static void dsi_clk_ulp_mode_leave(struct mtk_dsi *dsi)
+static void mtk_dsi_clk_ulp_mode_leave(struct mtk_dsi *dsi)
 {
 	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_ULPM_EN, 0);
 	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_WAKEUP_EN, LC_WAKEUP_EN);
 	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_WAKEUP_EN, 0);
 }
 
-static void dsi_lane0_ulp_mode_enter(struct mtk_dsi *dsi)
+static void mtk_dsi_lane0_ulp_mode_enter(struct mtk_dsi *dsi)
 {
 	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_HS_TX_EN, 0);
-	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_ULPM_EN, 0);
+	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_ULPM_EN, LD0_ULPM_EN);
 }
 
-static void dsi_lane0_ulp_mode_leave(struct mtk_dsi *dsi)
+static void mtk_dsi_lane0_ulp_mode_leave(struct mtk_dsi *dsi)
 {
 	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_ULPM_EN, 0);
 	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_WAKEUP_EN, LD0_WAKEUP_EN);
 	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_WAKEUP_EN, 0);
 }
 
-static bool dsi_clk_hs_state(struct mtk_dsi *dsi)
+static bool mtk_dsi_clk_hs_state(struct mtk_dsi *dsi)
 {
 	u32 tmp_reg1;
 
@@ -364,15 +365,15 @@ static bool dsi_clk_hs_state(struct mtk_dsi *dsi)
 	return ((tmp_reg1 & LC_HS_TX_EN) == 1) ? true : false;
 }
 
-static void dsi_clk_hs_mode(struct mtk_dsi *dsi, bool enter)
+static void mtk_dsi_clk_hs_mode(struct mtk_dsi *dsi, bool enter)
 {
-	if (enter && !dsi_clk_hs_state(dsi))
+	if (enter && !mtk_dsi_clk_hs_state(dsi))
 		mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_HS_TX_EN, LC_HS_TX_EN);
-	else if (!enter && dsi_clk_hs_state(dsi))
+	else if (!enter && mtk_dsi_clk_hs_state(dsi))
 		mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_HS_TX_EN, 0);
 }
 
-static void dsi_set_mode(struct mtk_dsi *dsi)
+static void mtk_dsi_set_mode(struct mtk_dsi *dsi)
 {
 	u32 vid_mode = CMD_MODE;
 
@@ -382,12 +383,22 @@ static void dsi_set_mode(struct mtk_dsi *dsi)
 		if ((dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) &&
 		    !(dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE))
 			vid_mode = BURST_MODE;
+		else
+			vid_mode = SYNC_EVENT_MODE;
 	}
 
 	writel(vid_mode, dsi->regs + DSI_MODE_CTRL);
 }
 
-static void dsi_ps_control_vact(struct mtk_dsi *dsi)
+static void mtk_dsi_set_vm_cmd(struct mtk_dsi *dsi)
+{
+	writel(0x3c, dsi->regs + DSI_MEM_CONTI);
+
+	mtk_dsi_mask(dsi, DSI_VM_CMD_CON, VM_CMD_EN, VM_CMD_EN);
+	mtk_dsi_mask(dsi, DSI_VM_CMD_CON, TS_VFP_EN, TS_VFP_EN);
+}
+
+static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
 {
 	struct videomode *vm = &dsi->vm;
 	u32 dsi_buf_bpp, ps_wc;
@@ -421,7 +432,7 @@ static void dsi_ps_control_vact(struct mtk_dsi *dsi)
 	writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);
 }
 
-static void dsi_rxtx_control(struct mtk_dsi *dsi)
+static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
 {
 	u32 tmp_reg;
 
@@ -443,12 +454,15 @@ static void dsi_rxtx_control(struct mtk_dsi *dsi)
 		break;
 	}
 
+	tmp_reg |= (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) << 6;
+	tmp_reg |= (dsi->mode_flags & MIPI_DSI_MODE_EOT_PACKET) >> 3;
+
 	writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
 }
 
-static void dsi_ps_control(struct mtk_dsi *dsi)
+static void mtk_dsi_ps_control(struct mtk_dsi *dsi)
 {
-	unsigned int dsi_tmp_buf_bpp;
+	u32 dsi_tmp_buf_bpp;
 	u32 tmp_reg;
 
 	switch (dsi->format) {
@@ -478,12 +492,12 @@ static void dsi_ps_control(struct mtk_dsi *dsi)
 	writel(tmp_reg, dsi->regs + DSI_PSCTRL);
 }
 
-static void dsi_config_vdo_timing(struct mtk_dsi *dsi)
+static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 {
-	unsigned int horizontal_sync_active_byte;
-	unsigned int horizontal_backporch_byte;
-	unsigned int horizontal_frontporch_byte;
-	unsigned int dsi_tmp_buf_bpp;
+	u32 horizontal_sync_active_byte;
+	u32 horizontal_backporch_byte;
+	u32 horizontal_frontporch_byte;
+	u32 dsi_tmp_buf_bpp;
 
 	struct videomode *vm = &dsi->vm;
 
@@ -512,7 +526,7 @@ static void dsi_config_vdo_timing(struct mtk_dsi *dsi)
 	writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
 	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
 
-	dsi_ps_control(dsi);
+	mtk_dsi_ps_control(dsi);
 }
 
 static void mtk_dsi_start(struct mtk_dsi *dsi)
@@ -521,6 +535,19 @@ static void mtk_dsi_start(struct mtk_dsi *dsi)
 	writel(1, dsi->regs + DSI_START);
 }
 
+static void mtk_dsi_stop(struct mtk_dsi *dsi)
+{
+	writel(0, dsi->regs + DSI_START);
+}
+
+static void mtk_dsi_set_cmd_mode(struct mtk_dsi *dsi)
+{
+	u32 tmp_reg1;
+
+	tmp_reg1 = CMD_MODE;
+	writel(tmp_reg1, dsi->regs + DSI_MODE_CTRL);
+}
+
 static void mtk_dsi_set_interrupt_enable(struct mtk_dsi *dsi)
 {
 	u32 inten = DSI_INT_ALL_BITS;
@@ -609,6 +636,21 @@ static s32 mtk_dsi_wait_for_irq_timeout(struct mtk_dsi *dsi, u32 irq_bit,
 	return -1;
 }
 
+static void mtk_dsi_switch_to_cmd_mode(struct mtk_dsi *dsi)
+{
+	s32 ret = 0;
+
+	mtk_dsi_set_cmd_mode(dsi);
+
+	ret = mtk_dsi_wait_for_irq_timeout(dsi, DSI_INT_VM_DONE_FLAG, 500);
+	if (ret != 0) {
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
@@ -617,8 +659,19 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
 	if (--dsi->refcount != 0)
 		return;
 
-	dsi_lane0_ulp_mode_enter(dsi);
-	dsi_clk_ulp_mode_enter(dsi);
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
+	mtk_dsi_lane0_ulp_mode_enter(dsi);
+	mtk_dsi_clk_ulp_mode_enter(dsi);
 
 	mtk_dsi_disable(dsi);
 
@@ -635,32 +688,40 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
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
 
-	dsi_rxtx_control(dsi);
+	usleep_range(20000, 21000);
 
-	dsi_clk_ulp_mode_leave(dsi);
-	dsi_lane0_ulp_mode_leave(dsi);
-	dsi_clk_hs_mode(dsi, 0);
-	dsi_set_mode(dsi);
-
-	dsi_ps_control_vact(dsi);
-	dsi_config_vdo_timing(dsi);
+	mtk_dsi_rxtx_control(dsi);
+	mtk_dsi_phy_timconfig(dsi);
+	mtk_dsi_ps_control_vact(dsi);
+	mtk_dsi_set_vm_cmd(dsi);
+	mtk_dsi_config_vdo_timing(dsi);
 	mtk_dsi_set_interrupt_enable(dsi);
 
-	dsi_set_mode(dsi);
-	dsi_clk_hs_mode(dsi, 1);
+	mtk_dsi_enable(dsi);
+	mtk_dsi_clk_ulp_mode_leave(dsi);
+	mtk_dsi_lane0_ulp_mode_leave(dsi);
+	mtk_dsi_clk_hs_mode(dsi, 0);
+
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
+
+	mtk_dsi_set_mode(dsi);
+	mtk_dsi_clk_hs_mode(dsi, 1);
 
 	mtk_dsi_start(dsi);
 
@@ -679,6 +740,7 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
 		}
 	}
 
+	mtk_dsi_stop(dsi);
 	mtk_dsi_poweroff(dsi);
 
 	dsi->enabled = false;
@@ -1351,6 +1413,7 @@ static int mtk_dsi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_dsi_of_match[] = {
+	{ .compatible = "mediatek,mt2701-dsi" },
 	{ .compatible = "mediatek,mt8173-dsi" },
 	{ },
 };
diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
index cf8f38d..3bffc40 100644
--- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
+++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
 
@@ -87,6 +88,9 @@
 
 #define MIPITX_DSI_PLL_CON2	0x58
 
+#define MIPITX_DSI_PLL_TOP	0x64
+#define RG_DSI_MPPLL_PRESERVE		(0xff << 8)
+
 #define MIPITX_DSI_PLL_PWR	0x68
 #define RG_DSI_MPPLL_SDM_PWR_ON		BIT(0)
 #define RG_DSI_MPPLL_SDM_ISO_EN		BIT(1)
@@ -123,10 +127,32 @@
 #define SW_LNT2_HSTX_PRE_OE		BIT(24)
 #define SW_LNT2_HSTX_OE			BIT(25)
 
+struct mtk_mipitx_data {
+	const u32 data;
+};
+
+static const struct mtk_mipitx_data mt2701_mipitx_data = {
+	.data = (3 << 8)
+};
+
+static const struct mtk_mipitx_data mt8173_mipitx_data = {
+	.data = (0 << 8)
+};
+
+static const struct of_device_id mtk_mipi_tx_match[] = {
+	{ .compatible = "mediatek,mt2701-mipi-tx",
+	  .data = &mt2701_mipitx_data },
+	{ .compatible = "mediatek,mt8173-mipi-tx",
+	  .data = &mt8173_mipitx_data },
+	{},
+};
+
 struct mtk_mipi_tx {
 	struct device *dev;
 	void __iomem *regs;
-	unsigned int data_rate;
+	u32 data_rate;
+	const struct mtk_mipitx_data *driver_data;
+
 	struct clk_hw pll_hw;
 	struct clk *pll;
 };
@@ -163,12 +189,14 @@ static void mtk_mipi_tx_update_bits(struct mtk_mipi_tx *mipi_tx, u32 offset,
 static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
 {
 	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
-	unsigned int txdiv, txdiv0, txdiv1;
+	u8 txdiv, txdiv0, txdiv1;
 	u64 pcw;
 
 	dev_dbg(mipi_tx->dev, "prepare: %u Hz\n", mipi_tx->data_rate);
 
-	if (mipi_tx->data_rate >= 500000000) {
+	if (mipi_tx->data_rate > 1250000000) {
+		return -EINVAL;
+	} else if (mipi_tx->data_rate >= 500000000) {
 		txdiv = 1;
 		txdiv0 = 0;
 		txdiv1 = 0;
@@ -192,6 +220,10 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
 		return -EINVAL;
 	}
 
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_TOP_CON,
+				RG_DSI_LNT_IMP_CAL_CODE | RG_DSI_LNT_HS_BIAS_EN,
+				(8 << 4) | RG_DSI_LNT_HS_BIAS_EN);
+
 	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_BG_CON,
 				RG_DSI_VOUT_MSK |
 				RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN,
@@ -201,24 +233,18 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
 
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
@@ -233,15 +259,21 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
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
 
 	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
-			       RG_DSI_MPPLL_SDM_SSC_EN);
+					RG_DSI_MPPLL_SDM_SSC_EN);
+
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
+				RG_DSI_MPPLL_PRESERVE,
+				mipi_tx->driver_data->data);
 
 	return 0;
 }
@@ -255,6 +287,10 @@ static void mtk_mipi_tx_pll_unprepare(struct clk_hw *hw)
 	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
 			       RG_DSI_MPPLL_PLL_EN);
 
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
+				RG_DSI_MPPLL_PRESERVE,
+				mipi_tx->driver_data->data);
+
 	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_PWR,
 				RG_DSI_MPPLL_SDM_ISO_EN |
 				RG_DSI_MPPLL_SDM_PWR_ON,
@@ -310,7 +346,7 @@ static const struct clk_ops mtk_mipi_tx_pll_ops = {
 static int mtk_mipi_tx_power_on_signal(struct phy *phy)
 {
 	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
-	unsigned int reg;
+	u32 reg;
 
 	for (reg = MIPITX_DSI_CLOCK_LANE;
 	     reg <= MIPITX_DSI_DATA_LANE3; reg += 4)
@@ -341,7 +377,7 @@ static int mtk_mipi_tx_power_on(struct phy *phy)
 static void mtk_mipi_tx_power_off_signal(struct phy *phy)
 {
 	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
-	unsigned int reg;
+	u32 reg;
 
 	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_TOP_CON,
 			     RG_DSI_PAD_TIE_LOW_EN);
@@ -391,6 +427,7 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
 	if (!mipi_tx)
 		return -ENOMEM;
 
+	mipi_tx->driver_data = of_device_get_match_data(dev);
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mipi_tx->regs = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(mipi_tx->regs)) {
@@ -448,11 +485,6 @@ static int mtk_mipi_tx_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mtk_mipi_tx_match[] = {
-	{ .compatible = "mediatek,mt8173-mipi-tx", },
-	{},
-};
-
 struct platform_driver mtk_mipi_tx_driver = {
 	.probe = mtk_mipi_tx_probe,
 	.remove = mtk_mipi_tx_remove,
-- 
1.7.9.5
