From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:25:50 +0000
Subject: [PATCH RFC 01/46] imx-drm: imx-drm-core: use the crtc drm device for
 vblank
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypm2-0007DZ-Tz@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a couple of ways to get at the drm_device for the vblank
operations.  One of them is via the private imxdrm structure, the
other is via the DRM crtc structure, which also stores a pointer.
Use the DRM method instead of our own method.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 96e4eee344ef..9aa5eaab6539 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -142,19 +142,19 @@ EXPORT_SYMBOL_GPL(imx_drm_crtc_panel_format);
 
 int imx_drm_crtc_vblank_get(struct imx_drm_crtc *imx_drm_crtc)
 {
-	return drm_vblank_get(imx_drm_crtc->imxdrm->drm, imx_drm_crtc->pipe);
+	return drm_vblank_get(imx_drm_crtc->crtc->dev, imx_drm_crtc->pipe);
 }
 EXPORT_SYMBOL_GPL(imx_drm_crtc_vblank_get);
 
 void imx_drm_crtc_vblank_put(struct imx_drm_crtc *imx_drm_crtc)
 {
-	drm_vblank_put(imx_drm_crtc->imxdrm->drm, imx_drm_crtc->pipe);
+	drm_vblank_put(imx_drm_crtc->crtc->dev, imx_drm_crtc->pipe);
 }
 EXPORT_SYMBOL_GPL(imx_drm_crtc_vblank_put);
 
 void imx_drm_handle_vblank(struct imx_drm_crtc *imx_drm_crtc)
 {
-	drm_handle_vblank(imx_drm_crtc->imxdrm->drm, imx_drm_crtc->pipe);
+	drm_handle_vblank(imx_drm_crtc->crtc->dev, imx_drm_crtc->pipe);
 }
 EXPORT_SYMBOL_GPL(imx_drm_handle_vblank);
 
-- 
1.7.4.4
