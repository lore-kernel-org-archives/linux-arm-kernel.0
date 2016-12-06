From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 6 Dec 2016 17:28:08 +0000
Subject: [RFC v3 03/10] iommu: Add new reserved IOMMU attributes
In-Reply-To: <1479215363-2898-4-git-send-email-eric.auger@redhat.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
 <1479215363-2898-4-git-send-email-eric.auger@redhat.com>
Message-ID: <2b80e62b-5a1a-d2d0-eeb0-ad1d7ed0f44b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/16 13:09, Eric Auger wrote:
> IOMMU_RESV_NOMAP is used to tag reserved IOVAs that are not
> supposed to be IOMMU mapped. IOMMU_RESV_MSI tags IOVAs
> corresponding to MSIs that need to be IOMMU mapped.
> 
> IOMMU_RESV_MASK allows to check if the IOVA is reserved.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/linux/iommu.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7f6ebd0..02cf565 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -32,6 +32,10 @@
>  #define IOMMU_NOEXEC	(1 << 3)
>  #define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
>  
> +#define IOMMU_RESV_MASK		0x300 /* Reserved IOVA mask */
> +#define IOMMU_RESV_NOMAP	(1 << 8) /* IOVA that cannot be mapped */
> +#define IOMMU_RESV_MSI		(1 << 9) /* MSI region transparently mapped */

It feels a bit grotty encoding these in prot - NOMAP sort of fits, but
MSI really is something else entirely. On reflection I think a separate
iommu_resv_region::type field would be better, particularly as it's
something we might potentially want to expose via the sysfs entry.

Robin.

> +
>  struct iommu_ops;
>  struct iommu_group;
>  struct bus_type;
> 
