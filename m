From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 11:06:16 +0200
Subject: [PATCH 09/23] drm/panel: lvds: Add support for the power-supply
 property
In-Reply-To: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <6f688742088e5e873f8d392956e06e783667aa96.1508231063.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A significant number of panels need to power up a regulator in order to
operate properly. Add support for the power-supply property to enable and
disable such a regulator whenever needed.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/panel/panel-lvds.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index e2d57c01200b..57e38a9e7ab4 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #include <drm/drmP.h>
@@ -39,6 +40,7 @@ struct panel_lvds {
 	bool data_mirror;
 
 	struct backlight_device *backlight;
+	struct regulator *supply;
 
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *reset_gpio;
@@ -69,6 +71,9 @@ static int panel_lvds_unprepare(struct drm_panel *panel)
 	if (lvds->enable_gpio)
 		gpiod_set_value_cansleep(lvds->enable_gpio, 0);
 
+	if (lvds->supply)
+		regulator_disable(lvds->supply);
+
 	return 0;
 }
 
@@ -76,6 +81,17 @@ static int panel_lvds_prepare(struct drm_panel *panel)
 {
 	struct panel_lvds *lvds = to_panel_lvds(panel);
 
+	if (lvds->supply) {
+		int err;
+
+		err = regulator_enable(lvds->supply);
+		if (err < 0) {
+			dev_err(lvds->dev, "failed to enable supply: %d\n",
+				err);
+			return err;
+		}
+	}
+
 	if (lvds->enable_gpio)
 		gpiod_set_value_cansleep(lvds->enable_gpio, 1);
 
@@ -196,6 +212,13 @@ static int panel_lvds_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	lvds->supply = devm_regulator_get_optional(lvds->dev, "power");
+	if (IS_ERR(lvds->supply)) {
+		ret = PTR_ERR(lvds->supply);
+		dev_err(lvds->dev, "failed to request regulator: %d\n", ret);
+		return ret;
+	}
+
 	/* Get GPIOs and backlight controller. */
 	lvds->enable_gpio = devm_gpiod_get_optional(lvds->dev, "enable",
 						     GPIOD_OUT_LOW);
-- 
git-series 0.9.1
