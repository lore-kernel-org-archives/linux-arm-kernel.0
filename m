From: jsarha@ti.com (Jyri Sarha)
Date: Wed, 31 Aug 2016 16:14:09 +0300
Subject: [PATCH v3 4/8] drm/tilcdc: Choose console BPP that supports RGB
In-Reply-To: <cover.1472634657.git.jsarha@ti.com>
References: <cover.1472634657.git.jsarha@ti.com>
Message-ID: <a23e06024e41eeae42cc421fa6c68ebb480ed7b8.1472634657.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Choose console BPP that supports RGB and remove the old fbdev bpp
selection code. LCDC on AM335x has red and blue wires switched between
24 bit and 16 bit colors. If 24 format is wired for RGB colors, the 16
bit format is wired for BGR. drm_fbdev_cma_init() does not currently
like anything else but RGB formats, so we must choose such bytes per
pixel value that supports RGB.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c      | 14 +++++---------
 drivers/gpu/drm/tilcdc/tilcdc_drv.h      |  1 -
 drivers/gpu/drm/tilcdc/tilcdc_external.c |  7 +++----
 drivers/gpu/drm/tilcdc/tilcdc_external.h |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel.c    |  2 --
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c   |  2 --
 6 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 4371537..9a55ea2 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -240,7 +240,6 @@ static int tilcdc_load(struct drm_device *dev, unsigned long flags)
 	struct platform_device *pdev = dev->platformdev;
 	struct device_node *node = pdev->dev.of_node;
 	struct tilcdc_drm_private *priv;
-	struct tilcdc_module *mod;
 	struct resource *res;
 	u32 bpp = 0;
 	int ret;
@@ -336,6 +335,7 @@ static int tilcdc_load(struct drm_device *dev, unsigned long flags)
 		DBG("Revision 1 LCDC supports only RGB565 format");
 		priv->pixelformats = tilcdc_rev1_formats;
 		priv->num_pixelformats = ARRAY_SIZE(tilcdc_rev1_formats);
+		bpp = 16;
 	} else {
 		const char *str = "\0";
 
@@ -345,18 +345,21 @@ static int tilcdc_load(struct drm_device *dev, unsigned long flags)
 			priv->pixelformats = tilcdc_crossed_formats;
 			priv->num_pixelformats =
 				ARRAY_SIZE(tilcdc_crossed_formats);
+			bpp = 32; /* Choose bpp with RGB support for fbdef */
 		} else if(0 == strcmp(str, "default") ||
 			  0 == strcmp(str, "straight")) {
 			DBG("Configured for straight blue and red wires");
 			priv->pixelformats = tilcdc_straight_formats;
 			priv->num_pixelformats =
 				ARRAY_SIZE(tilcdc_straight_formats);
+			bpp = 16; /* Choose bpp with RGB support for fbdef */
 		} else {
 			DBG("Blue and red wiring '%s' unknown, use legacy mode",
 			    str);
 			priv->pixelformats = tilcdc_legacy_formats;
 			priv->num_pixelformats =
 				ARRAY_SIZE(tilcdc_legacy_formats);
+			bpp = 16; /* This is just a guess */
 		}
 	}
 
@@ -373,7 +376,7 @@ static int tilcdc_load(struct drm_device *dev, unsigned long flags)
 		if (ret < 0)
 			goto fail_mode_config_cleanup;
 
-		ret = tilcdc_add_external_encoders(dev, &bpp);
+		ret = tilcdc_add_external_encoders(dev);
 		if (ret < 0)
 			goto fail_component_cleanup;
 	}
@@ -396,13 +399,6 @@ static int tilcdc_load(struct drm_device *dev, unsigned long flags)
 		goto fail_vblank_cleanup;
 	}
 
-	list_for_each_entry(mod, &module_list, list) {
-		DBG("%s: preferred_bpp: %d", mod->name, mod->preferred_bpp);
-		bpp = mod->preferred_bpp;
-		if (bpp > 0)
-			break;
-	}
-
 	drm_mode_config_reset(dev);
 
 	priv->fbdev = drm_fbdev_cma_init(dev, bpp,
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
index 0e19c14..a6e5e6d 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
@@ -116,7 +116,6 @@ struct tilcdc_module {
 	const char *name;
 	struct list_head list;
 	const struct tilcdc_module_ops *funcs;
-	unsigned int preferred_bpp;
 };
 
 void tilcdc_module_init(struct tilcdc_module *mod, const char *name,
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.c b/drivers/gpu/drm/tilcdc/tilcdc_external.c
index 849b23e..68e8950 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_external.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_external.c
@@ -52,7 +52,7 @@ static int tilcdc_external_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-static int tilcdc_add_external_encoder(struct drm_device *dev, int *bpp,
+static int tilcdc_add_external_encoder(struct drm_device *dev,
 				       struct drm_connector *connector)
 {
 	struct tilcdc_drm_private *priv = dev->dev_private;
@@ -64,7 +64,6 @@ static int tilcdc_add_external_encoder(struct drm_device *dev, int *bpp,
 	/* Only tda998x is supported at the moment. */
 	tilcdc_crtc_set_simulate_vesa_sync(priv->crtc, true);
 	tilcdc_crtc_set_panel_info(priv->crtc, &panel_info_tda998x);
-	*bpp = panel_info_tda998x.bpp;
 
 	connector_funcs = devm_kzalloc(dev->dev, sizeof(*connector_funcs),
 				       GFP_KERNEL);
@@ -94,7 +93,7 @@ static int tilcdc_add_external_encoder(struct drm_device *dev, int *bpp,
 	return 0;
 }
 
-int tilcdc_add_external_encoders(struct drm_device *dev, int *bpp)
+int tilcdc_add_external_encoders(struct drm_device *dev)
 {
 	struct tilcdc_drm_private *priv = dev->dev_private;
 	struct drm_connector *connector;
@@ -108,7 +107,7 @@ int tilcdc_add_external_encoders(struct drm_device *dev, int *bpp)
 			if (connector == priv->connectors[i])
 				found = true;
 		if (!found) {
-			ret = tilcdc_add_external_encoder(dev, bpp, connector);
+			ret = tilcdc_add_external_encoder(dev, connector);
 			if (ret)
 				return ret;
 		}
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.h b/drivers/gpu/drm/tilcdc/tilcdc_external.h
index 6aabe27..c700e0c 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_external.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_external.h
@@ -18,7 +18,7 @@
 #ifndef __TILCDC_EXTERNAL_H__
 #define __TILCDC_EXTERNAL_H__
 
-int tilcdc_add_external_encoders(struct drm_device *dev, int *bpp);
+int tilcdc_add_external_encoders(struct drm_device *dev);
 void tilcdc_remove_external_encoders(struct drm_device *dev);
 int tilcdc_get_external_components(struct device *dev,
 				   struct component_match **match);
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 4ac1d25..7b36509 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -397,8 +397,6 @@ static int panel_probe(struct platform_device *pdev)
 		goto fail_timings;
 	}
 
-	mod->preferred_bpp = panel_mod->info->bpp;
-
 	return 0;
 
 fail_timings:
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
index 3faf735..6e64a4f 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
@@ -329,8 +329,6 @@ static int tfp410_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	mod->preferred_bpp = dvi_info.bpp;
-
 	i2c_node = of_find_node_by_phandle(i2c_phandle);
 	if (!i2c_node) {
 		dev_err(&pdev->dev, "could not get i2c bus node\n");
-- 
1.9.1
