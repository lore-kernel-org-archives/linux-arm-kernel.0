From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 13 Jul 2017 21:39:36 +0200
Subject: [PATCH 1/4] drm/atomic: implement drm_atomic_helper_commit_tail
 for runtime_pm users
In-Reply-To: <aeeb8f778dae8f170294b6da92819973b742feb2.1499956639.git-series.maxime.ripard@free-electrons.com>
References: <cover.75b0c7f741ed33015a7ad44941bed1f6152a48a9.1499956639.git-series.maxime.ripard@free-electrons.com>
 <aeeb8f778dae8f170294b6da92819973b742feb2.1499956639.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170713193935.qwv24kf5gm35najr@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 04:41:13PM +0200, Maxime Ripard wrote:
> The current drm_atomic_helper_commit_tail helper works only if the CRTC is
> accessible, and documents an alternative implementation that is supposed to
> be used if that happens.
> 
> That implementation is then duplicated by some drivers. Instead of
> documenting it, let's implement an helper that all the relevant users can
> use directly.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c        | 47 +++++++++++++++--------
>  drivers/gpu/drm/exynos/exynos_drm_fb.c     | 27 +-------------
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c      | 18 +---------
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 21 +----------
>  include/drm/drm_atomic_helper.h            |  1 +-
>  5 files changed, 36 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 86d3093c6c9b..a288805078f9 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1245,23 +1245,11 @@ EXPORT_SYMBOL(drm_atomic_helper_wait_for_vblanks);
>   * @old_state: atomic state object with old state structures
>   *
>   * This is the default implementation for the
> - * &drm_mode_config_helper_funcs.atomic_commit_tail hook.
> + * &drm_mode_config_helper_funcs.atomic_commit_tail hook, for drivers
> + * that do not support runtime_pm.
>   *
>   * Note that the default ordering of how the various stages are called is to
> - * match the legacy modeset helper library closest. One peculiarity of that is
> - * that it doesn't mesh well with runtime PM at all.
> - *
> - * For drivers supporting runtime PM the recommended sequence is instead ::
> - *
> - *     drm_atomic_helper_commit_modeset_disables(dev, old_state);
> - *
> - *     drm_atomic_helper_commit_modeset_enables(dev, old_state);
> - *
> - *     drm_atomic_helper_commit_planes(dev, old_state,
> - *                                     DRM_PLANE_COMMIT_ACTIVE_ONLY);
> - *
> - * for committing the atomic update to hardware.  See the kerneldoc entries for
> - * these three functions for more details.
> + * match the legacy modeset helper library closest.

Please sprinkle links into both functions (and everywhere the old one was
referenced) to make this more discoverable, and explain when to use the
other variant.

>   */
>  void drm_atomic_helper_commit_tail(struct drm_atomic_state *old_state)
>  {
> @@ -1281,6 +1269,35 @@ void drm_atomic_helper_commit_tail(struct drm_atomic_state *old_state)
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_commit_tail);
>  
> +/**
> + * drm_atomic_helper_commit_tail_runtime_pm - commit atomic update to hardware
> + * @old_state: new modeset state to be committed
> + *
> + * This is a variant of drm_atomic_helper_commit_tail suited for
> + * drivers that implement runtime_pm.
> + *
> + * Note that the default ordering of how the various stages are called is to
> + * match the legacy modeset helper library closest.
> + */
> +void drm_atomic_helper_commit_tail_runtime_pm(struct drm_atomic_state *old_state)

Bikeshed: I'd go with _rpm since this thing is already super long. But fee
free to ignore that.

With the docs polished I think this looks good.
-Daniel

> +{
> +	struct drm_device *dev = old_state->dev;
> +
> +	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> +
> +	drm_atomic_helper_commit_modeset_enables(dev, old_state);
> +
> +	drm_atomic_helper_commit_planes(dev, old_state,
> +					DRM_PLANE_COMMIT_ACTIVE_ONLY);
> +
> +	drm_atomic_helper_commit_hw_done(old_state);
> +
> +	drm_atomic_helper_wait_for_vblanks(dev, old_state);
> +
> +	drm_atomic_helper_cleanup_planes(dev, old_state);
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_commit_tail_runtime_pm);
> +
>  static void commit_tail(struct drm_atomic_state *old_state)
>  {
>  	struct drm_device *dev = old_state->dev;
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
> index d48fd7c918f8..71f6873255f1 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
> @@ -187,33 +187,8 @@ dma_addr_t exynos_drm_fb_dma_addr(struct drm_framebuffer *fb, int index)
>  	return exynos_fb->dma_addr[index];
>  }
>  
> -static void exynos_drm_atomic_commit_tail(struct drm_atomic_state *state)
> -{
> -	struct drm_device *dev = state->dev;
> -
> -	drm_atomic_helper_commit_modeset_disables(dev, state);
> -
> -	drm_atomic_helper_commit_modeset_enables(dev, state);
> -
> -	/*
> -	 * Exynos can't update planes with CRTCs and encoders disabled,
> -	 * its updates routines, specially for FIMD, requires the clocks
> -	 * to be enabled. So it is necessary to handle the modeset operations
> -	 * *before* the commit_planes() step, this way it will always
> -	 * have the relevant clocks enabled to perform the update.
> -	 */
> -	drm_atomic_helper_commit_planes(dev, state,
> -					DRM_PLANE_COMMIT_ACTIVE_ONLY);
> -
> -	drm_atomic_helper_commit_hw_done(state);
> -
> -	drm_atomic_helper_wait_for_vblanks(dev, state);
> -
> -	drm_atomic_helper_cleanup_planes(dev, state);
> -}
> -
>  static struct drm_mode_config_helper_funcs exynos_drm_mode_config_helpers = {
> -	.atomic_commit_tail = exynos_drm_atomic_commit_tail,
> +	.atomic_commit_tail = drm_atomic_helper_commit_tail_runtime_pm,
>  };
>  
>  static const struct drm_mode_config_funcs exynos_drm_mode_config_funcs = {
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> index f4125c8ca902..cb0f6266fbae 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> @@ -249,28 +249,12 @@ static int rcar_du_atomic_check(struct drm_device *dev,
>  	return rcar_du_atomic_check_planes(dev, state);
>  }
>  
> -static void rcar_du_atomic_commit_tail(struct drm_atomic_state *old_state)
> -{
> -	struct drm_device *dev = old_state->dev;
> -
> -	/* Apply the atomic update. */
> -	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> -	drm_atomic_helper_commit_modeset_enables(dev, old_state);
> -	drm_atomic_helper_commit_planes(dev, old_state,
> -					DRM_PLANE_COMMIT_ACTIVE_ONLY);
> -
> -	drm_atomic_helper_commit_hw_done(old_state);
> -	drm_atomic_helper_wait_for_vblanks(dev, old_state);
> -
> -	drm_atomic_helper_cleanup_planes(dev, old_state);
> -}
> -
>  /* -----------------------------------------------------------------------------
>   * Initialization
>   */
>  
>  static const struct drm_mode_config_helper_funcs rcar_du_mode_config_helper = {
> -	.atomic_commit_tail = rcar_du_atomic_commit_tail,
> +	.atomic_commit_tail = drm_atomic_helper_commit_tail_runtime_pm,
>  };
>  
>  static const struct drm_mode_config_funcs rcar_du_mode_config_funcs = {
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> index 81f9548672b0..647745479c39 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> @@ -174,27 +174,8 @@ static void rockchip_drm_output_poll_changed(struct drm_device *dev)
>  		drm_fb_helper_hotplug_event(fb_helper);
>  }
>  
> -static void
> -rockchip_atomic_commit_tail(struct drm_atomic_state *state)
> -{
> -	struct drm_device *dev = state->dev;
> -
> -	drm_atomic_helper_commit_modeset_disables(dev, state);
> -
> -	drm_atomic_helper_commit_modeset_enables(dev, state);
> -
> -	drm_atomic_helper_commit_planes(dev, state,
> -					DRM_PLANE_COMMIT_ACTIVE_ONLY);
> -
> -	drm_atomic_helper_commit_hw_done(state);
> -
> -	drm_atomic_helper_wait_for_vblanks(dev, state);
> -
> -	drm_atomic_helper_cleanup_planes(dev, state);
> -}
> -
>  static const struct drm_mode_config_helper_funcs rockchip_mode_config_helpers = {
> -	.atomic_commit_tail = rockchip_atomic_commit_tail,
> +	.atomic_commit_tail = drm_atomic_helper_commit_tail_runtime_pm,
>  };
>  
>  static const struct drm_mode_config_funcs rockchip_drm_mode_config_funcs = {
> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
> index f0a8678ae98e..9ff64c6d3043 100644
> --- a/include/drm/drm_atomic_helper.h
> +++ b/include/drm/drm_atomic_helper.h
> @@ -41,6 +41,7 @@ int drm_atomic_helper_check_planes(struct drm_device *dev,
>  int drm_atomic_helper_check(struct drm_device *dev,
>  			    struct drm_atomic_state *state);
>  void drm_atomic_helper_commit_tail(struct drm_atomic_state *state);
> +void drm_atomic_helper_commit_tail_runtime_pm(struct drm_atomic_state *state);
>  int drm_atomic_helper_commit(struct drm_device *dev,
>  			     struct drm_atomic_state *state,
>  			     bool nonblock);
> -- 
> git-series 0.9.1
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
