From: yt.shen@mediatek.com (YT Shen)
Date: Mon, 23 Jan 2017 19:05:24 +0800
Subject: [PATCH v12 11/12] drm/mediatek: update DSI sub driver flow for
 sending commands to panel
In-Reply-To: <1485169525-22163-1-git-send-email-yt.shen@mediatek.com>
References: <1485169525-22163-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1485169525-22163-12-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch update enable/disable flow of DSI module.
Original flow works on there is a bridge chip: DSI -> bridge -> panel.
In this case: DSI -> panel, the DSI sub driver flow should be updated.
We need to initialize DSI first so that we can send commands to panel.

Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 266 ++++++++++++++++++++++---------------
 1 file changed, 161 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 85f22d2..aa3541e 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -126,6 +126,10 @@
 #define CLK_HS_POST			(0xff << 8)
 #define CLK_HS_EXIT			(0xff << 16)
 
+#define DSI_VM_CMD_CON		0x130
+#define VM_CMD_EN			BIT(0)
+#define TS_VFP_EN			BIT(5)
+
 #define DSI_CMDQ0		0x180
 #define CONFIG				(0xff << 0)
 #define SHORT_PACKET			0
@@ -239,85 +243,6 @@ static void mtk_dsi_reset_engine(struct mtk_dsi *dsi)
 	mtk_dsi_mask(dsi, DSI_CON_CTRL, DSI_RESET, 0);
 }
 
-static int mtk_dsi_poweron(struct mtk_dsi *dsi)
-{
-	struct device *dev = dsi->dev;
-	int ret;
-	u64 pixel_clock, total_bits;
-	u32 htotal, htotal_bits, bit_per_pixel, overhead_cycles, overhead_bits;
-
-	if (++dsi->refcount != 1)
-		return 0;
-
-	switch (dsi->format) {
-	case MIPI_DSI_FMT_RGB565:
-		bit_per_pixel = 16;
-		break;
-	case MIPI_DSI_FMT_RGB666_PACKED:
-		bit_per_pixel = 18;
-		break;
-	case MIPI_DSI_FMT_RGB666:
-	case MIPI_DSI_FMT_RGB888:
-	default:
-		bit_per_pixel = 24;
-		break;
-	}
-
-	/**
-	 * vm.pixelclock is in kHz, pixel_clock unit is Hz, so multiply by 1000
-	 * htotal_time = htotal * byte_per_pixel / num_lanes
-	 * overhead_time = lpx + hs_prepare + hs_zero + hs_trail + hs_exit
-	 * mipi_ratio = (htotal_time + overhead_time) / htotal_time
-	 * data_rate = pixel_clock * bit_per_pixel * mipi_ratio / num_lanes;
-	 */
-	pixel_clock = dsi->vm.pixelclock * 1000;
-	htotal = dsi->vm.hactive + dsi->vm.hback_porch + dsi->vm.hfront_porch +
-			dsi->vm.hsync_len;
-	htotal_bits = htotal * bit_per_pixel;
-
-	overhead_cycles = T_LPX + T_HS_PREP + T_HS_ZERO + T_HS_TRAIL +
-			T_HS_EXIT;
-	overhead_bits = overhead_cycles * dsi->lanes * 8;
-	total_bits = htotal_bits + overhead_bits;
-
-	dsi->data_rate = DIV_ROUND_UP_ULL(pixel_clock * total_bits,
-					  htotal * dsi->lanes);
-
-	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set data rate: %d\n", ret);
-		goto err_refcount;
-	}
-
-	phy_power_on(dsi->phy);
-
-	ret = clk_prepare_enable(dsi->engine_clk);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable engine clock: %d\n", ret);
-		goto err_phy_power_off;
-	}
-
-	ret = clk_prepare_enable(dsi->digital_clk);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable digital clock: %d\n", ret);
-		goto err_disable_engine_clk;
-	}
-
-	mtk_dsi_enable(dsi);
-	mtk_dsi_reset_engine(dsi);
-	mtk_dsi_phy_timconfig(dsi);
-
-	return 0;
-
-err_disable_engine_clk:
-	clk_disable_unprepare(dsi->engine_clk);
-err_phy_power_off:
-	phy_power_off(dsi->phy);
-err_refcount:
-	dsi->refcount--;
-	return ret;
-}
-
 static void mtk_dsi_clk_ulp_mode_enter(struct mtk_dsi *dsi)
 {
 	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_HS_TX_EN, 0);
@@ -365,16 +290,23 @@ static void mtk_dsi_set_mode(struct mtk_dsi *dsi)
 	u32 vid_mode = CMD_MODE;
 
 	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
-		vid_mode = SYNC_PULSE_MODE;
-
-		if ((dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) &&
-		    !(dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE))
+		if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
 			vid_mode = BURST_MODE;
+		else if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
+			vid_mode = SYNC_PULSE_MODE;
+		else
+			vid_mode = SYNC_EVENT_MODE;
 	}
 
 	writel(vid_mode, dsi->regs + DSI_MODE_CTRL);
 }
 
+static void mtk_dsi_set_vm_cmd(struct mtk_dsi *dsi)
+{
+	mtk_dsi_mask(dsi, DSI_VM_CMD_CON, VM_CMD_EN, VM_CMD_EN);
+	mtk_dsi_mask(dsi, DSI_VM_CMD_CON, TS_VFP_EN, TS_VFP_EN);
+}
+
 static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
 {
 	struct videomode *vm = &dsi->vm;
@@ -512,6 +444,16 @@ static void mtk_dsi_start(struct mtk_dsi *dsi)
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
 	u32 inten = LPRX_RD_RDY_INT_FLAG | CMD_DONE_INT_FLAG | VM_DONE_INT_FLAG;
@@ -570,6 +512,121 @@ static irqreturn_t mtk_dsi_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static s32 mtk_dsi_switch_to_cmd_mode(struct mtk_dsi *dsi, u8 irq_flag, u32 t)
+{
+	mtk_dsi_irq_data_clear(dsi, irq_flag);
+	mtk_dsi_set_cmd_mode(dsi);
+
+	if (!mtk_dsi_wait_for_irq_done(dsi, irq_flag, t)) {
+		DRM_ERROR("failed to switch cmd mode\n");
+		return -ETIME;
+	} else {
+		return 0;
+	}
+}
+
+static int mtk_dsi_poweron(struct mtk_dsi *dsi)
+{
+	struct device *dev = dsi->dev;
+	int ret;
+	u64 pixel_clock, total_bits;
+	u32 htotal, htotal_bits, bit_per_pixel, overhead_cycles, overhead_bits;
+
+	if (++dsi->refcount != 1)
+		return 0;
+
+	switch (dsi->format) {
+	case MIPI_DSI_FMT_RGB565:
+		bit_per_pixel = 16;
+		break;
+	case MIPI_DSI_FMT_RGB666_PACKED:
+		bit_per_pixel = 18;
+		break;
+	case MIPI_DSI_FMT_RGB666:
+	case MIPI_DSI_FMT_RGB888:
+	default:
+		bit_per_pixel = 24;
+		break;
+	}
+
+	/**
+	 * vm.pixelclock is in kHz, pixel_clock unit is Hz, so multiply by 1000
+	 * htotal_time = htotal * byte_per_pixel / num_lanes
+	 * overhead_time = lpx + hs_prepare + hs_zero + hs_trail + hs_exit
+	 * mipi_ratio = (htotal_time + overhead_time) / htotal_time
+	 * data_rate = pixel_clock * bit_per_pixel * mipi_ratio / num_lanes;
+	 */
+	pixel_clock = dsi->vm.pixelclock * 1000;
+	htotal = dsi->vm.hactive + dsi->vm.hback_porch + dsi->vm.hfront_porch +
+			dsi->vm.hsync_len;
+	htotal_bits = htotal * bit_per_pixel;
+
+	overhead_cycles = T_LPX + T_HS_PREP + T_HS_ZERO + T_HS_TRAIL +
+			T_HS_EXIT;
+	overhead_bits = overhead_cycles * dsi->lanes * 8;
+	total_bits = htotal_bits + overhead_bits;
+
+	dsi->data_rate = DIV_ROUND_UP_ULL(pixel_clock * total_bits,
+					  htotal * dsi->lanes);
+
+	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set data rate: %d\n", ret);
+		goto err_refcount;
+	}
+
+	phy_power_on(dsi->phy);
+
+	ret = clk_prepare_enable(dsi->engine_clk);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable engine clock: %d\n", ret);
+		goto err_phy_power_off;
+	}
+
+	ret = clk_prepare_enable(dsi->digital_clk);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable digital clock: %d\n", ret);
+		goto err_disable_engine_clk;
+	}
+
+	mtk_dsi_enable(dsi);
+	mtk_dsi_reset_engine(dsi);
+	mtk_dsi_phy_timconfig(dsi);
+
+	mtk_dsi_rxtx_control(dsi);
+	mtk_dsi_ps_control_vact(dsi);
+	mtk_dsi_set_vm_cmd(dsi);
+	mtk_dsi_config_vdo_timing(dsi);
+	mtk_dsi_set_interrupt_enable(dsi);
+
+	mtk_dsi_clk_ulp_mode_leave(dsi);
+	mtk_dsi_lane0_ulp_mode_leave(dsi);
+	mtk_dsi_clk_hs_mode(dsi, 0);
+
+	if (dsi->panel) {
+		if (drm_panel_prepare(dsi->panel)) {
+			DRM_ERROR("failed to prepare the panel\n");
+			goto err_disable_digital_clk;
+		}
+	}
+
+	mtk_dsi_set_mode(dsi);
+	mtk_dsi_clk_hs_mode(dsi, 1);
+
+	mtk_dsi_start(dsi);
+
+	return 0;
+err_disable_digital_clk:
+	clk_disable_unprepare(dsi->digital_clk);
+err_disable_engine_clk:
+	clk_disable_unprepare(dsi->engine_clk);
+err_phy_power_off:
+	phy_power_off(dsi->phy);
+err_refcount:
+	dsi->refcount--;
+	return ret;
+}
+
 static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
 {
 	if (WARN_ON(dsi->refcount == 0))
@@ -578,6 +635,17 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
 	if (--dsi->refcount != 0)
 		return;
 
+	mtk_dsi_stop(dsi);
+	if (!mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500)) {
+		if (dsi->panel) {
+			if (drm_panel_unprepare(dsi->panel)) {
+				DRM_ERROR("failed to unprepare the panel\n");
+				return;
+			}
+		}
+	}
+
+	mtk_dsi_reset_engine(dsi);
 	mtk_dsi_lane0_ulp_mode_enter(dsi);
 	mtk_dsi_clk_ulp_mode_enter(dsi);
 
@@ -596,36 +664,24 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
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
 
-	mtk_dsi_rxtx_control(dsi);
-
-	mtk_dsi_clk_ulp_mode_leave(dsi);
-	mtk_dsi_lane0_ulp_mode_leave(dsi);
-	mtk_dsi_clk_hs_mode(dsi, 0);
-	mtk_dsi_set_mode(dsi);
-
-	mtk_dsi_ps_control_vact(dsi);
-	mtk_dsi_config_vdo_timing(dsi);
-	mtk_dsi_set_interrupt_enable(dsi);
-
-	mtk_dsi_set_mode(dsi);
-	mtk_dsi_clk_hs_mode(dsi, 1);
-
-	mtk_dsi_start(dsi);
+	if (dsi->panel) {
+		if (drm_panel_enable(dsi->panel)) {
+			DRM_ERROR("failed to enable the panel\n");
+			goto err_dsi_power_off;
+		}
+	}
 
 	dsi->enabled = true;
+
+	return;
+err_dsi_power_off:
+	mtk_dsi_poweroff(dsi);
 }
 
 static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
-- 
1.9.1
