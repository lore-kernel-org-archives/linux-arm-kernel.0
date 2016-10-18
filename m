From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 18 Oct 2016 14:20:28 +0200
Subject: [PATCH v4 3/9] drm/hisilicon/hibmc: Add support for frame buffer
In-Reply-To: <58060529.5010708@huawei.com>
References: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
 <1476763284-100508-4-git-send-email-zourongrong@gmail.com>
 <20161018074922.GZ20761@phenom.ffwll.local>
 <58060529.5010708@huawei.com>
Message-ID: <20161018122028.GB20761@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 07:19:05PM +0800, Rongrong Zou wrote:
> Hi Daniel,
> 
> Thanks for your review!
> 
> ? 2016/10/18 15:49, Daniel Vetter ??:
> > On Tue, Oct 18, 2016 at 12:01:18PM +0800, Rongrong Zou wrote:
> > > Add support for fbdev and framebuffer.
> > > 
> > > Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
> > > ---
> > >   drivers/gpu/drm/hisilicon/hibmc/Makefile          |   2 +-
> > >   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  25 +++
> > >   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  25 +++
> > >   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 257 ++++++++++++++++++++++
> > >   drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c       |  67 ++++++
> > >   5 files changed, 375 insertions(+), 1 deletion(-)
> > >   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
> > > 
> > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> > > index d5c40b8..810a37e 100644
> > > --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> > > +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> > > @@ -1,5 +1,5 @@
> > >   ccflags-y := -Iinclude/drm
> > > -hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_power.o hibmc_ttm.o
> > > +hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_fbdev.o hibmc_drm_power.o hibmc_ttm.o
> > > 
> > >   obj-$(CONFIG_DRM_HISI_HIBMC)	+=hibmc-drm.o
> > >   #obj-y	+= hibmc-drm.o
> > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > > index e118f3b..8ddb763 100644
> > > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > > @@ -66,11 +66,31 @@ static void hibmc_disable_vblank(struct drm_device *dev, unsigned int pipe)
> > > 
> > >   static int hibmc_pm_suspend(struct device *dev)
> > >   {
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> > > +	struct hibmc_drm_device *hidev = drm_dev->dev_private;
> > > +
> > > +	if (hidev->fbdev.initialized) {
> > 
> > What do you need these checks for? This looks a bit fishy tbh ...
> 
> It is delivered from the bochs driver, and I will fix if there are
> any problems, Thanks.

Yeah, existing drivers aren't up to latest best practices. Not sure why
that was added to bochs really ...

> 
> > 
> > > +		console_lock();
> > > +		drm_fb_helper_set_suspend(&hidev->fbdev.helper, 1);
> > > +		console_unlock();
> > 
> > drm_fb_helper_set_suspend_unlocked is the new fancy one. Please use that
> > one instead. Also, that has the check you might need already included,
> > which means you can nuke this entire function here and just call it
> > directly.
> 
> So it should be wrote as:
> static int hibmc_pm_suspend(struct device *dev)
> {
> 	...
> 	drm_kms_helper_poll_disable(drm_dev);
> 	drm_fb_helper_set_suspend_unlocked(&hidev->fbdev.helper, 1);
> 	...
> }
> 
> static int hibmc_pm_resume(struct device *dev)
> {
> 	...
> 	drm_helper_resume_force_mode(drm_dev);
> 	drm_fb_helper_set_suspend_unlocked(&hidev->fbdev.helper, 0);
> 	drm_kms_helper_poll_enable(drm_dev);
> 	...
> }, is it ?

Yup.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
