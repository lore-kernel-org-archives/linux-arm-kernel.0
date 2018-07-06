From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  6 Jul 2018 14:45:53 +0200
Subject: [PATCH] drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=m
Message-ID: <20180706124628.3192421-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:

ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!

This solves the problem by making DRM_SUN8I_MIXER a 'bool' symbol, building
the sun8i_tcon_top module the same way as the core sun4i-drm module whenever
DRM_SUN8I_MIXER is enabled, or not building it at all otherwise.

Alternatively, we could always build sun8i_tcon_top.ko along with sun4-drm.ko
and detach it from the mixer module, I could not tell which way is more
appropriate here.

Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TCON TOP")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/sun4i/Kconfig         | 2 +-
 drivers/gpu/drm/sun4i/Makefile        | 4 +++-
 drivers/gpu/drm/sun4i/sun4i_drv.c     | 3 ++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 156a865c3e6d..709461deb1c0 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -60,7 +60,7 @@ config DRM_SUN8I_DW_HDMI
 	  selected the module will be called sun8i_dw_hdmi.
 
 config DRM_SUN8I_MIXER
-	tristate "Support for Allwinner Display Engine 2.0 Mixer"
+	bool "Support for Allwinner Display Engine 2.0 Mixer"
 	default MACH_SUN8I
 	help
 	  Choose this option if you have an Allwinner SoC with the
diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index cd27d02c94e2..11de3cd52dae 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -39,4 +39,6 @@ endif
 obj-$(CONFIG_DRM_SUN4I_HDMI)	+= sun4i-drm-hdmi.o
 obj-$(CONFIG_DRM_SUN6I_DSI)	+= sun6i-dsi.o
 obj-$(CONFIG_DRM_SUN8I_DW_HDMI)	+= sun8i-drm-hdmi.o
-obj-$(CONFIG_DRM_SUN8I_MIXER)	+= sun8i-mixer.o sun8i_tcon_top.o
+ifdef CONFIG_DRM_SUN8I_MIXER
+obj-$(CONFIG_DRM_SUN4I)		+= sun8i-mixer.o sun8i_tcon_top.o
+endif
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 6ddf4eaccb40..7551dcb34c71 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -216,7 +216,8 @@ static bool sun4i_drv_node_is_tcon_with_ch0(struct device_node *node)
 
 static bool sun4i_drv_node_is_tcon_top(struct device_node *node)
 {
-	return !!of_match_node(sun8i_tcon_top_of_table, node);
+	return IS_ENABLED(CONFIG_DRM_SUN8I_MIXER) &&
+		!!of_match_node(sun8i_tcon_top_of_table, node);
 }
 
 static int compare_of(struct device *dev, void *data)
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 3459b9ec56c9..b18c8f175dba 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -44,7 +44,8 @@ sun8i_dw_hdmi_mode_valid(struct drm_connector *connector,
 
 static bool sun8i_dw_hdmi_node_is_tcon_top(struct device_node *node)
 {
-	return !!of_match_node(sun8i_tcon_top_of_table, node);
+	return IS_ENABLED(CONFIG_DRM_SUN8I_MIXER) &&
+		!!of_match_node(sun8i_tcon_top_of_table, node);
 }
 
 static u32 sun8i_dw_hdmi_find_possible_crtcs(struct drm_device *drm,
-- 
2.9.0
