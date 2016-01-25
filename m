From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 25 Jan 2016 09:52:52 +0000
Subject: [PATCH V3 18/21] ACPI, PCI: Refine the way to handle
 translation_offset for ACPI resources
In-Reply-To: <20160119122026.GA5185@red-moon>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-19-git-send-email-tn@semihalf.com>
 <20160119122026.GA5185@red-moon>
Message-ID: <20160125095252.GB32652@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 12:20:26PM +0000, Lorenzo Pieralisi wrote:
> Gerry,
> 
> On Wed, Jan 13, 2016 at 02:21:04PM +0100, Tomasz Nowicki wrote:
> > From: Liu Jiang <jiang.liu@linux.intel.com>
> > 
> > Some architectures, such as IA64 and ARM64, have no instructions to
> > directly access PCI IO ports, so they map PCI IO ports into PCI MMIO
> > address space. Typically PCI host bridges on those architectures take
> > the responsibility to map (translate) PCI IO port transactions into
> > Memory-Mapped IO transactions. ACPI specification provides support
> > of such a usage case by using resource translation_offset.
> > 
> > But current ACPI resource parsing interface isn't neutral enough,
> > it still has some special logic for IA64. So refine the ACPI resource
> > parsing interface and IA64 code to neutrally handle translation_offset
> > by:
> > 1) ACPI resource parsing interface doesn't do any translation, it just
> >    save the translation_offset to be used by arch code.
> > 2) Arch code will do the mapping(translation) based on arch specific
> >    information. Typically it does:
> > 2.a) Translate per PCI domain IO port address space into system global
> >    IO port address space.
> > 2.b) Setup MMIO address mapping for IO ports.
> 
> This patch fixes IO space handling on IA64 and should go in as a fix.
> 
> IA64 PCI IO space is currently broken (Hanjun tested this on an IA64 box).
> 
> The first broken commit is:
> 
> 3772aea7d6f3 ("ia64/PCI/ACPI: Use common ACPI resource parsing interface for host bridge")
> 
> because acpi core code checks (in acpi_dev_ioresource_flags()) the
> resource.end>=0x10003, which fails on ia64 - currently resource.end is
> set in acpi_decode_space() to:
> 
> AddressMaximum + AddressTranslation
> 
> where AddressTranslation is the CPU physical address mapping IO space
> on IA64, the >=0x10003 check in acpi_dev_ioresource_flags always
> triggers and the IO resource is then disabled.
> 
> Do you want me to re-send this patch as a fix, with updated commit log ?

Two more points to discuss here. IA64, in its prepare_resources() callback
calls acpi_pci_probe_root_resources() in turn. That function parses the
_CRS and validate the resources (acpi_pci_root_validate_resources()).

That does not make sense IMO, because IA64 changes the IO port resources
after calling acpi_pci_probe_root_resources(), hence the validation
carried out in acpi_pci_probe_root_resources(), at least for IO ports
seems wrong (what's the point of validating the CRS against
ioport_resource if we change the _CRS IO space resources afterwards ?).

Second point: we are aware that by removing the offset addition in
acpi_decode_space(), if for any reason on x86 or IA64 a resource has
that offset !=0 (speaking in terms of memory resources for instance)
we are in trouble. Jiang mentioned that on x86 and IA64 offset is always
0x0 for memory resources, but just want to make sure we are all aware
of this potential pitfall.

Comments appreciated, it is time to a) fix IA64 and b) get this _CRS
parsing consolidation done.

Thanks,
Lorenzo
