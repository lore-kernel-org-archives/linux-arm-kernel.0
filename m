From: vdumpa@nvidia.com (Krishna Reddy)
Date: Tue, 6 Mar 2012 14:48:42 -0800
Subject: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
In-Reply-To: <000001ccfaea$00c16f70$02444e50$%szyprowski@samsung.com>
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com>
 <1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
 <20120305134721.0ab0d0e6de56fa30250059b1@nvidia.com>
 <000001ccfaea$00c16f70$02444e50$%szyprowski@samsung.com>
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +struct dma_iommu_mapping *
> > +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
> > +                        int order)
> > +{
> > +       unsigned int count = (size >> PAGE_SHIFT) - order;
> > +       unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);

The count calculation doesn't seem correct. "order" is log2 number and
 size >> PAGE_SHIFT is number of pages. 

If size is passed as 64*4096(256KB) and order is 6(allocation granularity is 2^6 pages=256KB),
 just 1 bit is enough to manage allocations.  So it should be 4 bytes or one long.

But the calculation gives count = 64 - 6 = 58 and 
Bitmap_size gets set to (58/(4*8)) * 4 = 8 bytes, which is incorrect.

It should be as follows.
unsigned int count = 1 << get_order(size) - order;
unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long) * BITS_PER_BYTE;

-KR

--nvpublic
