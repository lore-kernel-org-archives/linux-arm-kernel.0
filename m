From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 02 Aug 2017 16:27:27 +0300
Subject: [PATCH v2 1/4] drm/atomic: implement
 drm_atomic_helper_commit_tail for runtime_pm users
In-Reply-To: <20170802124648.GP970@e110455-lin.cambridge.arm.com>
References: <cover.204b8c1b76558ee33ecf147e51c2b6a04d302d55.1500555652.git-series.maxime.ripard@free-electrons.com>
 <CAKMK7uH_JviQ-n6tR17qqJxitXX91dLhnwYBEW2NxvKS7-3HAA@mail.gmail.com>
 <20170802124648.GP970@e110455-lin.cambridge.arm.com>
Message-ID: <3036323.BRqfrJhm0Z@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Livu,

On Wednesday 02 Aug 2017 13:46:48 Liviu Dudau wrote:
> On Wed, Aug 02, 2017 at 01:27:23PM +0200, Daniel Vetter wrote:
> > On Wed, Aug 2, 2017 at 1:20 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> >> On Thu, Jul 20, 2017 at 03:01:16PM +0200, Maxime Ripard wrote:
> >>> +/**
> >>> + * drm_atomic_helper_commit_tail_rpm - commit atomic update to
> >>> hardware
> >>> + * @old_state: new modeset state to be committed
> >>> + *
> >>> + * This is an alternative implementation for the
> >>> + * &drm_mode_config_helper_funcs.atomic_commit_tail hook, for drivers
> >>> + * that support runtime_pm or need the CRTC to be enabled to perform a
> >>> + * commit. Otherwise, one should use the default implementation
> >>> + * drm_atomic_helper_commit_tail().
> >>> + */
> >>> +void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state
> >>> *old_state)
> >>> +{
> >>> +     struct drm_device *dev = old_state->dev;
> >>> +
> >>> +     drm_atomic_helper_commit_modeset_disables(dev, old_state);
> >>> +
> >>> +     drm_atomic_helper_commit_modeset_enables(dev, old_state);
> >>> +
> >>> +     drm_atomic_helper_commit_planes(dev, old_state,
> >>> +                                     DRM_PLANE_COMMIT_ACTIVE_ONLY);
> >>> +
> >>> +     drm_atomic_helper_commit_hw_done(old_state);
> >>> +
> >>> +     drm_atomic_helper_wait_for_vblanks(dev, old_state);
> >>> +
> >>> +     drm_atomic_helper_cleanup_planes(dev, old_state);
> >>> +}
> >>> +EXPORT_SYMBOL(drm_atomic_helper_commit_tail_rpm);
> >>> +
> >> 
> >> Given that this function is supposed to be used by runtime PM aware
> >> drivers and that the hook is called from the DRM core, should there not
> >> be some pm_runtime_{get,put} calls wrapping the body of this function?
> 
> Hi Daniel,
> 
> > No, because the drm atomic helpers have no idea which device is
> > backing which part of the drm device. Some drivers might on have one
> > device for the entire driver, some one device for just the display
> > part (which might or might not match drm_device->dev). And many arm
> > drivers have a device for each block separately (and you need to call
> > rpm_get/put on each). And some something in-between (e.g. core device
> > + external encoders).
> 
> Hmm, I understand your point about this function not having to care about
> pm_runtime_{get,put}, but I do not agree with your view that if it wanted to
> care about it, it wouldn't be able to do the right thing because it doesn't
> have the right device. After all, this function is about handling the
> updates that this atomic commit is concerned about, so having the
> old_state->dev drm_device pointer and its associated device should be
> enough. Am I missing something?

In embedded system it's quite common for display hardware to be made of 
multiple IP cores. Depending on the SoC you could have to manage runtime PM at 
the CRTC level for instance. The DRM core doesn't know about that, and sees a 
single device only.

I've expressed my doubts previously about the need for a RPM version of 
drm_atomic_helper_commit_tail(), as the resulting order of CRTC enable/disable 
and plane update operations can lead to corrupt frames when enabling the CRTC. 
I had a commit tail implementation in the rcar-du driver that was very similar 
to drm_atomic_helper_commit_tail_rpm(), and had to move back to the standard 
order to fix the corrupt frame issue. The result isn't as clean as I would 
like, as power handling is split between the CRTC enable/disable and the 
atomic begin/flush in a way that is not straightforward.

It now occurred to me that a simpler implementation could be possible. I'll 
have to experiment with it first, but the idea is as follows.

1 Call pm_runtime_get_sync() at the beginning of .commit_tail() and 
pm_runtime_put() at the end.

2. Use the standard CRTC disable, plane update, CRTC enable order in 
.commit_tail().

3. Call pm_runtime_get() in the CRTC .enable() handler and pm_runtime_put() in 
the CRTC .disable() handler;

This should guarantee that the device won't be suspended between CRTC disable 
and CRTC enable during a mode set, without requiring any special collaboration 
between CRTC enable/disable and atomic begin/flush to handle runtime PM. If 
drivers implement this, there should be no need for 
drm_atomic_helper_commit_tail_rpm().

Maxime, Daniel, what do you think about this ?

> > I don't think there's anything the helpers can to to help support this.
> > 
> > Also, just wrapping functions with rpm_get/put only papers over bugs
> > in your driver - either you enable something, then the rpm_get needs
> > to be done anyway (since the hw will be shut down otherwise), or you
> > disable something, same reasons. The only thing a rpm_get/put does is
> > paper over the bugs where you try to access the hw when it's off. As
> > soon as this function finishes, the hw is shut down again, drops all
> > register values on the floor, so either that access wasn't needed, or
> > your driver has a bug (because it assumes the register values survive
> > when they don't).
> > 
> > So imo all around a bad idea, at least from my experience of doing rpm
> > enabling on i915 hw.
> 
> Understood. Thanks!

-- 
Regards,

Laurent Pinchart
