From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 25 Jul 2014 10:20:39 +0200
Subject: [PATCH] imx-drm: imx-drm-core: add suspend/resume support
In-Reply-To: <20140724145934.GD8821@dragon>
References: <1406193474-13695-1-git-send-email-shawn.guo@freescale.com>
 <1406195275.4590.18.camel@weser.hi.pengutronix.de>
 <20140724095430.GM21766@n2100.arm.linux.org.uk>
 <20140724103859.GS15237@phenom.ffwll.local>
 <20140724145934.GD8821@dragon>
Message-ID: <20140725082039.GO4747@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 10:59:36PM +0800, Shawn Guo wrote:
> On Thu, Jul 24, 2014 at 12:38:59PM +0200, Daniel Vetter wrote:
> > > > > +static int imx_drm_suspend(struct device *dev)
> > > > > +{
> > > > > +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> > > > > +	struct drm_connector *connector;
> > > > > +
> > > > > +	drm_kms_helper_poll_disable(drm_dev);
> > > > > +
> > > > 
> > > > That's ok.
> > > > 
> > > > > +	drm_modeset_lock_all(drm_dev);
> > > > > +	list_for_each_entry(connector, &drm_dev->mode_config.connector_list, head) {
> > > > > +		if (connector->funcs->dpms)
> > > > > +			connector->funcs->dpms(connector, DRM_MODE_DPMS_OFF);
> > > > > +	}
> > > > 
> > > > Don't touch DPMS state here. See below.
> > > 
> > > In which case, how else does the hardware get placed into a low power
> > > mode on suspend?
> > > 
> > > DRM has nothing provided, and this is left up to each DRM driver to
> > > implement (probably because it tends to be very driver specific.)
> > > i915 for example calls the CRTC DPMS function with DRM_MODE_DPMS_OFF.
> > > 
> > > This provides a similar mechanism, but also informs the connector, any
> > > bridge, and encoder associated with the connector as well as the CRTC
> > > to place themselves into a low power mode (which is what
> > > DRM_MODE_DPMS_OFF should be doing anyway.)
> > 
> > Well you need to call internal functions to make sure you can restore the
> > state again. Not sure any more how that all works with the crtc helpers
> > and whether they restore dpms state properly at all. i915 uses something
> > completely different nowadays.
> 
> Is it okay to do what exynos driver does, i.e. saving/restoring the dpms
> state before/after calling connector .dpms function?
> 
>         list_for_each_entry(connector, &drm_dev->mode_config.connector_list, head) {
>                 int old_dpms = connector->dpms;
> 
>                 if (connector->funcs->dpms)
>                         connector->funcs->dpms(connector, DRM_MODE_DPMS_OFF);
> 
>                 /* Set the old mode back to the connector for resume */
>                 connector->dpms = old_dpms;
>         }

I'm not sure whether that will get you correct behavior since iirc the
crtc helpers aren't terribly good at restoring the right dpms state.
drm_helper_resume_force_mode simple does a modeset, and that has an
implicit dpms on when enabling the crtc. Someone might want to tackle
this, but thus far it doesn't seem to have been too annoying. I think the
best way would be to do this as part of atomic modeset, where we can
supply the desired dpms state directly.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
