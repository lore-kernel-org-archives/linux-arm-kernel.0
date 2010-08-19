From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 19 Aug 2010 17:51:51 +0900
Subject: ARM: 2.6.3[45] PCI regression (IXP4xx and PXA?)
In-Reply-To: <m3vd7agmqa.fsf@intrepid.localdomain>
References: <20100813215413.GA21607@n2100.arm.linux.org.uk>
	<20100814181306U.fujita.tomonori@lab.ntt.co.jp>
	<m3vd7agmqa.fsf@intrepid.localdomain>
Message-ID: <20100819175024W.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Aug 2010 01:29:49 +0200
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> Hi,
> 
> FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> writes:
> 
> > A long solution would be having two dma_mask for a device and a
> > bus. We also need something to represent a DMA-capable range instead
> > of the dma mask.
> >
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -77,6 +77,11 @@ static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gf
> >  	if (mask < 0xffffffffULL)
> >  		gfp |= GFP_DMA;
> >  
> > +#ifdef CONFIG_DMABOUNCE
> > +	if (dev->archdata.dmabounce)
> > +		gfp |= GFP_DMA;
> > +#endif
> > +
> >  	page = alloc_pages(gfp, order);
> >  	if (!page)
> >  		return NULL;
> 
> This patch fixes the problem on my IXP425.

Thanks a lot!

I'll re-send the patch in the proper format. Can you send it to
mainline for 2.6.36?

I'll work on the proper solution for this issue for 2.6.37.
