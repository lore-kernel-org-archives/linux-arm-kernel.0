From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Feb 2012 23:43:13 +0000
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <4F3AE98D.7030104@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <201202140804.49026.arnd@arndb.de> <4F3A7158.2080702@gmail.com>
 <201202141716.26930.arnd@arndb.de>
 <20120214174035.GA29765@n2100.arm.linux.org.uk> <4F3AE98D.7030104@gmail.com>
Message-ID: <20120214234313.GD29765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2012 at 05:09:01PM -0600, Rob Herring wrote:
> What about something like this:
> 
> io.h:
> #define PCI_IO_VIRT_BASE 0xfef00000
> 
> arch/arm/common/pci.c (new file):
> static struct map_desc pci_io_desc[] __initdata = {
> 	{
> 		.virtual	= PCI_IO_VIRT_BASE,
> 		.pfn		= 0,
> 		.length		= SZ_1M,
> 		.type		= MT_DEVICE,
> 	},
> };
> 
> void __init pci_map_io(unsigned long paddr)
> {
> 	pci_io_desc[0].pfn = __phys_to_pfn(paddr);
> 	iotable_init(pci_io_desc, ARRAY_SIZE(pci_io_desc));
> }
> 
> 
> This is using the last 1MB of vmalloc region. This may require some
> adjustment of platform's static memory, but most PCI platforms I've
> checked don't use this address, so it shouldn't be too painful.

Yes, something like that.  There's arch/arm/kernel/isa.c which could
take this, which only a few platforms use (it allows glibc inb() etc
to work.)

> orion5x maps 2 1MB regions for PCI and PCIE. How would you support 2 io
> ranges?

That's not the only platform which effectively has two IO ranges.  The
PCMCIA sockets on SA11x0 and probably PXA both have their own separate
IO region.  Arnd's idea for this was to map 32k from one and 32k from
the other into a single 64k space, and adapt soc_common to cope.

> BTW, I noticed some static mappings at 0xffxxxxxx. Are those even a
> valid address?

Nothing invalid about them as such, but I have tried to discourage their
use in case we decide that we want to go for a default 14MB DMA region.
