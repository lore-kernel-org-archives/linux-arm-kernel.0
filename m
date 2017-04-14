From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Thu, 13 Apr 2017 20:48:48 -0400
Subject: [PATCH 2/2] xen/arm,arm64: rename __generic_dma_ops to
 xen_get_dma_ops
In-Reply-To: <1492117462-19886-2-git-send-email-sstabellini@kernel.org>
References: <1492117462-19886-1-git-send-email-sstabellini@kernel.org>
 <1492117462-19886-2-git-send-email-sstabellini@kernel.org>
Message-ID: <a61c9f25-37fb-2c30-f723-e18560a03e26@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/13/2017 05:04 PM, Stefano Stabellini wrote:
> Now that __generic_dma_ops is a xen specific function, rename it to
> xen_get_dma_ops. Change all the call sites appropriately.
>
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> CC: linux at armlinux.org.uk
> CC: catalin.marinas at arm.com
> CC: will.deacon at arm.com
> CC: boris.ostrovsky at oracle.com
> CC: jgross at suse.com
> CC: Julien Grall <julien.grall@arm.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

(+Konrad)


> ---
>  drivers/xen/swiotlb-xen.c       |  8 ++++----
>  include/xen/arm/page-coherent.h | 20 ++++++++++----------
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index e8cef1a..8dab0d3 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -693,8 +693,8 @@ void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>  		     unsigned long attrs)
>  {
>  #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> -	if (__generic_dma_ops(dev)->mmap)
> -		return __generic_dma_ops(dev)->mmap(dev, vma, cpu_addr,
> +	if (xen_get_dma_ops(dev)->mmap)
> +		return xen_get_dma_ops(dev)->mmap(dev, vma, cpu_addr,
>  						    dma_addr, size, attrs);
>  #endif
>  	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
> @@ -711,7 +711,7 @@ void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>  			unsigned long attrs)
>  {
>  #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> -	if (__generic_dma_ops(dev)->get_sgtable) {
> +	if (xen_get_dma_ops(dev)->get_sgtable) {
>  #if 0
>  	/*
>  	 * This check verifies that the page belongs to the current domain and
> @@ -721,7 +721,7 @@ void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>  		unsigned long bfn = PHYS_PFN(dma_to_phys(dev, handle));
>  		BUG_ON (!page_is_ram(bfn));
>  #endif
> -		return __generic_dma_ops(dev)->get_sgtable(dev, sgt, cpu_addr,
> +		return xen_get_dma_ops(dev)->get_sgtable(dev, sgt, cpu_addr,
>  							   handle, size, attrs);
>  	}
>  #endif
> diff --git a/include/xen/arm/page-coherent.h b/include/xen/arm/page-coherent.h
> index b0a2bfc..b1b4ecd 100644
> --- a/include/xen/arm/page-coherent.h
> +++ b/include/xen/arm/page-coherent.h
> @@ -5,7 +5,7 @@
>  #include <asm/dma-mapping.h>
>  #include <linux/dma-mapping.h>
>
> -static inline const struct dma_map_ops *__generic_dma_ops(struct device *dev)
> +static inline const struct dma_map_ops *xen_get_dma_ops(struct device *dev)
>  {
>  	if (dev && dev->archdata.dev_dma_ops)
>  		return dev->archdata.dev_dma_ops;
> @@ -27,13 +27,13 @@ void __xen_dma_sync_single_for_device(struct device *hwdev,
>  static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
>  {
> -	return __generic_dma_ops(hwdev)->alloc(hwdev, size, dma_handle, flags, attrs);
> +	return xen_get_dma_ops(hwdev)->alloc(hwdev, size, dma_handle, flags, attrs);
>  }
>
>  static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
>  {
> -	__generic_dma_ops(hwdev)->free(hwdev, size, cpu_addr, dma_handle, attrs);
> +	xen_get_dma_ops(hwdev)->free(hwdev, size, cpu_addr, dma_handle, attrs);
>  }
>
>  static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
> @@ -57,7 +57,7 @@ static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
>  	 * specific function.
>  	 */
>  	if (local)
> -		__generic_dma_ops(hwdev)->map_page(hwdev, page, offset, size, dir, attrs);
> +		xen_get_dma_ops(hwdev)->map_page(hwdev, page, offset, size, dir, attrs);
>  	else
>  		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
>  }
> @@ -75,8 +75,8 @@ static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
>  	 * specific function.
>  	 */
>  	if (pfn_valid(pfn)) {
> -		if (__generic_dma_ops(hwdev)->unmap_page)
> -			__generic_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);
> +		if (xen_get_dma_ops(hwdev)->unmap_page)
> +			xen_get_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);
>  	} else
>  		__xen_dma_unmap_page(hwdev, handle, size, dir, attrs);
>  }
> @@ -86,8 +86,8 @@ static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
>  {
>  	unsigned long pfn = PFN_DOWN(handle);
>  	if (pfn_valid(pfn)) {
> -		if (__generic_dma_ops(hwdev)->sync_single_for_cpu)
> -			__generic_dma_ops(hwdev)->sync_single_for_cpu(hwdev, handle, size, dir);
> +		if (xen_get_dma_ops(hwdev)->sync_single_for_cpu)
> +			xen_get_dma_ops(hwdev)->sync_single_for_cpu(hwdev, handle, size, dir);
>  	} else
>  		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
>  }
> @@ -97,8 +97,8 @@ static inline void xen_dma_sync_single_for_device(struct device *hwdev,
>  {
>  	unsigned long pfn = PFN_DOWN(handle);
>  	if (pfn_valid(pfn)) {
> -		if (__generic_dma_ops(hwdev)->sync_single_for_device)
> -			__generic_dma_ops(hwdev)->sync_single_for_device(hwdev, handle, size, dir);
> +		if (xen_get_dma_ops(hwdev)->sync_single_for_device)
> +			xen_get_dma_ops(hwdev)->sync_single_for_device(hwdev, handle, size, dir);
>  	} else
>  		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
>  }
>
