From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 22 Feb 2015 19:03:25 +0100
Subject: [PATCHv2 1/2] drm: atmel-hlcdc: Add PM suspend/resume support
In-Reply-To: <54E30E2B.5070407@samsung.com>
References: <1423774163-4752-1-git-send-email-sylvain.rochet@finsecur.com>
 <1423774163-4752-2-git-send-email-sylvain.rochet@finsecur.com>
 <54E30E2B.5070407@samsung.com>
Message-ID: <20150222180325.GA18233@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrzej,

On Tue, Feb 17, 2015 at 10:47:23AM +0100, Andrzej Hajda wrote:
> On 02/12/2015 09:49 PM, Sylvain Rochet wrote:
> > +static int atmel_hlcdc_dc_resume(struct drm_device *dev)
> > +{
> > +	struct drm_crtc *crtc;
> > +
> > +	drm_modeset_lock_all(dev);
> > +
> > +	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> > +		struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
> > +		crtc_funcs->enable(crtc);
> 
> What about crtc's which were disabled before suspend, they will be
> enabled here unconditionally.

Indeed, fixed in v3.


> >  	struct atmel_hlcdc_dc *dc = dev->dev_private;
> > @@ -488,6 +518,8 @@ static struct drm_driver atmel_hlcdc_dc_driver = {
> >  	.driver_features = DRIVER_HAVE_IRQ | DRIVER_GEM | DRIVER_MODESET,
> >  	.preclose = atmel_hlcdc_dc_preclose,
> >  	.lastclose = atmel_hlcdc_dc_lastclose,
> > +	.suspend = atmel_hlcdc_dc_suspend,
> > +	.resume = atmel_hlcdc_dc_resume,
> 
> These callbacks are obsolete and should not be used, additionally core
> don't call them if drm_device have DRIVER_MODESET flag.

Oh!, that might explain the struggle I had understanding when they were 
actually called. Removed in v3.


> > +#ifdef CONFIG_PM
> > +static int atmel_hlcdc_dc_drm_suspend(struct device *dev)
> > +{
> > +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> > +	pm_message_t message;
> > +
> > +	if (pm_runtime_suspended(dev) || !drm_dev)
> 
> Nitpick, !drm_dev is always false, is not?

I guess so, platform_set_drvdata() is called during probe so it can't be 
null here. Removed in v3.


> > +		return 0;
> > +
> > +	message.event = PM_EVENT_SUSPEND;
> > +	return atmel_hlcdc_dc_suspend(drm_dev, message);
> 
> If you remove obsolete callbacks you can move suspend code here,
> the same for resume.
> 
> > +}
> > +
> > +static int atmel_hlcdc_dc_drm_resume(struct device *dev)
> > +{
> > +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> > +
> > +	if (pm_runtime_suspended(dev) || !drm_dev)
> > +		return 0;
> > +
> > +	return atmel_hlcdc_dc_resume(drm_dev);
> 
> Ditto x2

Indeed, merged in v3.


Thank you very much for this review ! :)

Sylvain
