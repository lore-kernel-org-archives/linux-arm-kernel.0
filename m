From: denis@eukrea.com (Denis Carikli)
Date: Wed, 12 Mar 2014 17:31:06 +0100
Subject: [PATCH v10][ 09/10] imx-drm: parallel-display: retrive extra
 display-timings.
In-Reply-To: <1394641867-15629-1-git-send-email-denis@eukrea.com>
References: <1394641867-15629-1-git-send-email-denis@eukrea.com>
Message-ID: <1394641867-15629-9-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If de-active and/or pixelclk-active properties were set in the
display-timings DT node, they were not used.

Instead the data-enable and the pixel data clock polarity
were hardcoded.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v9->v10:
- New patch from what's left of:
  "staging: imx-drm: Use de-active and pixelclk-active
- New patch title.
---
 drivers/staging/imx-drm/parallel-display.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 871a737..09b07d5 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -85,7 +85,8 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
 			return -EINVAL;
 		of_get_drm_display_mode(np, &imxpd->mode, OF_USE_NATIVE_MODE);
 		drm_mode_copy(mode, &imxpd->mode);
-		imx_drm_set_default_timing_flags(mode);
+		imx_drm_of_get_extra_timing_flags(&imxpd->connector, mode,
+						  imxpd->dev->of_node);
 		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
 		drm_mode_probed_add(connector, mode);
 		num_modes++;
-- 
1.7.9.5
