From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 10 Jun 2016 16:33:13 +0200
Subject: [PATCH v3 2/3] drm/arm: Add support for Mali Display Processors
In-Reply-To: <20160610085259.GB1165@e106497-lin.cambridge.arm.com>
References: <1465489099-25628-1-git-send-email-Liviu.Dudau@arm.com>
 <1465489099-25628-3-git-send-email-Liviu.Dudau@arm.com>
 <20160609185629.GU3363@phenom.ffwll.local>
 <20160610085259.GB1165@e106497-lin.cambridge.arm.com>
Message-ID: <20160610143313.GD3363@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 09:52:59AM +0100, Liviu Dudau wrote:
> On Thu, Jun 09, 2016 at 08:56:29PM +0200, Daniel Vetter wrote:
> I'm seeing ->disable being called at HPD event time, which is soon after ->probe.
> 
> > This is the case when enabling a crtc when it is fully
> > disabled. Just mentioning in case ->enter_config_mode() is something that
> > must be called symmetrically with ->leave_config_mode().
> 
> ->leave_config_mode() should be the default mode when HW is disabled or not active,
> and the reset default value. Regardless of that, ->enter_config_mode() can be
> called at any time, even if HW is already in config mode.
> 
> > > +
> > > +	/* mclk needs to be set to the same or higher rate than pxlclk */
> > > +	clk_set_rate(hwdev->mclk, crtc->state->adjusted_mode.crtc_clock * 1000);
> > > +	clk_set_rate(hwdev->pxlclk, crtc->state->adjusted_mode.crtc_clock * 1000);
> > > +
> > > +	hwdev->modeset(hwdev, &vm);
> > > +	hwdev->leave_config_mode(hwdev);
> > > +}
> > > +
> > > +static void malidp_crtc_disable(struct drm_crtc *crtc)
> > > +{
> > > +	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
> > > +	struct malidp_hw_device *hwdev = malidp->dev;
> > > +
> > > +	/*
> > > +	 * avoid disabling already disabled clocks and hardware
> > > +	 * (as is the case at device probe time)
> > > +	 */
> > > +	if (crtc->state->active) {
> > 
> > Comment doesn't match code. Checking crtc->state->active in ->disable
> > looks at the _new_ state, not at the current state of the crtc. Atomic
> > helpers already guarantee you that ->disable is only called when the CRTC
> > is still on. 
> 
> Except at probe* time, when the framework calls ->disable before modeset to
> make sure that the hardware is in a known state. And I'm not sure how to
> check the _current_ state of the crtc other than by using crtc->state.
> 
> * actually, it is HPD event after probe.

Surprising. And you don't have a call to
drm_helper_disable_unused_functions, which is the usual culprit. Where
exactly do you see that ->disable call? Can you pls capture a backtrace
with full drm debugging enabled?

This shouldn't happen with atomic ...

> > > +static void malidp_unbind(struct device *dev)
> > > +{
> > > +	struct drm_device *drm = dev_get_drvdata(dev);
> > > +	struct malidp_drm *malidp = drm->dev_private;
> > > +	struct malidp_hw_device *hwdev = malidp->dev;
> > > +
> > > +	if (malidp->fbdev) {
> > > +		drm_fbdev_cma_fini(malidp->fbdev);
> > > +		malidp->fbdev = NULL;
> > > +	}
> > > +	drm_kms_helper_poll_fini(drm);
> > > +	malidp_se_irq_fini(drm);
> > > +	malidp_de_irq_fini(drm);
> > > +	drm_vblank_cleanup(drm);
> > > +	component_unbind_all(dev, drm);
> > > +	drm_dev_unregister(drm);
> > 
> > Unregister first, also need to unregister connectors too.
> 
> Bah, you are right. Does unregister have to come even before
> drm_kms_helper_poll_fini() ?

It's just generally the safest approach to first unregister everything,
and only then start cleaning up.

> As for the connectors, because my driver uses an encoder that
> is also a component slave, component_[un]bind_all() should take
> care of [un]registering that.

E.g. this sounds unsafe, because drm assume that encoder lists are static
over the lifetime of the driver. You should make sure no one can get at it
any more first before cleaning up any components.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
