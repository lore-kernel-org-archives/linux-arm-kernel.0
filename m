From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 4 Apr 2017 10:49:53 +0200
Subject: [PATCH v2 01/13] drm/meson: Use crtc_state for hdisplay and fix
 atomic flush/enable sync for vsync commit
In-Reply-To: <1490109950-21421-2-git-send-email-narmstrong@baylibre.com>
References: <1490109950-21421-1-git-send-email-narmstrong@baylibre.com>
 <1490109950-21421-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20170404084945.l7r7wkpjl664vrac@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 04:25:38PM +0100, Neil Armstrong wrote:
> Clean the crtc_enable by using the proper crtc_state instead of the state
> of the primary plane state data.
> 
> Also fix the dependency to commit the plane changes even if enable is called
> after the flush.

Would have done this as 2 patches ... either way ack.
-Daniel

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_crtc.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
> index 0fe49ec..c986eb0 100644
> --- a/drivers/gpu/drm/meson/meson_crtc.c
> +++ b/drivers/gpu/drm/meson/meson_crtc.c
> @@ -82,11 +82,18 @@ static void meson_crtc_disable_vblank(struct drm_crtc *crtc)
>  static void meson_crtc_enable(struct drm_crtc *crtc)
>  {
>  	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
> -	struct drm_plane *plane = meson_crtc->priv->primary_plane;
> +	struct drm_crtc_state *crtc_state = crtc->state;
>  	struct meson_drm *priv = meson_crtc->priv;
>  
> +	DRM_DEBUG_DRIVER("\n");
> +
> +	if (!crtc_state) {
> +		DRM_ERROR("Invalid crtc_state\n");
> +		return;
> +	}
> +
>  	/* Enable VPP Postblend */
> -	writel(plane->state->crtc_w,
> +	writel(crtc_state->mode.hdisplay,
>  	       priv->io_base + _REG(VPP_POSTBLEND_H_SIZE));
>  
>  	writel_bits_relaxed(VPP_POSTBLEND_ENABLE, VPP_POSTBLEND_ENABLE,
> @@ -101,6 +108,7 @@ static void meson_crtc_disable(struct drm_crtc *crtc)
>  	struct meson_drm *priv = meson_crtc->priv;
>  
>  	priv->viu.osd1_enabled = false;
> +	priv->viu.osd1_commit = false;
>  
>  	/* Disable VPP Postblend */
>  	writel_bits_relaxed(VPP_POSTBLEND_ENABLE, 0,
> @@ -137,8 +145,7 @@ static void meson_crtc_atomic_flush(struct drm_crtc *crtc,
>  	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>  	struct meson_drm *priv = meson_crtc->priv;
>  
> -	if (priv->viu.osd1_enabled)
> -		priv->viu.osd1_commit = true;
> +	priv->viu.osd1_commit = true;
>  }
>  
>  static const struct drm_crtc_helper_funcs meson_crtc_helper_funcs = {
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
