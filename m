From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Jun 2018 20:44:50 +0200
Subject: [PATCH] drm/pl111: Support Nomadik LCDC variant
Message-ID: <20180621184450.25377-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nomadik has a variant of the PL110 known as "Color LCD
Controller" LCDC. This variant has the same bit ordering as
the DRM subsystem (in difference from the other variants)
and adds a few bits for the control of 5551, 565 etc in the
control register. Notably it also adds a packed RGB888
24BPP mode.

We add support by detecting this variant and also adding a
small plug-in that will mux the LCDC out if the ASIC happens
to be muxed to the other graphics controller (they are
mutually exclusive).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/Makefile        |  1 +
 drivers/gpu/drm/pl111/pl111_display.c | 54 ++++++++++++++++++++++-----
 drivers/gpu/drm/pl111/pl111_drm.h     |  5 +++
 drivers/gpu/drm/pl111/pl111_drv.c     | 41 +++++++++++++++++++-
 drivers/gpu/drm/pl111/pl111_nomadik.c | 36 ++++++++++++++++++
 drivers/gpu/drm/pl111/pl111_nomadik.h | 18 +++++++++
 6 files changed, 144 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/pl111/pl111_nomadik.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_nomadik.h

diff --git a/drivers/gpu/drm/pl111/Makefile b/drivers/gpu/drm/pl111/Makefile
index 19a8189dc54f..0c70f0e91d21 100644
--- a/drivers/gpu/drm/pl111/Makefile
+++ b/drivers/gpu/drm/pl111/Makefile
@@ -4,6 +4,7 @@ pl111_drm-y +=	pl111_display.o \
 		pl111_drv.o
 
 pl111_drm-$(CONFIG_ARCH_VEXPRESS) += pl111_vexpress.o
+pl111_drm-$(CONFIG_ARCH_NOMADIK) += pl111_nomadik.o
 pl111_drm-$(CONFIG_DEBUG_FS) += pl111_debugfs.o
 
 obj-$(CONFIG_DRM_PL111) += pl111_drm.o
diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 19b0d006a54a..a432eb7ad445 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -223,48 +223,84 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 
 	/* Hard-code TFT panel */
 	cntl = CNTL_LCDEN | CNTL_LCDTFT | CNTL_LCDVCOMP(1);
+	/* On the ST Micro variant, assume all 24 bits are connected */
+	if (priv->variant->st_bitmux_control)
+		cntl |= CNTL_ST_CDWID_24;
 
-	/* Note that the the hardware's format reader takes 'r' from
+	/*
+	 * Note that the the ARM hardware's format reader takes 'r' from
 	 * the low bit, while DRM formats list channels from high bit
-	 * to low bit as you read left to right.
+	 * to low bit as you read left to right. The ST Micro version of
+	 * the PL110 (LCDC) however uses the standard DRM format.
 	 */
 	switch (fb->format->format) {
+	case DRM_FORMAT_BGR888:
+		/* Only supported on the ST Micro variant */
+		if (priv->variant->st_bitmux_control)
+			cntl |= CNTL_ST_LCDBPP24_PACKED | CNTL_BGR;
+		break;
+	case DRM_FORMAT_RGB888:
+		/* Only supported on the ST Micro variant */
+		if (priv->variant->st_bitmux_control)
+			cntl |= CNTL_ST_LCDBPP24_PACKED;
+		break;
 	case DRM_FORMAT_ABGR8888:
 	case DRM_FORMAT_XBGR8888:
-		cntl |= CNTL_LCDBPP24;
+		if (priv->variant->st_bitmux_control)
+			cntl |= CNTL_LCDBPP24 | CNTL_BGR;
+		else
+			cntl |= CNTL_LCDBPP24;
 		break;
 	case DRM_FORMAT_ARGB8888:
 	case DRM_FORMAT_XRGB8888:
-		cntl |= CNTL_LCDBPP24 | CNTL_BGR;
+		if (priv->variant->st_bitmux_control)
+			cntl |= CNTL_LCDBPP24;
+		else
+			cntl |= CNTL_LCDBPP24 | CNTL_BGR;
 		break;
 	case DRM_FORMAT_BGR565:
 		if (priv->variant->is_pl110)
 			cntl |= CNTL_LCDBPP16;
+		else if (priv->variant->st_bitmux_control)
+			cntl |= CNTL_LCDBPP16 | CNTL_ST_1XBPP_565 | CNTL_BGR;
 		else
 			cntl |= CNTL_LCDBPP16_565;
 		break;
 	case DRM_FORMAT_RGB565:
 		if (priv->variant->is_pl110)
-			cntl |= CNTL_LCDBPP16;
+			cntl |= CNTL_LCDBPP16 | CNTL_BGR;
+		else if (priv->variant->st_bitmux_control)
+			cntl |= CNTL_LCDBPP16 | CNTL_ST_1XBPP_565;
 		else
-			cntl |= CNTL_LCDBPP16_565;
-		cntl |= CNTL_BGR;
+			cntl |= CNTL_LCDBPP16_565 | CNTL_BGR;
 		break;
 	case DRM_FORMAT_ABGR1555:
 	case DRM_FORMAT_XBGR1555:
 		cntl |= CNTL_LCDBPP16;
+		if (priv->variant->st_bitmux_control)
+			cntl |= CNTL_ST_1XBPP_5551 | CNTL_BGR;
 		break;
 	case DRM_FORMAT_ARGB1555:
 	case DRM_FORMAT_XRGB1555:
-		cntl |= CNTL_LCDBPP16 | CNTL_BGR;
+		cntl |= CNTL_LCDBPP16;
+		if (priv->variant->st_bitmux_control)
+			cntl |= CNTL_ST_1XBPP_5551;
+		else
+			cntl |= CNTL_BGR;
 		break;
 	case DRM_FORMAT_ABGR4444:
 	case DRM_FORMAT_XBGR4444:
 		cntl |= CNTL_LCDBPP16_444;
+		if (priv->variant->st_bitmux_control)
+			cntl |= CNTL_ST_1XBPP_444 | CNTL_BGR;
 		break;
 	case DRM_FORMAT_ARGB4444:
 	case DRM_FORMAT_XRGB4444:
-		cntl |= CNTL_LCDBPP16_444 | CNTL_BGR;
+		cntl |= CNTL_LCDBPP16_444;
+		if (priv->variant->st_bitmux_control)
+			cntl |= CNTL_ST_1XBPP_444;
+		else
+			cntl |= CNTL_BGR;
 		break;
 	default:
 		WARN_ONCE(true, "Unknown FB format 0x%08x\n",
diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index ce4501d0ab48..1aa015ccacef 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -36,11 +36,14 @@ struct drm_minor;
  * struct pl111_variant_data - encodes IP differences
  * @name: the name of this variant
  * @is_pl110: this is the early PL110 variant
+ * @is_lcdc: this is the ST Microelectronics Nomadik LCDC variant
  * @external_bgr: this is the Versatile Pl110 variant with external
  *	BGR/RGB routing
  * @broken_clockdivider: the clock divider is broken and we need to
  *	use the supplied clock directly
  * @broken_vblank: the vblank IRQ is broken on this variant
+ * @st_bitmux_control: this variant is using the ST Micro bitmux
+ *	extensions to the control register
  * @formats: array of supported pixel formats on this variant
  * @nformats: the length of the array of supported pixel formats
  * @fb_bpp: desired bits per pixel on the default framebuffer
@@ -48,9 +51,11 @@ struct drm_minor;
 struct pl111_variant_data {
 	const char *name;
 	bool is_pl110;
+	bool is_lcdc;
 	bool external_bgr;
 	bool broken_clockdivider;
 	bool broken_vblank;
+	bool st_bitmux_control;
 	const u32 *formats;
 	unsigned int nformats;
 	unsigned int fb_bpp;
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 454ff0804642..46559b686abd 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -75,6 +75,7 @@
 
 #include "pl111_drm.h"
 #include "pl111_versatile.h"
+#include "pl111_nomadik.h"
 
 #define DRIVER_DESC      "DRM module for PL111"
 
@@ -288,8 +289,8 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 		priv->memory_bw = 0;
 	}
 
-	/* The two variants swap this register */
-	if (variant->is_pl110) {
+	/* The two main variants swap this register */
+	if (variant->is_pl110 || variant->is_lcdc) {
 		priv->ienb = CLCD_PL110_IENB;
 		priv->ctrl = CLCD_PL110_CNTL;
 	} else {
@@ -308,6 +309,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	ret = pl111_versatile_init(dev, priv);
 	if (ret)
 		goto dev_unref;
+	pl111_nomadik_init(dev);
 
 	/* turn off interrupts before requesting the irq */
 	writel(0, priv->regs + priv->ienb);
@@ -400,12 +402,47 @@ static const struct pl111_variant_data pl111_variant = {
 	.fb_bpp = 32,
 };
 
+static const u32 pl110_nomadik_pixel_formats[] = {
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_BGR565,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_XBGR1555,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_ABGR4444,
+	DRM_FORMAT_XBGR4444,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_XRGB4444,
+};
+
+static const struct pl111_variant_data pl110_nomadik_variant = {
+	.name = "LCDC (PL110 Nomadik)",
+	.formats = pl110_nomadik_pixel_formats,
+	.nformats = ARRAY_SIZE(pl110_nomadik_pixel_formats),
+	.is_lcdc = true,
+	.st_bitmux_control = true,
+	.broken_vblank = true,
+	.fb_bpp = 16,
+};
+
+
 static const struct amba_id pl111_id_table[] = {
 	{
 		.id = 0x00041110,
 		.mask = 0x000fffff,
 		.data = (void*)&pl110_variant,
 	},
+	{
+		.id = 0x00180110,
+		.mask = 0x00fffffe,
+		.data = (void*)&pl110_nomadik_variant,
+	},
 	{
 		.id = 0x00041111,
 		.mask = 0x000fffff,
diff --git a/drivers/gpu/drm/pl111/pl111_nomadik.c b/drivers/gpu/drm/pl111/pl111_nomadik.c
new file mode 100644
index 000000000000..6ade7ca9d367
--- /dev/null
+++ b/drivers/gpu/drm/pl111/pl111_nomadik.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include "pl111_nomadik.h"
+
+#define PMU_CTRL_OFFSET 0x0000
+#define PMU_CTRL_LCDNDIF BIT(26)
+
+void pl111_nomadik_init(struct device *dev)
+{
+	struct regmap *pmu_regmap;
+
+	/*
+	 * Just bail out of this is not found, we could be running
+	 * multiplatform on something else than Nomadik.
+	 */
+	pmu_regmap =
+		syscon_regmap_lookup_by_compatible("stericsson,nomadik-pmu");
+	if (IS_ERR(pmu_regmap))
+		return;
+
+	/*
+	 * This bit in the PMU controller multiplexes the two graphics
+	 * blocks found in the Nomadik STn8815. The other one is called
+	 * MDIF (Master Display Interface) and gets muxed out here.
+	 */
+	regmap_update_bits(pmu_regmap,
+			   PMU_CTRL_OFFSET,
+			   PMU_CTRL_LCDNDIF,
+			   0);
+	dev_info(dev, "set Nomadik PMU mux to CLCD mode\n");
+}
+EXPORT_SYMBOL_GPL(pl111_nomadik_init);
diff --git a/drivers/gpu/drm/pl111/pl111_nomadik.h b/drivers/gpu/drm/pl111/pl111_nomadik.h
new file mode 100644
index 000000000000..c408842a1c73
--- /dev/null
+++ b/drivers/gpu/drm/pl111/pl111_nomadik.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+
+#ifndef PL111_NOMADIK_H
+#define PL111_NOMADIK_H
+#endif
+
+#ifdef CONFIG_ARCH_NOMADIK
+
+void pl111_nomadik_init(struct device *dev);
+
+#else
+
+static inline void pl111_nomadik_init(struct device *dev)
+{
+}
+
+#endif
-- 
2.17.1
