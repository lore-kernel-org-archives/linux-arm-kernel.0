From: david@lechnology.com (David Lechner)
Date: Sat, 29 Jul 2017 14:17:45 -0500
Subject: [PATCH 1/6] drm/tinydrm: Add parameter for MIPI DCS pixel format
In-Reply-To: <1501355870-13960-1-git-send-email-david@lechnology.com>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
Message-ID: <1501355870-13960-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a parameter for MIPI DCS pixel format to mipi_dbi_init().
This is in preparation for supporting displays that don't use a 16bpp
memory layout.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/tinydrm/mi0283qt.c |  3 ++-
 drivers/gpu/drm/tinydrm/mipi-dbi.c | 21 ++++++++++++++++++---
 include/drm/tinydrm/mipi-dbi.h     |  7 ++++++-
 include/video/mipi_display.h       | 14 ++++++++------
 4 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tinydrm/mi0283qt.c b/drivers/gpu/drm/tinydrm/mi0283qt.c
index 482ff1c3..2680dab 100644
--- a/drivers/gpu/drm/tinydrm/mi0283qt.c
+++ b/drivers/gpu/drm/tinydrm/mi0283qt.c
@@ -196,7 +196,8 @@ static int mi0283qt_probe(struct spi_device *spi)
 	device_property_read_u32(dev, "rotation", &rotation);
 
 	ret = mipi_dbi_spi_init(spi, mipi, dc, &mi0283qt_pipe_funcs,
-				&mi0283qt_driver, &mi0283qt_mode, rotation);
+				&mi0283qt_driver, &mi0283qt_mode,
+				MIPI_DCS_PIXEL_FMT_16BIT, rotation);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
index c83eeb7..7d49366 100644
--- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
+++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
@@ -336,6 +336,7 @@ static const uint32_t mipi_dbi_formats[] = {
  * @pipe_funcs: Display pipe functions
  * @driver: DRM driver
  * @mode: Display mode
+ * @pixel_fmt: The display memory's pixel format
  * @rotation: Initial rotation in degrees Counter Clock Wise
  *
  * This function initializes a &mipi_dbi structure and it's underlying
@@ -352,15 +353,26 @@ static const uint32_t mipi_dbi_formats[] = {
 int mipi_dbi_init(struct device *dev, struct mipi_dbi *mipi,
 		  const struct drm_simple_display_pipe_funcs *pipe_funcs,
 		  struct drm_driver *driver,
-		  const struct drm_display_mode *mode, unsigned int rotation)
+		  const struct drm_display_mode *mode,
+		  enum mipi_dcs_pixel_format pixel_fmt, unsigned int rotation)
 {
-	size_t bufsize = mode->vdisplay * mode->hdisplay * sizeof(u16);
 	struct tinydrm_device *tdev = &mipi->tinydrm;
+	size_t bufsize;
 	int ret;
 
 	if (!mipi->command)
 		return -EINVAL;
 
+	switch (pixel_fmt) {
+	case MIPI_DCS_PIXEL_FMT_16BIT:
+		bufsize = mode->vdisplay * mode->hdisplay * sizeof(u16);
+		break;
+	default:
+		DRM_ERROR("Pixel format is not supported\n");
+		return -EINVAL;
+	}
+	mipi->pixel_fmt = pixel_fmt;
+
 	mutex_init(&mipi->cmdlock);
 
 	mipi->tx_buf = devm_kmalloc(dev, bufsize, GFP_KERNEL);
@@ -781,6 +793,7 @@ static int mipi_dbi_typec3_command(struct mipi_dbi *mipi, u8 cmd,
  * @pipe_funcs: Display pipe functions
  * @driver: DRM driver
  * @mode: Display mode
+ * @pixel_fmt: The display memory's pixel format
  * @rotation: Initial rotation in degrees Counter Clock Wise
  *
  * This function sets &mipi_dbi->command, enables &mipi->read_commands for the
@@ -803,6 +816,7 @@ int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *mipi,
 		      const struct drm_simple_display_pipe_funcs *pipe_funcs,
 		      struct drm_driver *driver,
 		      const struct drm_display_mode *mode,
+		      enum mipi_dcs_pixel_format pixel_fmt,
 		      unsigned int rotation)
 {
 	size_t tx_size = tinydrm_spi_max_transfer_size(spi, 0);
@@ -849,7 +863,8 @@ int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *mipi,
 			return -ENOMEM;
 	}
 
-	return mipi_dbi_init(dev, mipi, pipe_funcs, driver, mode, rotation);
+	return mipi_dbi_init(dev, mipi, pipe_funcs, driver, mode, pixel_fmt,
+			     rotation);
 }
 EXPORT_SYMBOL(mipi_dbi_spi_init);
 
diff --git a/include/drm/tinydrm/mipi-dbi.h b/include/drm/tinydrm/mipi-dbi.h
index d137b16..dda100c 100644
--- a/include/drm/tinydrm/mipi-dbi.h
+++ b/include/drm/tinydrm/mipi-dbi.h
@@ -13,6 +13,7 @@
 #define __LINUX_MIPI_DBI_H
 
 #include <drm/tinydrm/tinydrm.h>
+#include <video/mipi_display.h>
 
 struct spi_device;
 struct gpio_desc;
@@ -33,6 +34,7 @@ struct regulator;
  * @tx_buf9_len: Size of tx_buf9.
  * @swap_bytes: Swap bytes in buffer before transfer
  * @reset: Optional reset gpio
+ * @pixel_fmt: The display memory's pixel format
  * @rotation: initial rotation in degrees Counter Clock Wise
  * @backlight: backlight device (optional)
  * @regulator: power regulator (optional)
@@ -50,6 +52,7 @@ struct mipi_dbi {
 	size_t tx_buf9_len;
 	bool swap_bytes;
 	struct gpio_desc *reset;
+	enum mipi_dcs_pixel_format pixel_fmt;
 	unsigned int rotation;
 	struct backlight_device *backlight;
 	struct regulator *regulator;
@@ -66,11 +69,13 @@ int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *mipi,
 		      const struct drm_simple_display_pipe_funcs *pipe_funcs,
 		      struct drm_driver *driver,
 		      const struct drm_display_mode *mode,
+		      enum mipi_dcs_pixel_format pixel_fmt,
 		      unsigned int rotation);
 int mipi_dbi_init(struct device *dev, struct mipi_dbi *mipi,
 		  const struct drm_simple_display_pipe_funcs *pipe_funcs,
 		  struct drm_driver *driver,
-		  const struct drm_display_mode *mode, unsigned int rotation);
+		  const struct drm_display_mode *mode,
+		  enum mipi_dcs_pixel_format pixel_fmt, unsigned int rotation);
 void mipi_dbi_pipe_enable(struct drm_simple_display_pipe *pipe,
 			  struct drm_crtc_state *crtc_state);
 void mipi_dbi_pipe_disable(struct drm_simple_display_pipe *pipe);
diff --git a/include/video/mipi_display.h b/include/video/mipi_display.h
index 19aa65a..84b70cd 100644
--- a/include/video/mipi_display.h
+++ b/include/video/mipi_display.h
@@ -128,11 +128,13 @@ enum {
 };
 
 /* MIPI DCS pixel formats */
-#define MIPI_DCS_PIXEL_FMT_24BIT	7
-#define MIPI_DCS_PIXEL_FMT_18BIT	6
-#define MIPI_DCS_PIXEL_FMT_16BIT	5
-#define MIPI_DCS_PIXEL_FMT_12BIT	3
-#define MIPI_DCS_PIXEL_FMT_8BIT		2
-#define MIPI_DCS_PIXEL_FMT_3BIT		1
+enum mipi_dcs_pixel_format {
+	MIPI_DCS_PIXEL_FMT_24BIT	= 7,
+	MIPI_DCS_PIXEL_FMT_18BIT	= 6,
+	MIPI_DCS_PIXEL_FMT_16BIT	= 5,
+	MIPI_DCS_PIXEL_FMT_12BIT	= 3,
+	MIPI_DCS_PIXEL_FMT_8BIT		= 2,
+	MIPI_DCS_PIXEL_FMT_3BIT		= 1,
+};
 
 #endif
-- 
2.7.4
