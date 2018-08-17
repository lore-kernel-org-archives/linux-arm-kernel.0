From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Fri, 17 Aug 2018 15:27:16 +0000
Subject: [PATCH 1/3] iommu: Add fast hook for getting DMA domains
In-Reply-To: <4d50587e62c16f7b5cfc45dee808d774655155cf.1534250425.git.robin.murphy@arm.com>
References: <cover.1534250425.git.robin.murphy@arm.com>
 <4d50587e62c16f7b5cfc45dee808d774655155cf.1534250425.git.robin.murphy@arm.com>
Message-ID: <b2b043f7-6f28-42e4-d630-d9694d34b5b6@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 14.08.2018 16:04, Robin Murphy wrote:
> While iommu_get_domain_for_dev() is the robust way for arbitrary IOMMU
> API callers to retrieve the domain pointer, for DMA ops domains it
> doesn't scale well for large systems and multi-queue devices, since the
> momentary refcount adjustment will lead to exclusive cacheline contention
> when multiple CPUs are operating in parallel on different mappings for
> the same device.
> 
> In the case of DMA ops domains, however, this refcounting is actually
> unnecessary, since they already imply that the group exists and is
> managed by platform code and IOMMU internals (by virtue of
> iommu_group_get_for_dev()) such that a reference will already be held
> for the lifetime of the device. Thus we can avoid the bottleneck by
> providing a fast lookup specifically for the DMA code to retrieve the
> default domain it already knows it has set up - a simple read-only
> dereference plays much nicer with cache-coherency protocols.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iommu.c | 9 +++++++++
>   include/linux/iommu.h | 1 +
>   2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 63b37563db7e..63c586875df5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1379,6 +1379,15 @@ struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
>   
> +/*
> + * For IOMMU_DOMAIN_DMA implementations which already provide their own
> + * guarantees that the group and its default domain are valid and correct.
> + */
> +struct iommu_domain *iommu_get_dma_domain(struct device *dev)
> +{
> +	return dev->iommu_group->default_domain;
> +}

After some preliminary tests I'm seeing a ~10% performance improvement 
on one of our chips (nxp ls1046a) which is pretty nice. :-)
Any chance of making the function inline?
If not, shouldn't an EXPORT_SYMBOL_GPL be added?

---
Thanks & Best Regards, Laurentiu
