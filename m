From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 06 Oct 2013 23:10:56 +0100
Subject: [PATCH 4/5] DRM: Armada: start of MMP2/MMP3 support
In-Reply-To: <20131006220728.GG12758@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
Message-ID: <E1VSwXQ-0000iL-8N@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/Makefile      |    1 +
 drivers/gpu/drm/armada/armada_610.c  |   49 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/armada/armada_crtc.c |    1 +
 drivers/gpu/drm/armada/armada_drm.h  |    1 +
 drivers/gpu/drm/armada/armada_drv.c  |    6 ++++
 drivers/gpu/drm/armada/armada_hw.h   |    8 +++++
 6 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpu/drm/armada/armada_610.c

diff --git a/drivers/gpu/drm/armada/Makefile b/drivers/gpu/drm/armada/Makefile
index d6f43e0..088db4a 100644
--- a/drivers/gpu/drm/armada/Makefile
+++ b/drivers/gpu/drm/armada/Makefile
@@ -2,6 +2,7 @@ armada-y	:= armada_crtc.o armada_drv.o armada_fb.o armada_fbdev.o \
 		   armada_gem.o armada_output.o armada_overlay.o \
 		   armada_slave.o
 armada-y	+= armada_510.o
+armada-y	+= armada_610.o
 armada-$(CONFIG_DEBUG_FS) += armada_debugfs.o
 
 obj-$(CONFIG_DRM_ARMADA) := armada.o
diff --git a/drivers/gpu/drm/armada/armada_610.c b/drivers/gpu/drm/armada/armada_610.c
new file mode 100644
index 0000000..36a10e3
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_610.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Armada 610/MMP2/MMP3 variant support
+ */
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include "armada_crtc.h"
+#include "armada_drm.h"
+#include "armada_hw.h"
+
+static int mmp23_init(struct armada_private *priv, struct device *dev)
+{
+	priv->extclk[0] = devm_clk_get(dev, NULL);
+
+	if (IS_ERR(priv->extclk[0]) && PTR_ERR(priv->extclk[0]) == -ENOENT)
+		priv->extclk[0] = ERR_PTR(-EPROBE_DEFER);
+
+	return PTR_RET(priv->extclk[0]);
+}
+
+/*
+ * This gets called with sclk = NULL to test whether the mode is
+ * supportable, and again with sclk != NULL to set the clocks up for
+ * that.  The former can return an error, but the latter is expected
+ * not to.
+ */
+static int mmp23_crtc_compute_clock(struct armada_crtc *dcrtc,
+	const struct drm_display_mode *mode, uint32_t *sclk)
+{
+	/*
+	 * on MMP3 bits 31:29 select the clock, OLPC wants 0x1 here, LCD clock 1
+	 * on MMP2 bits 31:30 select the clock, OLPC wants 0x1 here, LCD clock 1
+	 */
+	*sclk = 0x20001100; // FIXME hardcoded mmp3 value
+
+	return 0;
+}
+
+const struct armada_variant mmp23_ops = {
+	.init = mmp23_init,
+	.crtc_compute_clock = mmp23_crtc_compute_clock,
+};
diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index e8605bf..b5877ee 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1054,6 +1054,7 @@ int armada_drm_crtc_create(struct drm_device *dev, unsigned num,
 	dcrtc->clk = ERR_PTR(-EINVAL);
 	dcrtc->csc_yuv_mode = CSC_AUTO;
 	dcrtc->csc_rgb_mode = CSC_AUTO;
+	/* FIXME: MMP2/MMP3: OLPC panel is RGB666 */
 	dcrtc->cfg_dumb_ctrl = DUMB24_RGB888_0;
 	dcrtc->spu_iopad_ctrl = CFG_VSCALE_LN_EN | CFG_IOPAD_DUMB24;
 	spin_lock_init(&dcrtc->irq_lock);
diff --git a/drivers/gpu/drm/armada/armada_drm.h b/drivers/gpu/drm/armada/armada_drm.h
index eef09ec..f52fccb 100644
--- a/drivers/gpu/drm/armada/armada_drm.h
+++ b/drivers/gpu/drm/armada/armada_drm.h
@@ -70,6 +70,7 @@ struct armada_variant {
 
 /* Variant ops */
 extern const struct armada_variant armada510_ops;
+extern const struct armada_variant mmp23_ops;
 
 struct armada_private {
 	const struct armada_variant *variant;
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 7bfab9a..db62f1b 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -344,6 +344,12 @@ static const struct platform_device_id armada_drm_platform_ids[] = {
 		.name		= "armada-drm",
 		.driver_data	= (unsigned long)&armada510_ops,
 	}, {
+		.name		= "armada-610-drm", /* aka MMP2 */
+		.driver_data	= (unsigned long)&mmp23_ops,
+	}, {
+		.name		= "mmp3-drm",
+		.driver_data	= (unsigned long)&mmp23_ops,
+	}, {
 		.name		= "armada-510-drm",
 		.driver_data	= (unsigned long)&armada510_ops,
 	},
diff --git a/drivers/gpu/drm/armada/armada_hw.h b/drivers/gpu/drm/armada/armada_hw.h
index 27319a8..1688716 100644
--- a/drivers/gpu/drm/armada/armada_hw.h
+++ b/drivers/gpu/drm/armada/armada_hw.h
@@ -74,6 +74,7 @@ enum {
 	LCD_SPU_IOPAD_CONTROL		= 0x01bc,
 	LCD_SPU_IRQ_ENA			= 0x01c0,
 	LCD_SPU_IRQ_ISR			= 0x01c4,
+	LCD_MISC_CNTL			= 0x01c8,	/* Armada 168 */
 };
 
 /* For LCD_SPU_ADV_REG */
@@ -211,6 +212,13 @@ enum {
 	SCLK_16X_PLL		= 0x8 << 28,
 	SCLK_16X_FRAC_DIV_MASK	= 0xfff << 16,
 	SCLK_16X_INT_DIV_MASK	= 0xffff << 0,
+
+	/* PXA910 / MMP2 (Armada 610) / MMP3 / PXA988 */
+	SCLK_MMP_SRC_SEL	= 1 << 31,
+	SCLK_MMP_DISABLE	= 1 << 28,
+	SCLK_MMP_FRAC_DIV_MASK	= 0xfff << 16,
+	SCLK_MMP_DSI_DIV_MASK	= 0xf << 8,
+	SCLK_MMP_INT_DIV_MASK	= 0xff << 0,
 };
 
 /* For LCD_SPU_DUMB_CTRL */
-- 
1.7.4.4
