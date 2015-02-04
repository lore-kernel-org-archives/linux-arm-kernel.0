From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Feb 2015 13:32:05 +0000
Subject: ask for help about swiotlb buffer is full
In-Reply-To: <54D209FD.40100@huawei.com>
References: <54CB5820.9020102@huawei.com> <54CB5AA4.7050705@huawei.com>
 <20150130115915.GB27542@e104818-lin.cambridge.arm.com>
 <54CC5346.5070402@huawei.com>
 <20150202182435.GH22661@e104818-lin.cambridge.arm.com>
 <54D209FD.40100@huawei.com>
Message-ID: <20150204133205.GC26006@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 12:01:01PM +0000, Kefeng Wang wrote:
> On 2015-02-03 2:24, Catalin Marinas wrote:
> > On Sat, Jan 31, 2015 at 04:00:06AM +0000, Kefeng Wang wrote:
> >> On 2015-01-30 19:59, Catalin Marinas wrote:
> [...]
> >>>
> >>
> >> 4kb page,  use Make ARCH=arm64 defconfig in v3.19 to generate config.
> >>
> >> [    0.678293] software IO TLB [mem 0x7e800000-0x7ec00000] (4MB) mapped at [ffffffc07e800000-ffffffc07ebfffff]
> >> [    0.686991] DMA: preallocated 256 KiB pool for atomic allocations
> > 
> > Was the swiotlb buffer size the same in the 3.16 kernel? The only thing
> > I recall adding was the atomic pool allocations but these are only for
> > non-coherent DMA ops and only for dma_alloc/free. I assume, in the case
> > of SATA, the failure is on the dma_map_sg() path.
> 
> Swiotlb buffer size is both 4M in v3.16 and v3.19-rc4, and the failure is
> on the dma_map_sg() -> swiotlb_map_sg_attrs.
> 
> > Maybe with a 3.19 kernel you get more than 4MB swiotlb buffers used at a
> > time with your tests; can you try increasing this via a kernel command
> > like to, let's say, 8MB? If I got my calculations correctly (an IO TLB
> > slab is 1 << 11):
> > 
> > 	swiotlb=4096
> > 
> > If it still runs out with bigger buffers, we may need to look into
> > potential leaks.
> 
> The buddy allocator can only support 4M contiguous physical memory, so it's
> useless to increase swiotlb buffer.

You could hack arch/arm64/Kconfig to set a higher
CONFIG_FORCE_MAX_ZONEORDER as a test. Depending on the test result, we
can look for an alternative solution.

-- 
Catalin
