From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 19 Aug 2014 22:41:54 +0800
Subject: [PATCH 2/2] imx-drm: ipuv3-plane: fix kernel Oops in ipu_dp_put()
In-Reply-To: <1408456778.2899.6.camel@paszta.hi.pengutronix.de>
References: <1408441795-24719-1-git-send-email-shawn.guo@freescale.com>
 <1408441795-24719-3-git-send-email-shawn.guo@freescale.com>
 <1408456778.2899.6.camel@paszta.hi.pengutronix.de>
Message-ID: <20140819144152.GB26734@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 03:59:38PM +0200, Philipp Zabel wrote:
> > diff --git a/drivers/staging/imx-drm/ipuv3-plane.c b/drivers/staging/imx-drm/ipuv3-plane.c
> > index 6f393a11f44d..a79ae7731a03 100644
> > --- a/drivers/staging/imx-drm/ipuv3-plane.c
> > +++ b/drivers/staging/imx-drm/ipuv3-plane.c
> > @@ -274,15 +274,10 @@ static void ipu_plane_dpms(struct ipu_plane *ipu_plane, int mode)
> >  	if (enable == ipu_plane->enabled)
> >  		return;
> >  
> > -	if (enable) {
> > +	if (enable)
> >  		ipu_plane_enable(ipu_plane);
> > -	} else {
> > +	else
> >  		ipu_plane_disable(ipu_plane);
> > -
> > -		ipu_idmac_put(ipu_plane->ipu_ch);
> > -		ipu_dmfc_put(ipu_plane->dmfc);
> > -		ipu_dp_put(ipu_plane->dp);
> > -	}
> >  }
> >  
> >  /*
> 
> we could then remove ipu_plane_dpms completely:

Yeah, you're right, Philipp.  I will fold your code change below into my
v2 of the patch.  Thanks.

Shawn

> 
> ---
>  drivers/staging/imx-drm/ipuv3-plane.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/imx-drm/ipuv3-plane.c b/drivers/staging/imx-drm/ipuv3-plane.c
> index b2d1bb2..6987e16 100644
> --- a/drivers/staging/imx-drm/ipuv3-plane.c
> +++ b/drivers/staging/imx-drm/ipuv3-plane.c
> @@ -290,23 +290,6 @@ void ipu_plane_disable(struct ipu_plane *ipu_plane)
>  		ipu_dp_disable(ipu_plane->ipu);
>  }
>  
> -static void ipu_plane_dpms(struct ipu_plane *ipu_plane, int mode)
> -{
> -	bool enable;
> -
> -	DRM_DEBUG_KMS("mode = %d", mode);
> -
> -	enable = (mode == DRM_MODE_DPMS_ON);
> -
> -	if (enable == ipu_plane->enabled)
> -		return;
> -
> -	if (enable)
> -		ipu_plane_enable(ipu_plane);
> -	else
> -		ipu_plane_disable(ipu_plane);
> -}
> -
>  /*
>   * drm_plane API
>   */
> @@ -340,7 +323,8 @@ static int ipu_update_plane(struct drm_plane *plane, struct drm_crtc *crtc,
>  				plane->crtc, crtc);
>  	plane->crtc = crtc;
>  
> -	ipu_plane_dpms(ipu_plane, DRM_MODE_DPMS_ON);
> +	if (!ipu_plane->enabled)
> +		ipu_plane_enable(ipu_plane);
>  
>  	return 0;
>  }
> @@ -351,7 +335,8 @@ static int ipu_disable_plane(struct drm_plane *plane)
>  
>  	DRM_DEBUG_KMS("[%d] %s\n", __LINE__, __func__);
>  
> -	ipu_plane_dpms(ipu_plane, DRM_MODE_DPMS_OFF);
> +	if (ipu_plane->enabled)
> +		ipu_plane_disable(ipu_plane);
>  
>  	ipu_plane_put_resources(ipu_plane);
>  
> -- 
> 2.1.0.rc1
> 
> regards
> Philipp
> 
