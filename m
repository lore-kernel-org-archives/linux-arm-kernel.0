From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 4 Aug 2016 10:38:31 +0800
Subject: [PATCH v3 3/3] drm/mediatek: fix the wrong pixel clock when
 resolution is 4K
In-Reply-To: <1470278311-22528-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1470278311-22528-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1470278311-22528-4-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Junzhi Zhao <junzhi.zhao@mediatek.com>

Pixel clock should be 297MHz when resolution is 4K.

Signed-off-by: Junzhi Zhao <junzhi.zhao@mediatek.com>
Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index d05ca79..a90af59 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -438,10 +438,14 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	}
 
 	pix_rate = 1000UL * mode->clock;
-	if (mode->clock <= 74000)
+	if (mode->clock <= 27000)
+		factor = 16 * 3;
+	else if (mode->clock <= 74250)
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
