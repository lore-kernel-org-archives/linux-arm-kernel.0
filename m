From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 6 Dec 2016 17:36:34 +0000
Subject: [RFC v3 05/10] iommu: Do not map reserved regions
In-Reply-To: <1479215363-2898-6-git-send-email-eric.auger@redhat.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
 <1479215363-2898-6-git-send-email-eric.auger@redhat.com>
Message-ID: <fff44f65-d9a6-1e35-97cd-997b92d2fce3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/16 13:09, Eric Auger wrote:
> As we introduced IOMMU_RESV_NOMAP and IOMMU_RESV_MSI regions,
> let's prevent those new regions from being mapped.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/iommu/iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 6ee529f..a4530ad 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -343,6 +343,9 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
>  		start = ALIGN(entry->start, pg_size);
>  		end   = ALIGN(entry->start + entry->length, pg_size);
>  
> +		if (entry->prot & IOMMU_RESV_MASK)

This seems to be the only place that this mask is used, and frankly I
think it's less clear than simply "(IOMMU_RESV_NOMAP | IOMMU_RESV_MSI)"
would be, at which point we may as well drop the mask and special value
trickery altogether. Plus, per my previous comment, if it were to be "if
(entry->type != <direct mapped type>)" instead, that's about as obvious
as it can get.

Robin.

> +			continue;
> +
>  		for (addr = start; addr < end; addr += pg_size) {
>  			phys_addr_t phys_addr;
>  
> 
