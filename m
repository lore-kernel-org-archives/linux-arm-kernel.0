From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 29 Sep 2016 11:02:15 +0800
Subject: [PATCH v5 3/3] drm/mediatek: modify the factor to make the pll_rate
 set in the 1G-2G range
In-Reply-To: <1475118135-56780-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1475118135-56780-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1475118135-56780-4-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Junzhi Zhao <junzhi.zhao@mediatek.com>

Currently, the code sets the "pll" to the desired multiple
of the pixel clock manully(4*3m 8*3,etc).  The valid range
of the pll is 1G-2G, however, when the pixel clock is bigger
than 167MHz,  the "pll" will be set to a invalid value( > 2G),
then the "pll" will be 2GHz, thus the pixel clock will be in
correct. Change the factor to make the "pll" be set in the
(1G, 2G) range.

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
