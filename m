From: fugang.duan@freescale.com (Duan Andy)
Date: Fri, 4 Dec 2015 02:18:38 +0000
Subject: [PATCH] drivers: dma-coherent: free memory when failed to init
 DMA memory pool
In-Reply-To: <xa1t1tb3y01e.fsf@mina86.com>
References: <1449138962-8264-1-git-send-email-b38611@freescale.com>
 <xa1toae7y9u8.fsf@mina86.com>
 <CY1PR0301MB12257F63F594E65DE67E64DFF50D0@CY1PR0301MB1225.namprd03.prod.outlook.com>
 <20151203153937.GP8644@n2100.arm.linux.org.uk> <xa1t1tb3y01e.fsf@mina86.com>
Message-ID: <BN3PR0301MB1219B3F45F36280B9FE93A08F50C0@BN3PR0301MB1219.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Nazarewicz <mpn@google.com> Sent: Friday, December 04, 2015 12:23 AM
> To: Russell King - ARM Linux; Duan Fugang-B38611
> Cc: torvalds at linux-foundation.org; gregkh at linuxfoundation.org;
> m.szyprowski at samsung.com; iamjoonsoo.kim at lge.com; arnd at arndb.de; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] drivers: dma-coherent: free memory when failed to
> init DMA memory pool
> 
> On Thu, Dec 03 2015, Russell King - ARM Linux wrote:
> > On Thu, Dec 03, 2015 at 01:54:05PM +0000, Duan Andy wrote:
> >> From: Mike Nazarewicz <mpn@google.com> Sent: Thursday, December 03,
> >> 2015 8:51 PM
> >> > To: Duan Fugang-B38611; torvalds at linux-foundation.org;
> >> > gregkh at linuxfoundation.org; m.szyprowski at samsung.com
> >> > Cc: linux-arm-kernel at lists.infradead.org; arnd at arndb.de;
> >> > iamjoonsoo.kim at lge.com; Duan Fugang-B38611
> >> > Subject: Re: [PATCH] drivers: dma-coherent: free memory when failed
> >> > to init DMA memory pool
> >> >
> >> > On Thu, Dec 03 2015, Fugang Duan wrote:
> >> > > Free dma coherent memory when it failed to init DMA memory pool
> >> > > after calling .dma_init_coherent_memory(), otherwise it causes
> memmory leak.
> >> > >
> >> > > Signed-off-by: Fugang Duan <B38611@freescale.com>
> >> > > ---
> >> > >  drivers/base/dma-coherent.c | 1 +
> >> > >  1 file changed, 1 insertion(+)
> >> > >
> >> > > diff --git a/drivers/base/dma-coherent.c
> >> > > b/drivers/base/dma-coherent.c index 55b8398..beb6bbe 100644
> >> > > --- a/drivers/base/dma-coherent.c
> >> > > +++ b/drivers/base/dma-coherent.c
> >> > > @@ -286,6 +286,7 @@ static int rmem_dma_device_init(struct
> >> > > reserved_mem
> >> > *rmem, struct device *dev)
> >> > >  				     &mem) != DMA_MEMORY_MAP) {
> >> > >  		pr_err("Reserved memory: failed to init DMA memory pool
> >> > at %pa, size %ld MiB\n",
> >> > >  			&rmem->base, (unsigned long)rmem->size / SZ_1M);
> >> > > +		kfree(mem);
> >> >
> >> > mem == NULL at this point.  If dma_init_coherent_memory doesn?t
> >> > return DMA_MEMORY_MAP, mem pointer is not assigned any value.  If
> >> > you think there is a memory leak, please demonstrate a path of it
> happening.
> >> >
> >> Kfree() will check mem NULL condition, so no need to add check in here.
> >
> > That isn't what the reviewer was stating.
> >
> > However, had the reviewer looked at the existing code, then he may
> > have stated a different opinion. :)
> 
> I?m not sure that I would.  Here?s code I?m looking at:
> 
> 
> static int dma_init_coherent_memory(phys_addr_t phys_addr, dma_addr_t
> device_addr,
> 			     size_t size, int flags,
> 			     struct dma_coherent_mem **mem)
> {
> 	struct dma_coherent_mem *dma_mem = NULL;
> 	void __iomem *mem_base = NULL;
> 	int pages = size >> PAGE_SHIFT;
> 	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> 
> 	if ((flags & (DMA_MEMORY_MAP | DMA_MEMORY_IO)) == 0)
> 		goto out;
> 	if (!size)
> 		goto out;
> 
> 	mem_base = ioremap(phys_addr, size);
> 	if (!mem_base)
> 		goto out;
> 
> 	dma_mem = kzalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);
> 	if (!dma_mem)
> 		goto out;
> 	dma_mem->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> 	if (!dma_mem->bitmap)
> 		goto out;
> 
> 	dma_mem->virt_base = mem_base;
> 	dma_mem->device_base = device_addr;
> 	dma_mem->pfn_base = PFN_DOWN(phys_addr);
> 	dma_mem->size = pages;
> 	dma_mem->flags = flags;
> 	spin_lock_init(&dma_mem->spinlock);
> 
> 	/**************************************************************/
> 	/* Here's the only place where mem is set to non-NULL value.  */
> 	/**************************************************************/
> 	*mem = dma_mem;
> 
> 	if (flags & DMA_MEMORY_MAP)
> 		/******************************************************/
> 		/* Here's where function returns.                     */
> 		/******************************************************/
> 		return DMA_MEMORY_MAP;
> 
> 	return DMA_MEMORY_IO;
> 
> out:
> 	kfree(dma_mem);
> 	if (mem_base)
> 		iounmap(mem_base);
> 	return 0;
> }
> 
> static int rmem_dma_device_init(struct reserved_mem *rmem, struct device
> *dev) {
> 	struct dma_coherent_mem *mem = rmem->priv;
> 
> 	if (!mem &&
> 	    /**********************************************************/
> 	    /* Note that flags & DMA_MEMORY_MAP is non-zero.          */
> 	    /**********************************************************/
> 	    dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,
> 				     DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE,
> 				     &mem) != DMA_MEMORY_MAP) {
> 		pr_err("Reserved memory: failed to init DMA memory pool
> at %pa, size %ld MiB\n",
> 			&rmem->base, (unsigned long)rmem->size / SZ_1M);
> 		return -ENODEV;
> 	}
> 	rmem->priv = mem;
> 	dma_assign_coherent_memory(dev, mem);
> 	return 0;
> }
> 
> 
> > When you look at the existing code, there are three possible return
> > values from dma_init_coherent_memory():
> >
> > - zero, which means failure, and the mem pointer is left alone.  In
> >   the above code, we know that it's guaranteed to be NULL, as we
> >   won't get into the if() unless it was.
> > - DMA_MEMORY_IO, which would mean that mem points at a kmalloc()d
> >   chunk of memory, and this case is treated as failure because we
> >   want memory.
> 
> No.  This never happens in the code that is being patched.  flags &
> DMA_MEMORY_MAP is non-zero thus dma_init_coherent_memory returns
> DMA_MEMORY_MAP.
> 
> > - DMA_MEMORY_MAP, which also means that mem points at a kmalloc()d
> >   chunk of memory, which we treat as success.
> >
> > So, in the case of DMA_MEMORY_IO,
> 
> Which never happens.
> 
I agree with your explain. For current code, dma_init_coherent_memory(x,x,x, DMA_MEMORY_MAP|x, x) bring DMA_MEMORY_MAP flag, so return value DMA_MEMORY_IO never happens.

Sorry for my mistake, pls drop the patch.  Thanks Michal and Russell's detail comments and review.

[snip]
