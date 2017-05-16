From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Tue, 16 May 2017 13:54:23 +0000
Subject: [RFC v1 6/7] iommu/arm-smmu-v3: Rearrange msi resv alloc functions
In-Reply-To: <d2d90929-6e79-70a3-5c82-a25e67931b4a@arm.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
 <20170513094731.3676-7-shameerali.kolothum.thodi@huawei.com>
 <d2d90929-6e79-70a3-5c82-a25e67931b4a@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838350A37@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Tuesday, May 16, 2017 2:28 PM
> To: Shameerali Kolothum Thodi; will.deacon at arm.com;
> mark.rutland at arm.com; lorenzo.pieralisi at arm.com; hanjun.guo at linaro.org
> Cc: devicetree at vger.kernel.org; Gabriele Paoloni; John Garry; Linuxarm;
> linux-acpi at vger.kernel.org; iommu at lists.linux-foundation.org; Wangzhou
> (B); Guohanjun (Hanjun Guo); linux-arm-kernel at lists.infradead.org;
> devel at acpica.org
> Subject: Re: [RFC v1 6/7] iommu/arm-smmu-v3: Rearrange msi resv alloc
> functions
> 
> On 13/05/17 10:47, shameer wrote:
> > This moves the SW MSI reserve region allocation to probe fn.
> 
> Why?

Sure, I will modify the commit message to mention about the next patch
where we will add the quirk to modify the default SW MSI region with a HW MSI
region on Hip06/07 platforms.

> > Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 36 +++++++++++++++++++++++++++---
> ------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-
> v3.c
> > index 770cc9e..e7a8a50 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -619,6 +619,9 @@ struct arm_smmu_device {
> >
> >  	/* IOMMU core code handle */
> >  	struct iommu_device		iommu;
> > +
> > +	/* MSI Reserve region */
> > +	struct iommu_resv_region        *msi_region;
> >  };
> >
> >  /* SMMU private data for each master */
> > @@ -1960,15 +1963,12 @@ static int arm_smmu_of_xlate(struct device
> *dev, struct of_phandle_args *args)
> >  static void arm_smmu_get_resv_regions(struct device *dev,
> >  				      struct list_head *head)
> >  {
> > -	struct iommu_resv_region *region;
> > -	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > -
> > -	region = iommu_alloc_resv_region(MSI_IOVA_BASE,
> MSI_IOVA_LENGTH,
> > -					 prot, IOMMU_RESV_SW_MSI);
> > -	if (!region)
> > -		return;
> > +	struct iommu_domain *domain =
> iommu_get_domain_for_dev(dev);
> > +	struct arm_smmu_domain *smmu_domain =
> to_smmu_domain(domain);
> > +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> 
> There's never any need for the domain dance if you don't need the
> domain, just pull the smmu out of the device's iommu_fwspec.

Ok. That makes sense. Thanks.

> > -	list_add_tail(&region->list, head);
> > +	if (smmu && smmu->msi_region)
> > +		list_add_tail(&smmu->msi_region->list, head);
> 
> Have you considered what happens for the second and subsequent domains
> allocated on this SMMU? I can't see that ending well.

Yes, I probably missed this part. I will recheck this.

Thanks,
Shameer
