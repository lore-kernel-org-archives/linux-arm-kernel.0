From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 27 Sep 2013 11:24:25 +0200
Subject: [PATCH 1/9] iommu/arm-smmu: Switch to arch_initcall for driver
 registration
In-Reply-To: <20130927085811.GD8319@mudshark.cambridge.arm.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-2-git-send-email-andreas.herrmann@calxeda.com>
 <20130927085811.GD8319@mudshark.cambridge.arm.com>
Message-ID: <20130927092425.GG3315@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 04:58:12AM -0400, Will Deacon wrote:
> On Thu, Sep 26, 2013 at 11:36:13PM +0100, Andreas Herrmann wrote:
> > This should ensure that arm-smmu is initialized before other drivers
> > start handling devices that propably need smmu support.
> > 
> > Also remove module_exit function as we most likely never want to
> > unload this driver.
> 
> Doesn't hurt to leave the exit function there though, right?

Yes.

> > Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> > ---
> >  drivers/iommu/arm-smmu.c |    8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 181c9ba..6808577 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1976,13 +1976,7 @@ static int __init arm_smmu_init(void)
> >  	return 0;
> >  }
> >  
> > -static void __exit arm_smmu_exit(void)
> > -{
> > -	return platform_driver_unregister(&arm_smmu_driver);
> > -}
> > -
> > -module_init(arm_smmu_init);
> > -module_exit(arm_smmu_exit);
> > +arch_initcall(arm_smmu_init);
> 
> Why not subsys_initcall, like the other ARM IOMMUs?

No specific reason. I just tried to load the driver at the earliest
point during boot.

I just retested successful with subsys_initcall. The initialization
sequence looks fine (and yes, arch_initcall is overkill).

Will adapt this.


Andreas
