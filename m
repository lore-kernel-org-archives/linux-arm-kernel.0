From: david@lechnology.com (David Lechner)
Date: Thu,  3 Aug 2017 17:33:45 -0500
Subject: [PATCH v3 1/6] drm/tinydrm: remove call to mipi_dbi_init() from
 mipi_dbi_spi_init()
In-Reply-To: <1501799630-1650-1-git-send-email-david@lechnology.com>
References: <1501799630-1650-1-git-send-email-david@lechnology.com>
Message-ID: <1501799630-1650-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the call to mipi_dbi_init() from mipi_dbi_spi_init() so that
drivers can have a driver-specific implementation if needed.

Suggested-by: Noralf Tr?nnes <noralf@tronnes.org>
Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Noralf Tr?nnes <noralf@tronnes.org>
---
 drivers/gpu/drm/tinydrm/mi0283qt.c |  8 ++++++--
 drivers/gpu/drm/tinydrm/mipi-dbi.c | 17 +++++------------
 include/drm/tinydrm/mipi-dbi.h     |  6 +-----
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/tinydrm/mi0283qt.c b/drivers/gpu/drm/tinydrm/mi0283qt.c
index 482ff1c3..7e5bb7d 100644
--- a/drivers/gpu/drm/tinydrm/mi0283qt.c
+++ b/drivers/gpu/drm/tinydrm/mi0283qt.c
@@ -195,8 +195,12 @@ static int mi0283qt_probe(struct spi_device *spi)
 
 	device_property_read_u32(dev, "rotation", &rotation);
 
-	ret = mipi_dbi_spi_init(spi, mipi, dc, &mi0283qt_pipe_funcs,
-				&mi0283qt_driver, &mi0283qt_mode, rotation);
+	ret = mipi_dbi_spi_init(spi, mipi, dc);
+	if (ret)
+		return ret;
+
+	ret = mipi_dbi_init(&spi->dev, mipi, &mi0283qt_pipe_funcs,
+			    &mi0283qt_driver, &mi0283qt_mode, rotation);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
index e10fa4b..cba9784 100644
--- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
+++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
@@ -777,15 +777,12 @@ static int mipi_dbi_typec3_command(struct mipi_dbi *mipi, u8 cmd,
 /**
  * mipi_dbi_spi_init - Initialize MIPI DBI SPI interfaced controller
  * @spi: SPI device
- * @dc: D/C gpio (optional)
  * @mipi: &mipi_dbi structure to initialize
- * @pipe_funcs: Display pipe functions
- * @driver: DRM driver
- * @mode: Display mode
- * @rotation: Initial rotation in degrees Counter Clock Wise
+ * @dc: D/C gpio (optional)
  *
  * This function sets &mipi_dbi->command, enables &mipi->read_commands for the
- * usual read commands and initializes @mipi using mipi_dbi_init().
+ * usual read commands. It should be followed by a call to mipi_dbi_init() or
+ * a driver-specific init.
  *
  * If @dc is set, a Type C Option 3 interface is assumed, if not
  * Type C Option 1.
@@ -800,11 +797,7 @@ static int mipi_dbi_typec3_command(struct mipi_dbi *mipi, u8 cmd,
  * Zero on success, negative error code on failure.
  */
 int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *mipi,
-		      struct gpio_desc *dc,
-		      const struct drm_simple_display_pipe_funcs *pipe_funcs,
-		      struct drm_driver *driver,
-		      const struct drm_display_mode *mode,
-		      unsigned int rotation)
+		      struct gpio_desc *dc)
 {
 	size_t tx_size = tinydrm_spi_max_transfer_size(spi, 0);
 	struct device *dev = &spi->dev;
@@ -850,7 +843,7 @@ int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *mipi,
 			return -ENOMEM;
 	}
 
-	return mipi_dbi_init(dev, mipi, pipe_funcs, driver, mode, rotation);
+	return 0;
 }
 EXPORT_SYMBOL(mipi_dbi_spi_init);
 
diff --git a/include/drm/tinydrm/mipi-dbi.h b/include/drm/tinydrm/mipi-dbi.h
index d137b16..83346dd 100644
--- a/include/drm/tinydrm/mipi-dbi.h
+++ b/include/drm/tinydrm/mipi-dbi.h
@@ -62,11 +62,7 @@ mipi_dbi_from_tinydrm(struct tinydrm_device *tdev)
 }
 
 int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *mipi,
-		      struct gpio_desc *dc,
-		      const struct drm_simple_display_pipe_funcs *pipe_funcs,
-		      struct drm_driver *driver,
-		      const struct drm_display_mode *mode,
-		      unsigned int rotation);
+		      struct gpio_desc *dc);
 int mipi_dbi_init(struct device *dev, struct mipi_dbi *mipi,
 		  const struct drm_simple_display_pipe_funcs *pipe_funcs,
 		  struct drm_driver *driver,
-- 
2.7.4
