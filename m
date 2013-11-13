From: denis@eukrea.com (Denis Carikli)
Date: Wed, 13 Nov 2013 10:23:18 +0100
Subject: [PATCHv4][ 2/7] staging: imx-drm: Use de-active and pixelclk-active
 display-timings.
In-Reply-To: <1384334603-14208-1-git-send-email-denis@eukrea.com>
References: <1384334603-14208-1-git-send-email-denis@eukrea.com>
Message-ID: <1384334603-14208-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If de-active and/or pixelclk-active properties were set in the
display-timings DT node, they were not used.

Instead the data-enable and the pixel data clock polarity
were hardcoded.

This change is needed for making the eukrea-cpuimx51
  QVGA display work.

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: driverdev-devel at linuxdriverproject.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel at lists.freedesktop.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v3->v4:
- The old patch was named "staging: imx-drm: ipuv3-crtc: don't harcode some mode".
- Reworked the patch entierly: we now takes the mode flags from the device tree.

ChangeLog v2->v3:
- Added some interested people in the Cc list.
- Ajusted the flags to match the changes in "drm: Add the lacking
  DRM_MODE_FLAG_* for matching the DISPLAY_FLAGS_*"
---
 drivers/staging/imx-drm/imx-drm.h          |    3 +++
 drivers/staging/imx-drm/ipuv3-crtc.c       |   11 +++++++++--
 drivers/staging/imx-drm/parallel-display.c |   28 ++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index ae90c9c..dfdc180 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -5,6 +5,9 @@
 
 #define IPU_PIX_FMT_GBR24	v4l2_fourcc('G', 'B', 'R', '3')
 
+#define IMXDRM_MODE_FLAG_DE_HIGH		(1<<0)
+#define IMXDRM_MODE_FLAG_PIXDATA_POSEDGE	(1<<1)
+
 struct drm_crtc;
 struct drm_connector;
 struct drm_device;
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index 670a56a..82dce06 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -156,8 +156,15 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		sig_cfg.Vsync_pol = 1;
 
-	sig_cfg.enable_pol = 1;
-	sig_cfg.clk_pol = 1;
+	/* Such flags are not availables in the DRM modes header,
+	 * and we don't want to export them to userspace.
+	 */
+	if (mode->private_flags & IMXDRM_MODE_FLAG_DE_HIGH)
+		sig_cfg.enable_pol = 1;
+
+	if (mode->private_flags & IMXDRM_MODE_FLAG_PIXDATA_POSEDGE)
+		sig_cfg.clk_pol = 1;
+
 	sig_cfg.width = mode->hdisplay;
 	sig_cfg.height = mode->vdisplay;
 	sig_cfg.pixel_fmt = out_pixel_fmt;
diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 24aa9be..09658ac 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -74,7 +74,35 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
 
 	if (np) {
 		struct drm_display_mode *mode = drm_mode_create(connector->dev);
+		struct device_node *timings_np;
+		struct device_node *mode_np;
+		u32 val;
+
 		of_get_drm_display_mode(np, &imxpd->mode, 0);
+
+		/* Such flags are not availables in the DRM modes header,
+		 * and we don't want to export them to userspace.
+		 */
+		timings_np = of_get_child_by_name(np, "display-timings");
+		if (timings_np) {
+			/* get the display mode node */
+			mode_np = of_parse_phandle(timings_np,
+						   "native-mode", 0);
+			if (!mode_np)
+				mode_np = of_get_next_child(timings_np, NULL);
+
+			/* set de-active to 1 if not set */
+			of_property_read_u32(mode_np, "de-active", &val);
+			if (!!val)
+				imxpd->mode.private_flags |=
+					IMXDRM_MODE_FLAG_DE_HIGH;
+
+			/* set pixelclk-active to 1 if not set */
+			of_property_read_u32(mode_np, "pixelclk-active", &val);
+			if (!!val)
+				imxpd->mode.private_flags |=
+					IMXDRM_MODE_FLAG_PIXDATA_POSEDGE;
+		}
 		drm_mode_copy(mode, &imxpd->mode);
 		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
 		drm_mode_probed_add(connector, mode);
-- 
1.7.9.5
