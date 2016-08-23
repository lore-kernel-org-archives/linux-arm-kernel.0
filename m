From: kbeldan@baylibre.com (Karl Beldan)
Date: Tue, 23 Aug 2016 12:56:59 +0000
Subject: [PATCH 1/3] drm/tilcdc: Adjust the FB_CEILING address
In-Reply-To: <20160823125701.25700-1-kbeldan@baylibre.com>
References: <20160823125701.25700-1-kbeldan@baylibre.com>
Message-ID: <20160823125701.25700-2-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCDC seems to expect its framebuffer ceiling address pointer to be
an inclusive bound.  The IP rev2 seems to cope with that but rev1 (as
found on the LCDK) don't.
Also note that this is what the framebuffer code does in da8xx-fb.c.

Since, as the TRM puts it, "The 2 LSBs are hardwired to 00b", the
dma_addr_t can be decremented without cast.
I tested it with a v2 (AM335x, rev  0x4F201000) and an LCDK (v1).

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index 25d6b22..89d6916 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -80,7 +80,7 @@ static void set_scanout(struct drm_crtc *crtc, struct drm_framebuffer *fb)
 	end = start + (crtc->mode.vdisplay * fb->pitches[0]);
 
 	tilcdc_write(dev, LCDC_DMA_FB_BASE_ADDR_0_REG, start);
-	tilcdc_write(dev, LCDC_DMA_FB_CEILING_ADDR_0_REG, end);
+	tilcdc_write(dev, LCDC_DMA_FB_CEILING_ADDR_0_REG, end - 1);
 
 	if (tilcdc_crtc->curr_fb)
 		drm_flip_work_queue(&tilcdc_crtc->unref_work,
-- 
2.9.2
