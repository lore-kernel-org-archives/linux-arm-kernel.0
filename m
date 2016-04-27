From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 27 Apr 2016 17:58:27 -0500
Subject: pci_ioremap_set_mem_type(), pci_remap_iospace()
Message-ID: <20160427225827.GC17629@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas & Liviu,

You added pci_ioremap_set_mem_type(int mem_type) with 1c8c3cf0b523
("ARM: 8060/1: mm: allow sub-architectures to override PCI I/O memory
type").

I see this patch on the list: "[PATCH 3/3] ARM: mvebu: implement
L2/PCIe deadlock workaround"
(http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/242784.html)
that does call pci_ioremap_set_mem_type(), but it doesn't look like
that patch ever got merged.

Is it still useful to have pci_ioremap_set_mem_type() even though
nobody calls it?

I'm looking at the issue of how we ioremap memory-mapped ioport
spaces, and pci_ioremap_mem_type is currently used in the arm-specific
pci_ioremap_io():

  int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
  {
    BUG_ON(offset + SZ_64K > IO_SPACE_LIMIT);

    return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
                              PCI_IO_VIRT_BASE + offset + SZ_64K,
                              phys_addr,
                              __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte));
  }

Also, what about pci_remap_iospace(), added by 8b921acfeffd ("PCI: Add
pci_remap_iospace() to map bus I/O resources")?

  int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
  {
  #if defined(PCI_IOBASE) && defined(CONFIG_MMU)
    unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;

    if (!(res->flags & IORESOURCE_IO))
      return -EINVAL;

    if (res->end > IO_SPACE_LIMIT)
      return -EINVAL;

    return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
                              pgprot_device(PAGE_KERNEL));
    ...

pci_remap_iospace() is generic code from drivers/pci/pci.c.  Here we
also call ioremap_page_range(), but we use pgprot_device(PAGE_KERNEL)
(not __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte)).

It seems like these two calls of ioremap_page_range() should use the
same prot argument.  Looking at __arm_ioremap_pfn_caller() makes me
suspect that pci_remap_iospace() is not safe on arm.

Bjorn
