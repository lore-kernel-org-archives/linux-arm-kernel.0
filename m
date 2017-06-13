From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Tue, 13 Jun 2017 14:52:54 +0000
Subject: [PATCH 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
In-Reply-To: <20170613131317.GB2868@red-moon>
References: <20170613114829.188036-1-shameerali.kolothum.thodi@huawei.com>
 <20170613114829.188036-3-shameerali.kolothum.thodi@huawei.com>
 <20170613131317.GB2868@red-moon>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838368BC6@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi at arm.com]
> Sent: Tuesday, June 13, 2017 2:13 PM
> To: Shameerali Kolothum Thodi
> Cc: marc.zyngier at arm.com; sudeep.holla at arm.com; will.deacon at arm.com;
> robin.murphy at arm.com; hanjun.guo at linaro.org; Gabriele Paoloni; John
> Garry; iommu at lists.linux-foundation.org; linux-arm-
> kernel at lists.infradead.org; linux-acpi at vger.kernel.org; devel at acpica.org;
> Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
> erratum 161010801
> 
> On Tue, Jun 13, 2017 at 12:48:29PM +0100, shameer wrote:
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
> >  drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-
> v3.c
> > index abe4b88..2636c85 100644
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
> > @@ -1904,14 +1905,29 @@ static void arm_smmu_get_resv_regions(struct
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
> >
> > -	list_add_tail(&region->list, head);
> > +	if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)
> &&
> > +		      dev_is_pci(dev)) {
> > +		int ret;
> > +
> > +		ret = iort_iommu_its_get_resv_regions(dev, head);
> 
> This should be made fwnode dependent, it makes precious little sense to call
> IORT to reserve regions on a DT based platforms (I know the
> ARM_SMMU_OPT_RESV_HW_MSI option is only selected in ACPI (?) but
> comment applies regardless - have you prototyped a DT version too ?).

Ok. I will add a check here.  I don't have a DT version for now as ACPI is our top
priority at the moment.

Thanks,
Shameer
