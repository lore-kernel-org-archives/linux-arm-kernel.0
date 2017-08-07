From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Mon, 7 Aug 2017 08:21:40 +0000
Subject: [PATCH v5 1/2] ACPI/IORT: Add ITS address regions reservation
 helper
In-Reply-To: <b478d1b4-5993-9459-adfc-dec05525d72e@arm.com>
References: <20170801104913.71912-1-shameerali.kolothum.thodi@huawei.com>
 <20170801104913.71912-2-shameerali.kolothum.thodi@huawei.com>
 <b478d1b4-5993-9459-adfc-dec05525d72e@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8383C7EF8@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Friday, August 04, 2017 5:57 PM
> To: Shameerali Kolothum Thodi; lorenzo.pieralisi at arm.com;
> marc.zyngier at arm.com; sudeep.holla at arm.com; will.deacon at arm.com;
> hanjun.guo at linaro.org
> Cc: Gabriele Paoloni; John Garry; iommu at lists.linux-foundation.org; linux-
> arm-kernel at lists.infradead.org; linux-acpi at vger.kernel.org;
> devel at acpica.org; Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> Subject: Re: [PATCH v5 1/2] ACPI/IORT: Add ITS address regions reservation
> helper
> 
> On 01/08/17 11:49, Shameer Kolothum wrote:
> > On some platforms ITS address regions have to be excluded from normal
> > IOVA allocation in that they are detected and decoded in a HW specific
> > way by system components and so they cannot be considered normal
> IOVA
> > address space.
> >
> > Add an helper function that retrieves ITS address regions through IORT
> > device <-> ITS mappings and reserves it so that these regions will not
> > be translated by IOMMU and will be excluded from IOVA allocations.
> 
> I've just realised that we no longer seem to have a check that ensures
> the regions are only reserved on platforms that need it - if not, then
> we're going to break everything else that does have an ITS behind SMMU
> translation as expected.

Right. I had this doubt, but then my thinking was that we will have the SW_MSI
regions for those and will end up  using that. But that doesn?t seems
to be the case now.

> It feels like IORT should know enough to be able to make that decision
> internally, but if not (or if it would be hideous to do so), then I
> guess my idea for patch #2 was a bust and we probably do need to go back
> to calling directly from the SMMU driver based on the SMMU model.

It might be possible to do that check inside iort code, but then we have to find
the  smmu node first and check the model number. I think it will be more
cleaner if SMMU driver makes that check and call the
iommu_dma_get_msi_resv_regions().

If you are Ok with that I will quickly rework and send out the next version.

Thanks,
Shameer
