From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  9 Jul 2018 18:05:55 +0200
Subject: [PATCH] [v2] drm/sun4i: fix build failure with
 CONFIG_DRM_SUN8I_MIXER=m
Message-ID: <20180709160615.2686055-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:

ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!

This solves the problem by adding a silent symbol for the tcon_top module,
building it as a separate module in exactly the cases that we need it,
but in a way that it is reachable by the other modules.

Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TCON TOP")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: link the tcon top module separately instead of into the mixer
---
 drivers/gpu/drm/sun4i/Kconfig         | 7 +++++++
 drivers/gpu/drm/sun4i/Makefile        | 3 ++-
 drivers/gpu/drm/sun4i/sun4i_drv.c     | 3 ++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 3 ++-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 156a865c3e6d..c2c042287c19 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -68,4 +68,11 @@ config DRM_SUN8I_MIXER
 	  graphics mixture and feed graphics to TCON, If M is
 	  selected the module will be called sun8i-mixer.
 
+config DRM_SUN8I_TCON_TOP
+	tristate
+	default DRM_SUN4I if DRM_SUN8I_MIXER!=n
+	help
+	  TCON TOP is responsible for configuring display pipeline for
+	  HTMI, TVE and LCD.
+
 endif
diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index cd27d02c94e2..0eb38ac8e86e 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -39,4 +39,5 @@ endif
 obj-$(CONFIG_DRM_SUN4I_HDMI)	+= sun4i-drm-hdmi.o
 obj-$(CONFIG_DRM_SUN6I_DSI)	+= sun6i-dsi.o
 obj-$(CONFIG_DRM_SUN8I_DW_HDMI)	+= sun8i-drm-hdmi.o
-obj-$(CONFIG_DRM_SUN8I_MIXER)	+= sun8i-mixer.o sun8i_tcon_top.o
+obj-$(CONFIG_DRM_SUN8I_MIXER)	+= sun8i-mixer.o
+obj-$(CONFIG_DRM_SUN8I_TCON_TOP) += sun8i_tcon_top.o
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 6ddf4eaccb40..495d0fc41297 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -216,7 +216,8 @@ static bool sun4i_drv_node_is_tcon_with_ch0(struct device_node *node)
 
 static bool sun4i_drv_node_is_tcon_top(struct device_node *node)
 {
-	return !!of_match_node(sun8i_tcon_top_of_table, node);
+	return IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
+		!!of_match_node(sun8i_tcon_top_of_table, node);
 }
 
 static int compare_of(struct device *dev, void *data)
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 3459b9ec56c9..3704d95874c2 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -44,7 +44,8 @@ sun8i_dw_hdmi_mode_valid(struct drm_connector *connector,
 
 static bool sun8i_dw_hdmi_node_is_tcon_top(struct device_node *node)
 {
-	return !!of_match_node(sun8i_tcon_top_of_table, node);
+	return IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
+		!!of_match_node(sun8i_tcon_top_of_table, node);
 }
 
 static u32 sun8i_dw_hdmi_find_possible_crtcs(struct drm_device *drm,
-- 
2.9.0
