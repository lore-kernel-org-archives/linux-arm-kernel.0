From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 21 May 2014 11:35:49 +0530
Subject: [PATCH 2/2] dmaengine: sa11x0: remove broken #ifdef
In-Reply-To: <1399565317.9018.4.camel@smile.fi.intel.com>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-2-git-send-email-arnd@arndb.de>
 <1399565317.9018.4.camel@smile.fi.intel.com>
Message-ID: <20140521060548.GM21128@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 09:38:37PM +0530, Shevchenko, Andriy wrote:
> On Thu, 2014-05-08 at 16:56 +0200, Arnd Bergmann wrote:
> > The sa11x0_dma_pm_ops unconditionally reference sa11x0_dma_resume
> > and sa11x0_dma_suspend, which currently breaks if CONFIG_PM_SLEEP
> > is disabled.
> > 
> > There is probably a better way to remove the reference in this
> > case, but the safe choice is to have the suspend/resume code always
> > built in the driver.
> 
> Maybe you could create a macro in pm.h for *_noirq version of
> suspend/resume? However, like we discussed with Vinod it's much better
> to use suspend_late/resume_early for DMAC device drivers, though I have
> no idea if it works for sa11x0.
It should work as the guidance is not client/controller specfic. But I think
thats not the point here as the fix is not related to how suspend is
implemented..

-- 
~Vinod

> 
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: dmaengine at vger.kernel.org
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/dma/sa11x0-dma.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
> > index ab26d46..5ebdfbc 100644
> > --- a/drivers/dma/sa11x0-dma.c
> > +++ b/drivers/dma/sa11x0-dma.c
> > @@ -113,11 +113,9 @@ struct sa11x0_dma_phy {
> >  	struct sa11x0_dma_desc	*txd_load;
> >  	unsigned		sg_done;
> >  	struct sa11x0_dma_desc	*txd_done;
> > -#ifdef CONFIG_PM_SLEEP
> >  	u32			dbs[2];
> >  	u32			dbt[2];
> >  	u32			dcsr;
> > -#endif
> >  };
> >  
> >  struct sa11x0_dma_dev {
> > @@ -984,7 +982,6 @@ static int sa11x0_dma_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > -#ifdef CONFIG_PM_SLEEP
> >  static int sa11x0_dma_suspend(struct device *dev)
> >  {
> >  	struct sa11x0_dma_dev *d = dev_get_drvdata(dev);
> > @@ -1054,7 +1051,6 @@ static int sa11x0_dma_resume(struct device *dev)
> >  
> >  	return 0;
> >  }
> > -#endif
> >  
> >  static const struct dev_pm_ops sa11x0_dma_pm_ops = {
> >  	.suspend_noirq = sa11x0_dma_suspend,
> 
> 
> -- 
> Andy Shevchenko <andriy.shevchenko@intel.com>
> Intel Finland Oy

-- 
