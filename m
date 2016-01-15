From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 15 Jan 2016 11:17:30 +0100
Subject: [PATCH v2 13/26] drm/fb_cma_helper: Remove implicit call to
 disable_unused_functions
In-Reply-To: <2014724.QmjXVju9UW@avalon>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-14-git-send-email-maxime.ripard@free-electrons.com>
 <2014724.QmjXVju9UW@avalon>
Message-ID: <20160115101730.GH19130@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 01:13:05AM +0200, Laurent Pinchart wrote:
> Hi Maxime,
> 
> Thank you for the patch.
> 
> On Thursday 14 January 2016 16:24:56 Maxime Ripard wrote:
> > The drm_fbdev_cma_init function always calls the
> > drm_helper_disable_unused_functions. Since it's part of the usual probe
> > process, all the drivers using that helper will end up having their encoder
> > and CRTC disable functions called at probe if their device has not been
> > reported as enabled.
> > 
> > This could be fixed by reading out from the registers the current state of
> > the device if it is enabled, but even that will not handle the case where
> > the device is actually disabled.
> > 
> > Moreover, the drivers using the atomic modesetting expect that their enable
> > and disable callback to be called when the device is already enabled or
> > disabled (respectively).
> > 
> > We can however fix this issue by moving the call to
> > drm_helper_disable_unused_functions out of drm_fbdev_cma_init and make the
> > drivers needing it (all the drivers calling drm_fbdev_cma_init and not
> > using the atomic modesetting) explicitly call it.
> 
> I'd rather add it to all drivers that call drm_fbdev_cma_init(). All the 
> atomic ones must have special code to cope with it that could be rendered 
> useless by the removal of the drm_helper_disable_unused_functions() call. That 
> code should be removed too, and it would be easier to check drivers one by one 
> and fixing them individually (outside of this patch series, unless you insist 
> ;-)) when removing the explicit drm_helper_disable_unused_functions() call. 

I had the same thought, but figured there's really no good reason ever to
do this. I suspect most of that disable_unused_function stuff we have all
over is supreme cargo-cult anyway ;-)

> Other than that the patch looks fine to me.

So went ahead and applied to drm-misc.
-Daniel

> 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/gpu/drm/drm_fb_cma_helper.c | 3 ---
> >  drivers/gpu/drm/imx/imx-drm-core.c  | 1 +
> >  drivers/gpu/drm/sti/sti_drv.c       | 1 +
> >  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 1 +
> >  4 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c
> > b/drivers/gpu/drm/drm_fb_cma_helper.c index c19a62561183..daa98d881142
> > 100644
> > --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> > @@ -348,9 +348,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct
> > drm_device *dev,
> > 
> >  	}
> > 
> > -	/* disable all the possible outputs/crtcs before entering KMS mode */
> > -	drm_helper_disable_unused_functions(dev);
> > -
> >  	ret = drm_fb_helper_initial_config(helper, preferred_bpp);
> >  	if (ret < 0) {
> >  		dev_err(dev->dev, "Failed to set initial hw configuration.\n");
> > diff --git a/drivers/gpu/drm/imx/imx-drm-core.c
> > b/drivers/gpu/drm/imx/imx-drm-core.c index 7b990b4e96d2..e1db57791fc9
> > 100644
> > --- a/drivers/gpu/drm/imx/imx-drm-core.c
> > +++ b/drivers/gpu/drm/imx/imx-drm-core.c
> > @@ -312,6 +312,7 @@ static int imx_drm_driver_load(struct drm_device *drm,
> > unsigned long flags) dev_warn(drm->dev, "Invalid legacyfb_depth. 
> > Defaulting to 16bpp\n"); legacyfb_depth = 16;
> >  	}
> > +	drm_helper_disable_unused_functions(drm);
> >  	imxdrm->fbhelper = drm_fbdev_cma_init(drm, legacyfb_depth,
> >  				drm->mode_config.num_crtc, MAX_CRTC);
> >  	if (IS_ERR(imxdrm->fbhelper)) {
> > diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
> > index 1469987949d8..506b5626f3ed 100644
> > --- a/drivers/gpu/drm/sti/sti_drv.c
> > +++ b/drivers/gpu/drm/sti/sti_drv.c
> > @@ -160,6 +160,7 @@ static int sti_load(struct drm_device *dev, unsigned
> > long flags)
> > 
> >  	drm_mode_config_reset(dev);
> > 
> > +	drm_helper_disable_unused_functions(dev);
> >  	drm_fbdev_cma_init(dev, 32,
> >  			   dev->mode_config.num_crtc,
> >  			   dev->mode_config.num_connector);
> > diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> > b/drivers/gpu/drm/tilcdc/tilcdc_drv.c index 876cad58b1f9..24be31d69701
> > 100644
> > --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> > +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> > @@ -294,6 +294,7 @@ static int tilcdc_load(struct drm_device *dev, unsigned
> > long flags) break;
> >  	}
> > 
> > +	drm_helper_disable_unused_functions(dev);
> >  	priv->fbdev = drm_fbdev_cma_init(dev, bpp,
> >  			dev->mode_config.num_crtc,
> >  			dev->mode_config.num_connector);
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
