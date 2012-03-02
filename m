From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 02 Mar 2012 12:07:59 +0100
Subject: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
In-Reply-To: <CAHQjnOO5DLOj8Fw=ZriSnXg8W3k7y8Dnu--Peqe6JJX0xGMhoQ@mail.gmail.com>
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com>
 <1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
 <CAHQjnOO5DLOj8Fw=ZriSnXg8W3k7y8Dnu--Peqe6JJX0xGMhoQ@mail.gmail.com>
Message-ID: <015101ccf864$bacb1070$30613150$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, March 02, 2012 9:06 AM KyongHo Cho wrote:

> On Thu, Mar 1, 2012 at 12:04 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > +/**
> > + * arm_iommu_map_sg - map a set of SG buffers for streaming mode DMA
> > + * @dev: valid struct device pointer
> > + * @sg: list of buffers
> > + * @nents: number of buffers to map
> > + * @dir: DMA transfer direction
> > + *
> > + * Map a set of buffers described by scatterlist in streaming mode for DMA.
> > + * The scatter gather list elements are merged together (if possible) and
> > + * tagged with the appropriate dma address and length. They are obtained via
> > + * sg_dma_{address,length}.
> > + */
> > +int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> > + ? ? ? ? ? ? ? ? ? ?enum dma_data_direction dir, struct dma_attrs *attrs)
> > +{
> > + ? ? ? struct scatterlist *s = sg, *dma = sg, *start = sg;
> > + ? ? ? int i, count = 0;
> > + ? ? ? unsigned int offset = s->offset;
> > + ? ? ? unsigned int size = s->offset + s->length;
> > + ? ? ? unsigned int max = dma_get_max_seg_size(dev);
> > +
> > + ? ? ? for (i = 1; i < nents; i++) {
> > + ? ? ? ? ? ? ? s->dma_address = ARM_DMA_ERROR;
> > + ? ? ? ? ? ? ? s->dma_length = 0;
> > +
> > + ? ? ? ? ? ? ? s = sg_next(s);
> > +
> > + ? ? ? ? ? ? ? if (s->offset || (size & ~PAGE_MASK) || size + s->length > max) {
> > + ? ? ? ? ? ? ? ? ? ? ? if (__map_sg_chunk(dev, start, size, &dma->dma_address,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? dir) < 0)
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? goto bad_mapping;
> > +
> > + ? ? ? ? ? ? ? ? ? ? ? dma->dma_address += offset;
> > + ? ? ? ? ? ? ? ? ? ? ? dma->dma_length = size - offset;
> > +
> > + ? ? ? ? ? ? ? ? ? ? ? size = offset = s->offset;
> > + ? ? ? ? ? ? ? ? ? ? ? start = s;
> > + ? ? ? ? ? ? ? ? ? ? ? dma = sg_next(dma);
> > + ? ? ? ? ? ? ? ? ? ? ? count += 1;
> > + ? ? ? ? ? ? ? }
> > + ? ? ? ? ? ? ? size += s->length;
> > + ? ? ? }
> > + ? ? ? if (__map_sg_chunk(dev, start, size, &dma->dma_address, dir) < 0)
> > + ? ? ? ? ? ? ? goto bad_mapping;
> > +
> > + ? ? ? dma->dma_address += offset;
> > + ? ? ? dma->dma_length = size - offset;
> > +
> > + ? ? ? return count+1;
> > +
> > +bad_mapping:
> > + ? ? ? for_each_sg(sg, s, count, i)
> > + ? ? ? ? ? ? ? __iommu_remove_mapping(dev, sg_dma_address(s), sg_dma_len(s));
> > + ? ? ? return 0;
> > +}
> > +
> This looks that the given sg list specifies the list of physical
> memory chunks and
> the list of IO virtual memory chunks at the same time after calling
> arm_dma_map_sg().
> It can happen that dma_address and dma_length of a sg entry does not
> correspond to
> physical memory information of the sg entry.

Right, that's how it is designed. If fact sg entries describes 2 independent 
lists - one for physical memory chunks and one for virtual memory chunks. 
It might happen that the whole scattered physical memory can be mapped into
contiguous virtual memory chunk, what result in only one element describing
the io dma addresses. Here is the respective paragraph from 
Documentation/DMA-API-HOWTO.txt (lines 511-517):

'The implementation is free to merge several consecutive sglist entries
into one (e.g. if DMA mapping is done with PAGE_SIZE granularity, any
consecutive sglist entries can be merged into one provided the first one
ends and the second one starts on a page boundary - in fact this is a huge
advantage for cards which either cannot do scatter-gather or have very
limited number of scatter-gather entries) and returns the actual number
of sg entries it mapped them to. On failure 0 is returned.'

> I think it is beneficial for handling IO virtual memory.
> 
> However, I worry about any other problems caused by a single sg entry contains
> information from 2 different context.

What do you mean by the 'context'. DMA mapping assumes that a single call to 
dma_map_sg maps a single memory buffer.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
