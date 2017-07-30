From: eric.auger@redhat.com (Auger Eric)
Date: Sun, 30 Jul 2017 12:39:37 +0200
Subject: [PATCH 2/2] vfio/type1: Give hardware MSI regions precedence
In-Reply-To: <d42df6c9d7d854a6b5c4586b02000678e71916fc.1501163100.git.robin.murphy@arm.com>
References: <d244103e295a81d7f556f297adc79c2ac45345cc.1501163100.git.robin.murphy@arm.com>
 <d42df6c9d7d854a6b5c4586b02000678e71916fc.1501163100.git.robin.murphy@arm.com>
Message-ID: <60052d02-276e-ed12-f372-14ce166f50ed@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,
On 27/07/2017 16:54, Robin Murphy wrote:
> If the IOMMU driver advertises 'real' reserved regions for MSIs, but
> still includes the software-managed region as well, we are currently
> blind to the former and will configure the IOMMU domain to map MSIs into
> the latter, which is unlikely to work as expected.
> 
> Since it would take a ridiculous hardware topology for both regions to
> be valid (which would be rather difficult to support in general), we
> should be safe to assume that the presence of any hardware regions makes
> the software region irrelevant. However, the IOMMU driver might still
> advertise the software region by default, particularly if the hardware
> regions are filled in elsewhere by generic code, so it might not be fair
> for VFIO to be super-strict about not mixing them. To that end, make
> vfio_iommu_has_sw_msi() robust against the presence of both region types
> at once, so that we end up doing what is almost certainly right, rather
> than what is almost certainly wrong.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/vfio/vfio_iommu_type1.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 2328be628f21..92155cce926d 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1169,13 +1169,21 @@ static bool vfio_iommu_has_sw_msi(struct iommu_group *group, phys_addr_t *base)
>  	INIT_LIST_HEAD(&group_resv_regions);
>  	iommu_get_group_resv_regions(group, &group_resv_regions);
>  	list_for_each_entry(region, &group_resv_regions, list) {
> +		/*
> +		 * The presence of any 'real' MSI regions should take
> +		 * precedence over the software-managed one if the
> +		 * IOMMU driver happens to advertise both types.
> +		 */
> +		if (region->type == IOMMU_RESV_MSI) {
> +			ret = false;
> +			break;
> +		}
> +
>  		if (region->type == IOMMU_RESV_SW_MSI) {
>  			*base = region->start;
>  			ret = true;
> -			goto out;
>  		}
>  	}
> -out:
>  	list_for_each_entry_safe(region, next, &group_resv_regions, list)
>  		kfree(region);
>  	return ret;
> 
