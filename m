From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 10 Jun 2013 23:51:52 +0100
Subject: [PATCH RFC v3 4/4] DRM: Armada: convert hardware cursor support to
 64x32 or 32x64 ARGB
In-Reply-To: <20130609190612.GM18614@n2100.arm.linux.org.uk>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
Message-ID: <E1UmAwK-0006Em-TO@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/armada_crtc.c |  125 +++++++++++-----------------------
 drivers/gpu/drm/armada/armada_hw.h   |    6 +-
 2 files changed, 43 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index b833014..3e2f9d3 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -493,7 +493,8 @@ static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
 	dcrtc->v[1].spu_adv_reg = val << 20 | val;
 
 	/* Always enable RGB hardware cursor mode */
-	dcrtc->v[1].spu_adv_reg |= ADV_HWC32ENABLE;
+	dcrtc->v[1].spu_adv_reg |= ADV_HWC32ENABLE |
+				   ADV_HWC32ARGB | ADV_HWC32BLEND;
 
 	if (interlaced) {
 		/* Odd interlaced frame */
@@ -641,100 +642,46 @@ static const struct drm_crtc_helper_funcs armada_crtc_helper_funcs = {
 };
 
 #ifdef CONFIG_DRM_ARMADA_CURSOR
-static void armada_load_cursor_rgb(void __iomem *base, uint32_t *pix,
+static void armada_load_cursor_argb(void __iomem *base, uint32_t *pix,
 	unsigned stride, unsigned width, unsigned height)
 {
-	uint32_t r, g, b, addr;
-	unsigned y, n;
+	uint32_t addr;
+	unsigned y;
 
-	for (r = g = b = addr = n = y = 0; y < height; y++) {
+	addr = SRAM_HWC32_RAM1;
+	for (y = 0; y < height; y++) {
 		uint32_t *p = &pix[y * stride];
 		unsigned x;
 
 		for (x = 0; x < width; x++, p++) {
-			r >>= 8;
-			r |= 0xff000000 & (*p << 8);
-			g >>= 8;
-			g |= 0xff000000 & (*p << 16);
-			b >>= 8;
-			b |= 0xff000000 & (*p << 24);
-			if (x == 0 || y == 0) {
-				b |= 0xff000000;
-				g |= 0xff000000;
-				r &= ~0xff000000;
-			}
-			if (++n == 4) {
-				writel_relaxed(r,
-					       base + LCD_SPU_SRAM_WRDAT);
-				writel_relaxed(addr |
-					       SRAM_WRITE | SRAM_HWC32_RAMR,
-					       base + LCD_SPU_SRAM_CTRL);
-				writel_relaxed(g,
-					       base + LCD_SPU_SRAM_WRDAT);
-				writel_relaxed(addr |
-					       SRAM_WRITE | SRAM_HWC32_RAMG,
-					       base + LCD_SPU_SRAM_CTRL);
-				writel_relaxed(b,
-					       base + LCD_SPU_SRAM_WRDAT);
-				writel_relaxed(addr |
-					       SRAM_WRITE | SRAM_HWC32_RAMB,
-					       base + LCD_SPU_SRAM_CTRL);
-				addr += 1;
-				if ((addr & 255) == 0)
-					addr += 0xf00;
-				n = 0;
-			}
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
 		}
 	}
-	if (n) {
-		r >>= 8 * (4 - n);
-		g >>= 8 * (4 - n);
-		b >>= 8 * (4 - n);
-		writel_relaxed(r, base + LCD_SPU_SRAM_WRDAT);
-		writel_relaxed(addr | SRAM_WRITE | SRAM_HWC32_RAMR,
-			       base + LCD_SPU_SRAM_CTRL);
-		writel_relaxed(g, base + LCD_SPU_SRAM_WRDAT);
-		writel_relaxed(addr | SRAM_WRITE | SRAM_HWC32_RAMG,
-			       base + LCD_SPU_SRAM_CTRL);
-		writel_relaxed(b, base + LCD_SPU_SRAM_WRDAT);
-		writel_relaxed(addr | SRAM_WRITE | SRAM_HWC32_RAMB,
-			       base + LCD_SPU_SRAM_CTRL);
-	}
 }
 
-static void armada_load_cursor_alpha(void __iomem *base, uint32_t *pix,
-	unsigned stride, unsigned width, unsigned height)
+static void armada_drm_crtc_cursor_tran(void __iomem *base)
 {
-	uint32_t data, addr, ram_cmd = SRAM_WRITE | SRAM_HWC32_TRAN;
-	unsigned y, n;
+	unsigned addr;
 
-	for (data = addr = n = y = 0; y < height; y++) {
-		uint32_t *p = &pix[y * stride];
-		unsigned x;
-
-		for (x = 0; x < width; x++, p++) {
-			data >>= 2;
-			if (*p >= 0x80000000)
-				data |= 0x40000000;
-			if (x == 0 || y == 0)
-				data |= 0x40000000;
-			if (++n == 16) {
-				writel_relaxed(data,
-					       base + LCD_SPU_SRAM_WRDAT);
-				writel_relaxed(addr |
-					       SRAM_WRITE | SRAM_HWC32_TRAN,
-					       base + LCD_SPU_SRAM_CTRL);
-				addr += 1;
-				if ((addr & 255) == 0)
-					addr += 0xf00;
-				n = 0;
-			}
-		}
-	}
-	if (n) {
-		data >>= 2 * (16 - n);
-		writel_relaxed(data, base + LCD_SPU_SRAM_WRDAT);
-		writel_relaxed(addr | ram_cmd, base + LCD_SPU_SRAM_CTRL);
+	for (addr = 0; addr < 256; addr++) {
+		/* write the default value */
+		writel_relaxed(0x55555555, base + LCD_SPU_SRAM_WRDAT);
+		writel_relaxed(addr | SRAM_WRITE | SRAM_HWC32_TRAN,
+			       base + LCD_SPU_SRAM_CTRL);
 	}
 }
 
@@ -742,6 +689,7 @@ static int armada_drm_crtc_cursor_update(struct armada_crtc *dcrtc, bool reload)
 {
 	uint32_t xoff, xscr, w = dcrtc->cursor_w, s;
 	uint32_t yoff, yscr, h = dcrtc->cursor_h;
+	uint32_t para1;
 
 	/*
 	 * Calculate the visible width and height of the cursor,
@@ -790,9 +738,14 @@ static int armada_drm_crtc_cursor_update(struct armada_crtc *dcrtc, bool reload)
 		return 0;
 	}
 
+	para1 = readl_relaxed(dcrtc->base + LCD_SPU_SRAM_PARA1);
 	armada_updatel(CFG_CSB_256x32, CFG_PDWN256x32,
 		     dcrtc->base + LCD_SPU_SRAM_PARA1);
 
+	/* Initialize the transparency if the SRAM was powered down */
+	if (!(para1 & CFG_CSB_256x32))
+		armada_drm_crtc_cursor_tran(dcrtc->base);
+
 	if (dcrtc->cursor_hw_sz != (h << 16 | w) || reload) {
 		struct armada_gem_object *obj = dcrtc->cursor_obj;
 		uint32_t *pix;
@@ -806,8 +759,7 @@ static int armada_drm_crtc_cursor_update(struct armada_crtc *dcrtc, bool reload)
 		/* Set the top-left corner of the cursor image */
 		pix = obj->addr;
 		pix += yoff * s + xoff;
-		armada_load_cursor_rgb(dcrtc->base, pix, s, w, h);
-		armada_load_cursor_alpha(dcrtc->base, pix, s, w, h);
+		armada_load_cursor_argb(dcrtc->base, pix, s, w, h);
 	}
 
 	/* Reload the cursor position, size and enable in the IRQ handler */
@@ -835,8 +787,8 @@ static int armada_drm_crtc_cursor_set(struct drm_crtc *crtc,
 	int ret;
 
 	if (handle && w > 0 && h > 0) {
-		/* maximum size is 64x64 */
-		if (w > 64 || h > 64)
+		/* maximum size is 64x32 or 32x64 */
+		if (w > 64 || h > 64 || (w > 32 && h > 32))
 			return -ENOMEM;
 
 		obj = armada_gem_object_lookup(dev, file, handle);
@@ -1023,6 +975,7 @@ int armada_drm_crtc_create(struct drm_device *dev, unsigned num,
 	writel_relaxed(0x0000e000, dcrtc->base + LCD_SPU_SRAM_PARA1);
 	writel_relaxed(0x2032ff81, dcrtc->base + LCD_SPU_DMA_CTRL1);
 	writel_relaxed(0x00000000, dcrtc->base + LCD_SPU_GRA_OVSA_HPXL_VLN);
+	writel_relaxed(CFG_PDWN256x32, dcrtc->base + LCD_SPU_SRAM_PARA1);
 
 	/* Lower the watermark so to eliminate jitter at higher bandwidths */
 	armada_updatel(0x20, (1 << 11) | 0xff, dcrtc->base + LCD_CFG_RDREG4F);
diff --git a/drivers/gpu/drm/armada/armada_hw.h b/drivers/gpu/drm/armada/armada_hw.h
index 58d2a20..0c2937b 100644
--- a/drivers/gpu/drm/armada/armada_hw.h
+++ b/drivers/gpu/drm/armada/armada_hw.h
@@ -171,8 +171,10 @@ enum {
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
