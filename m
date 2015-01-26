From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 26 Jan 2015 17:10:22 +0800
Subject: [RFC PATCH 4/5] arm64: add IOMMU dma_ops
In-Reply-To: <aa7de3b1dd189c31eb8b14d0c0eea699183f8a2c.1421086706.git.robin.murphy@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
 <aa7de3b1dd189c31eb8b14d0c0eea699183f8a2c.1421086706.git.robin.murphy@arm.com>
Message-ID: <54C6047E.6070005@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2015 04:48 AM, Robin Murphy wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
[snip]
>   static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
>   {
> +#ifdef CONFIG_IOMMU_DMA
> +	if (dev->archdata.mapping)

Hi Robin,

Report one more issue, it would be safer like this.
if (dev && dev->archdata.mapping)

I do some more tests with a generic buffer allocator (ION). Allocate 
buffer from ION and then import by Tegra/DRM. I saw a crash in ION.

Please reference and follow the call stack below. You could find out it 
could pass NULL of the dev pointer (ion_page_pool_alloc_pages).

[   83.836688] Call trace:
[   83.836694] [<ffffffc000422fd0>] swiotlb_sync_single+0xc/0xa4
[   83.836707] [<ffffffc0004230dc>] swiotlb_sync_sg_for_device+0x44/0x70
[   83.836713] [<ffffffc000211030>] __swiotlb_sync_sg_for_device+0x28/0xac
[   83.836720] [<ffffffc0005eb934>] ion_pages_sync_for_device+0xfc/0x10c
[   83.836724] [<ffffffc0005ecb6c>] ion_page_pool_alloc+0xc8/0xe0
[   83.836729] [<ffffffc0005ed3d0>] ion_system_heap_allocate+0xfc/0x324
[   83.836732] [<ffffffc0005eae98>] ion_alloc+0xf0/0x480
[   83.836736] [<ffffffc0005eb3bc>] ion_ioctl+0x194/0x608
[   83.836741] [<ffffffc0005eeae0>] compat_ion_ioctl+0x300/0x6e0
[   83.836747] [<ffffffc000340280>] compat_sys_ioctl+0x108/0x139c

Thanks
-Joseph

> +		return iova_to_phys(dev, dev_addr);
> +#endif
>   	return (phys_addr_t)dev_addr;
>   }
