From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 2 Aug 2017 13:46:48 +0100
Subject: [PATCH v2 1/4] drm/atomic: implement
 drm_atomic_helper_commit_tail for runtime_pm users
In-Reply-To: <CAKMK7uH_JviQ-n6tR17qqJxitXX91dLhnwYBEW2NxvKS7-3HAA@mail.gmail.com>
References: <cover.204b8c1b76558ee33ecf147e51c2b6a04d302d55.1500555652.git-series.maxime.ripard@free-electrons.com>
 <a8f92dc70048bab746e94dadd1c23200626aff60.1500555652.git-series.maxime.ripard@free-electrons.com>
 <20170802112001.GO970@e110455-lin.cambridge.arm.com>
 <CAKMK7uH_JviQ-n6tR17qqJxitXX91dLhnwYBEW2NxvKS7-3HAA@mail.gmail.com>
Message-ID: <20170802124648.GP970@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 01:27:23PM +0200, Daniel Vetter wrote:
> On Wed, Aug 2, 2017 at 1:20 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > On Thu, Jul 20, 2017 at 03:01:16PM +0200, Maxime Ripard wrote:
> >> +/**
> >> + * drm_atomic_helper_commit_tail_rpm - commit atomic update to hardware
> >> + * @old_state: new modeset state to be committed
> >> + *
> >> + * This is an alternative implementation for the
> >> + * &drm_mode_config_helper_funcs.atomic_commit_tail hook, for drivers
> >> + * that support runtime_pm or need the CRTC to be enabled to perform a
> >> + * commit. Otherwise, one should use the default implementation
> >> + * drm_atomic_helper_commit_tail().
> >> + */
> >> +void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
> >> +{
> >> +     struct drm_device *dev = old_state->dev;
> >> +
> >> +     drm_atomic_helper_commit_modeset_disables(dev, old_state);
> >> +
> >> +     drm_atomic_helper_commit_modeset_enables(dev, old_state);
> >> +
> >> +     drm_atomic_helper_commit_planes(dev, old_state,
> >> +                                     DRM_PLANE_COMMIT_ACTIVE_ONLY);
> >> +
> >> +     drm_atomic_helper_commit_hw_done(old_state);
> >> +
> >> +     drm_atomic_helper_wait_for_vblanks(dev, old_state);
> >> +
> >> +     drm_atomic_helper_cleanup_planes(dev, old_state);
> >> +}
> >> +EXPORT_SYMBOL(drm_atomic_helper_commit_tail_rpm);
> >> +
> >
> > Given that this function is supposed to be used by runtime PM aware
> > drivers and that the hook is called from the DRM core, should there not
> > be some pm_runtime_{get,put} calls wrapping the body of this function?

Hi Daniel,

> 
> No, because the drm atomic helpers have no idea which device is
> backing which part of the drm device. Some drivers might on have one
> device for the entire driver, some one device for just the display
> part (which might or might not match drm_device->dev). And many arm
> drivers have a device for each block separately (and you need to call
> rpm_get/put on each). And some something in-between (e.g. core device
> + external encoders).

Hmm, I understand your point about this function not having to care about
pm_runtime_{get,put}, but I do not agree with your view that if it wanted to
care about it, it wouldn't be able to do the right thing because it doesn't
have the right device. After all, this function is about handling the
updates that this atomic commit is concerned about, so having the
old_state->dev drm_device pointer and its associated device should be
enough. Am I missing something?

> 
> I don't think there's anything the helpers can to to help support this.
> 
> Also, just wrapping functions with rpm_get/put only papers over bugs
> in your driver - either you enable something, then the rpm_get needs
> to be done anyway (since the hw will be shut down otherwise), or you
> disable something, same reasons. The only thing a rpm_get/put does is
> paper over the bugs where you try to access the hw when it's off. As
> soon as this function finishes, the hw is shut down again, drops all
> register values on the floor, so either that access wasn't needed, or
> your driver has a bug (because it assumes the register values survive
> when they don't).
> 
> So imo all around a bad idea, at least from my experience of doing rpm
> enabling on i915 hw.

Understood. Thanks!

Best regards,
Liviu

> -Daniel
> 
> >
> > Best regards,
> > Liviu
> >
> >
> >>  static void commit_tail(struct drm_atomic_state *old_state)
> >>  {
> >>       struct drm_device *dev = old_state->dev;
> >> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
> >> index d48fd7c918f8..ed1a648d518c 100644
> >> --- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
> >> +++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
> >> @@ -187,33 +187,8 @@ dma_addr_t exynos_drm_fb_dma_addr(struct drm_framebuffer *fb, int index)
> >>       return exynos_fb->dma_addr[index];
> >>  }
> >>
> >> -static void exynos_drm_atomic_commit_tail(struct drm_atomic_state *state)
> >> -{
> >> -     struct drm_device *dev = state->dev;
> >> -
> >> -     drm_atomic_helper_commit_modeset_disables(dev, state);
> >> -
> >> -     drm_atomic_helper_commit_modeset_enables(dev, state);
> >> -
> >> -     /*
> >> -      * Exynos can't update planes with CRTCs and encoders disabled,
> >> -      * its updates routines, specially for FIMD, requires the clocks
> >> -      * to be enabled. So it is necessary to handle the modeset operations
> >> -      * *before* the commit_planes() step, this way it will always
> >> -      * have the relevant clocks enabled to perform the update.
> >> -      */
> >> -     drm_atomic_helper_commit_planes(dev, state,
> >> -                                     DRM_PLANE_COMMIT_ACTIVE_ONLY);
> >> -
> >> -     drm_atomic_helper_commit_hw_done(state);
> >> -
> >> -     drm_atomic_helper_wait_for_vblanks(dev, state);
> >> -
> >> -     drm_atomic_helper_cleanup_planes(dev, state);
> >> -}
> >> -
> >>  static struct drm_mode_config_helper_funcs exynos_drm_mode_config_helpers = {
> >> -     .atomic_commit_tail = exynos_drm_atomic_commit_tail,
> >> +     .atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
> >>  };
> >>
> >>  static const struct drm_mode_config_funcs exynos_drm_mode_config_funcs = {
> >> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> >> index 81f9548672b0..35ad386c401e 100644
> >> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> >> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> >> @@ -174,27 +174,8 @@ static void rockchip_drm_output_poll_changed(struct drm_device *dev)
> >>               drm_fb_helper_hotplug_event(fb_helper);
> >>  }
> >>
> >> -static void
> >> -rockchip_atomic_commit_tail(struct drm_atomic_state *state)
> >> -{
> >> -     struct drm_device *dev = state->dev;
> >> -
> >> -     drm_atomic_helper_commit_modeset_disables(dev, state);
> >> -
> >> -     drm_atomic_helper_commit_modeset_enables(dev, state);
> >> -
> >> -     drm_atomic_helper_commit_planes(dev, state,
> >> -                                     DRM_PLANE_COMMIT_ACTIVE_ONLY);
> >> -
> >> -     drm_atomic_helper_commit_hw_done(state);
> >> -
> >> -     drm_atomic_helper_wait_for_vblanks(dev, state);
> >> -
> >> -     drm_atomic_helper_cleanup_planes(dev, state);
> >> -}
> >> -
> >>  static const struct drm_mode_config_helper_funcs rockchip_mode_config_helpers = {
> >> -     .atomic_commit_tail = rockchip_atomic_commit_tail,
> >> +     .atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
> >>  };
> >>
> >>  static const struct drm_mode_config_funcs rockchip_drm_mode_config_funcs = {
> >> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
> >> index f0a8678ae98e..af4aaff9ec0b 100644
> >> --- a/include/drm/drm_atomic_helper.h
> >> +++ b/include/drm/drm_atomic_helper.h
> >> @@ -41,6 +41,7 @@ int drm_atomic_helper_check_planes(struct drm_device *dev,
> >>  int drm_atomic_helper_check(struct drm_device *dev,
> >>                           struct drm_atomic_state *state);
> >>  void drm_atomic_helper_commit_tail(struct drm_atomic_state *state);
> >> +void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *state);
> >>  int drm_atomic_helper_commit(struct drm_device *dev,
> >>                            struct drm_atomic_state *state,
> >>                            bool nonblock);
> >> --
> >> git-series 0.9.1
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel at lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > ====================
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     ?\_(?)_/?
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel at lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
