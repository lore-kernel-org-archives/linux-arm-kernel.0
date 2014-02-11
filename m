From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Feb 2014 20:15:18 +0100
Subject: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
In-Reply-To: <20140209203412.GN26684@n2100.arm.linux.org.uk>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <201402092118.19701.arnd@arndb.de>
 <20140209203412.GN26684@n2100.arm.linux.org.uk>
Message-ID: <201402112015.19252.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 February 2014, Russell King - ARM Linux wrote:
> On Sun, Feb 09, 2014 at 09:18:19PM +0100, Arnd Bergmann wrote:
> > On Thursday 06 February 2014, Russell King - ARM Linux wrote:
> > 
> > > So, whenever you enumerate a PCI bus, and read the resource information
> > > out of the BARs, you must know how that address region specified in
> > > the BAR as a bus address maps to the host address space.
> > > 
> > 
> > None of that contradicts what I wrote. Please try to understand what
> > I suggested, which is to have a common way to communicate that
> > information from DT to the PCI core without involving the PCI host
> > bridge driver.
> 
> Please explain it better then.
>

Let me try again: Looking at the dw_pcie driver (since that is one of
the few that gets it mostly right), we have quite a bit of generic
code in dw_pcie_host_init() and in dw_pcie_setup(). All the DT parsing
in there just implements the generic PCI DT binding, and what the
setup function does depends exclusively on what comes out of the
parser.

If we manage to move all the common parts into a generic helper
function that gets called by the setup() on arm32, we no longer
need to worry about host drivers implementing an incorrect DT
parser or getting the io_offset calculation wrong, because they
don't actually see any of that, plus we save a lot of duplicate
code.

How it fits together with the new arm64 pci support is a different
question, but if it's just a helper function, it should really work
on any architecture.

	Arnd
