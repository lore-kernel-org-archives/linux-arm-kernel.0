From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 7 Mar 2012 07:37:06 +0100
Subject: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
In-Reply-To: <20120307.080952.2152478004740487196.hdoyu@nvidia.com>
References: <000001ccfaea$00c16f70$02444e50$%szyprowski@samsung.com><401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com><20120307.080952.2152478004740487196.hdoyu@nvidia.com>
Message-ID: <20120307.083706.2087121294965856946.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiroshi DOYU <hdoyu@nvidia.com>
Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Date: Wed, 07 Mar 2012 08:09:52 +0200 (EET)
Message-ID: <20120307.080952.2152478004740487196.hdoyu@nvidia.com>

> From: Krishna Reddy <vdumpa@nvidia.com>
> Subject: RE: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
> Date: Tue, 6 Mar 2012 23:48:42 +0100
> Message-ID: <401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com>
> 
> > > > +struct dma_iommu_mapping *
> > > > +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
> > > > +                        int order)
> > > > +{
> > > > +       unsigned int count = (size >> PAGE_SHIFT) - order;
> > > > +       unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
> > 
> > The count calculation doesn't seem correct. "order" is log2 number and
> >  size >> PAGE_SHIFT is number of pages. 
> > 
> > If size is passed as 64*4096(256KB) and order is 6(allocation granularity is 2^6 pages=256KB),
> >  just 1 bit is enough to manage allocations.  So it should be 4 bytes or one long.
> 
> Good catch!
> 
> > But the calculation gives count = 64 - 6 = 58 and 
> > Bitmap_size gets set to (58/(4*8)) * 4 = 8 bytes, which is incorrect.
> 
> "order" isn't the order of size passed, which is minimal *page*
> allocation order which client decides whatever, just in case.
> 
> > It should be as follows.
> > unsigned int count = 1 << get_order(size) - order;

To be precise, as below?

 unsigned int count = 1 << (get_order(size) - order);

> > unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long) * BITS_PER_BYTE;
> > 
> > -KR
> > 
> > --nvpublic
> > 
> > 
