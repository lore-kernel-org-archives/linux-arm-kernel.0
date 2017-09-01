From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  1 Sep 2017 11:46:22 +0200
Subject: [PATCH 1/2] RFC: drm: bridge: Add API to fetch connector
Message-ID: <20170901094622.6519-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to be able to get the connector out of a dumb VGA
for the PL111 driver. This is because we are using the
connector in the driver when initializing the display
pipe.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This is a bit ugly but not uglier than how we are reaching
into the connector of the panels in several drivers. I don't
know any better idea, advice welcome.
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 7 +++++++
 include/drm/dumb_vga_dac.h            | 9 +++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 include/drm/dumb_vga_dac.h

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index 6c2fdcb4fde1..c0d46ab7fde0 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -19,6 +19,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/dumb_vga_dac.h>
 
 /**
  * struct vga_dac_variant - characteristics of the DAC
@@ -51,6 +52,12 @@ drm_connector_to_dumb_vga(struct drm_connector *connector)
 	return container_of(connector, struct dumb_vga, connector);
 }
 
+struct drm_connector *drm_dumb_vga_get_connector(struct drm_bridge *bridge)
+{
+	return &drm_bridge_to_dumb_vga(bridge)->connector;
+}
+EXPORT_SYMBOL_GPL(drm_dumb_vga_get_connector);
+
 static int dumb_vga_get_modes(struct drm_connector *connector)
 {
 	struct dumb_vga *vga = drm_connector_to_dumb_vga(connector);
diff --git a/include/drm/dumb_vga_dac.h b/include/drm/dumb_vga_dac.h
new file mode 100644
index 000000000000..b7117222054d
--- /dev/null
+++ b/include/drm/dumb_vga_dac.h
@@ -0,0 +1,9 @@
+#ifndef _DUMB_VGA_DAC_H_
+#define _DUMB_VGA_DAC_H_
+
+struct drm_connector;
+struct drm_bridge;
+
+struct drm_connector *drm_dumb_vga_get_connector(struct drm_bridge *bridge);
+
+#endif
-- 
2.13.5
