From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 24 Feb 2012 14:18:02 +0100
Subject: [PATCHv6 7/7] ARM: dma-mapping: add support for IOMMU mapper
In-Reply-To: <201202241249.44731.arnd@arndb.de>
References: <1328900324-20946-1-git-send-email-m.szyprowski@samsung.com>
 <401E54CE964CD94BAE1EB4A729C7087E378E42AE18@HQMAIL04.nvidia.com>
 <00f301ccf2d7$b5b68570$21239050$%szyprowski@samsung.com>
 <201202241249.44731.arnd@arndb.de>
Message-ID: <013301ccf2f6$bc4ad840$34e088c0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, February 24, 2012 1:50 PM Arnd Bergmann wrote:

> On Friday 24 February 2012, Marek Szyprowski wrote:
> > > > +static struct page **__iommu_alloc_buffer(struct device *dev, size_t
> > > > +size, gfp_t gfp) {
> > > > +     struct page **pages;
> > > > +     int count = size >> PAGE_SHIFT;
> > > > +     int i=0;
> > > > +
> > > > +     pages = kzalloc(count * sizeof(struct page*), gfp);
> > > > +     if (!pages)
> > > > +             return NULL;
> > >
> > > kzalloc can fail for any size bigger than PAGE_SIZE, if the system memory is
> > > fully fragmented.
> > > If there is a request for size bigger than 4MB, then the pages pointer array won't
> > > Fit in one page and kzalloc may fail. we should use vzalloc()/vfree()
> > > when pages pointer array size needed is bigger than PAGE_SIZE.
> >
> > Right, thanks for spotting this. I will fix this in the next version.
> 
> It's not clear though if that is the best solution. vzalloc comes at the
> price of using up space in the vmalloc area and as well as extra TLB entries,
> so we try to limit its use where possible. The other current code might fail
> in out of memory situations, but if a user wants to allocate a >4MB buffer
> (using up more than one physically contiguous page of pointers to pages), the
> following allocation of >1024 pages will likely fail as well, so we might
> just fail early.

I want to use some kind of chained arrays, each of at most of PAGE_SIZE. This code 
doesn't really need to keep these page pointers in contiguous virtual memory area, so
it will not be a problem here.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
