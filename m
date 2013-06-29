From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 29 Jun 2013 23:54:22 +0100
Subject: [PATCH RFC 2/3] DRM: Armada: Add support for ARGB 32x64 or 64x32
 hardware cursors
In-Reply-To: <20130629225210.GF3353@n2100.arm.linux.org.uk>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
Message-ID: <E1Ut42A-0000wq-L8@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ARGB hardware cursor support to the DRM driver for the
Marvell Armada SoCs.  ARGB cursors are supported at either 32x64 or
64x32 resolutions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/armada_510.c  |    1 +
 drivers/gpu/drm/armada/armada_crtc.c |  244 +++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/armada/armada_crtc.h |    9 ++
 drivers/gpu/drm/armada/armada_drm.h  |    1 +
 drivers/gpu/drm/armada/armada_hw.h   |    6 +-
 5 files changed, 255 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_510.c b/drivers/gpu/drm/armada/armada_510.c
index a016888..59948ef 100644
--- a/drivers/gpu/drm/armada/armada_510.c
+++ b/drivers/gpu/drm/armada/armada_510.c
@@ -80,6 +80,7 @@ static int armada510_crtc_compute_clock(struct armada_crtc *dcrtc,
 
 const struct armada_variant armada510_ops = {
 	.has_spu_adv_reg = true,
+	.spu_adv_reg = ADV_HWC32ENABLE | ADV_HWC32ARGB | ADV_HWC32BLEND,
 	.init = armada510_init,
 	.crtc_init = armada510_crtc_init,
 	.crtc_compute_clock = armada510_crtc_compute_clock,
diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index f489157..7df1101 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -381,8 +381,21 @@ void armada_drm_crtc_irq(struct armada_crtc *dcrtc, u32 stat)
 		val = readl_relaxed(base + LCD_SPU_ADV_REG);
 		val &= ~(ADV_VSYNC_L_OFF | ADV_VSYNC_H_OFF | ADV_VSYNCOFFEN);
 		val |= dcrtc->v[i].spu_adv_reg;
-		writel_relaxed(val, dcrtc->base + LCD_SPU_ADV_REG);
+		writel_relaxed(val, base + LCD_SPU_ADV_REG);
 	}
+
+	if (stat & DUMB_FRAMEDONE && dcrtc->cursor_update) {
+		writel_relaxed(dcrtc->cursor_hw_pos,
+			       base + LCD_SPU_HWC_OVSA_HPXL_VLN);
+		writel_relaxed(dcrtc->cursor_hw_sz,
+			       base + LCD_SPU_HWC_HPXL_VLN);
+		armada_updatel(CFG_HWC_ENA,
+			       CFG_HWC_ENA | CFG_HWC_1BITMOD | CFG_HWC_1BITENA,
+			       base + LCD_SPU_DMA_CTRL0);
+		dcrtc->cursor_update = false;
+		armada_drm_crtc_disable_irq(dcrtc, DUMB_FRAMEDONE_ENA);
+	}
+
 	spin_unlock(&dcrtc->irq_lock);
 
 	if (stat & GRA_FRAME_IRQ) {
@@ -522,7 +535,8 @@ static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
 				    adj->crtc_htotal;
 	dcrtc->v[1].spu_v_porch = tm << 16 | bm;
 	val = adj->crtc_hsync_start;
-	dcrtc->v[1].spu_adv_reg = val << 20 | val | ADV_VSYNCOFFEN;
+	dcrtc->v[1].spu_adv_reg = val << 20 | val | ADV_VSYNCOFFEN |
+		priv->variant->spu_adv_reg;
 
 	if (interlaced) {
 		/* Odd interlaced frame */
@@ -530,7 +544,8 @@ static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
 						(1 << 16);
 		dcrtc->v[0].spu_v_porch = dcrtc->v[1].spu_v_porch + 1;
 		val = adj->crtc_hsync_start - adj->crtc_htotal / 2;
-		dcrtc->v[0].spu_adv_reg = val << 20 | val | ADV_VSYNCOFFEN;
+		dcrtc->v[0].spu_adv_reg = val << 20 | val | ADV_VSYNCOFFEN |
+			priv->variant->spu_adv_reg;
 	} else {
 		dcrtc->v[0] = dcrtc->v[1];
 	}
@@ -545,10 +560,11 @@ static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
 	armada_reg_queue_set(regs, i, dcrtc->v[0].spu_v_h_total,
 			   LCD_SPUT_V_H_TOTAL);
 
-	if (priv->variant->has_spu_adv_reg)
+	if (priv->variant->has_spu_adv_reg) {
 		armada_reg_queue_mod(regs, i, dcrtc->v[0].spu_adv_reg,
 				     ADV_VSYNC_L_OFF | ADV_VSYNC_H_OFF |
 				     ADV_VSYNCOFFEN, LCD_SPU_ADV_REG);
+	}
 
 	val = CFG_GRA_ENA | CFG_GRA_HSMOOTH;
 	val |= CFG_GRA_FMT(drm_fb_to_armada_fb(dcrtc->crtc.fb)->fmt);
@@ -640,11 +656,229 @@ static const struct drm_crtc_helper_funcs armada_crtc_helper_funcs = {
 	.disable	= armada_drm_crtc_disable,
 };
 
+static void armada_load_cursor_argb(void __iomem *base, uint32_t *pix,
+	unsigned stride, unsigned width, unsigned height)
+{
+	uint32_t addr;
+	unsigned y;
+
+	addr = SRAM_HWC32_RAM1;
+	for (y = 0; y < height; y++) {
+		uint32_t *p = &pix[y * stride];
+		unsigned x;
+
+		for (x = 0; x < width; x++, p++) {
+			uint32_t val = *p;
+
+			val = (val & 0xff00ff00) |
+			      (val & 0x000000ff) << 16 |
+			      (val & 0x00ff0000) >> 16;
+
+			writel_relaxed(val,
+				       base + LCD_SPU_SRAM_WRDAT);
+			writel_relaxed(addr | SRAM_WRITE,
+				       base + LCD_SPU_SRAM_CTRL);
+			addr += 1;
+			if ((addr & 0x00ff) == 0)
+				addr += 0xf00;
+			if ((addr & 0x30ff) == 0)
+				addr = SRAM_HWC32_RAM2;
+		}
+	}
+}
+
+static void armada_drm_crtc_cursor_tran(void __iomem *base)
+{
+	unsigned addr;
+
+	for (addr = 0; addr < 256; addr++) {
+		/* write the default value */
+		writel_relaxed(0x55555555, base + LCD_SPU_SRAM_WRDAT);
+		writel_relaxed(addr | SRAM_WRITE | SRAM_HWC32_TRAN,
+			       base + LCD_SPU_SRAM_CTRL);
+	}
+}
+
+static int armada_drm_crtc_cursor_update(struct armada_crtc *dcrtc, bool reload)
+{
+	uint32_t xoff, xscr, w = dcrtc->cursor_w, s;
+	uint32_t yoff, yscr, h = dcrtc->cursor_h;
+	uint32_t para1;
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
+		armada_drm_crtc_disable_irq(dcrtc, DUMB_FRAMEDONE_ENA);
+		dcrtc->cursor_update = false;
+		armada_updatel(0, CFG_HWC_ENA, dcrtc->base + LCD_SPU_DMA_CTRL0);
+		spin_unlock_irq(&dcrtc->irq_lock);
+		return 0;
+	}
+
+	para1 = readl_relaxed(dcrtc->base + LCD_SPU_SRAM_PARA1);
+	armada_updatel(CFG_CSB_256x32, CFG_CSB_256x32 | CFG_PDWN256x32,
+		       dcrtc->base + LCD_SPU_SRAM_PARA1);
+
+	/*
+	 * Initialize the transparency if the SRAM was powered down.
+	 * We must also reload the cursor data as well.
+	 */
+	if (!(para1 & CFG_CSB_256x32)) {
+		armada_drm_crtc_cursor_tran(dcrtc->base);
+		reload = true;
+	}
+
+	if (dcrtc->cursor_hw_sz != (h << 16 | w) || reload) {
+		struct armada_gem_object *obj = dcrtc->cursor_obj;
+		uint32_t *pix;
+
+		spin_lock_irq(&dcrtc->irq_lock);
+		armada_drm_crtc_disable_irq(dcrtc, DUMB_FRAMEDONE_ENA);
+		dcrtc->cursor_update = false;
+		armada_updatel(0, CFG_HWC_ENA, dcrtc->base + LCD_SPU_DMA_CTRL0);
+		spin_unlock_irq(&dcrtc->irq_lock);
+
+		/* Set the top-left corner of the cursor image */
+		pix = obj->addr;
+		pix += yoff * s + xoff;
+		armada_load_cursor_argb(dcrtc->base, pix, s, w, h);
+	}
+
+	/* Reload the cursor position, size and enable in the IRQ handler */
+	spin_lock_irq(&dcrtc->irq_lock);
+	dcrtc->cursor_hw_pos = yscr << 16 | xscr;
+	dcrtc->cursor_hw_sz = h << 16 | w;
+	dcrtc->cursor_update = true;
+	armada_drm_crtc_enable_irq(dcrtc, DUMB_FRAMEDONE_ENA);
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
+	struct armada_private *priv = crtc->dev->dev_private;
+	struct armada_gem_object *obj = NULL;
+	int ret;
+
+	/* If no cursor support, replicate drm's return value */
+	if (!priv->variant->has_spu_adv_reg)
+		return -ENXIO;
+
+	if (handle && w > 0 && h > 0) {
+		/* maximum size is 64x32 or 32x64 */
+		if (w > 64 || h > 64 || (w > 32 && h > 32))
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
+	struct armada_private *priv = crtc->dev->dev_private;
+	int ret;
+
+	/* If no cursor support, replicate drm's return value */
+	if (!priv->variant->has_spu_adv_reg)
+		return -EFAULT;
+
+	mutex_lock(&dev->struct_mutex);
+	dcrtc->cursor_x = x;
+	dcrtc->cursor_y = y;
+	ret = armada_drm_crtc_cursor_update(dcrtc, false);
+	mutex_unlock(&dev->struct_mutex);
+
+	return ret;
+}
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
 
@@ -750,6 +984,8 @@ armada_drm_crtc_set_property(struct drm_crtc *crtc,
 }
 
 static struct drm_crtc_funcs armada_crtc_funcs = {
+	.cursor_set	= armada_drm_crtc_cursor_set,
+	.cursor_move	= armada_drm_crtc_cursor_move,
 	.destroy	= armada_drm_crtc_destroy,
 	.set_config	= drm_crtc_helper_set_config,
 	.page_flip	= armada_drm_crtc_page_flip,
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
index 972da53..9c10a07 100644
--- a/drivers/gpu/drm/armada/armada_crtc.h
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -44,11 +44,20 @@ struct armada_crtc {
 		uint32_t	spu_adv_reg;
 	} v[2];
 	bool			interlaced;
+	bool			cursor_update;
 	uint8_t			csc_yuv_mode;
 	uint8_t			csc_rgb_mode;
 
 	struct drm_plane	*plane;
 
+	struct armada_gem_object	*cursor_obj;
+	int			cursor_x;
+	int			cursor_y;
+	uint32_t		cursor_hw_pos;
+	uint32_t		cursor_hw_sz;
+	uint32_t		cursor_w;
+	uint32_t		cursor_h;
+
 	int			dpms;
 	uint32_t		cfg_dumb_ctrl;
 	uint32_t		dumb_ctrl;
diff --git a/drivers/gpu/drm/armada/armada_drm.h b/drivers/gpu/drm/armada/armada_drm.h
index e8c4f80..eef09ec 100644
--- a/drivers/gpu/drm/armada/armada_drm.h
+++ b/drivers/gpu/drm/armada/armada_drm.h
@@ -60,6 +60,7 @@ struct armada_private;
 
 struct armada_variant {
 	bool	has_spu_adv_reg;
+	uint32_t spu_adv_reg;
 	int (*init)(struct armada_private *, struct device *);
 	int (*crtc_init)(struct armada_crtc *);
 	int (*crtc_compute_clock)(struct armada_crtc *,
diff --git a/drivers/gpu/drm/armada/armada_hw.h b/drivers/gpu/drm/armada/armada_hw.h
index 216a4b5..27319a8 100644
--- a/drivers/gpu/drm/armada/armada_hw.h
+++ b/drivers/gpu/drm/armada/armada_hw.h
@@ -168,8 +168,10 @@ enum {
 	SRAM_READ	= 0 << 14,
 	SRAM_WRITE	= 2 << 14,
 	SRAM_INIT	= 3 << 14,
-	SRAM_HWC32_RAMR	= 0xc << 8,
-	SRAM_HWC32_RAMG	= 0xd << 8,
+	SRAM_HWC32_RAM1	= 0xc << 8,
+	SRAM_HWC32_RAM2	= 0xd << 8,
+	SRAM_HWC32_RAMR	= SRAM_HWC32_RAM1,
+	SRAM_HWC32_RAMG	= SRAM_HWC32_RAM2,
 	SRAM_HWC32_RAMB	= 0xe << 8,
 	SRAM_HWC32_TRAN	= 0xf << 8,
 	SRAM_HWC	= 0xf << 8,
-- 
1.7.4.4
