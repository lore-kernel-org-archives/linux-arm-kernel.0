From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 20 Apr 2016 13:55:13 +0100
Subject: [PATCH v7 03/10] iommu: introduce a reserved iova cookie
In-Reply-To: <1461084994-2355-4-git-send-email-eric.auger@linaro.org>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
 <1461084994-2355-4-git-send-email-eric.auger@linaro.org>
Message-ID: <57177C31.9090004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/16 17:56, Eric Auger wrote:
> This patch introduces some new fields in the iommu_domain struct,
> dedicated to reserved iova management.
>
> In a similar way as DMA mapping IOVA window, we need to store
> information related to a reserved IOVA window.
>
> The reserved_iova_cookie will store the reserved iova_domain
> handle. An RB tree indexed by physical address is introduced to
> store the host physical addresses bound to reserved IOVAs.
>
> Those physical addresses will correspond to MSI frame base
> addresses, also referred to as doorbells. Their number should be
> quite limited per domain.
>
> Also a spin_lock is introduced to protect accesses to the iova_domain
> and RB tree. The choice of a spin_lock is driven by the fact the RB
> tree will need to be accessed in MSI controller code not allowed to
> sleep.
>
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>
> ---
> v5 -> v6:
> - initialize reserved_binding_list
> - use a spinlock instead of a mutex
> ---
>   drivers/iommu/iommu.c | 2 ++
>   include/linux/iommu.h | 6 ++++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b9df141..f70ef3b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1073,6 +1073,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>
>   	domain->ops  = bus->iommu_ops;
>   	domain->type = type;
> +	spin_lock_init(&domain->reserved_lock);
> +	domain->reserved_binding_list = RB_ROOT;
>
>   	return domain;
>   }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b3e8c5b..60999db 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -24,6 +24,7 @@
>   #include <linux/of.h>
>   #include <linux/types.h>
>   #include <linux/scatterlist.h>
> +#include <linux/spinlock.h>
>   #include <trace/events/iommu.h>
>
>   #define IOMMU_READ	(1 << 0)
> @@ -83,6 +84,11 @@ struct iommu_domain {
>   	void *handler_token;
>   	struct iommu_domain_geometry geometry;
>   	void *iova_cookie;
> +	void *reserved_iova_cookie;

Why exactly do we need this? From your description, it's for the user of 
the domain to keep track of IOVA allocations in, but then that's 
precisely what the iova_cookie exists for.

> +	/* rb tree indexed by PA, for reserved bindings only */
> +	struct rb_root reserved_binding_list;

Nit: that's more puzzling than helpful - "reserved binding" is 
particularly vague and nondescript, and makes me think of anything but 
MSI descriptors. Plus it's called a list but isn't a list (that said, 
given that we'd typically only expect a handful of entries, and lookups 
are hardly going to be a performance-critical bottleneck, would a simple 
list not suffice?)

> +	/* protects reserved cookie and rbtree manipulation */
> +	spinlock_t reserved_lock;

A cookie is an opaque structure, so any locking it needs would normally 
be hidden within. If on the other hand it's not meant to be opaque at 
this level, then it should probably be something more specific than a 
void * (if at all, as above).

Robin.

>   };
>
>   enum iommu_cap {
>
