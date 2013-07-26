From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 26 Jul 2013 10:08:16 +0300
Subject: [PATCH 13/21] ARM: OMAP: igep0020: use new display drivers
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1374822504-28949-14-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use new display drivers for igep0020 board.

The new OMAP display drivers were merged for 3.11, and we can now change
the board files to use the new ones and phase out the old ones.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-igep0020.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 87e65dd..06dbb2d 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -429,31 +429,39 @@ static struct twl4030_gpio_platform_data igep_twl4030_gpio_pdata = {
 	.setup		= igep_twl_gpio_setup,
 };
 
-static struct tfp410_platform_data dvi_panel = {
-	.i2c_bus_num		= 3,
-	.power_down_gpio	= IGEP2_GPIO_DVI_PUP,
+static struct connector_dvi_platform_data omap3stalker_dvi_connector_pdata = {
+	.name                   = "dvi",
+	.source                 = "tfp410.0",
+	.i2c_bus_num            = 3,
 };
 
-static struct omap_dss_device igep2_dvi_device = {
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.name			= "dvi",
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
+static struct platform_device omap3stalker_dvi_connector_device = {
+	.name                   = "connector-dvi",
+	.id                     = 0,
+	.dev.platform_data      = &omap3stalker_dvi_connector_pdata,
 };
 
-static struct omap_dss_device *igep2_dss_devices[] = {
-	&igep2_dvi_device
+static struct encoder_tfp410_platform_data omap3stalker_tfp410_pdata = {
+	.name                   = "tfp410.0",
+	.source                 = "dpi.0",
+	.data_lines             = 24,
+	.power_down_gpio        = IGEP2_GPIO_DVI_PUP,
+};
+
+static struct platform_device omap3stalker_tfp410_device = {
+	.name                   = "tfp410",
+	.id                     = 0,
+	.dev.platform_data      = &omap3stalker_tfp410_pdata,
 };
 
 static struct omap_dss_board_info igep2_dss_data = {
-	.num_devices	= ARRAY_SIZE(igep2_dss_devices),
-	.devices	= igep2_dss_devices,
-	.default_device	= &igep2_dvi_device,
+	.default_display_name = "dvi",
 };
 
 static struct platform_device *igep_devices[] __initdata = {
 	&igep_vwlan_device,
+	&omap3stalker_tfp410_device,
+	&omap3stalker_dvi_connector_device,
 };
 
 static int igep2_keymap[] = {
-- 
1.8.1.2
