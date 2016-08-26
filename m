From: jitao.shi@mediatek.com (Jitao Shi)
Date: Fri, 26 Aug 2016 14:10:31 +0800
Subject: drm/mediatek: fixed the calc method of data rate per lane
Message-ID: <1472191831-7150-1-git-send-email-jitao.shi@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tune dsi frame rate by pixel clock, dsi add some extra signal (i.e. Tlpx,
Ths-prepare, Ths-zero, Ths-trail,Ths-exit) when enter and exit LP mode, this
signal will cause h-time larger than normal and reduce FPS.
Need to multiply a coefficient to offset the extra signal's effect.
coefficient = ((htotal*bpp/lane_number)+Tlpx+Ths_prep+Ths_zero+Ths_trail+
                Ths_exit)/(htotal*bpp/lane_number))

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c |  111 ++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 28b2044..506aa22 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -85,28 +85,26 @@
 #define LD0_WAKEUP_EN			BIT(2)
 
 #define DSI_PHY_TIMECON0	0x110
-#define LPX				(0xff << 0)
-#define HS_PRPR				(0xff << 8)
-#define HS_ZERO				(0xff << 16)
-#define HS_TRAIL			(0xff << 24)
+#define LPX(x)				((x) << 0)
+#define HS_PRPR(x)			((x) << 8)
+#define HS_ZERO(x)			((x) << 16)
+#define HS_TRAIL(x)			((x) << 24)
 
 #define DSI_PHY_TIMECON1	0x114
-#define TA_GO				(0xff << 0)
-#define TA_SURE				(0xff << 8)
-#define TA_GET				(0xff << 16)
-#define DA_HS_EXIT			(0xff << 24)
+#define TA_GO(x)			((x) << 0)
+#define TA_SURE(x)			((x) << 8)
+#define TA_GET(x)			((x) << 16)
+#define DA_HS_EXIT(x)			((x) << 24)
 
 #define DSI_PHY_TIMECON2	0x118
-#define CONT_DET			(0xff << 0)
-#define CLK_ZERO			(0xff << 16)
-#define CLK_TRAIL			(0xff << 24)
+#define CONT_DET(x)			((x) << 0)
+#define CLK_ZERO(x)			((x) << 16)
+#define CLK_TRAIL(x)			((x) << 24)
 
 #define DSI_PHY_TIMECON3	0x11c
-#define CLK_HS_PRPR			(0xff << 0)
-#define CLK_HS_POST			(0xff << 8)
-#define CLK_HS_EXIT			(0xff << 16)
-
-#define NS_TO_CYCLE(n, c)    ((n) / (c) + (((n) % (c)) ? 1 : 0))
+#define CLK_HS_PRPR(x)			((x) << 0)
+#define CLK_HS_POST(x)			((x) << 8)
+#define CLK_HS_EXIT(x)			((x) << 16)
 
 struct phy;
 
@@ -158,28 +156,14 @@ static void mtk_dsi_mask(struct mtk_dsi *dsi, u32 offset, u32 mask, u32 data)
 	writel((temp & ~mask) | (data & mask), dsi->regs + offset);
 }
 
-static void dsi_phy_timconfig(struct mtk_dsi *dsi)
+static void dsi_phy_timconfig(struct mtk_dsi *dsi, u32 phy_timing0,
+			      u32 phy_timing1, u32 phy_timing2,
+			      u32 phy_timing3)
 {
-	u32 timcon0, timcon1, timcon2, timcon3;
-	unsigned int ui, cycle_time;
-	unsigned int lpx;
-
-	ui = 1000 / dsi->data_rate + 0x01;
-	cycle_time = 8000 / dsi->data_rate + 0x01;
-	lpx = 5;
-
-	timcon0 = (8 << 24) | (0xa << 16) | (0x6 << 8) | lpx;
-	timcon1 = (7 << 24) | (5 * lpx << 16) | ((3 * lpx) / 2) << 8 |
-		  (4 * lpx);
-	timcon2 = ((NS_TO_CYCLE(0x64, cycle_time) + 0xa) << 24) |
-		  (NS_TO_CYCLE(0x150, cycle_time) << 16);
-	timcon3 = (2 * lpx) << 16 | NS_TO_CYCLE(80 + 52 * ui, cycle_time) << 8 |
-		   NS_TO_CYCLE(0x40, cycle_time);
-
-	writel(timcon0, dsi->regs + DSI_PHY_TIMECON0);
-	writel(timcon1, dsi->regs + DSI_PHY_TIMECON1);
-	writel(timcon2, dsi->regs + DSI_PHY_TIMECON2);
-	writel(timcon3, dsi->regs + DSI_PHY_TIMECON3);
+	writel(phy_timing0, dsi->regs + DSI_PHY_TIMECON0);
+	writel(phy_timing1, dsi->regs + DSI_PHY_TIMECON1);
+	writel(phy_timing2, dsi->regs + DSI_PHY_TIMECON2);
+	writel(phy_timing3, dsi->regs + DSI_PHY_TIMECON3);
 }
 
 static void mtk_dsi_enable(struct mtk_dsi *dsi)
@@ -202,19 +186,57 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 {
 	struct device *dev = dsi->dev;
 	int ret;
+	u64 bit_clock, total_bits;
+	u32 htotal, htotal_bits, bit_per_pixel, overhead_cycles, overhead_bits;
+	u32 phy_timing0, phy_timing1, phy_timing2, phy_timing3;
 
 	if (++dsi->refcount != 1)
 		return 0;
 
+	phy_timing0 = LPX(5) | HS_PRPR(6) | HS_ZERO(10) | HS_TRAIL(8);
+	phy_timing1 = TA_GO(20) | TA_SURE(7) | TA_GET(25) | DA_HS_EXIT(7);
+	phy_timing2 = CLK_ZERO(38) | CLK_TRAIL(22);
+	phy_timing3 = CLK_HS_PRPR(8) | CLK_HS_POST(21) | CLK_HS_EXIT(10);
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
 	/**
-	 * data_rate = (pixel_clock / 1000) * pixel_dipth * mipi_ratio;
-	 * pixel_clock unit is Khz, data_rata unit is MHz, so need divide 1000.
-	 * mipi_ratio is mipi clk coefficient for balance the pixel clk in mipi.
-	 * we set mipi_ratio is 1.05.
+	 * data_rate = (pixel_clock) * bit_per_pixel * mipi_ratio / lane_num;
+	 * vm.pixelclock is Khz, data_rata unit is Hz, so need to multiply 1000
+	 * mipi_ratio is (htotal * byte_per_pixel / lane_num + Tlpx + Ths_prep
+	 *		  + Thstrail + Ths_exit + Ths_zero) /
+	 *		 (htotal * byte_per_pixel /lane_number)
 	 */
-	dsi->data_rate = dsi->vm.pixelclock * 3 * 21 / (1 * 1000 * 10);
+	bit_clock = dsi->vm.pixelclock * 1000 * bit_per_pixel;
+	htotal = dsi->vm.hactive + dsi->vm.hback_porch + dsi->vm.hfront_porch +
+		 dsi->vm.hsync_len;
+	htotal_bits = htotal * bit_per_pixel;
+
+	/**
+	 * overhead = lpx + hs_prepare + hs_zero + hs_trail + hs_exit
+	 */
+	overhead_cycles = (phy_timing0 & 0xff) + (phy_timing0 >> 8 & 0xff) +
+			  (phy_timing0 >> 16 & 0xff) +
+			  (phy_timing0 >> 24 & 0xff) +
+			  (phy_timing1 >> 24 & 0xff);
+	overhead_bits = overhead_cycles * dsi->lanes * 8;
+	total_bits = htotal_bits + overhead_bits;
+
+	dsi->data_rate = DIV_ROUND_UP_ULL(bit_clock * total_bits,
+					  htotal_bits * dsi->lanes);
 
-	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate * 1000000);
+	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set data rate: %d\n", ret);
 		goto err_refcount;
@@ -236,7 +258,8 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 
 	mtk_dsi_enable(dsi);
 	mtk_dsi_reset(dsi);
-	dsi_phy_timconfig(dsi);
+	dsi_phy_timconfig(dsi, phy_timing0, phy_timing1, phy_timing2,
+			  phy_timing3);
 
 	return 0;
 
-- 
1.7.9.5
