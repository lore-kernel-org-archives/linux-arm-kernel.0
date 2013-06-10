From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 10 Jun 2013 23:49:52 +0100
Subject: [PATCH RFC v3 2/4] DRM: Armada: Add support for hardware cursors
In-Reply-To: <20130609190612.GM18614@n2100.arm.linux.org.uk>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
Message-ID: <E1UmAuO-0006EQ-J4@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds hardware cursor support to the DRM driver for the
Marvell Armada SoCs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/Kconfig       |    7 +
 drivers/gpu/drm/armada/armada_crtc.c |  201 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/armada/armada_crtc.h |    8 ++
 3 files changed, 216 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/armada/Kconfig b/drivers/gpu/drm/armada/Kconfig
index c7a0a94..6f64642 100644
--- a/drivers/gpu/drm/armada/Kconfig
+++ b/drivers/gpu/drm/armada/Kconfig
@@ -13,3 +13,10 @@ config DRM_ARMADA
 	  This driver provides no built-in acceleration; acceleration is
 	  performed by other IP found on the SoC.  This driver provides
 	  kernel mode setting and buffer management to userspace.
+
+config DRM_ARMADA_CURSOR
+	bool "Enable hardware cursor support for Marvell Armada DRM"
+	depends on DRM_ARMADA != n
+	help
+	  Add support for hardware cursor support on the Marvell
+	  Armada devices.
diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index dadaf63..4a71ba0 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -626,11 +626,210 @@ static const struct drm_crtc_helper_funcs armada_crtc_helper_funcs = {
 	.disable	= armada_drm_crtc_disable,
 };
 
+#ifdef CONFIG_DRM_ARMADA_CURSOR
+static int armada_drm_crtc_cursor_update(struct armada_crtc *dcrtc, bool reload)
+{
+	uint32_t xoff, xscr, w = dcrtc->cursor_w, s;
+	uint32_t yoff, yscr, h = dcrtc->cursor_h;
+
+	/*
+	 * Calculate the visible width and height of the cursor,
+	 * screen position, and the position in the cursor bitmap.
+	 */
+	if (dcrtc->cursor_x < 0) {
+		xoff = -dcrtc->cursor_x;
+		xscr = 0;
+		w -= min(xoff, w);
+	} else if (dcrtc->cursor_x + w > dcrtc->crtc.mode.hdisplay) {
+		xoff = 0;
+		xscr = dcrtc->cursor_x;
+		w = max_t(int, dcrtc->crtc.mode.hdisplay - dcrtc->cursor_x, 0);
+	} else {
+		xoff = 0;
+		xscr = dcrtc->cursor_x;
+	}
+
+	if (dcrtc->cursor_y < 0) {
+		yoff = -dcrtc->cursor_y;
+		yscr = 0;
+		h -= min(yoff, h);
+	} else if (dcrtc->cursor_y + h > dcrtc->crtc.mode.vdisplay) {
+		yoff = 0;
+		yscr = dcrtc->cursor_y;
+		h = max_t(int, dcrtc->crtc.mode.vdisplay - dcrtc->cursor_y, 0);
+	} else {
+		yoff = 0;
+		yscr = dcrtc->cursor_y;
+	}
+
+	/* On interlaced modes, the vertical cursor size must be halved */
+	s = dcrtc->cursor_w;
+	if (dcrtc->interlaced) {
+		s *= 2;
+		yscr /= 2;
+		h /= 2;
+	}
+
+	if (!dcrtc->cursor_obj || !h || !w) {
+		spin_lock_irq(&dcrtc->irq_lock);
+		armada_updatel(0, CFG_HWC_ENA, dcrtc->base + LCD_SPU_DMA_CTRL0);
+		spin_unlock_irq(&dcrtc->irq_lock);
+		return 0;
+	}
+
+	armada_updatel(CFG_CSB_256x32, CFG_PDWN256x32,
+		     dcrtc->base + LCD_SPU_SRAM_PARA1);
+
+	if (dcrtc->cursor_lw != w || dcrtc->cursor_lh != h || reload) {
+		struct armada_gem_object *obj = dcrtc->cursor_obj;
+		uint32_t *pix, *p, col2 = 0, col3 = 0;
+		unsigned x, y, d, n, a;
+
+		dcrtc->cursor_lw = w;
+		dcrtc->cursor_lh = h;
+
+		pix = obj->addr;
+
+		/* Set the top-left corner of the cursor image */
+		pix += yoff * s + xoff;
+
+		a = 2 << 14 | 15 << 8;
+		for (d = n = y = 0; y < h; y++) {
+			for (x = 0, p = &pix[y * s]; x < w; x++, p++) {
+				uint32_t v = *p;
+				unsigned b;
+
+				if ((v & 0xff000000) != 0xff000000) {
+					b = 0;	/* transparent */
+				} else if (col2 == v) {
+					b = 2;	/* color 2 */
+				} else if (col3 == v) {
+					b = 3;	/* color 3 */
+				} else if (col2 == 0) {
+					col2 = v;
+					b = 2;	/* alloc color 2 */
+				} else if (col3 == 0) {
+					col3 = v;
+					b = 3;	/* alloc color 3 */
+				} else {
+					/* fail */
+					b = 1;	/* inverse (!) */
+				}
+
+				d |= b << n;
+				n += 2;
+
+				if (n == 32) {
+					writel_relaxed(d, dcrtc->base + LCD_SPU_SRAM_WRDAT);
+					writel_relaxed(a, dcrtc->base + LCD_SPU_SRAM_CTRL);
+					a++;
+					d = n = 0;
+				}
+			}
+		}
+
+		if (n) {
+			writel_relaxed(d, dcrtc->base + LCD_SPU_SRAM_WRDAT);
+			writel_relaxed(a, dcrtc->base + LCD_SPU_SRAM_CTRL);
+		}
+
+		writel_relaxed(col2, dcrtc->base + LCD_SPU_ALPHA_COLOR1);
+		writel_relaxed(col3, dcrtc->base + LCD_SPU_ALPHA_COLOR2);
+		writel_relaxed(h << 16 | w, dcrtc->base + LCD_SPU_HWC_HPXL_VLN);
+	}
+
+	writel_relaxed(yscr << 16 | xscr, dcrtc->base + LCD_SPU_HWC_OVSA_HPXL_VLN);
+
+	spin_lock_irq(&dcrtc->irq_lock);
+	armada_updatel(CFG_HWC_ENA,
+		     CFG_HWC_ENA | CFG_HWC_1BITMOD | CFG_HWC_1BITENA,
+		     dcrtc->base + LCD_SPU_DMA_CTRL0);
+	spin_unlock_irq(&dcrtc->irq_lock);
+
+	return 0;
+}
+
+static void cursor_update(void *data)
+{
+	armada_drm_crtc_cursor_update(data, true);
+}
+
+static int armada_drm_crtc_cursor_set(struct drm_crtc *crtc,
+	struct drm_file *file, uint32_t handle, uint32_t w, uint32_t h)
+{
+	struct drm_device *dev = crtc->dev;
+	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+	struct armada_gem_object *obj = NULL;
+	int ret;
+
+	if (handle && w > 0 && h > 0) {
+		/* maximum size is 64x64 */
+		if (w > 64 || h > 64)
+			return -ENOMEM;
+
+		obj = armada_gem_object_lookup(dev, file, handle);
+		if (!obj)
+			return -ENOENT;
+
+		/* Must be a kernel-mapped object */
+		if (!obj->addr) {
+			drm_gem_object_unreference_unlocked(&obj->obj);
+			return -EINVAL;
+		}
+
+		if (obj->obj.size < w * h * 4) {
+			DRM_ERROR("buffer is too small\n");
+			drm_gem_object_unreference_unlocked(&obj->obj);
+			return -ENOMEM;
+		}
+	}
+
+	mutex_lock(&dev->struct_mutex);
+	if (dcrtc->cursor_obj) {
+		dcrtc->cursor_obj->update = NULL;
+		dcrtc->cursor_obj->update_data = NULL;
+		drm_gem_object_unreference(&dcrtc->cursor_obj->obj);
+	}
+	dcrtc->cursor_obj = obj;
+	dcrtc->cursor_w = w;
+	dcrtc->cursor_h = h;
+	ret = armada_drm_crtc_cursor_update(dcrtc, true);
+	if (obj) {
+		obj->update_data = dcrtc;
+		obj->update = cursor_update;
+	}
+	mutex_unlock(&dev->struct_mutex);
+
+	return ret;
+}
+
+static int armada_drm_crtc_cursor_move(struct drm_crtc *crtc, int x, int y)
+{
+	struct drm_device *dev = crtc->dev;
+	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+	int ret;
+
+	mutex_lock(&dev->struct_mutex);
+	dcrtc->cursor_x = x;
+	dcrtc->cursor_y = y;
+	ret = armada_drm_crtc_cursor_update(dcrtc, false);
+	mutex_unlock(&dev->struct_mutex);
+
+	return ret;
+}
+#else
+#define armada_drm_crtc_cursor_set NULL
+#define armada_drm_crtc_cursor_move NULL
+#endif
+
 static void armada_drm_crtc_destroy(struct drm_crtc *crtc)
 {
 	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
 	struct armada_private *priv = crtc->dev->dev_private;
 
+	if (dcrtc->cursor_obj)
+		drm_gem_object_unreference(&dcrtc->cursor_obj->obj);
+
 	priv->dcrtc[dcrtc->num] = NULL;
 	drm_crtc_cleanup(&dcrtc->crtc);
 
@@ -708,6 +907,8 @@ static int armada_drm_crtc_page_flip(struct drm_crtc *crtc,
 }
 
 static struct drm_crtc_funcs armada_crtc_funcs = {
+	.cursor_set	= armada_drm_crtc_cursor_set,
+	.cursor_move	= armada_drm_crtc_cursor_move,
 	.destroy	= armada_drm_crtc_destroy,
 	.page_flip	= armada_drm_crtc_page_flip,
 	.set_config	= drm_crtc_helper_set_config,
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
index e00dcf5..16e9d93 100644
--- a/drivers/gpu/drm/armada/armada_crtc.h
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -48,6 +48,14 @@ struct armada_crtc {
 
 	struct armada_overlay	*overlay;
 
+	struct armada_gem_object	*cursor_obj;
+	int			cursor_x;
+	int			cursor_y;
+	uint32_t		cursor_w;
+	uint32_t		cursor_h;
+	uint32_t		cursor_lw;
+	uint32_t		cursor_lh;
+
 	int			dpms;
 	uint32_t		cfg_dma_ctrl0;
 	uint32_t		cfg_dumb_ctrl;
-- 
1.7.4.4
