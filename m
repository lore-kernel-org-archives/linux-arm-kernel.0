From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 14 Jul 2014 17:56:53 +0100
Subject: [PATCH v8 9/9] pci: Remap I/O bus resources into CPU space with
 pci_remap_iospace()
In-Reply-To: <20140714165443.GI1112@arm.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <1404240214-9804-10-git-send-email-Liviu.Dudau@arm.com>
 <20140714165443.GI1112@arm.com>
Message-ID: <20140714165653.GD825@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 05:54:43PM +0100, Catalin Marinas wrote:
> On Tue, Jul 01, 2014 at 07:43:34PM +0100, Liviu Dudau wrote:
> > Introduce a default implementation for remapping PCI bus I/O resources
> > onto the CPU address space. Architectures with special needs may
> > provide their own version, but most should be able to use this one.
> [...]
> > +/**
> > + *	pci_remap_iospace - Remap the memory mapped I/O space
> > + *	@res: Resource describing the I/O space
> > + *	@phys_addr: physical address where the range will be mapped.
> > + *
> > + *	Remap the memory mapped I/O space described by the @res
> > + *	into the CPU physical address space. Only architectures
> > + *	that have memory mapped IO defined (and hence PCI_IOBASE)
> > + *	should call this function.
> > + */
> > +int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> > +{
> > +	int err = -ENODEV;
> > +
> > +#ifdef PCI_IOBASE
> > +	if (!(res->flags & IORESOURCE_IO))
> > +		return -EINVAL;
> > +
> > +	if (res->end > IO_SPACE_LIMIT)
> > +		return -EINVAL;
> > +
> > +	err = ioremap_page_range(res->start + (unsigned long)PCI_IOBASE,
> > +				res->end + 1 + (unsigned long)PCI_IOBASE,
> > +				phys_addr, __pgprot(PROT_DEVICE_nGnRE));
> 
> Except that PROT_DEVICE_nGnRE is arm64 only. I think that's a function
> that should remain arch specific.

Yes, I was following Arnd's suggestion and lost track of the fact that
PROT_DEVICE_nGnRE is arm64 specific.

Best regards,
Liviu

> 
> -- 
> Catalin

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
