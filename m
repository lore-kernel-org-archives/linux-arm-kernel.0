From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 6 Mar 2014 16:17:13 +0000
Subject: [PATCH v5 3/3] arm64: Add architecture support for PCI
In-Reply-To: <201403042328.51361.arnd@arndb.de>
References: <1393948216-11599-1-git-send-email-Liviu.Dudau@arm.com>
 <1393948216-11599-4-git-send-email-Liviu.Dudau@arm.com>
 <201403042328.51361.arnd@arndb.de>
Message-ID: <20140306161713.GH6457@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 10:28:51PM +0000, Arnd Bergmann wrote:
> On Tuesday 04 March 2014, Liviu Dudau wrote:
> 
> > +extern int isa_dma_bridge_buggy;
> 
> As commented before, I still think we can hardcode this to off

Unfortunately that doesn't work when you have CONFIG_PCI=y. drivers/pci/pci.c has:

drivers/pci/pci.c:int isa_dma_bridge_buggy;
drivers/pci/pci.c:EXPORT_SYMBOL(isa_dma_bridge_buggy);

and drivers/pci/quirks.c does:

drivers/pci/quirks.c:   if (!isa_dma_bridge_buggy) {
drivers/pci/quirks.c:           isa_dma_bridge_buggy=1;
drivers/pci/quirks.c-           dev_info(&dev->dev, "Activating ISA DMA hang workarounds\n");
drivers/pci/quirks.c-   }


> 
> > +unsigned long pci_address_to_pio(phys_addr_t address)
> > +{
> > +	struct ioresource *res;
> > +
> > +	list_for_each_entry(res, &io_list, list) {
> > +		if (address >= res->start &&
> > +			address < res->start + res->size) {
> > +			return res->start - address;
> > +		}
> > +	}
> > +
> > +	return (unsigned long)-1;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_address_to_pio);
> 
> This has two problems:
> 
> - You return the address in bus space not the logical Linux
>   port number as powerpc and microblaze do.
> - You imply that the window starts at bus address zero, which
>   might not be the case.

That's definitely not the intention here. I want to return the
logical port number and I want that port number to start from
zero for every registered IO range. 

> 
> > +EXPORT_SYMBOL(pcibios_fixup_bus);
> 
> no need for this export.

OK.

> 
> > +/*
> > + * We don't have to worry about legacy ISA devices, so nothing to do here
> > + */
> > +resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> > +				resource_size_t size, resource_size_t align)
> > +{
> > +	return ALIGN(res->start, align);
> > +}
> > +EXPORT_SYMBOL(pcibios_align_resource);
> 
> or this one. Also, the ALIGN() is already done by the PCI core.

This has been fix in v6 already.

Thanks for reviewing this!

Liviu

> 
> 	Arnd
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
