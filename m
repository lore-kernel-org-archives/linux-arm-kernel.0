From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 2 Feb 2015 18:24:35 +0000
Subject: ask for help about swiotlb buffer is full
In-Reply-To: <54CC5346.5070402@huawei.com>
References: <54CB5820.9020102@huawei.com> <54CB5AA4.7050705@huawei.com>
 <20150130115915.GB27542@e104818-lin.cambridge.arm.com>
 <54CC5346.5070402@huawei.com>
Message-ID: <20150202182435.GH22661@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 31, 2015 at 04:00:06AM +0000, Kefeng Wang wrote:
> On 2015-01-30 19:59, Catalin Marinas wrote:
> > On Fri, Jan 30, 2015 at 10:19:16AM +0000, Kefeng Wang wrote:
> >> On 2015-01-30 18:08, Kefeng Wang wrote:
> >>>   There is an AHCI compliant SATA controller in our arm64 soc, and
> >>>   it only supports 32bit DMA(used coherent dma_ops). It works well
> >>>   in v3.16. Recently, we update kernel from linux v3.16 to linux
> >>>   v3.19-rc4(use defconfig in arm64), but we get errors when test
> >>>   sata driver, as follows.
> >>>
> >>> ------------------------------------------------------------------------------
> >>> ahci b1002800.sata: swiotlb buffer is full (sz: 65536 bytes)
> >>> DMA: Out of SW-IOMMU space for 65536 bytes at device b1002800.sata
> > 
> > Do you use a 64KB page kernel configuration?
> > 
> > What does your kernel log say about "software IO TLB [mem ...]"?
> > 
> 
> 4kb page,  use Make ARCH=arm64 defconfig in v3.19 to generate config.
> 
> [    0.678293] software IO TLB [mem 0x7e800000-0x7ec00000] (4MB) mapped at [ffffffc07e800000-ffffffc07ebfffff]
> [    0.686991] DMA: preallocated 256 KiB pool for atomic allocations

Was the swiotlb buffer size the same in the 3.16 kernel? The only thing
I recall adding was the atomic pool allocations but these are only for
non-coherent DMA ops and only for dma_alloc/free. I assume, in the case
of SATA, the failure is on the dma_map_sg() path.

Maybe with a 3.19 kernel you get more than 4MB swiotlb buffers used at a
time with your tests; can you try increasing this via a kernel command
like to, let's say, 8MB? If I got my calculations correctly (an IO TLB
slab is 1 << 11):

	swiotlb=4096

If it still runs out with bigger buffers, we may need to look into
potential leaks.

-- 
Catalin
