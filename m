From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 18 Aug 2014 20:38:25 +0800
Subject: [PATCH v2] imx-drm: imx-drm-core: add suspend/resume support
In-Reply-To: <53F1AE97.8090807@samsung.com>
References: <1406269240-24622-1-git-send-email-shawn.guo@freescale.com>
 <53F1AE97.8090807@samsung.com>
Message-ID: <20140818123823.GK2114@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,

On Mon, Aug 18, 2014 at 09:43:19AM +0200, Andrzej Hajda wrote:
> > diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
> > index def8280d7ee6..ab41152089a3 100644
> > --- a/drivers/staging/imx-drm/imx-drm-core.c
> > +++ b/drivers/staging/imx-drm/imx-drm-core.c
> > @@ -696,6 +696,29 @@ static int imx_drm_platform_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_PM_SLEEP
> > +static int imx_drm_suspend(struct device *dev)
> > +{
> > +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> > +
> > +	drm_kms_helper_poll_disable(drm_dev);
> 
> drm_dev can be NULL here. You should add check before.

The drvdata is set to drm_dev in drm_driver .load() hook.  So are you
saying that .suspend() hook could possibly be called before the .load()
hook gets called?

Shawn

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_drm_resume(struct device *dev)
> > +{
> > +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> > +
> > +	drm_helper_resume_force_mode(drm_dev);
> 
> ditto
