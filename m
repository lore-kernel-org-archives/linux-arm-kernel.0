From: daniel.morsing@gmail.com (Daniel Morsing)
Date: Tue, 21 Dec 2010 11:23:13 +0100
Subject: [PATCH v2] OMAP2: Devkit8000: Use _cansleep GPIO functions for
	display reset lines
Message-ID: <1292926993.9611.10.camel@morsing>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display reset lines are connected to a TPS65930 which may sleep
when changing GPIO values. Use the appropriate function to silence
a nasty warning from gpiolib.

Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
Acked-by: Thomas Weber <weber@corscience.de>
---

Gmail destroyed the previous patch send, so resending with a sane client.

---
 arch/arm/mach-omap2/board-devkit8000.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 53ac762..f1f58f5 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -118,27 +118,27 @@ static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
 	twl_i2c_write_u8(TWL4030_MODULE_LED, 0x0, 0x0);
 
 	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value(dssdev->reset_gpio, 1);
+		gpio_set_value_cansleep(dssdev->reset_gpio, 1);
 	return 0;
 }
 
 static void devkit8000_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
 	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value(dssdev->reset_gpio, 0);
+		gpio_set_value_cansleep(dssdev->reset_gpio, 0);
 }
 
 static int devkit8000_panel_enable_dvi(struct omap_dss_device *dssdev)
 {
 	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value(dssdev->reset_gpio, 1);
+		gpio_set_value_cansleep(dssdev->reset_gpio, 1);
 	return 0;
 }
 
 static void devkit8000_panel_disable_dvi(struct omap_dss_device *dssdev)
 {
 	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value(dssdev->reset_gpio, 0);
+		gpio_set_value_cansleep(dssdev->reset_gpio, 0);
 }
 
 static struct regulator_consumer_supply devkit8000_vmmc1_supply =
-- 
1.7.3.3
