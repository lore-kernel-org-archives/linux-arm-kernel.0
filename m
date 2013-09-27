From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Sep 2013 11:23:07 +0100
Subject: [PATCH 4/9] iommu/arm-smmu: Check for num_context_irqs > 0 to
 avoid divide by zero exception
In-Reply-To: <20130927090348.GF3315@alberich>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-5-git-send-email-andreas.herrmann@calxeda.com>
 <20130927084154.GB8319@mudshark.cambridge.arm.com>
 <20130927090348.GF3315@alberich>
Message-ID: <20130927102307.GE9057@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 10:03:48AM +0100, Andreas Herrmann wrote:
> On Fri, Sep 27, 2013 at 04:41:54AM -0400, Will Deacon wrote:
> > On Thu, Sep 26, 2013 at 11:36:16PM +0100, Andreas Herrmann wrote:
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index 4307fbc..de9dd60 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> > > @@ -1822,7 +1822,11 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
> > >  			 num_irqs, smmu->num_global_irqs);
> > >  		smmu->num_global_irqs = num_irqs;
> > >  	}
> > > -	smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;
> > 
> > Why are you deleting this line?
> 
> Because I felt it's redundant in some cases and erroneously I thought
> it could be bogus if num_irqs < num_global_irqs.
> Of course the latter is wrong, as num_global_irqs is corrected two
> lines above.
> 
> Now I think it's always redundant. num_context_irqs is only
> incremented here
> 
>                if (num_irqs > smmu->num_global_irqs)
>                         smmu->num_context_irqs++;

Yes, I think you're right. This leaves us in a situation where getting the
#global-interrupts property wrong will trigger a warning followed
immediately by a failure to probe. That means we could simply augment the
current check and make it fatal instead:

--->8

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2931921..03ffbae 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1799,12 +1799,11 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
                        smmu->num_context_irqs++;
        }
 
-       if (num_irqs < smmu->num_global_irqs) {
+       if (num_irqs <= smmu->num_global_irqs) {
                dev_warn(dev, "found %d interrupts but expected at least %d\n",
-                        num_irqs, smmu->num_global_irqs);
-               smmu->num_global_irqs = num_irqs;
+                        num_irqs, smmu->num_global_irqs + 1);
+               return -ENODEV;
        }
-       smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;
 
        smmu->irqs = devm_kzalloc(dev, sizeof(*smmu->irqs) * num_irqs,
                                  GFP_KERNEL);

8<---

What do you think?

Will
