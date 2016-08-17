From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Wed, 17 Aug 2016 14:58:08 +0800
Subject: [PATCH v4 3/3] drm/mediatek: fix the wrong pixel clock when
 resolution is 4K
In-Reply-To: <1471417088-2993-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1471417088-2993-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1471417088-2993-4-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Junzhi Zhao <junzhi.zhao@mediatek.com>

Pixel clock should be 297MHz when resolution is 4K.

Signed-off-by: Junzhi Zhao <junzhi.zhao@mediatek.com>
Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 0186e50..90fb831 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -432,11 +432,16 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	unsigned long pll_rate;
 	unsigned int factor;
 
+	/* let pll_rate can fix the valid range of tvdpll (1G~2GHz) */
 	pix_rate = 1000UL * mode->clock;
-	if (mode->clock <= 74000)
+	if (mode->clock <= 27000)
+		factor = 16 * 3;
+	else if (mode->clock <= 84000)
 		factor = 8 * 3;
-	else
+	else if (mode->clock <= 167000)
 		factor = 4 * 3;
+	else
+		factor = 2 * 3;
 	pll_rate = pix_rate * factor;
 
 	dev_dbg(dpi->dev, "Want PLL %lu Hz, pixel clock %lu Hz\n",
-- 
1.7.9.5
