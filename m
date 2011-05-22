From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 22 May 2011 13:05:43 +0200
Subject: [RFC PATCH 1/2] arm: introduce arch_ioremap and arch_iounmap
	function pointer
In-Reply-To: <20110522100342.GD17672@n2100.arm.linux.org.uk>
References: <1306055080-30420-1-git-send-email-plagnioj@jcrosoft.com>
	<20110522100342.GD17672@n2100.arm.linux.org.uk>
Message-ID: <20110522110543.GB15292@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:03 Sun 22 May     , Russell King - ARM Linux wrote:
> On Sun, May 22, 2011 at 11:04:39AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > today we define it at runtime via __arch_ioremap and __arch_iounmap
> > 
> > this PATH will allow to overwrite the default ioremap at runtime
> > to be able to compile multiple soc in the same kernel
> 
> This is buggy.
> 
> > diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> > index ab50627..40ef390 100644
> > --- a/arch/arm/mm/ioremap.c
> > +++ b/arch/arm/mm/ioremap.c
> > @@ -281,9 +281,15 @@ __arm_ioremap_pfn(unsigned long pfn, unsigned long offset, size_t size,
> >  }
> >  EXPORT_SYMBOL(__arm_ioremap_pfn);
> >  
> > +void __iomem* (*arch_ioremap)(unsigned long p, size_t size, unsigned int type);
> > +void (*arch_iounmap)(volatile void __iomem *addr);
> > +
> >  void __iomem *
> >  __arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
> >  {
> > +	if (arch_ioremap)
> > +		return arch_ioremap(phys_addr, size, mtype);
> > +
> 
> Some SoCs call __arm_ioremap() from their ioremap() implementation, so
> making this hook results in infinite function recursion if you try to
> set this to their ioremap() implementation.
> 
> >  void __iounmap(volatile void __iomem *io_addr)
> >  {
> > -	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
> > +	void *addr;
> >  #ifndef CONFIG_SMP
> >  	struct vm_struct **p, *tmp;
> > +#endif
> >  
> > +	if (arch_iounmap) {
> > +		arch_iounmap(io_addr);
> > +		return;
> > +	}
> 
> And on OMAP, for similar reasons, this will also be infinite function
> recursion:
> 
> void omap_iounmap(volatile void __iomem *addr)
> {
>         unsigned long virt = (unsigned long)addr;
> 
>         if (virt >= VMALLOC_START && virt < VMALLOC_END)
>                 __iounmap(addr);
> }
> 
> So you'll end up with a call to iounmap() calling __iounmap() which then
> calls omap_iounmap(), which then calls __iounmap()...
did see that and I should I did it on at91 too

so how about introduce a new ioreamap/iouremap functiom

as to be able to compile more than one soc we need to be able to specifcy the
custom ioremap at runtime
Do you agree on this?


like this patch

Best Regards,
J.
