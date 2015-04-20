From: cbz@baozis.org (Chen Baozi)
Date: Mon, 20 Apr 2015 19:07:30 +0800
Subject: [Xen-devel] [PATCH] xen: Add __GFP_DMA flag when
 xen_swiotlb_init gets free pages.
In-Reply-To: <5534DABB.5060305@citrix.com>
References: <1429526904-27176-1-git-send-email-cbz@baozis.org>
 <5534DABB.5060305@citrix.com>
Message-ID: <20150420110729.GA27707@cbz-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 11:53:47AM +0100, David Vrabel wrote:
> On 20/04/15 11:48, Chen Baozi wrote:
> > Make sure that xen_swiotlb_init allocates buffers that is DMA capable.
> > 
> > Signed-off-by: Chen Baozi <baozich@gmail.com>
> > ---
> >  drivers/xen/swiotlb-xen.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > index 810ad41..7345afd 100644
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -235,7 +235,8 @@ retry:
> >  #define SLABS_PER_PAGE (1 << (PAGE_SHIFT - IO_TLB_SHIFT))
> >  #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
> >  		while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
> > -			xen_io_tlb_start = (void *)__get_free_pages(__GFP_NOWARN, order);
> > +			xen_io_tlb_start = (void *)__get_free_pages(
> > +						__GFP_NOWARN|__GFP_DMA, order);
> 
> I think this breaks x86 where __GFP_DMA means below 16 MB.  Perhaps you
> mean __GFP_DMA32?

__GFP_DMA32 doesn't help on arm64...

I guess there might be conflicts about the meaning of __GFP_DMA between x86 and
arm?

Cheers,

Baozi.
