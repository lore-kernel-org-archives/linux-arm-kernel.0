From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 28 Apr 2016 13:06:24 +0100
Subject: pci_ioremap_set_mem_type(), pci_remap_iospace()
In-Reply-To: <20160427225827.GC17629@localhost>
References: <20160427225827.GC17629@localhost>
Message-ID: <20160428120624.GV28464@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 05:58:27PM -0500, Bjorn Helgaas wrote:
> Hi Thomas & Liviu,

Hi Bjorn,

> 
> You added pci_ioremap_set_mem_type(int mem_type) with 1c8c3cf0b523
> ("ARM: 8060/1: mm: allow sub-architectures to override PCI I/O memory
> type").
> 
> I see this patch on the list: "[PATCH 3/3] ARM: mvebu: implement
> L2/PCIe deadlock workaround"
> (http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/242784.html)
> that does call pci_ioremap_set_mem_type(), but it doesn't look like
> that patch ever got merged.
> 
> Is it still useful to have pci_ioremap_set_mem_type() even though
> nobody calls it?
> 
> I'm looking at the issue of how we ioremap memory-mapped ioport
> spaces, and pci_ioremap_mem_type is currently used in the arm-specific
> pci_ioremap_io():
> 
>   int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
>   {
>     BUG_ON(offset + SZ_64K > IO_SPACE_LIMIT);
> 
>     return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
>                               PCI_IO_VIRT_BASE + offset + SZ_64K,
>                               phys_addr,
>                               __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte));
>   }
> 
> Also, what about pci_remap_iospace(), added by 8b921acfeffd ("PCI: Add
> pci_remap_iospace() to map bus I/O resources")?
> 
>   int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>   {
>   #if defined(PCI_IOBASE) && defined(CONFIG_MMU)
>     unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
> 
>     if (!(res->flags & IORESOURCE_IO))
>       return -EINVAL;
> 
>     if (res->end > IO_SPACE_LIMIT)
>       return -EINVAL;
> 
>     return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
>                               pgprot_device(PAGE_KERNEL));
>     ...
> 
> pci_remap_iospace() is generic code from drivers/pci/pci.c.  Here we
> also call ioremap_page_range(), but we use pgprot_device(PAGE_KERNEL)
> (not __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte)).

The pci_ioremap_mem_type variable is an arch/arm thing and not generic.
I chose pgprot_device(PAGE_KERNEL) as the more generic way of describing
device type memory mapping for a kernel page, which is arguably the correct
description for PCI MMIO addresses. If a platform needs special treatment for
the mapping then they can redefine pgprot_device to be something other than
pgprot_uncached.

> 
> It seems like these two calls of ioremap_page_range() should use the
> same prot argument.  

Except that, according to Thomas, he wants to use custom prot attributes to work
around bugs in HW.

> Looking at __arm_ioremap_pfn_caller() makes me
> suspect that pci_remap_iospace() is not safe on arm.

Hmm, not sure how you reached that conclusion. __arm_ioremap_pfn_caller()
does call in the end ioremap_page_range() for ARMv7 || ARM_LPAE, which is
what pci_remap_iospace() does as well. Beside the possibly different pgprot_t
values, what would make it unsafe for arm?

I am OK with the suggestion that Thomas has to add a parameter to
pci_remap_iospace() to pass on the pgprot_t value one wants and get rid of
pci_remap_io(), but I would suggest first to him to convert the ARMADA XP
platform to generic PCI code and see if it doesn't work OK by default. We
(well, Lorenzo driven nowadays) are pushing in that direction for a while now.

Best regards,
Liviu

> 
> Bjorn
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
