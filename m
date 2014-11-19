From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 09:45:43 +0100
Subject: For the problem when using swiotlb
In-Reply-To: <546C0BBB.9070000@huawei.com>
References: <5469E26B.2010905@huawei.com>
 <20141117180947.GI29595@e104818-lin.cambridge.arm.com>
 <546C0BBB.9070000@huawei.com>
Message-ID: <1535751.CcvIi3DN4F@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014 11:17:15 Ding Tianhong wrote:
> On 2014/11/18 2:09, Catalin Marinas wrote:
> > On Mon, Nov 17, 2014 at 12:18:42PM +0000, Arnd Bergmann wrote:
> >> On Monday 17 November 2014 19:56:27 Ding Tianhong wrote:
> >>>         The commit 3690951fc6d42f3a0903987677d0e592c49dd8db(arm64: Use swiotlb late initialisation)
> >>> switches the DMA mapping code to swiotlb_tlb_late_init_with_default_size(), this will occur a problem
> >>> when I run the scsi stress tests, the message as below:
> >>>
> >>>         sas_controller b1000000.sas: swiotlb buffer is full (sz: 65536 bytes)..
> >>>         DMA: Out of SW-IOMMU space for 65536 bytes at device b1000000.sas
> >>>
> >>> The reason is that the swiotlb_tlb_late_init_with_default_size() could only alloc 16M memory for DMA-mapping,
> >>> and the param in cmdline "swiotlb=xxx" is useless because the get_free_pages() only use the buddy to assigned a
> >>> maximum memory of 16M(The MAX_ORDER is 13 for 4k pages), obviously 16M is too small in many scenes, but
> >>> the swiotlb_init() which could reserved a bigger memory as wished could work well for most drivers.
> >>>
> >>> I could not get a better way to fix this problem except to revert this patch, so could you please give me some
> >>> advise and help me, thanks very much.
> >>
> >> In general, you should not need to use swiotlb for most devices, in
> >> particular for high-performance devices like network or block.
> >>
> >> Please make sure that you have set up the dma-ranges properties in
> >> your DT properly to allow 64-bit DMA if the device supports it.
> > 
> > That's the problem indeed, the DMA API ends up using swiotlb bounce
> > buffers because the physical address of the pages passed to (or
> > allocated by) the driver are beyond 32-bit limit (which is the default
> > dma mask).
> > 
> 
> Thanks everyone, I think I found the way to fix it, need to enable DMA_CMA, to reserve a big memory
> for CMA and set coherent mask for dev, then dma_alloc and dma_mapping will not use the swiotlb until
> the memory out of mask or swiotlb_force is enabled.
> 
> If I still understand uncorrectly, please inform me.
> 

Please do not use CMA to work around the problem, but fix the underlying bug
instead.

The driver should call 'dma_set_mask_and_coherent()' with the appropriate
dma mask, and check whether that succeeded. However, the code implementing
dma_set_mask_and_coherent on arm64 also needs to be changed to look up
the dma-ranges property (see of_dma_configure()), and check if the mask
is possible.

	Arnd
