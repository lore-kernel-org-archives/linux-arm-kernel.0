From: fugang.duan@freescale.com (Duan Andy)
Date: Fri, 4 Dec 2015 02:20:35 +0000
Subject: [PATCH] drivers: dma-coherent: free memory when failed to init
 DMA memory pool
In-Reply-To: <20151203153937.GP8644@n2100.arm.linux.org.uk>
References: <1449138962-8264-1-git-send-email-b38611@freescale.com>
 <xa1toae7y9u8.fsf@mina86.com>
 <CY1PR0301MB12257F63F594E65DE67E64DFF50D0@CY1PR0301MB1225.namprd03.prod.outlook.com>
 <20151203153937.GP8644@n2100.arm.linux.org.uk>
Message-ID: <BN3PR0301MB12195BD3A1CCDF070CD4075EF50C0@BN3PR0301MB1219.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk> Sent: Thursday, December 03, 2015 11:40 PM
> To: Duan Fugang-B38611
> Cc: Michal Nazarewicz; torvalds at linux-foundation.org;
> gregkh at linuxfoundation.org; m.szyprowski at samsung.com;
> iamjoonsoo.kim at lge.com; arnd at arndb.de; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] drivers: dma-coherent: free memory when failed to
> init DMA memory pool
> 
> On Thu, Dec 03, 2015 at 01:54:05PM +0000, Duan Andy wrote:
> > From: Mike Nazarewicz <mpn@google.com> Sent: Thursday, December 03,
> > 2015 8:51 PM
> > > To: Duan Fugang-B38611; torvalds at linux-foundation.org;
> > > gregkh at linuxfoundation.org; m.szyprowski at samsung.com
> > > Cc: linux-arm-kernel at lists.infradead.org; arnd at arndb.de;
> > > iamjoonsoo.kim at lge.com; Duan Fugang-B38611
> > > Subject: Re: [PATCH] drivers: dma-coherent: free memory when failed
> > > to init DMA memory pool
> > >
> > > On Thu, Dec 03 2015, Fugang Duan wrote:
> > > > Free dma coherent memory when it failed to init DMA memory pool
> > > > after calling .dma_init_coherent_memory(), otherwise it causes
> memmory leak.
> > > >
> > > > Signed-off-by: Fugang Duan <B38611@freescale.com>
> > > > ---
> > > >  drivers/base/dma-coherent.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/base/dma-coherent.c
> > > > b/drivers/base/dma-coherent.c index 55b8398..beb6bbe 100644
> > > > --- a/drivers/base/dma-coherent.c
> > > > +++ b/drivers/base/dma-coherent.c
> > > > @@ -286,6 +286,7 @@ static int rmem_dma_device_init(struct
> > > > reserved_mem
> > > *rmem, struct device *dev)
> > > >  				     &mem) != DMA_MEMORY_MAP) {
> > > >  		pr_err("Reserved memory: failed to init DMA memory pool
> > > at %pa, size %ld MiB\n",
> > > >  			&rmem->base, (unsigned long)rmem->size / SZ_1M);
> > > > +		kfree(mem);
> > >
> > > mem == NULL at this point.  If dma_init_coherent_memory doesn?t
> > > return DMA_MEMORY_MAP, mem pointer is not assigned any value.  If
> > > you think there is a memory leak, please demonstrate a path of it
> happening.
> > >
> > Kfree() will check mem NULL condition, so no need to add check in here.
> 
> That isn't what the reviewer was stating.
> 
> However, had the reviewer looked at the existing code, then he may have
> stated a different opinion. :)
> 
> When you look at the existing code, there are three possible return
> values from dma_init_coherent_memory():
> 
> - zero, which means failure, and the mem pointer is left alone.  In
>   the above code, we know that it's guaranteed to be NULL, as we
>   won't get into the if() unless it was.
> - DMA_MEMORY_IO, which would mean that mem points at a kmalloc()d
>   chunk of memory, and this case is treated as failure because we
>   want memory.
> - DMA_MEMORY_MAP, which also means that mem points at a kmalloc()d
>   chunk of memory, which we treat as success.
> 
> So, in the case of DMA_MEMORY_IO, we have a failure case where the
> kmalloc'd memory is dropped on the floor - aka a memory leak.  In the
> failure paths, there are two known values for mem: NULL, or validly
> pointing at kmalloc()'d memory which would be leaked.  So, adding a
> kfree() here is certainly correct.
> 
> However, the above explanation needs to go into the commit message to
> justify the change.
> 
Thanks Russell's detail explain.
As Michal's comment in next mail,  return DMA_MEMORY_IO never happens. So no need to free the mem.
