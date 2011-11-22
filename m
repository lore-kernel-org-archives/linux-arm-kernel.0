From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 22 Nov 2011 08:44:37 -0500 (EST)
Subject: [PATCH 21/23] ARM: add generic ioremap optimization by reusing
 static mappings
In-Reply-To: <20111122101627.GX9581@n2100.arm.linux.org.uk>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
 <1321422521-1138-22-git-send-email-nico@fluxnic.net>
 <20111122101627.GX9581@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1111220842181.17904@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Nov 2011, Russell King - ARM Linux wrote:

> On Wed, Nov 16, 2011 at 12:48:39AM -0500, Nicolas Pitre wrote:
> > @@ -201,12 +195,6 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
> >  	if (pfn >= 0x100000 && (__pfn_to_phys(pfn) & ~SUPERSECTION_MASK))
> >  		return NULL;
> >  
> > -	/*
> > -	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
> > -	 */
> > -	if (WARN_ON(pfn_valid(pfn)))
> > -		return NULL;
> > -
> >  	type = get_mem_type(mtype);
> >  	if (!type)
> >  		return NULL;
> > @@ -216,6 +204,34 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
> >  	 */
> >  	size = PAGE_ALIGN(offset + size);
> >  
> > +	/*
> > +	 * Try to reuse one of the static mapping whenever possible.
> > +	 */
> > +	read_lock(&vmlist_lock);
> > +	for (area = vmlist; area; area = area->next) {
> > +		if (!size || (sizeof(phys_addr_t) == 4 && pfn >= 0x100000))
> > +			break;
> > +		if (!(area->flags & VM_ARM_STATIC_MAPPING))
> > +			continue;
> > +		if ((area->flags & VM_ARM_MTYPE_MASK) != VM_ARM_MTYPE(mtype))
> > +			continue;
> > +		if (__phys_to_pfn(area->phys_addr) > pfn ||
> > +		    __pfn_to_phys(pfn) + size-1 > area->phys_addr + area->size-1)
> > +			continue;
> > +		/* we can drop the lock here as we know *area is static */
> > +		read_unlock(&vmlist_lock);
> > +		addr = (unsigned long)area->addr;
> > +		addr += __pfn_to_phys(pfn) - area->phys_addr;
> > +		return (void __iomem *) (offset + addr);
> > +	}
> > +	read_unlock(&vmlist_lock);
> > +
> > +	/*
> > +	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
> > +	 */
> > +	if (WARN_ON(pfn_valid(pfn)))
> > +		return NULL;
> 
> Why are you moving this check?  System RAM should never end up in the
> vmlist.

Because some architectures, such as OMAP, are relying on the ioremap 
optimization that reuse static mappings being functional even before the 
memory management is initialized.


Nicolas
