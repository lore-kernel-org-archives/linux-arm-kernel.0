From: kbeldan@baylibre.com (Karl Beldan)
Date: Tue, 23 Aug 2016 12:57:00 +0000
Subject: [PATCH 2/3] drm/tilcdc: Enable EOF interrupts for v1 LCDC
In-Reply-To: <20160823125701.25700-1-kbeldan@baylibre.com>
References: <20160823125701.25700-1-kbeldan@baylibre.com>
Message-ID: <20160823125701.25700-3-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This got accidentally dropped in the fixed commit and is required for
the driver to properly work on the rev1 IP, such as found on the LCDK.

Fixes: 2b2080d7e9ae ("drm/tilcdc: Get rid of complex ping-pong mechanism")
Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index 89d6916..163f111 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -98,6 +98,8 @@ static void tilcdc_crtc_enable_irqs(struct drm_device *dev)
 	if (priv->rev == 1) {
 		tilcdc_set(dev, LCDC_RASTER_CTRL_REG,
 			LCDC_V1_UNDERFLOW_INT_ENA);
+		tilcdc_set(dev, LCDC_DMA_CTRL_REG,
+			LCDC_V1_END_OF_FRAME_INT_ENA);
 	} else {
 		tilcdc_write(dev, LCDC_INT_ENABLE_SET_REG,
 			LCDC_V2_UNDERFLOW_INT_ENA |
-- 
2.9.2
