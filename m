From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 18 Apr 2017 20:36:48 +1000
Subject: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
In-Reply-To: <20170418085732.GA23882@red-moon>
References: <1491917906.7236.7.camel@kernel.crashing.org>
 <20170411140857.GA6821@red-moon>
 <1491952371.7236.22.camel@kernel.crashing.org>
 <20170412113124.GZ17774@n2100.armlinux.org.uk>
 <1492005119.7236.62.camel@kernel.crashing.org>
 <20170412141654.GA17774@n2100.armlinux.org.uk>
 <20170412144109.GB6842@red-moon>
 <1492036240.7236.80.camel@kernel.crashing.org>
 <20170412224555.GB17774@n2100.armlinux.org.uk>
 <1492044780.7236.87.camel@kernel.crashing.org>
 <20170418085732.GA23882@red-moon>
Message-ID: <1492511808.25766.91.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-18 at 09:57 +0100, Lorenzo Pieralisi wrote:
> I can add a defined(pgprot_nonposted) to pci_remap_iospace() if that's
> not too ugly (I suspect Bjorn is thrilled about it :)), that plus
> the Kconfig option for ioremap_nopost() should complete this series.
> 
> int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> {
> #if defined(PCI_IOBASE) && defined(CONFIG_MMU) && defined(pgprot_nonposted)
> ????????unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
> 
> ????????if (!(res->flags & IORESOURCE_IO))
> ????????????????return -EINVAL;
> 
> ????????if (res->end > IO_SPACE_LIMIT)
> ????????????????return -EINVAL
> ????????return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
> ????????????????????????????????? pgprot_nonposted(PAGE_KERNEL));
> #else
> ????????/* this architecture does not have memory mapped I/O space,
> ?????????? so this function should never be called */
> ????????WARN_ONCE(1, "This architecture does not support memory mapped I/O\n");
> ????????return -ENODEV;
> #endif

The above would effectively disable mmap'ing of IO space for any
architecture that doesn't have pgprot_nonposted... so everybody except
ARM. Thus breaking a number of systems that have been working fine for
years.

I fail to see the point....

I think you are giving the whole non-posted stuff way more importance
than it deserves. It's originally a kludge Intel did to PCI because it
well with their synchronous IO space, which was itself a remnant of
pre-history that should have long died.

In the specific case of PCI (again I'm not talking about the general
case of pgprot/ioremap_nonposted), we have routinely been "violating"
that rule, at least on the CPU -> PCI Bridge path (the PCI bridge
itself tends to respect it though I've seen exceptions) for decades
without any adverse effect.

I don't think there's much code (if any) out there which actually
relies on the non-posted characteristics of IO space.

I don't care *that* much mind you, we dropped IO space on PCI with
POWER8, but it would break stuff on existing older machines such as
PowerMacs for no good reason.

I'd rather we document that mmap'ing IO space via sysfs doesn't fully
respect the "non-posted" semantics of IO and be done with it.

Is there any other practical use of non-posted mappings ? Config space
I suppose, though here mostly PCI host bridges handle it by doing a
read back in the config ops...

Cheers,
Ben.
