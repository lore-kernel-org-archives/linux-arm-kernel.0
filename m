From: alex.williamson@redhat.com (Alex Williamson)
Date: Thu, 10 Aug 2017 13:16:18 -0600
Subject: [PATCH 1/2] vfio/type1: Cope with hardware MSI reserved regions
In-Reply-To: <d244103e295a81d7f556f297adc79c2ac45345cc.1501163100.git.robin.murphy@arm.com>
References: <d244103e295a81d7f556f297adc79c2ac45345cc.1501163100.git.robin.murphy@arm.com>
Message-ID: <20170810131618.30500ce6@w520.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Jul 2017 15:54:13 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

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

I've pushed these to my next branch with Eric's R-b and Shameerali's
T-b for v4.14.  Thanks,

Alex

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 8549cb111627..2328be628f21 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1265,8 +1265,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	INIT_LIST_HEAD(&domain->group_list);
>  	list_add(&group->next, &domain->group_list);
>  
> -	msi_remap = resv_msi ? irq_domain_check_msi_remap() :
> -				iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
> +	msi_remap = irq_domain_check_msi_remap() ||
> +		    iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
>  
>  	if (!allow_unsafe_interrupts && !msi_remap) {
>  		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
