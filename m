From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Jan 2018 14:22:20 +0100
Subject: [PATCH] drm/pl111: Use max memory bandwidth for resolution
Message-ID: <20180123132220.29886-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We were previously selecting 1024x768 and 32BPP as the default
set-up for the PL111 consumers.

This does not work on elder systems: the device tree bindings
support a property "max-memory-bandwidth" in bytes/second that
states that if you exceed this the memory bus will saturate.
The result is flickering and unstable images.

Parse the "max-memory-bandwidth" and respect it when
intializing the driver. On the RealView PB11MP we get a nice
1024x768 console with RGB565 as default with this code.

If the device tree does not specify the maximum memory
bandwidth we keep the old assumption that we can support
1024x768, 32BPP.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_drm.h |  1 +
 drivers/gpu/drm/pl111/pl111_drv.c | 99 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index 440f53ebee8c..770ef5ce3645 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -56,6 +56,7 @@ struct pl111_drm_dev_private {
 	struct drm_fbdev_cma *fbdev;
 
 	void *regs;
+	u32 memory_bw;
 	u32 ienb;
 	u32 ctrl;
 	/* The pixel clock (a reference to our clock divider off of CLCDCLK). */
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 101a9c7db6ff..1b47ee67097d 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -58,6 +58,7 @@
 #include <linux/dma-buf.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
@@ -80,21 +81,107 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
+/**
+ * pl111_choose_max_resolution() - choose max resolution
+ * @dev: DRM device
+ * @memory_bw: the graphics maximum memory bandwidth in bytes/s
+ * @max_width: returns the maximum width
+ * @max_height: returns the maximum height
+ * @bpp: returns the maximum bips per pixed (32 or 16)
+ *
+ * This function attempts to cut down the maximum supported resolution
+ * to something the system memory bus can handle. The PL111 and pixel
+ * clocks may be able to support higher resolutions and color depths
+ * but as we go up the memory bus get saturated and becomes the
+ * bottleneck for the resolution. On several systems using e.g.
+ * 1024x768 with 32 BPP results in instable flickering images.
+ */
+static void pl111_choose_max_resolution(struct drm_device *dev,
+					u32 memory_bw,
+					int *max_width,
+					int *max_height,
+					unsigned int *bpp)
+{
+	/* No limitations, this is the most aggressive */
+	if (!memory_bw) {
+		*max_width = 1024;
+		*max_height = 768;
+		*bpp = 32;
+		return;
+	}
+
+	/*
+	 * 1024x768 with RGBX8888 requires a memory bandwidth of
+	 * 65Mhz * 4 bytes = 260000000 bytes per second.
+	 */
+	if (memory_bw >= 260000000) {
+		*max_width = 1024;
+		*max_height = 768;
+		*bpp = 32;
+		return;
+	}
+
+	/*
+	 * 800x600 with RGB8888 requires a memory bandwidth of
+	 * 36Mhz * 4 bytes = 144000000 bytes per second. But we
+	 * assume the user prefer higher resolution over more
+	 * color depth, so we do not add this mode here.
+	 */
+
+	/*
+	 * 1024x768 with RGB565 requires a memory bandwidth of
+	 * 65Mhz * 2 bytes = 130000000 bytes per second.
+	 */
+	if (memory_bw >= 130000000) {
+		*max_width = 1024;
+		*max_height = 768;
+		*bpp = 16;
+		return;
+	}
+
+	/*
+	 * 800x600 with RGB565 requires a memory bandwidth of
+	 * 36Mhz * 2 bytes = 72000000 bytes per second.
+	 */
+	if (memory_bw >= 72000000) {
+		*max_width = 800;
+		*max_height = 600;
+		*bpp = 16;
+		return;
+	}
+
+	/*
+	 * 640x480 with RGB565 requires a memory bandwidth of
+	 * 25.175Mhz * 2 bytes = 50350000 bytes per second.
+	 */
+	if (memory_bw < 50350000)
+		dev_err(dev->dev, "can't even do 640x480 VGA RGB565, proceed anyway\n");
+
+	*max_width = 640;
+	*max_height = 480;
+	*bpp = 16;
+}
+
 static int pl111_modeset_init(struct drm_device *dev)
 {
 	struct drm_mode_config *mode_config;
 	struct pl111_drm_dev_private *priv = dev->dev_private;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
+	unsigned int bpp; /* bits per pixel */
 	int ret = 0;
 
 	drm_mode_config_init(dev);
 	mode_config = &dev->mode_config;
 	mode_config->funcs = &mode_config_funcs;
 	mode_config->min_width = 1;
-	mode_config->max_width = 1024;
 	mode_config->min_height = 1;
-	mode_config->max_height = 768;
+
+	pl111_choose_max_resolution(dev, priv->memory_bw,
+				    &mode_config->max_width,
+				    &mode_config->max_height, &bpp);
+	dev_info(dev->dev, "cap resolution at %u x %u, %u BPP\n",
+		 mode_config->max_width, mode_config->max_height, bpp);
 
 	ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
 					  0, 0, &panel, &bridge);
@@ -139,7 +226,7 @@ static int pl111_modeset_init(struct drm_device *dev)
 
 	drm_mode_config_reset(dev);
 
-	priv->fbdev = drm_fbdev_cma_init(dev, 32,
+	priv->fbdev = drm_fbdev_cma_init(dev, bpp,
 					 dev->mode_config.num_connector);
 
 	drm_kms_helper_poll_init(dev);
@@ -216,6 +303,12 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	drm->dev_private = priv;
 	priv->variant = variant;
 
+	if (of_property_read_u32(dev->of_node, "max-memory-bandwidth",
+				 &priv->memory_bw)) {
+		dev_info(dev, "no max memory bandwidth specified, assume unlimited\n");
+		priv->memory_bw = 0;
+	}
+
 	/*
 	 * The PL110 and PL111 variants have two registers
 	 * swapped: interrupt enable and control. For this reason
-- 
2.14.3
