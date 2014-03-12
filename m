From: denis@eukrea.com (Denis Carikli)
Date: Wed, 12 Mar 2014 17:31:05 +0100
Subject: [PATCH v10][ 08/10] imx-drm: imx-drm-core: provide a common display
 timings retrival function.
In-Reply-To: <1394641867-15629-1-git-send-email-denis@eukrea.com>
References: <1394641867-15629-1-git-send-email-denis@eukrea.com>
Message-ID: <1394641867-15629-8-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx_drm_of_get_extra_timing_flags will be used to
retrive the native-mode and de-active display-timings
node properties in the device tree.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v9->v10:
- New patch that was splitted out of
  "staging: imx-drm: Use de-active and pixelclk-active
- When a IMXDRM_MODE_FLAG_ flag is set, its opposite
  flag is also unset.
---
 drivers/staging/imx-drm/imx-drm-core.c |   57 ++++++++++++++++++++++++++++++++
 drivers/staging/imx-drm/imx-drm.h      |    2 ++
 2 files changed, 59 insertions(+)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 6a71cd9..d877b77 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -24,6 +24,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <video/of_display_timing.h>
 
 #include "imx-drm.h"
 
@@ -492,6 +493,62 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
 }
 EXPORT_SYMBOL_GPL(imx_drm_encoder_parse_of);
 
+int imx_drm_of_get_extra_timing_flags(struct drm_connector *connector,
+				 struct drm_display_mode *mode,
+				 struct device_node *display_np)
+{
+	struct drm_display_mode *new_mode = drm_mode_create(connector->dev);
+	struct device_node *timings_np;
+	struct device_node *mode_np;
+	u32 val;
+
+	if (!new_mode)
+		return -EINVAL;
+
+	of_get_drm_display_mode(display_np, mode, OF_USE_NATIVE_MODE);
+
+	timings_np = of_get_child_by_name(display_np, "display-timings");
+	if (timings_np) {
+		/* get the display mode node */
+		mode_np = of_parse_phandle(timings_np,
+					   "native-mode", 0);
+		if (!mode_np)
+			mode_np = of_get_next_child(timings_np, NULL);
+
+		if (!of_property_read_u32(mode_np, "de-active", &val)) {
+			if (val) {
+				mode->private_flags |=
+					IMXDRM_MODE_FLAG_DE_HIGH;
+				mode->private_flags &=
+					~IMXDRM_MODE_FLAG_DE_LOW;
+			} else {
+				mode->private_flags &=
+					~IMXDRM_MODE_FLAG_DE_HIGH;
+				mode->private_flags |=
+					IMXDRM_MODE_FLAG_DE_LOW;
+			}
+		}
+
+		if (!of_property_read_u32(mode_np, "pixelclk-active",
+					  &val)) {
+			if (val) {
+				mode->private_flags |=
+					IMXDRM_MODE_FLAG_PIXDATA_POSEDGE;
+				mode->private_flags &=
+					~IMXDRM_MODE_FLAG_PIXDATA_NEGEDGE;
+			} else {
+				mode->private_flags &=
+					~IMXDRM_MODE_FLAG_PIXDATA_POSEDGE;
+				mode->private_flags |=
+					IMXDRM_MODE_FLAG_PIXDATA_NEGEDGE;
+			}
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imx_drm_of_get_extra_timing_flags);
+
 void imx_drm_set_default_timing_flags(struct drm_display_mode *mode)
 {
 	mode->private_flags &= ~IMXDRM_MODE_FLAG_DE_LOW;
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index ae07d9d..ae01f4d 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -54,6 +54,8 @@ int imx_drm_encoder_get_mux_id(struct device_node *node,
 		struct drm_encoder *encoder);
 int imx_drm_encoder_parse_of(struct drm_device *drm,
 	struct drm_encoder *encoder, struct device_node *np);
+int imx_drm_of_get_extra_timing_flags(struct drm_connector *connector,
+	struct drm_display_mode *mode, struct device_node *display_np);
 void imx_drm_set_default_timing_flags(struct drm_display_mode *mode);
 
 int imx_drm_connector_mode_valid(struct drm_connector *connector,
-- 
1.7.9.5
