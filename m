From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 10 Sep 2014 22:10:43 +0800
Subject: [PATCH] imx-drm: ipuv3-plane: remove function ipu_plane_dpms()
Message-ID: <1410358243-10527-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All those ipu_*_put() calls in ipu_plane_dpms() are unnecessary,
because the only occurrence of ipu_plane_dpms() with 'mode' not being
DRM_MODE_DPMS_ON is in function ipu_disable_plane(), which already
has a ipu_plane_put_resources() call to put those ipu resources right
after ipu_plane_dpms().

So with those redundant ipu_*_put() calls removed from ipu_plane_dpms(),
the only left code in the function is ipu_plane_enable|disable().  Thus,
we can just call ipu_plane_enable|disable() as needed directly and
remove the ipu_plane_dpms() function completely.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Greg,

This cleanup patch is based on Russell's fix -'imx-drm: ipuv3-plane:
fix ipu_plane_dpms()'.

Shawn

 drivers/staging/imx-drm/ipuv3-plane.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/imx-drm/ipuv3-plane.c b/drivers/staging/imx-drm/ipuv3-plane.c
index 50de10a550e9..06a0cb9c6b26 100644
--- a/drivers/staging/imx-drm/ipuv3-plane.c
+++ b/drivers/staging/imx-drm/ipuv3-plane.c
@@ -263,29 +263,6 @@ void ipu_plane_disable(struct ipu_plane *ipu_plane)
 		ipu_dp_disable(ipu_plane->ipu);
 }
 
-static void ipu_plane_dpms(struct ipu_plane *ipu_plane, int mode)
-{
-	bool enable;
-
-	DRM_DEBUG_KMS("mode = %d", mode);
-
-	enable = (mode == DRM_MODE_DPMS_ON);
-
-	if (enable == ipu_plane->enabled)
-		return;
-
-	if (enable) {
-		ipu_plane_enable(ipu_plane);
-	} else {
-		ipu_plane_disable(ipu_plane);
-
-		ipu_idmac_put(ipu_plane->ipu_ch);
-		ipu_dmfc_put(ipu_plane->dmfc);
-		if (ipu_plane->dp)
-			ipu_dp_put(ipu_plane->dp);
-	}
-}
-
 /*
  * drm_plane API
  */
@@ -319,7 +296,8 @@ static int ipu_update_plane(struct drm_plane *plane, struct drm_crtc *crtc,
 				plane->crtc, crtc);
 	plane->crtc = crtc;
 
-	ipu_plane_dpms(ipu_plane, DRM_MODE_DPMS_ON);
+	if (!ipu_plane->enabled)
+		ipu_plane_enable(ipu_plane);
 
 	return 0;
 }
@@ -330,7 +308,8 @@ static int ipu_disable_plane(struct drm_plane *plane)
 
 	DRM_DEBUG_KMS("[%d] %s\n", __LINE__, __func__);
 
-	ipu_plane_dpms(ipu_plane, DRM_MODE_DPMS_OFF);
+	if (ipu_plane->enabled)
+		ipu_plane_disable(ipu_plane);
 
 	ipu_plane_put_resources(ipu_plane);
 
-- 
1.9.1
