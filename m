From: jsarha@ti.com (Jyri Sarha)
Date: Mon, 29 Aug 2016 10:41:26 +0300
Subject: [PATCH RFC] drm/tilcdc: Write DMA base and ceiling address with
 single instruction
Message-ID: <1472456486-22919-1-git-send-email-jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Write DMA base and ceiling address with a single instruction, if
available. This should make it more unlikely that LCDC would fetch the
DMA addresses in the middle of an update. Having bad combination of
addresses in dma base and ceiling (e.g base > ceiling) can cause
unpredictaple behavior in LCDC.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
I am not sure what would be the least ugly way of utilizing ARM7 strd
instruction. Using inline assebler would be the most straight forward
way, but this looks less ugly to me.

 drivers/gpu/drm/tilcdc/tilcdc_crtc.c |  9 +++++++--
 drivers/gpu/drm/tilcdc/tilcdc_regs.h | 13 +++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index 6350f2a..41ec5b3 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -70,6 +70,7 @@ static void set_scanout(struct drm_crtc *crtc, struct drm_framebuffer *fb)
 	struct drm_gem_cma_object *gem;
 	unsigned int depth, bpp;
 	dma_addr_t start, end;
+	u64 dma_base_and_ceiling;
 
 	drm_fb_get_bpp_depth(fb->pixel_format, &depth, &bpp);
 	gem = drm_fb_cma_get_gem_obj(fb, 0);
@@ -80,8 +81,12 @@ static void set_scanout(struct drm_crtc *crtc, struct drm_framebuffer *fb)
 
 	end = start + (crtc->mode.vdisplay * fb->pitches[0]);
 
-	tilcdc_write(dev, LCDC_DMA_FB_BASE_ADDR_0_REG, start);
-	tilcdc_write(dev, LCDC_DMA_FB_CEILING_ADDR_0_REG, end - 1);
+	/* Write DMA base and ceiling address with a single insruction,
+	 * if available. This should make it more unlikely that LCDC would
+	 * fetch the DMA addresses in the middle of an update.
+	 */
+	dma_base_and_ceiling = (u64)(end - 1) << 32 | start;
+	tilcdc_write64(dev, LCDC_DMA_FB_BASE_ADDR_0_REG, dma_base_and_ceiling);
 
 	if (tilcdc_crtc->curr_fb)
 		drm_flip_work_queue(&tilcdc_crtc->unref_work,
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_regs.h b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
index 1bf5e25..ea934c9 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
@@ -119,6 +119,19 @@ static inline void tilcdc_write(struct drm_device *dev, u32 reg, u32 data)
 	iowrite32(data, priv->mmio + reg);
 }
 
+static inline void tilcdc_write64(struct drm_device *dev, u32 reg, u64 data)
+{
+	struct tilcdc_drm_private *priv = dev->dev_private;
+	volatile void __iomem *addr = priv->mmio + reg;
+
+#ifdef iowrite64
+	iowrite64(data, addr);
+#else
+	/* This compiles to strd (=64-bit write) on ARM7 */
+	*(volatile u64 __force *)addr = data;
+#endif
+}
+
 static inline u32 tilcdc_read(struct drm_device *dev, u32 reg)
 {
 	struct tilcdc_drm_private *priv = dev->dev_private;
-- 
1.9.1
