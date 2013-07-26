From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 26 Jul 2013 10:08:18 +0300
Subject: [PATCH 15/21] ARM: OMAP: H4: use new display drivers
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1374822504-28949-16-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use new display drivers for H4 board.

The new OMAP display drivers were merged for 3.11, and we can now change
the board files to use the new ones and phase out the old ones.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-h4.c | 48 +++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 69c0acf..87e41a8 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -194,30 +194,48 @@ static struct platform_device h4_flash_device = {
 	.resource	= &h4_flash_resource,
 };
 
-static struct platform_device *h4_devices[] __initdata = {
-	&h4_flash_device,
+static const struct display_timing cm_t35_lcd_videomode = {
+	.pixelclock	= { 0, 6250000, 0 },
+
+	.hactive = { 0, 240, 0 },
+	.hfront_porch = { 0, 15, 0 },
+	.hback_porch = { 0, 60, 0 },
+	.hsync_len = { 0, 15, 0 },
+
+	.vactive = { 0, 320, 0 },
+	.vfront_porch = { 0, 1, 0 },
+	.vback_porch = { 0, 1, 0 },
+	.vsync_len = { 0, 1, 0 },
+
+	.flags = DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH |
+		DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE,
 };
 
-static struct panel_generic_dpi_data h4_panel_data = {
-	.name			= "h4",
+static struct panel_dpi_platform_data cm_t35_lcd_pdata = {
+	.name                   = "lcd",
+	.source                 = "dpi.0",
+
+	.data_lines		= 16,
+
+	.display_timing		= &cm_t35_lcd_videomode,
+
+	.enable_gpio		= -1,
+	.backlight_gpio		= -1,
 };
 
-static struct omap_dss_device h4_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "generic_dpi_panel",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.phy.dpi.data_lines	= 16,
-	.data			= &h4_panel_data,
+static struct platform_device cm_t35_lcd_device = {
+	.name                   = "panel-dpi",
+	.id                     = 0,
+	.dev.platform_data      = &cm_t35_lcd_pdata,
 };
 
-static struct omap_dss_device *h4_dss_devices[] = {
-	&h4_lcd_device,
+static struct platform_device *h4_devices[] __initdata = {
+	&h4_flash_device,
+	&cm_t35_lcd_device,
 };
 
 static struct omap_dss_board_info h4_dss_data = {
-	.num_devices	= ARRAY_SIZE(h4_dss_devices),
-	.devices	= h4_dss_devices,
-	.default_device	= &h4_lcd_device,
+	.default_display_name = "lcd",
 };
 
 /* 2420 Sysboot setup (2430 is different) */
-- 
1.8.1.2
