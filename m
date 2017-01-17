From: tnowicki@caviumnetworks.com (Tomasz Nowicki)
Date: Tue, 17 Jan 2017 13:13:18 +0100
Subject: [PATCH v8 05/18] iommu: Only map direct mapped regions
In-Reply-To: <1484127714-3263-6-git-send-email-eric.auger@redhat.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
 <1484127714-3263-6-git-send-email-eric.auger@redhat.com>
Message-ID: <a9618d26-44a8-3453-8b98-f5c46b2e8fa6@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.01.2017 10:41, Eric Auger wrote:
> As we introduced new reserved region types which do not require
> mapping, let's make sure we only map direct mapped regions.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>

Thanks,
Tomasz

>
> ---
>
> v3 -> v4:
> - use region's type and reword commit message and title
> ---
>  drivers/iommu/iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 927878d..41c1906 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -343,6 +343,9 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
>  		start = ALIGN(entry->start, pg_size);
>  		end   = ALIGN(entry->start + entry->length, pg_size);
>
> +		if (entry->type != IOMMU_RESV_DIRECT)
> +			continue;
> +
>  		for (addr = start; addr < end; addr += pg_size) {
>  			phys_addr_t phys_addr;
>
>
