From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Oct 2011 15:23:50 +0100
Subject: [PATCH 1/3 v3] ARM Realview PCIX map include file changes
In-Reply-To: <F01D8B85CFF58440B2A13965FBA90CA47375AC1794@GEORGE.Emea.Arm.com>
References: <20110822130507.23830.26191.stgit@e102602-lin.cambridge.arm.com>
	<20110822130942.23830.4767.stgit@e102602-lin.cambridge.arm.com>
	<201109051635.59927.arnd@arndb.de>
	<F01D8B85CFF58440B2A13965FBA90CA47375AC1794@GEORGE.Emea.Arm.com>
Message-ID: <20111006142350.GD26349@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2011 at 03:00:50PM +0100, Colin Tuckley wrote:
> > pcibios_min_io should be 0x1000 as a constant, in order to get the
> > ISA addresses out of the way, but there is no need to make it
> > board dependent.
> 
> REALVIEW_PB_PCI_IO_BASE is currently 0x90050000, which works, so
> why would I change pcibios_min_io to 0x1000 ?

All the points in this email all go together.

This is how it works:

1. The PCI IO window is _supposed_ to be 64K in size.
2. "pcibios_min_io" sets the minimum offset into the PCI IO window which
   PCI IO BARs should be assigned.  It is assumed that a PCI IO BAR value
   of 0 corresponds with the virtual base address of this window.
3. inb() et.al. take the PCI IO offset and _not_ the physical address nor
   the virtual address of the desired access.

This is so that existing drivers - including VGA card drivers - can work.
There are many PCI cards which require accesses to specific IO locations
not listed in their BARs for initialization etc.

Moreover, we're trying to work towards having a single fixed 64k PCI IO
virtual mapping across all platforms (so that this shows up at the same
virtual address no matter what platform.)  Not having this is a blocker
to the multi-platform activity which Linaro is tasked with.
