From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 3 Jun 2011 12:39:27 +0300
Subject: [PATCH v3 1/2] omap3: iovmm: Work around sg_alloc_table size
	limitation in IOMMU
In-Reply-To: <201106030212.48226.laurent.pinchart@ideasonboard.com>
References: <20110601131744.GH11352@atomide.com>
	<201106011550.50873.laurent.pinchart@ideasonboard.com>
	<20110601140306.GC6700@n2100.arm.linux.org.uk>
	<201106030212.48226.laurent.pinchart@ideasonboard.com>
Message-ID: <BANLkTingi0kS6MpqGNd0RJtAcY40Rz0DRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 3, 2011 at 3:12 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Russell,
>
> On Wednesday 01 June 2011 16:03:06 Russell King - ARM Linux wrote:
>> On Wed, Jun 01, 2011 at 03:50:50PM +0200, Laurent Pinchart wrote:
>> > In the specific iovmm case, the driver uses the sglist API to build a
>> > list of page-size sg entries, and then process it in software. Is that
>> > considered as an abuse of the sglist API, or valid usage ?
>> >
>> > Anyway, sglist chaining is not needed by iovmm. As iovmm just walks the
>> > sglist manually, it's easier to allocate it in one go rather than using
>> > sglist chaining. This of course doesn't make your patch unneeded or
>> > wrong.
>>
>> Well, there's a two issues here:
>> 1. Should iovmm use sg_phys(sg) with sg_dma_len(sg) ?
>> ? ?Probably not, because a scatterlist before DMA API mapping is defined
>> ? ?by sg_page(sg), sg->offset, sg->length and has N entries. ?After DMA
>> ? ?API mapping (n = dma_map_sg(dev, sg, N, dir)), it has n entries where
>> ? ?n <= N, and the DMA address/lengths are sg_dma_address(sg) and
>> ? ?sg_dma_len(sg). ?Both these are undefined for unmapped scatterlists.
>>
>> ? ?Getting this wrong means breakage when CONFIG_NEED_SG_DMA_LENGTH is
>> ? ?enabled.
>
> iovmm abuses the sglist API, there's no doubt on that. It will break when
> CONFIG_NEED_SG_DMA_LENGTH is enabled. iovmm should probably not use the sglist
> API, and it should probably not even exist in the first place. I know that TI
> is working on moving the OMAP-specific iommu/iovmm implementation to the
> generic IOMMU API, but that will take time. In the meantime, I'd like to fix
> iovmm to avoid the userspace-triggerable BUG_ON().

This would also allow the tidspbridge driver to use iommu.

-- 
Felipe Contreras
