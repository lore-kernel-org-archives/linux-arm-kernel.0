From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 27 Sep 2013 12:45:57 +0200
Subject: [PATCH 8/9] iommu/arm-smmu: Introduce a default fault handler
In-Reply-To: <20130927100902.GD9057@mudshark.cambridge.arm.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-9-git-send-email-andreas.herrmann@calxeda.com>
 <20130927100902.GD9057@mudshark.cambridge.arm.com>
Message-ID: <20130927104557.GN3315@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 06:09:02AM -0400, Will Deacon wrote:
> On Thu, Sep 26, 2013 at 11:36:20PM +0100, Andreas Herrmann wrote:
> > And register the default handler for domains that are created during
> > device isolation.
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> > ---
> >  drivers/iommu/arm-smmu.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 48f3bfb..380c2a0 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1816,6 +1816,13 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
> >  	return 0;
> >  }
> >  
> > +static int arm_smmu_context_fault_handler(struct iommu_domain *domain,
> > +		struct device *dev, unsigned long iova, int flags, void *arg)
> > +{
> > +	dev_warn(dev, "context fault: iova=0x%08lx, flags=0x%x\n", iova, flags);
> > +	return 0;
> 
> Maybe we're better off sandwiching this into arm_smmu_context_fault when
> report_iommu_fault doesn't handle the fault.

... which would allow us to dump the entire cb fault syndrome register.
(which has more info than what we get from above flags)

Fine with me.



Andreas
