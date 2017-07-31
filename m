From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Mon, 31 Jul 2017 15:59:39 +0000
Subject: [PATCH 1/2] vfio/type1: Cope with hardware MSI reserved regions
In-Reply-To: <d244103e295a81d7f556f297adc79c2ac45345cc.1501163100.git.robin.murphy@arm.com>
References: <d244103e295a81d7f556f297adc79c2ac45345cc.1501163100.git.robin.murphy@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8383C25EA@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Thursday, July 27, 2017 3:54 PM
> To: alex.williamson at redhat.com
> Cc: kvm at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; eric.auger at redhat.com; Shameerali Kolothum
> Thodi; marc.zyngier at arm.com
> Subject: [PATCH 1/2] vfio/type1: Cope with hardware MSI reserved regions
> 
> For ARM-based systems with a GICv3 ITS to provide interrupt isolation,
> but hardware limitations which are worked around by having MSIs bypass
> SMMU translation (e.g. HiSilicon Hip06/Hip07), VFIO neglects to check
> for the IRQ_DOMAIN_FLAG_MSI_REMAP capability, (and thus erroneously
> demands unsafe_interrupts) if a software-managed MSI region is absent.
> 
> Fix this by always checking for isolation capability at both the IRQ
> domain and IOMMU domain levels, rather than predicating that on whether
> MSIs require an IOMMU mapping (which was always slightly tenuous logic).
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c
> index 8549cb111627..2328be628f21 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1265,8 +1265,8 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
>  	INIT_LIST_HEAD(&domain->group_list);
>  	list_add(&group->next, &domain->group_list);
> 
> -	msi_remap = resv_msi ? irq_domain_check_msi_remap() :
> -				iommu_capable(bus,
> IOMMU_CAP_INTR_REMAP);
> +	msi_remap = irq_domain_check_msi_remap() ||
> +		    iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
> 
>  	if (!allow_unsafe_interrupts && !msi_remap) {
>  		pr_warn("%s: No interrupt remapping support.  Use the
> module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support
> on this platform\n",

Verified these patches(1 and 2) on HiSilicon Hip07 platform along with HW MSI resv
region patches[1]. Please feel free to add, 

Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Thanks,
Shameer

1. https://www.spinics.net/lists/arm-kernel/msg595847.html
