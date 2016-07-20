From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 20 Jul 2016 11:18:49 +0800
Subject: [PATCH 1/2] drm/panel: add of display timing support
Message-ID: <1468984730-23186-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want add display support on loader, share the same timing
with kernel side, but the timing is hide into kernel code,
can't be share, avoid config twice display timing, add device-tree
display timing support would be good idea.

With this patch, loader and kernel can share same timing from
device node.

Cc: Thierry Reding <thierry.reding@gmail.com>

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 73 ++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 85143d1..04cd797 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -34,6 +34,7 @@
 #include <drm/drm_panel.h>
 
 #include <video/display_timing.h>
+#include <video/of_display_timing.h>
 #include <video/videomode.h>
 
 struct panel_desc {
@@ -80,6 +81,7 @@ struct panel_simple {
 	bool prepared;
 	bool enabled;
 
+	struct device *dev;
 	const struct panel_desc *desc;
 
 	struct backlight_device *backlight;
@@ -159,6 +161,32 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
 	return num;
 }
 
+static int panel_simple_of_get_native_mode(struct panel_simple *panel)
+{
+	struct drm_connector *connector = panel->base.connector;
+	struct drm_device *drm = panel->base.drm;
+	struct drm_display_mode *mode;
+	int ret;
+
+	mode = drm_mode_create(drm);
+	if (!mode)
+		return 0;
+
+	ret = of_get_drm_display_mode(panel->dev->of_node, mode,
+				      OF_USE_NATIVE_MODE);
+	if (ret) {
+		dev_dbg(panel->dev, "failed to find dts display timings\n");
+		drm_mode_destroy(drm, mode);
+		return 0;
+	}
+
+	drm_mode_set_name(mode);
+	mode->type |= DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
 static int panel_simple_disable(struct drm_panel *panel)
 {
 	struct panel_simple *p = to_panel_simple(panel);
@@ -172,7 +200,7 @@ static int panel_simple_disable(struct drm_panel *panel)
 		backlight_update_status(p->backlight);
 	}
 
-	if (p->desc->delay.disable)
+	if (p->desc && p->desc->delay.disable)
 		msleep(p->desc->delay.disable);
 
 	p->enabled = false;
@@ -192,7 +220,7 @@ static int panel_simple_unprepare(struct drm_panel *panel)
 
 	regulator_disable(p->supply);
 
-	if (p->desc->delay.unprepare)
+	if (p->desc && p->desc->delay.unprepare)
 		msleep(p->desc->delay.unprepare);
 
 	p->prepared = false;
@@ -217,7 +245,7 @@ static int panel_simple_prepare(struct drm_panel *panel)
 	if (p->enable_gpio)
 		gpiod_set_value_cansleep(p->enable_gpio, 1);
 
-	if (p->desc->delay.prepare)
+	if (p->desc && p->desc->delay.prepare)
 		msleep(p->desc->delay.prepare);
 
 	p->prepared = true;
@@ -232,7 +260,7 @@ static int panel_simple_enable(struct drm_panel *panel)
 	if (p->enabled)
 		return 0;
 
-	if (p->desc->delay.enable)
+	if (p->desc && p->desc->delay.enable)
 		msleep(p->desc->delay.enable);
 
 	if (p->backlight) {
@@ -264,6 +292,9 @@ static int panel_simple_get_modes(struct drm_panel *panel)
 	/* add hard-coded panel modes */
 	num += panel_simple_get_fixed_modes(p);
 
+	/* add device node plane modes */
+	num += panel_simple_of_get_native_mode(p);
+
 	return num;
 }
 
@@ -274,6 +305,9 @@ static int panel_simple_get_timings(struct drm_panel *panel,
 	struct panel_simple *p = to_panel_simple(panel);
 	unsigned int i;
 
+	if (!p->desc)
+		return 0;
+
 	if (p->desc->num_timings < num_timings)
 		num_timings = p->desc->num_timings;
 
@@ -306,6 +340,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 	panel->enabled = false;
 	panel->prepared = false;
 	panel->desc = desc;
+	panel->dev = dev;
 
 	panel->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(panel->supply))
@@ -1515,6 +1550,9 @@ static const struct panel_desc urt_umsh_8596md_parallel = {
 
 static const struct of_device_id platform_of_match[] = {
 	{
+		.compatible = "simple-panel",
+		.data = NULL,
+	}, {
 		.compatible = "ampire,am800480r3tmqwa1h",
 		.data = &ampire_am800480r3tmqwa1h,
 	}, {
@@ -1860,6 +1898,9 @@ static const struct panel_desc_dsi panasonic_vvx10f004b00 = {
 
 static const struct of_device_id dsi_of_match[] = {
 	{
+		.compatible = "simple-panel-dsi",
+		.data = NULL
+	}, {
 		.compatible = "auo,b080uan01",
 		.data = &auo_b080uan01
 	}, {
@@ -1884,6 +1925,8 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
 {
 	const struct panel_desc_dsi *desc;
 	const struct of_device_id *id;
+	const struct panel_desc *pdesc;
+	u32 val;
 	int err;
 
 	id = of_match_node(dsi_of_match, dsi->dev.of_node);
@@ -1892,13 +1935,27 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
 
 	desc = id->data;
 
-	err = panel_simple_probe(&dsi->dev, &desc->desc);
+	if (desc) {
+		dsi->mode_flags = desc->flags;
+		dsi->format = desc->format;
+		dsi->lanes = desc->lanes;
+		pdesc = &desc->desc;
+	} else {
+		pdesc = NULL;
+	}
+
+	err = panel_simple_probe(&dsi->dev, pdesc);
 	if (err < 0)
 		return err;
 
-	dsi->mode_flags = desc->flags;
-	dsi->format = desc->format;
-	dsi->lanes = desc->lanes;
+	if (!of_property_read_u32(dsi->dev.of_node, "dsi,flags", &val))
+		dsi->mode_flags = val;
+
+	if (!of_property_read_u32(dsi->dev.of_node, "dsi,format", &val))
+		dsi->format = val;
+
+	if (!of_property_read_u32(dsi->dev.of_node, "dsi,lanes", &val))
+		dsi->lanes = val;
 
 	return mipi_dsi_attach(dsi);
 }
-- 
1.9.1
