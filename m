From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jul 2018 10:37:58 +0100
Subject: [PATCH v3 0/6] add non-strict mode support for arm-smmu-v3
In-Reply-To: <5B5A8857.9040907@huawei.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
 <aace9ec9-a36a-79a8-98eb-bbedd06f11a4@arm.com>
 <5B594399.1080404@huawei.com>
 <f54dd9e0-6d4b-5daa-f6f6-be610393b487@arm.com>
 <5B5A8857.9040907@huawei.com>
Message-ID: <20180727093758.GL28088@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 10:49:59AM +0800, Leizhen (ThunderTown) wrote:
> On 2018/7/26 22:16, Robin Murphy wrote:
> > On 2018-07-26 4:44 AM, Leizhen (ThunderTown) wrote:
> >> Passthrough is not enough to support VFIO, and virtualization need
> >> the later.
> > 
> > Huh? The whole point of passthrough mode is that the IOMMU can still be
> > used for VFIO, but without imposing the overhead of dynamic mapping on
> > host DMA.
> 
> I said that from my experience. Userspace do not known the PA, so I think
> the user can not fill dma_map.iova correctly.
> 
> 	/* Allocate some space and setup a DMA mapping */
> 	dma_map.vaddr = (__u64)mmap(0, 0x1000, PROT_READ | PROT_WRITE,
> 			     MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> 	dma_map.size = 0x1000;
> 	dma_map.iova = 0x2f00000000UL;						/* user specified */
> 	dma_map.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
> 
> 	ioctl(container, VFIO_IOMMU_MAP_DMA, &dma_map);

Hmm, I'm pretty sure that's not the case. When passthrough is configured
via iommu.passthrough, it only applies to the default domain and therefore
won't affect the unmanaged domain that VFIO manages explicitly. So VFIO
will continue to use translation and userspace can't pass whatever it likes
for the iova.

Will
