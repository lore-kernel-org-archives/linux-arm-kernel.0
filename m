From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 19 Aug 2014 15:59:38 +0200
Subject: [PATCH 2/2] imx-drm: ipuv3-plane: fix kernel Oops in ipu_dp_put()
In-Reply-To: <1408441795-24719-3-git-send-email-shawn.guo@freescale.com>
References: <1408441795-24719-1-git-send-email-shawn.guo@freescale.com>
 <1408441795-24719-3-git-send-email-shawn.guo@freescale.com>
Message-ID: <1408456778.2899.6.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Dienstag, den 19.08.2014, 17:49 +0800 schrieb Shawn Guo:
> Unbinding imx-hdmi or imx-ldb driver triggers a kernel Oops in function
> ipu_dp_put() as below.
> 
> $ echo 120000.hdmi > /sys/devices/soc0/soc/2000000.aips-bus/120000.hdmi/driver/unbind
[...]
> From the call stack, the issue is caused by that ipu_dp_put() is called
> from ipu_plane_dpms() with ipu_plane->dp being NULL.  Rather than
> being called unconditionally, ipu_dp_put() should be called only when
> ipu_plane->dp is valid, just like what ipu_plane_put_resources() does.
> Acutally, all those ipu_*_put() calls in ipu_plane_dpms() are
> unnecessary, because the only occurrence of ipu_plane_dpms() with 'mode'
> not being DRM_MODE_DPMS_ON is from function ipu_disable_plane(), which
> already has a ipu_plane_put_resources() call right after
> ipu_plane_dpms().
> 
> The patch fixes above kernel Oops by removing those buggy and
> unnecessary ipu_*_put() calls from ipu_plane_dpms().
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  drivers/staging/imx-drm/ipuv3-plane.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/imx-drm/ipuv3-plane.c b/drivers/staging/imx-drm/ipuv3-plane.c
> index 6f393a11f44d..a79ae7731a03 100644
> --- a/drivers/staging/imx-drm/ipuv3-plane.c
> +++ b/drivers/staging/imx-drm/ipuv3-plane.c
> @@ -274,15 +274,10 @@ static void ipu_plane_dpms(struct ipu_plane *ipu_plane, int mode)
>  	if (enable == ipu_plane->enabled)
>  		return;
>  
> -	if (enable) {
> +	if (enable)
>  		ipu_plane_enable(ipu_plane);
> -	} else {
> +	else
>  		ipu_plane_disable(ipu_plane);
> -
> -		ipu_idmac_put(ipu_plane->ipu_ch);
> -		ipu_dmfc_put(ipu_plane->dmfc);
> -		ipu_dp_put(ipu_plane->dp);
> -	}
>  }
>  
>  /*

we could then remove ipu_plane_dpms completely:

---
 drivers/staging/imx-drm/ipuv3-plane.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/imx-drm/ipuv3-plane.c b/drivers/staging/imx-drm/ipuv3-plane.c
index b2d1bb2..6987e16 100644
--- a/drivers/staging/imx-drm/ipuv3-plane.c
+++ b/drivers/staging/imx-drm/ipuv3-plane.c
@@ -290,23 +290,6 @@ void ipu_plane_disable(struct ipu_plane *ipu_plane)
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
-	if (enable)
-		ipu_plane_enable(ipu_plane);
-	else
-		ipu_plane_disable(ipu_plane);
-}
-
 /*
  * drm_plane API
  */
@@ -340,7 +323,8 @@ static int ipu_update_plane(struct drm_plane *plane, struct drm_crtc *crtc,
 				plane->crtc, crtc);
 	plane->crtc = crtc;
 
-	ipu_plane_dpms(ipu_plane, DRM_MODE_DPMS_ON);
+	if (!ipu_plane->enabled)
+		ipu_plane_enable(ipu_plane);
 
 	return 0;
 }
@@ -351,7 +335,8 @@ static int ipu_disable_plane(struct drm_plane *plane)
 
 	DRM_DEBUG_KMS("[%d] %s\n", __LINE__, __func__);
 
-	ipu_plane_dpms(ipu_plane, DRM_MODE_DPMS_OFF);
+	if (ipu_plane->enabled)
+		ipu_plane_disable(ipu_plane);
 
 	ipu_plane_put_resources(ipu_plane);
 
-- 
2.1.0.rc1

regards
Philipp
