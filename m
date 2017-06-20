From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Tue, 20 Jun 2017 13:11:28 +0000
Subject: [PATCH v2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
In-Reply-To: <311de3aa-aec9-f403-d9a8-48b3e3de54c3@arm.com>
References: <20170619154500.92336-1-shameerali.kolothum.thodi@huawei.com>
 <20170619154500.92336-3-shameerali.kolothum.thodi@huawei.com>
 <311de3aa-aec9-f403-d9a8-48b3e3de54c3@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838385EC5@FRAEML521-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Monday, June 19, 2017 6:42 PM
> To: Shameerali Kolothum Thodi; lorenzo.pieralisi at arm.com;
> marc.zyngier at arm.com; sudeep.holla at arm.com; will.deacon at arm.com;
> hanjun.guo at linaro.org
> Cc: Gabriele Paoloni; John Garry; iommu at lists.linux-foundation.org; linux-
> arm-kernel at lists.infradead.org; linux-acpi at vger.kernel.org;
> devel at acpica.org; Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3:Enable ACPI based
> HiSilicon erratum 161010801
> 
> On 19/06/17 16:45, shameer wrote:
> > The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> > platforms Hip06/Hip07 to support the SMMU mappings for MSI
> transactions.
> >
> > On these platforms GICv3 ITS translator is presented with the deviceID
> > by extending the MSI payload data to 64 bits to include the deviceID.
> > Hence, the PCIe controller on this platforms has to differentiate the
> > MSI payload against other DMA payload and has to modify the MSI
> payload.
> > This basically makes it difficult for this platforms to have a SMMU
> > translation for MSI.
> >
> > This patch implements a ACPI table based quirk to reserve the hw msi
> > regions in the smmu-v3 driver which means these address regions will
> > not be translated and will be excluded from iova allocations.
> >
> > Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 29 ++++++++++++++++++++++++-----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-
> v3.c
> > index abe4b88..f03c63b 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -597,6 +597,7 @@ struct arm_smmu_device {
> >  	u32				features;
> >
> >  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> > +#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
> >  	u32				options;
> >
> >  	struct arm_smmu_cmdq		cmdq;
> > @@ -1904,14 +1905,31 @@ static void arm_smmu_get_resv_regions(struct
> device *dev,
> >  				      struct list_head *head)
> >  {
> >  	struct iommu_resv_region *region;
> > +	struct arm_smmu_device *smmu;
> > +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> >  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> >
> > -	region = iommu_alloc_resv_region(MSI_IOVA_BASE,
> MSI_IOVA_LENGTH,
> > -					 prot, IOMMU_RESV_SW_MSI);
> > -	if (!region)
> > -		return;
> > +	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
> > +
> > +	if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)
> &&
> 
> AFAICS, iommu_get_resv_regions is only ever called on devices which are
> at least already part of an iommu_group, so smmu should never
> legitimately be NULL. I'd say if you really want to be robust against
> flagrant API misuse, at least WARN_ON and bail out immediately.

Ok.  I will address this in next revision.

Thanks,
Shameer
