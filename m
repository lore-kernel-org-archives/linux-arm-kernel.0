From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 May 2014 16:32:43 +0200
Subject: [PATCHv3 1/3] ARM: mm: allow sub-architectures to override PCI
 I/O memory type
In-Reply-To: <20140515142924.GI27594@arm.com>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140515155130.193c3181@free-electrons.com> <20140515142924.GI27594@arm.com>
Message-ID: <4972763.mtuLYh6sDH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 May 2014 15:29:24 Will Deacon wrote:
>  Thu, May 15, 2014 at 02:51:30PM +0100, Thomas Petazzoni wrote:
> > On Thu, 15 May 2014 15:21:25 +0200, Arnd Bergmann wrote:
> > > On Thursday 15 May 2014 11:18:37 Thomas Petazzoni wrote:
> > > > @@ -445,7 +452,7 @@ int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
> > > >         return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
> > > >                                   PCI_IO_VIRT_BASE + offset + SZ_64K,
> > > >                                   phys_addr,
> > > > -                                 __pgprot(get_mem_type(MT_DEVICE)->prot_pte));
> > > > +                                 __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte));
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pci_ioremap_io);
> > > > 
> > > 
> > > As discussed on IRC, I think we'd be better off making this a strong-ordered
> > > mapping for all platforms unconditionally. The PCI I/O space semantics
> > > require non-posted writes, which is the main difference between device
> > > and SO mappings, so the same fix is required both for mvebu as a workaround
> > > for the deadlock as well as for everyone else as a fix for an incorrect
> > > PCI behavior.
> > 
> > Ok, I'll take that into account when posting a v4.
> 
> Actually, I don't think this reasoning is correct. The memory type here
> applies to accesses mastered by the CPU onto AXI -- it is the job of the
> AXI/PCI bridge (i.e. the host controller) to ensure that writes are not
> posted, so this is irrelevant.
> 
> Of course, the erratum in question requires SO memory, but that's an
> entirely different problem. The default should remain as device memory.

How can a write be non-posted on the PCI bus if it's posted on AXI?
The way I understand it, the CPU would continue with the next instruction
as soon as the write has made it out to the AXI fabric, i.e. before
the PIO instruction is complete. If this is used to synchronize with a
DMA, there is no guarantee that the transaction from PCI will be visible
in memory by then.

	Arnd
