From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Jul 2017 16:43:04 -0500
Subject: [PATCH] gpu: Convert to using %pOF instead of full_name
Message-ID: <20170718214339.7774-24-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: CK Hu <ck.hu@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mark Yao <mark.yao@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel at lists.freedesktop.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-amlogic at lists.infradead.org
Cc: linux-renesas-soc at vger.kernel.org
Cc: linux-rockchip at lists.infradead.org
---
 drivers/gpu/drm/armada/armada_crtc.c            |  3 +--
 drivers/gpu/drm/armada/armada_drv.c             |  4 ++--
 drivers/gpu/drm/drm_mipi_dsi.c                  |  6 +++---
 drivers/gpu/drm/drm_modes.c                     |  4 ++--
 drivers/gpu/drm/drm_of.c                        |  4 ++--
 drivers/gpu/drm/exynos/exynos_drm_dsi.c         |  3 +--
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c |  3 +--
 drivers/gpu/drm/mediatek/mtk_disp_color.c       |  4 ++--
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c         |  4 ++--
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c        |  4 ++--
 drivers/gpu/drm/mediatek/mtk_dpi.c              |  6 +++---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c         |  7 +++----
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c     |  6 ++----
 drivers/gpu/drm/mediatek/mtk_drm_drv.c          | 16 ++++++++--------
 drivers/gpu/drm/mediatek/mtk_dsi.c              |  4 ++--
 drivers/gpu/drm/mediatek/mtk_hdmi.c             |  8 ++++----
 drivers/gpu/drm/meson/meson_drv.c               |  5 ++---
 drivers/gpu/drm/panel/panel-lvds.c              | 16 ++++++++--------
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c       |  4 ++--
 drivers/gpu/drm/rcar-du/rcar_du_kms.c           | 16 ++++++++--------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c     |  4 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     |  4 ++--
 drivers/gpu/drm/stm/ltdc.c                      |  3 +--
 drivers/gpu/drm/sun4i/sun4i_drv.c               |  9 ++++-----
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c            |  4 ++--
 drivers/gpu/ipu-v3/ipu-common.c                 |  4 ++--
 26 files changed, 73 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index 4fe19fde84f9..85977c08879e 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1329,8 +1329,7 @@ armada_lcd_bind(struct device *dev, struct device *master, void *data)
 		port = of_get_child_by_name(parent, "port");
 		of_node_put(np);
 		if (!port) {
-			dev_err(dev, "no port node found in %s\n",
-				parent->full_name);
+			dev_err(dev, "no port node found in %pOF\n", parent);
 			return -ENXIO;
 		}

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index e618fab7f519..0b3227c039d7 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -232,8 +232,8 @@ static void armada_add_endpoints(struct device *dev,
 			of_node_put(remote);
 			continue;
 		} else if (!of_device_is_available(remote->parent)) {
-			dev_warn(dev, "parent device of %s is not available\n",
-				 remote->full_name);
+			dev_warn(dev, "parent device of %pOF is not available\n",
+				 remote);
 			of_node_put(remote);
 			continue;
 		}
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 1160a579e0dc..4b47226b90d4 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -165,14 +165,14 @@ of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 	u32 reg;

 	if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
-		dev_err(dev, "modalias failure on %s\n", node->full_name);
+		dev_err(dev, "modalias failure on %pOF\n", node);
 		return ERR_PTR(-EINVAL);
 	}

 	ret = of_property_read_u32(node, "reg", &reg);
 	if (ret) {
-		dev_err(dev, "device node %s has no valid reg property: %d\n",
-			node->full_name, ret);
+		dev_err(dev, "device node %pOF has no valid reg property: %d\n",
+			node, ret);
 		return ERR_PTR(-EINVAL);
 	}

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index f2493b9b82e6..a7f2a81c76f7 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -709,8 +709,8 @@ int of_get_drm_display_mode(struct device_node *np,
 	if (bus_flags)
 		drm_bus_flags_from_videomode(&vm, bus_flags);

-	pr_debug("%s: got %dx%d display mode from %s\n",
-		of_node_full_name(np), vm.hactive, vm.vactive, np->name);
+	pr_debug("%pOF: got %dx%d display mode from %s\n",
+		np, vm.hactive, vm.vactive, np->name);
 	drm_mode_debug_printmodeline(dmode);

 	return 0;
diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 2120f33bdf4a..8dafbdfcd2ea 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -160,8 +160,8 @@ int drm_of_component_probe(struct device *dev,
 				of_node_put(remote);
 				continue;
 			} else if (!of_device_is_available(remote->parent)) {
-				dev_warn(dev, "parent device of %s is not available\n",
-					 remote->full_name);
+				dev_warn(dev, "parent device of %pOF is not available\n",
+					 remote);
 				of_node_put(remote);
 				continue;
 			}
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index a11b79596e2f..f580be170089 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1618,8 +1618,7 @@ static int exynos_dsi_of_read_u32(const struct device_node *np,
 	int ret = of_property_read_u32(np, propname, out_value);

 	if (ret < 0)
-		pr_err("%s: failed to get '%s' property\n", np->full_name,
-		       propname);
+		pr_err("%pOF: failed to get '%s' property\n", np, propname);

 	return ret;
 }
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index c96c228a9898..a9e6db024131 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -583,8 +583,7 @@ static int ade_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 	 */
 	port = of_get_child_by_name(dev->dev->of_node, "port");
 	if (!port) {
-		DRM_ERROR("no port node found in %s\n",
-			  dev->dev->of_node->full_name);
+		DRM_ERROR("no port node found in %pOF\n", dev->dev->of_node);
 		return -EINVAL;
 	}
 	of_node_put(port);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
index ef79a6d55646..f609b62b8be6 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
@@ -84,8 +84,8 @@ static int mtk_disp_color_bind(struct device *dev, struct device *master,

 	ret = mtk_ddp_comp_register(drm_dev, &priv->ddp_comp);
 	if (ret < 0) {
-		dev_err(dev, "Failed to register component %s: %d\n",
-			dev->of_node->full_name, ret);
+		dev_err(dev, "Failed to register component %pOF: %d\n",
+			dev->of_node, ret);
 		return ret;
 	}

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 35bc5babdbf7..978782a77629 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -235,8 +235,8 @@ static int mtk_disp_ovl_bind(struct device *dev, struct device *master,

 	ret = mtk_ddp_comp_register(drm_dev, &priv->ddp_comp);
 	if (ret < 0) {
-		dev_err(dev, "Failed to register component %s: %d\n",
-			dev->of_node->full_name, ret);
+		dev_err(dev, "Failed to register component %pOF: %d\n",
+			dev->of_node, ret);
 		return ret;
 	}

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index b68a51376f83..585943c81e1f 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -155,8 +155,8 @@ static int mtk_disp_rdma_bind(struct device *dev, struct device *master,

 	ret = mtk_ddp_comp_register(drm_dev, &priv->ddp_comp);
 	if (ret < 0) {
-		dev_err(dev, "Failed to register component %s: %d\n",
-			dev->of_node->full_name, ret);
+		dev_err(dev, "Failed to register component %pOF: %d\n",
+			dev->of_node, ret);
 		return ret;
 	}

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 32ca351ecd09..e80a603e5fb0 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -605,8 +605,8 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)

 	ret = mtk_ddp_comp_register(drm_dev, &dpi->ddp_comp);
 	if (ret < 0) {
-		dev_err(dev, "Failed to register component %s: %d\n",
-			dev->of_node->full_name, ret);
+		dev_err(dev, "Failed to register component %pOF: %d\n",
+			dev->of_node, ret);
 		return ret;
 	}

@@ -710,7 +710,7 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 	if (!bridge_node)
 		return -ENODEV;

-	dev_info(dev, "Found bridge node: %s\n", bridge_node->full_name);
+	dev_info(dev, "Found bridge node: %pOF\n", bridge_node);

 	dpi->bridge = of_drm_find_bridge(bridge_node);
 	of_node_put(bridge_node);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index cb32c9369f3a..9fa2e3d217c1 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -577,8 +577,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 		node = priv->comp_node[comp_id];
 		comp = priv->ddp_comp[comp_id];
 		if (!comp) {
-			dev_err(dev, "Component %s not initialized\n",
-				node->full_name);
+			dev_err(dev, "Component %pOF not initialized\n", node);
 			ret = -ENODEV;
 			goto unprepare;
 		}
@@ -586,8 +585,8 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 		ret = clk_prepare(comp->clk);
 		if (ret) {
 			dev_err(dev,
-				"Failed to prepare clock for component %s: %d\n",
-				node->full_name, ret);
+				"Failed to prepare clock for component %pOF: %d\n",
+				node, ret);
 			goto unprepare;
 		}

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 07d7ea2268ef..4672317e3ad1 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -295,15 +295,13 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	larb_node = of_parse_phandle(node, "mediatek,larb", 0);
 	if (!larb_node) {
 		dev_err(dev,
-			"Missing mediadek,larb phandle in %s node\n",
-			node->full_name);
+			"Missing mediadek,larb phandle in %pOF node\n", node);
 		return -EINVAL;
 	}

 	larb_pdev = of_find_device_by_node(larb_node);
 	if (!larb_pdev) {
-		dev_warn(dev, "Waiting for larb device %s\n",
-			 larb_node->full_name);
+		dev_warn(dev, "Waiting for larb device %pOF\n", larb_node);
 		of_node_put(larb_node);
 		return -EPROBE_DEFER;
 	}
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 41d2cffe953e..b67923589dc2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -187,8 +187,8 @@ static int mtk_drm_kms_init(struct drm_device *drm)

 	pdev = of_find_device_by_node(private->mutex_node);
 	if (!pdev) {
-		dev_err(drm->dev, "Waiting for disp-mutex device %s\n",
-			private->mutex_node->full_name);
+		dev_err(drm->dev, "Waiting for disp-mutex device %pOF\n",
+			private->mutex_node);
 		of_node_put(private->mutex_node);
 		return -EPROBE_DEFER;
 	}
@@ -417,8 +417,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
 			continue;

 		if (!of_device_is_available(node)) {
-			dev_dbg(dev, "Skipping disabled component %s\n",
-				node->full_name);
+			dev_dbg(dev, "Skipping disabled component %pOF\n",
+				node);
 			continue;
 		}

@@ -431,8 +431,8 @@ static int mtk_drm_probe(struct platform_device *pdev)

 		comp_id = mtk_ddp_comp_get_id(node, comp_type);
 		if (comp_id < 0) {
-			dev_warn(dev, "Skipping unknown component %s\n",
-				 node->full_name);
+			dev_warn(dev, "Skipping unknown component %pOF\n",
+				 node);
 			continue;
 		}

@@ -448,8 +448,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
 		    comp_type == MTK_DISP_RDMA ||
 		    comp_type == MTK_DSI ||
 		    comp_type == MTK_DPI) {
-			dev_info(dev, "Adding component match for %s\n",
-				 node->full_name);
+			dev_info(dev, "Adding component match for %pOF\n",
+				 node);
 			drm_of_component_match_add(dev, &match, compare_of,
 						   node);
 		} else {
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 97253c8f813b..a31bd2a82de5 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1048,8 +1048,8 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)

 	ret = mtk_ddp_comp_register(drm, &dsi->ddp_comp);
 	if (ret < 0) {
-		dev_err(dev, "Failed to register component %s: %d\n",
-			dev->of_node->full_name, ret);
+		dev_err(dev, "Failed to register component %pOF: %d\n",
+			dev->of_node, ret);
 		return ret;
 	}

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 71eb4fbbfc85..fef246c2577c 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1456,8 +1456,8 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,

 	cec_pdev = of_find_device_by_node(cec_np);
 	if (!cec_pdev) {
-		dev_err(hdmi->dev, "Waiting for CEC device %s\n",
-			cec_np->full_name);
+		dev_err(hdmi->dev, "Waiting for CEC device %pOF\n",
+			cec_np);
 		return -EPROBE_DEFER;
 	}
 	hdmi->cec_dev = &cec_pdev->dev;
@@ -1501,8 +1501,8 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,

 	i2c_np = of_parse_phandle(remote, "ddc-i2c-bus", 0);
 	if (!i2c_np) {
-		dev_err(dev, "Failed to find ddc-i2c-bus node in %s\n",
-			remote->full_name);
+		dev_err(dev, "Failed to find ddc-i2c-bus node in %pOF\n",
+			remote);
 		of_node_put(remote);
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 4d98fac92795..5375e6dccdd7 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -303,9 +303,8 @@ static const struct component_master_ops meson_drv_master_ops = {

 static int compare_of(struct device *dev, void *data)
 {
-	DRM_DEBUG_DRIVER("Comparing of node %s with %s\n",
-			 of_node_full_name(dev->of_node),
-			 of_node_full_name(data));
+	DRM_DEBUG_DRIVER("Comparing of node %pOF with %pOF\n",
+			 dev->of_node, data);

 	return dev->of_node == data;
 }
diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 3216aa9a88d6..e2d57c01200b 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -143,14 +143,14 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)

 	ret = of_property_read_u32(np, "width-mm", &lvds->width);
 	if (ret < 0) {
-		dev_err(lvds->dev, "%s: invalid or missing %s DT property\n",
-			of_node_full_name(np), "width-mm");
+		dev_err(lvds->dev, "%pOF: invalid or missing %s DT property\n",
+			np, "width-mm");
 		return -ENODEV;
 	}
 	ret = of_property_read_u32(np, "height-mm", &lvds->height);
 	if (ret < 0) {
-		dev_err(lvds->dev, "%s: invalid or missing %s DT property\n",
-			of_node_full_name(np), "height-mm");
+		dev_err(lvds->dev, "%pOF: invalid or missing %s DT property\n",
+			np, "height-mm");
 		return -ENODEV;
 	}

@@ -158,8 +158,8 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)

 	ret = of_property_read_string(np, "data-mapping", &mapping);
 	if (ret < 0) {
-		dev_err(lvds->dev, "%s: invalid or missing %s DT property\n",
-			of_node_full_name(np), "data-mapping");
+		dev_err(lvds->dev, "%pOF: invalid or missing %s DT property\n",
+			np, "data-mapping");
 		return -ENODEV;
 	}

@@ -170,8 +170,8 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
 	} else if (!strcmp(mapping, "vesa-24")) {
 		lvds->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
 	} else {
-		dev_err(lvds->dev, "%s: invalid or missing %s DT property\n",
-			of_node_full_name(np), "data-mapping");
+		dev_err(lvds->dev, "%pOF: invalid or missing %s DT property\n",
+			np, "data-mapping");
 		return -EINVAL;
 	}

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 3e048dd98b64..ba8d2804c1d1 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -186,8 +186,8 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 	}

 	if (enc_node) {
-		dev_dbg(rcdu->dev, "initializing encoder %s for output %u\n",
-			of_node_full_name(enc_node), output);
+		dev_dbg(rcdu->dev, "initializing encoder %pOF for output %u\n",
+			enc_node, output);

 		/* Locate the DRM bridge from the encoder DT node. */
 		bridge = of_drm_find_bridge(enc_node);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index f4125c8ca902..5d681ea53be6 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -297,15 +297,15 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 	 */
 	entity = of_graph_get_remote_port_parent(ep->local_node);
 	if (!entity) {
-		dev_dbg(rcdu->dev, "unconnected endpoint %s, skipping\n",
-			ep->local_node->full_name);
+		dev_dbg(rcdu->dev, "unconnected endpoint %pOF, skipping\n",
+			ep->local_node);
 		return -ENODEV;
 	}

 	if (!of_device_is_available(entity)) {
 		dev_dbg(rcdu->dev,
-			"connected entity %s is disabled, skipping\n",
-			entity->full_name);
+			"connected entity %pOF is disabled, skipping\n",
+			entity);
 		return -ENODEV;
 	}

@@ -325,8 +325,8 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,

 		if (!connector) {
 			dev_warn(rcdu->dev,
-				 "no connector for encoder %s, skipping\n",
-				 encoder->full_name);
+				 "no connector for encoder %pOF, skipping\n",
+				 encoder);
 			of_node_put(entity_ep_node);
 			of_node_put(encoder);
 			return -ENODEV;
@@ -348,8 +348,8 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 	ret = rcar_du_encoder_init(rcdu, output, encoder, connector);
 	if (ret && ret != -EPROBE_DEFER)
 		dev_warn(rcdu->dev,
-			 "failed to initialize encoder %s on output %u (%d), skipping\n",
-			 of_node_full_name(encoder), output, ret);
+			 "failed to initialize encoder %pOF on output %u (%d), skipping\n",
+			 encoder, output, ret);

 	of_node_put(encoder);
 	of_node_put(connector);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index c6b1b7f3a2a3..02410429edf7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -370,8 +370,8 @@ static int rockchip_drm_platform_of_probe(struct device *dev)

 		iommu = of_parse_phandle(port->parent, "iommus", 0);
 		if (!iommu || !of_device_is_available(iommu->parent)) {
-			dev_dbg(dev, "no iommu attached for %s, using non-iommu buffers\n",
-				port->parent->full_name);
+			dev_dbg(dev, "no iommu attached for %pOF, using non-iommu buffers\n",
+				port->parent);
 			/*
 			 * if there is a crtc not support iommu, force set all
 			 * crtc use non-iommu buffer.
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 5d450332c2fd..aa3407f13bbd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1340,8 +1340,8 @@ static int vop_create_crtc(struct vop *vop)

 	port = of_get_child_by_name(dev->of_node, "port");
 	if (!port) {
-		DRM_DEV_ERROR(vop->dev, "no port node found in %s\n",
-			      dev->of_node->full_name);
+		DRM_DEV_ERROR(vop->dev, "no port node found in %pOF\n",
+			      dev->of_node);
 		ret = -ENOENT;
 		goto err_cleanup_crtc;
 	}
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 1b9483d4f2a4..cd4e74743d77 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -995,8 +995,7 @@ static struct drm_panel *ltdc_get_panel(struct drm_device *ddev)
 			panel = of_drm_find_panel(port);
 			of_node_put(port);
 			if (panel) {
-				DRM_DEBUG_DRIVER("remote panel %s\n",
-						 port->full_name);
+				DRM_DEBUG_DRIVER("remote panel %pOF\n", port);
 			} else {
 				DRM_DEBUG_DRIVER("panel missing\n");
 				of_node_put(entity);
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index abc7d8fe06b4..89cd590723ac 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -187,9 +187,9 @@ static bool sun4i_drv_node_is_tcon(struct device_node *node)

 static int compare_of(struct device *dev, void *data)
 {
-	DRM_DEBUG_DRIVER("Comparing of node %s with %s\n",
-			 of_node_full_name(dev->of_node),
-			 of_node_full_name(data));
+	DRM_DEBUG_DRIVER("Comparing of node %pOF with %pOF\n",
+			 dev->of_node,
+			 data);

 	return dev->of_node == data;
 }
@@ -219,8 +219,7 @@ static int sun4i_drv_add_endpoints(struct device *dev,

 	if (!sun4i_drv_node_is_frontend(node)) {
 		/* Add current component */
-		DRM_DEBUG_DRIVER("Adding component %s\n",
-				 of_node_full_name(node));
+		DRM_DEBUG_DRIVER("Adding component %pOF\n", node);
 		drm_of_component_match_add(dev, match, compare_of, node);
 		count++;
 	}
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index d524ed0d5146..8416c1fa0dd8 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -1038,8 +1038,8 @@ int tilcdc_crtc_create(struct drm_device *dev)
 	if (priv->is_componentized) {
 		crtc->port = of_graph_get_port_by_id(dev->dev->of_node, 0);
 		if (!crtc->port) { /* This should never happen */
-			dev_err(dev->dev, "Port node not found in %s\n",
-				dev->dev->of_node->full_name);
+			dev_err(dev->dev, "Port node not found in %pOF\n",
+				dev->dev->of_node);
 			ret = -EINVAL;
 			goto fail;
 		}
diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 960d816ad7f7..6a573d21d3cc 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1217,8 +1217,8 @@ static int ipu_add_client_devices(struct ipu_soc *ipu, unsigned long ipu_base)
 		of_node = of_graph_get_port_by_id(dev->of_node, i);
 		if (!of_node) {
 			dev_info(dev,
-				 "no port@%d node in %s, not using %s%d\n",
-				 i, dev->of_node->full_name,
+				 "no port@%d node in %pOF, not using %s%d\n",
+				 i, dev->of_node,
 				 (i / 2) ? "DI" : "CSI", i % 2);
 			continue;
 		}
--
2.11.0
