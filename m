From: jitao.shi@mediatek.com (Jitao Shi)
Date: Wed, 16 Nov 2016 11:20:54 +0800
Subject: [PATCH v5] drm/mediatek: fixed the calc method of data rate per lane
Message-ID: <1479266454-31892-1-git-send-email-jitao.shi@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tune dsi frame rate by pixel clock, dsi add some extra signal (i.e.
Tlpx, Ths-prepare, Ths-zero, Ths-trail,Ths-exit) when enter and exit LP
mode, those signals will cause h-time larger than normal and reduce FPS.
So need to multiply a coefficient to offset the extra signal's effect.
  coefficient = ((htotal*bpp/lane_number)+Tlpx+Ths_prep+Ths_zero+
		 Ths_trail+Ths_exit)/(htotal*bpp/lane_number)

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
Change since v4:
 - tune the calc comment more clear.
 - define the phy timings as constants.

Chnage since v3:
 - wrapp the commit msg.
 - fix alignment of some lines. 

Change since v2:
 - move phy timing back to dsi_phy_timconfig.

Change since v1:
 - phy_timing2 and phy_timing3 refer clock cycle time.
 - define values of LPX HS_PRPR HS_ZERO HS_TRAIL TA_GO TA_SURE TA_GET DA_HS_EXIT.
---
 drivers/gpu/drm/mediatek/mtk_dsi.c |   64 +++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 28b2044..eaa5a22 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -86,7 +86,7 @@
 
 #define DSI_PHY_TIMECON0	0x110
 #define LPX				(0xff << 0)
-#define HS_PRPR				(0xff << 8)
+#define HS_PREP				(0xff << 8)
 #define HS_ZERO				(0xff << 16)
 #define HS_TRAIL			(0xff << 24)
 
@@ -102,10 +102,16 @@
 #define CLK_TRAIL			(0xff << 24)
 
 #define DSI_PHY_TIMECON3	0x11c
-#define CLK_HS_PRPR			(0xff << 0)
+#define CLK_HS_PREP			(0xff << 0)
 #define CLK_HS_POST			(0xff << 8)
 #define CLK_HS_EXIT			(0xff << 16)
 
+#define T_LPX		5
+#define T_HS_PREP	6
+#define T_HS_TRAIL	8
+#define T_HS_EXIT	7
+#define T_HS_ZERO	10
+
 #define NS_TO_CYCLE(n, c)    ((n) / (c) + (((n) % (c)) ? 1 : 0))
 
 struct phy;
@@ -161,20 +167,18 @@ static void mtk_dsi_mask(struct mtk_dsi *dsi, u32 offset, u32 mask, u32 data)
 static void dsi_phy_timconfig(struct mtk_dsi *dsi)
 {
 	u32 timcon0, timcon1, timcon2, timcon3;
-	unsigned int ui, cycle_time;
-	unsigned int lpx;
+	u32 ui, cycle_time;
 
 	ui = 1000 / dsi->data_rate + 0x01;
 	cycle_time = 8000 / dsi->data_rate + 0x01;
-	lpx = 5;
 
-	timcon0 = (8 << 24) | (0xa << 16) | (0x6 << 8) | lpx;
-	timcon1 = (7 << 24) | (5 * lpx << 16) | ((3 * lpx) / 2) << 8 |
-		  (4 * lpx);
+	timcon0 = T_LPX | T_HS_PREP << 8 | T_HS_ZERO << 16 | T_HS_TRAIL << 24;
+	timcon1 = 4 * T_LPX | (3 * T_LPX / 2) << 8 | 5 * T_LPX << 16 |
+		  T_HS_EXIT << 24;
 	timcon2 = ((NS_TO_CYCLE(0x64, cycle_time) + 0xa) << 24) |
 		  (NS_TO_CYCLE(0x150, cycle_time) << 16);
-	timcon3 = (2 * lpx) << 16 | NS_TO_CYCLE(80 + 52 * ui, cycle_time) << 8 |
-		   NS_TO_CYCLE(0x40, cycle_time);
+	timcon3 = NS_TO_CYCLE(0x40, cycle_time) | (2 * T_LPX) << 16 |
+		  NS_TO_CYCLE(80 + 52 * ui, cycle_time) << 8;
 
 	writel(timcon0, dsi->regs + DSI_PHY_TIMECON0);
 	writel(timcon1, dsi->regs + DSI_PHY_TIMECON1);
@@ -202,19 +206,47 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 {
 	struct device *dev = dsi->dev;
 	int ret;
+	u64 pixel_clock, total_bits;
+	u32 htotal, htotal_bits, bit_per_pixel, overhead_cycles, overhead_bits;
 
 	if (++dsi->refcount != 1)
 		return 0;
 
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
 	/**
-	 * data_rate = (pixel_clock / 1000) * pixel_dipth * mipi_ratio;
-	 * pixel_clock unit is Khz, data_rata unit is MHz, so need divide 1000.
-	 * mipi_ratio is mipi clk coefficient for balance the pixel clk in mipi.
-	 * we set mipi_ratio is 1.05.
+	 * vm.pixelclock is in kHz, pixel_clock unit is Hz, so multiply by 1000
+	 * htotal_time = htotal * byte_per_pixel / num_lanes
+	 * overhead_time = lpx + hs_prepare + hs_zero + hs_trail + hs_exit
+	 * mipi_ratio = (htotal_time + overhead_time) / htotal_time
+	 * data_rate = pixel_clock * bit_per_pixel * mipi_ratio / num_lanes;
 	 */
-	dsi->data_rate = dsi->vm.pixelclock * 3 * 21 / (1 * 1000 * 10);
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
 
-	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate * 1000000);
+	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set data rate: %d\n", ret);
 		goto err_refcount;
-- 
1.7.9.5
