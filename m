From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 2 Aug 2017 12:20:02 +0100
Subject: [PATCH v2 1/4] drm/atomic: implement
 drm_atomic_helper_commit_tail for runtime_pm users
In-Reply-To: <a8f92dc70048bab746e94dadd1c23200626aff60.1500555652.git-series.maxime.ripard@free-electrons.com>
References: <cover.204b8c1b76558ee33ecf147e51c2b6a04d302d55.1500555652.git-series.maxime.ripard@free-electrons.com>
 <a8f92dc70048bab746e94dadd1c23200626aff60.1500555652.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170802112001.GO970@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Thu, Jul 20, 2017 at 03:01:16PM +0200, Maxime Ripard wrote:
> The current drm_atomic_helper_commit_tail helper works only if the CRTC is
> accessible, and documents an alternative implementation that is supposed to
> be used if that happens.
> 
> That implementation is then duplicated by some drivers. Instead of
> documenting it, let's implement an helper that all the relevant users can
> use directly.

Sorry for not noticing the series earlier, I was fooled by the series
top commit summary into thinking it was a driver specific change and
only paid proper attention when it ended up in drm-next. I have a comment
to make though.

> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c        | 49 +++++++++++++++--------
>  drivers/gpu/drm/exynos/exynos_drm_fb.c     | 27 +-------------
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 21 +----------
>  include/drm/drm_atomic_helper.h            |  1 +-
>  4 files changed, 37 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 86d3093c6c9b..d06a65ed3a57 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1245,23 +1245,13 @@ EXPORT_SYMBOL(drm_atomic_helper_wait_for_vblanks);
>   * @old_state: atomic state object with old state structures
>   *
>   * This is the default implementation for the
> - * &drm_mode_config_helper_funcs.atomic_commit_tail hook.
> + * &drm_mode_config_helper_funcs.atomic_commit_tail hook, for drivers
> + * that do not support runtime_pm or do not need the CRTC to be
> + * enabled to perform a commit. Otherwise, see
> + * drm_atomic_helper_commit_tail_rpm().
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
>   */
>  void drm_atomic_helper_commit_tail(struct drm_atomic_state *old_state)
>  {
> @@ -1281,6 +1271,35 @@ void drm_atomic_helper_commit_tail(struct drm_atomic_state *old_state)
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_commit_tail);
>  
> +/**
> + * drm_atomic_helper_commit_tail_rpm - commit atomic update to hardware
> + * @old_state: new modeset state to be committed
> + *
> + * This is an alternative implementation for the
> + * &drm_mode_config_helper_funcs.atomic_commit_tail hook, for drivers
> + * that support runtime_pm or need the CRTC to be enabled to perform a
> + * commit. Otherwise, one should use the default implementation
> + * drm_atomic_helper_commit_tail().
> + */
> +void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
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
> +EXPORT_SYMBOL(drm_atomic_helper_commit_tail_rpm);
> +

Given that this function is supposed to be used by runtime PM aware
drivers and that the hook is called from the DRM core, should there not
be some pm_runtime_{get,put} calls wrapping the body of this function?

Best regards,
Liviu


>  static void commit_tail(struct drm_atomic_state *old_state)
>  {
>  	struct drm_device *dev = old_state->dev;
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
> index d48fd7c918f8..ed1a648d518c 100644
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
> +	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
>  };
>  
>  static const struct drm_mode_config_funcs exynos_drm_mode_config_funcs = {
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> index 81f9548672b0..35ad386c401e 100644
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
> +	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
>  };
>  
>  static const struct drm_mode_config_funcs rockchip_drm_mode_config_funcs = {
> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
> index f0a8678ae98e..af4aaff9ec0b 100644
> --- a/include/drm/drm_atomic_helper.h
> +++ b/include/drm/drm_atomic_helper.h
> @@ -41,6 +41,7 @@ int drm_atomic_helper_check_planes(struct drm_device *dev,
>  int drm_atomic_helper_check(struct drm_device *dev,
>  			    struct drm_atomic_state *state);
>  void drm_atomic_helper_commit_tail(struct drm_atomic_state *state);
> +void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *state);
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
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
