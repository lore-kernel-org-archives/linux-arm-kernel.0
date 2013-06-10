From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 10 Jun 2013 23:50:52 +0100
Subject: [PATCH RFC v3 3/4] DRM: Armada: convert Armada hardware cursor
 support to RGB+transparency
In-Reply-To: <20130609190612.GM18614@n2100.arm.linux.org.uk>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
Message-ID: <E1UmAvM-0006Eb-OL@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/Kconfig       |    6 +-
 drivers/gpu/drm/armada/armada_crtc.c |  186 +++++++++++++++++++++++----------
 drivers/gpu/drm/armada/armada_crtc.h |    5 +-
 3 files changed, 135 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/armada/Kconfig b/drivers/gpu/drm/armada/Kconfig
index 6f64642..c401339 100644
--- a/drivers/gpu/drm/armada/Kconfig
+++ b/drivers/gpu/drm/armada/Kconfig
@@ -15,8 +15,8 @@ config DRM_ARMADA
 	  kernel mode setting and buffer management to userspace.
 
 config DRM_ARMADA_CURSOR
-	bool "Enable hardware cursor support for Marvell Armada DRM"
+	bool "Enable hardware RGB+T cursor support for Marvell Armada DRM"
 	depends on DRM_ARMADA != n
 	help
-	  Add support for hardware cursor support on the Marvell
-	  Armada devices.
+	  Add support for RGB+transparency hardware cursor support on
+	  the Marvell Armada devices.
diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index 4a71ba0..b833014 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -369,8 +369,19 @@ void armada_drm_crtc_irq(struct armada_crtc *dcrtc, u32 stat)
 		val = readl_relaxed(base + LCD_SPU_ADV_REG);
 		val &= ~(0xfff << 20 | 0xfff);
 		val |= dcrtc->v[i].spu_adv_reg;
-		writel_relaxed(val, dcrtc->base + LCD_SPU_ADV_REG);
+		writel_relaxed(val, base + LCD_SPU_ADV_REG);
 	}
+
+	if (stat & DUMB_FRAMEDONE && dcrtc->cursor_update) {
+		writel_relaxed(dcrtc->cursor_hw_pos, base + LCD_SPU_HWC_OVSA_HPXL_VLN);
+		writel_relaxed(dcrtc->cursor_hw_sz, base + LCD_SPU_HWC_HPXL_VLN);
+		armada_updatel(CFG_HWC_ENA,
+			     CFG_HWC_ENA | CFG_HWC_1BITMOD | CFG_HWC_1BITENA,
+			     base + LCD_SPU_DMA_CTRL0);
+		dcrtc->cursor_update = false;
+		armada_drm_crtc_disable_irq(dcrtc, DUMB_FRAMEDONE_ENA);
+	}
+
 	spin_unlock(&dcrtc->irq_lock);
 
 	/* Only on frame 0 IRQs (start of progressive / odd frame) */
@@ -481,6 +492,9 @@ static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
 	val = adj->crtc_hsync_start;
 	dcrtc->v[1].spu_adv_reg = val << 20 | val;
 
+	/* Always enable RGB hardware cursor mode */
+	dcrtc->v[1].spu_adv_reg |= ADV_HWC32ENABLE;
+
 	if (interlaced) {
 		/* Odd interlaced frame */
 		dcrtc->v[0].spu_v_h_total = dcrtc->v[1].spu_v_h_total +
@@ -627,6 +641,103 @@ static const struct drm_crtc_helper_funcs armada_crtc_helper_funcs = {
 };
 
 #ifdef CONFIG_DRM_ARMADA_CURSOR
+static void armada_load_cursor_rgb(void __iomem *base, uint32_t *pix,
+	unsigned stride, unsigned width, unsigned height)
+{
+	uint32_t r, g, b, addr;
+	unsigned y, n;
+
+	for (r = g = b = addr = n = y = 0; y < height; y++) {
+		uint32_t *p = &pix[y * stride];
+		unsigned x;
+
+		for (x = 0; x < width; x++, p++) {
+			r >>= 8;
+			r |= 0xff000000 & (*p << 8);
+			g >>= 8;
+			g |= 0xff000000 & (*p << 16);
+			b >>= 8;
+			b |= 0xff000000 & (*p << 24);
+			if (x == 0 || y == 0) {
+				b |= 0xff000000;
+				g |= 0xff000000;
+				r &= ~0xff000000;
+			}
+			if (++n == 4) {
+				writel_relaxed(r,
+					       base + LCD_SPU_SRAM_WRDAT);
+				writel_relaxed(addr |
+					       SRAM_WRITE | SRAM_HWC32_RAMR,
+					       base + LCD_SPU_SRAM_CTRL);
+				writel_relaxed(g,
+					       base + LCD_SPU_SRAM_WRDAT);
+				writel_relaxed(addr |
+					       SRAM_WRITE | SRAM_HWC32_RAMG,
+					       base + LCD_SPU_SRAM_CTRL);
+				writel_relaxed(b,
+					       base + LCD_SPU_SRAM_WRDAT);
+				writel_relaxed(addr |
+					       SRAM_WRITE | SRAM_HWC32_RAMB,
+					       base + LCD_SPU_SRAM_CTRL);
+				addr += 1;
+				if ((addr & 255) == 0)
+					addr += 0xf00;
+				n = 0;
+			}
+		}
+	}
+	if (n) {
+		r >>= 8 * (4 - n);
+		g >>= 8 * (4 - n);
+		b >>= 8 * (4 - n);
+		writel_relaxed(r, base + LCD_SPU_SRAM_WRDAT);
+		writel_relaxed(addr | SRAM_WRITE | SRAM_HWC32_RAMR,
+			       base + LCD_SPU_SRAM_CTRL);
+		writel_relaxed(g, base + LCD_SPU_SRAM_WRDAT);
+		writel_relaxed(addr | SRAM_WRITE | SRAM_HWC32_RAMG,
+			       base + LCD_SPU_SRAM_CTRL);
+		writel_relaxed(b, base + LCD_SPU_SRAM_WRDAT);
+		writel_relaxed(addr | SRAM_WRITE | SRAM_HWC32_RAMB,
+			       base + LCD_SPU_SRAM_CTRL);
+	}
+}
+
+static void armada_load_cursor_alpha(void __iomem *base, uint32_t *pix,
+	unsigned stride, unsigned width, unsigned height)
+{
+	uint32_t data, addr, ram_cmd = SRAM_WRITE | SRAM_HWC32_TRAN;
+	unsigned y, n;
+
+	for (data = addr = n = y = 0; y < height; y++) {
+		uint32_t *p = &pix[y * stride];
+		unsigned x;
+
+		for (x = 0; x < width; x++, p++) {
+			data >>= 2;
+			if (*p >= 0x80000000)
+				data |= 0x40000000;
+			if (x == 0 || y == 0)
+				data |= 0x40000000;
+			if (++n == 16) {
+				writel_relaxed(data,
+					       base + LCD_SPU_SRAM_WRDAT);
+				writel_relaxed(addr |
+					       SRAM_WRITE | SRAM_HWC32_TRAN,
+					       base + LCD_SPU_SRAM_CTRL);
+				addr += 1;
+				if ((addr & 255) == 0)
+					addr += 0xf00;
+				n = 0;
+			}
+		}
+	}
+	if (n) {
+		data >>= 2 * (16 - n);
+		writel_relaxed(data, base + LCD_SPU_SRAM_WRDAT);
+		writel_relaxed(addr | ram_cmd, base + LCD_SPU_SRAM_CTRL);
+	}
+}
+
 static int armada_drm_crtc_cursor_update(struct armada_crtc *dcrtc, bool reload)
 {
 	uint32_t xoff, xscr, w = dcrtc->cursor_w, s;
@@ -672,6 +783,8 @@ static int armada_drm_crtc_cursor_update(struct armada_crtc *dcrtc, bool reload)
 
 	if (!dcrtc->cursor_obj || !h || !w) {
 		spin_lock_irq(&dcrtc->irq_lock);
+		armada_drm_crtc_disable_irq(dcrtc, DUMB_FRAMEDONE_ENA);
+		dcrtc->cursor_update = false;
 		armada_updatel(0, CFG_HWC_ENA, dcrtc->base + LCD_SPU_DMA_CTRL0);
 		spin_unlock_irq(&dcrtc->irq_lock);
 		return 0;
@@ -680,70 +793,29 @@ static int armada_drm_crtc_cursor_update(struct armada_crtc *dcrtc, bool reload)
 	armada_updatel(CFG_CSB_256x32, CFG_PDWN256x32,
 		     dcrtc->base + LCD_SPU_SRAM_PARA1);
 
-	if (dcrtc->cursor_lw != w || dcrtc->cursor_lh != h || reload) {
+	if (dcrtc->cursor_hw_sz != (h << 16 | w) || reload) {
 		struct armada_gem_object *obj = dcrtc->cursor_obj;
-		uint32_t *pix, *p, col2 = 0, col3 = 0;
-		unsigned x, y, d, n, a;
-
-		dcrtc->cursor_lw = w;
-		dcrtc->cursor_lh = h;
+		uint32_t *pix;
 
-		pix = obj->addr;
+		spin_lock_irq(&dcrtc->irq_lock);
+		armada_drm_crtc_disable_irq(dcrtc, DUMB_FRAMEDONE_ENA);
+		dcrtc->cursor_update = false;
+		armada_updatel(0, CFG_HWC_ENA, dcrtc->base + LCD_SPU_DMA_CTRL0);
+		spin_unlock_irq(&dcrtc->irq_lock);
 
 		/* Set the top-left corner of the cursor image */
+		pix = obj->addr;
 		pix += yoff * s + xoff;
-
-		a = 2 << 14 | 15 << 8;
-		for (d = n = y = 0; y < h; y++) {
-			for (x = 0, p = &pix[y * s]; x < w; x++, p++) {
-				uint32_t v = *p;
-				unsigned b;
-
-				if ((v & 0xff000000) != 0xff000000) {
-					b = 0;	/* transparent */
-				} else if (col2 == v) {
-					b = 2;	/* color 2 */
-				} else if (col3 == v) {
-					b = 3;	/* color 3 */
-				} else if (col2 == 0) {
-					col2 = v;
-					b = 2;	/* alloc color 2 */
-				} else if (col3 == 0) {
-					col3 = v;
-					b = 3;	/* alloc color 3 */
-				} else {
-					/* fail */
-					b = 1;	/* inverse (!) */
-				}
-
-				d |= b << n;
-				n += 2;
-
-				if (n == 32) {
-					writel_relaxed(d, dcrtc->base + LCD_SPU_SRAM_WRDAT);
-					writel_relaxed(a, dcrtc->base + LCD_SPU_SRAM_CTRL);
-					a++;
-					d = n = 0;
-				}
-			}
-		}
-
-		if (n) {
-			writel_relaxed(d, dcrtc->base + LCD_SPU_SRAM_WRDAT);
-			writel_relaxed(a, dcrtc->base + LCD_SPU_SRAM_CTRL);
-		}
-
-		writel_relaxed(col2, dcrtc->base + LCD_SPU_ALPHA_COLOR1);
-		writel_relaxed(col3, dcrtc->base + LCD_SPU_ALPHA_COLOR2);
-		writel_relaxed(h << 16 | w, dcrtc->base + LCD_SPU_HWC_HPXL_VLN);
+		armada_load_cursor_rgb(dcrtc->base, pix, s, w, h);
+		armada_load_cursor_alpha(dcrtc->base, pix, s, w, h);
 	}
 
-	writel_relaxed(yscr << 16 | xscr, dcrtc->base + LCD_SPU_HWC_OVSA_HPXL_VLN);
-
+	/* Reload the cursor position, size and enable in the IRQ handler */
 	spin_lock_irq(&dcrtc->irq_lock);
-	armada_updatel(CFG_HWC_ENA,
-		     CFG_HWC_ENA | CFG_HWC_1BITMOD | CFG_HWC_1BITENA,
-		     dcrtc->base + LCD_SPU_DMA_CTRL0);
+	dcrtc->cursor_hw_pos = yscr << 16 | xscr;
+	dcrtc->cursor_hw_sz = h << 16 | w;
+	dcrtc->cursor_update = true;
+	armada_drm_crtc_enable_irq(dcrtc, DUMB_FRAMEDONE_ENA);
 	spin_unlock_irq(&dcrtc->irq_lock);
 
 	return 0;
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
index 16e9d93..817f29e 100644
--- a/drivers/gpu/drm/armada/armada_crtc.h
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -45,16 +45,17 @@ struct armada_crtc {
 		uint32_t	spu_adv_reg;
 	} v[2];
 	bool			interlaced;
+	bool			cursor_update;
 
 	struct armada_overlay	*overlay;
 
 	struct armada_gem_object	*cursor_obj;
 	int			cursor_x;
 	int			cursor_y;
+	uint32_t		cursor_hw_pos;
+	uint32_t		cursor_hw_sz;
 	uint32_t		cursor_w;
 	uint32_t		cursor_h;
-	uint32_t		cursor_lw;
-	uint32_t		cursor_lh;
 
 	int			dpms;
 	uint32_t		cfg_dma_ctrl0;
-- 
1.7.4.4
