From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Apr 2016 09:21:04 +0200
Subject: pci_ioremap_set_mem_type(), pci_remap_iospace()
In-Reply-To: <20160427225827.GC17629@localhost>
References: <20160427225827.GC17629@localhost>
Message-ID: <20160428092104.2fc0c592@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 27 Apr 2016 17:58:27 -0500, Bjorn Helgaas wrote:

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

I am actually about to send a patch that makes use of it, I discussed
it with Arnd a few days ago / last week.

Essentially the story was the following. On Cortex-A9 based Marvell
SoCs, when HW I/O coherency is enabled, you need all non-RAM space to
be mapped strongly ordered. To this effect, I submitted this patch
series that introduces pci_ioremap_mem_type() to allow
platform-specific code to override the memory type used to map PCI I/O
space.

The reaction of Arnd after this patch series was to suggest that maybe
I should just change the memory type for all platforms, so I sent
another patch doing that.

But in the end, Russell merged the implementation of
pci_ioremap_mem_type() from the previous version of the patch series.
And the remaining patch fell through the cracks. Since PCI I/O is
rarely used these days, it wasn't noticed.

But right now, I have this in my stack of patches to be sent:

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 7e989d6..2d1f06d 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -162,22 +162,16 @@ exit:
 }
 
 /*
- * This ioremap hook is used on Armada 375/38x to ensure that PCIe
- * memory areas are mapped as MT_UNCACHED instead of MT_DEVICE. This
- * is needed as a workaround for a deadlock issue between the PCIe
- * interface and the cache controller.
+ * This ioremap hook is used on Armada 375/38x to ensure that all MMIO
+ * areas are mapped as MT_UNCACHED instead of MT_DEVICE. This is
+ * needed as a workaround for a deadlock issue occurring when HW I/O
+ * coherency is used.
  */
 static void __iomem *
-armada_pcie_wa_ioremap_caller(phys_addr_t phys_addr, size_t size,
-                             unsigned int mtype, void *caller)
+armada_wa_ioremap_caller(phys_addr_t phys_addr, size_t size,
+                        unsigned int mtype, void *caller)
 {
-       struct resource pcie_mem;
-
-       mvebu_mbus_get_pcie_mem_aperture(&pcie_mem);
-
-       if (pcie_mem.start <= phys_addr && (phys_addr + size) <= pcie_mem.end)
-               mtype = MT_UNCACHED;
-
+       mtype = MT_UNCACHED;
        return __arm_ioremap_caller(phys_addr, size, mtype, caller);
 }
 
@@ -186,7 +180,8 @@ static void __init armada_375_380_coherency_init(struct device_node *np)
        struct device_node *cache_dn;
 
        coherency_cpu_base = of_iomap(np, 0);
-       arch_ioremap_caller = armada_pcie_wa_ioremap_caller;
+       arch_ioremap_caller = armada_wa_ioremap_caller;
+       pci_ioremap_set_mem_type(MT_UNCACHED);
 
        /*
         * We should switch the PL310 to I/O coherency mode only if

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

Yes, I was also surprised to see two functions doing pretty much the
same, this probably needs to be refactored. There are 11 users of
pci_ioremap_io() (6 of them being Marvell related), and
pci_ioremap_io() is provided by ARM specific code.

On the other hand, pci_remap_iospace() is provided by
architecture-independent code, and use in 6 PCI controller drivers.

What about:

 1/ Providing an alternate version of pci_remap_iospace() that allows
    to pass the memory attribute to be used.

 2/ Convert all users of pci_ioremap_io() to pci_remap_iospace().

 3/ Get rid of pci_ioremap_io().

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
