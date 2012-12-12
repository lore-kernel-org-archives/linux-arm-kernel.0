From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 12 Dec 2012 13:09:10 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121212170417.0bff22e6@skate>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
 <50C62161.9080708@wwwdotorg.org>
 <20121210184439.GA4687@obsidianresearch.com>
 <20121210200350.0f930e27@skate>
 <20121210191843.GB17336@obsidianresearch.com>
 <20121212170417.0bff22e6@skate>
Message-ID: <20121212200910.GA11530@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 05:04:17PM +0100, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Mon, 10 Dec 2012 12:18:43 -0700, Jason Gunthorpe wrote:
> 
> > I haven't studied the Linux code specifically for this, but a quick
> > perusal through the header file isn't showing up any existing support.
> > 
> > You'd have to confer with the PCI maintainers what they want, but a
> > possible way to start would be to fake the configuration query
> > results. This is already being done via a fixup to make the root port
> > report as a host bridge.
> 
> So I should implement fake PCI configuration read/write operations, and
> emulate a PCIe bridge? Sounds complicated...

Well, I can give you an outline what that would look like and you can
think about it.

I'd suggest something like

struct pcie_sw_rp_ops 
{
    int (*setup_port)(unsigned int portnum,..);
    int (*config_read)(unsigned int portnum,..);
    int (*config_write)(unsigned int portnum,..);
    int (*window_setup)(unsigned int portnum,..);
    int (*config_pcie_link_read)(unsgined int portnum,..);
    int (*config_pcie_link_write)(unsigned int portnum,..);
};

// This gets passed to pci_common_init or something more general
struct pcie_sw_rp
{
    // pcie_sw_rp's code has a pcie_ops associated with this
    struct hw_pci pci; 
    unsigned int num_ports;
    const struct pcie_sw_rp_ops *ops
};

pcie_sw_rp models a soft root port, a low level driver creates one of
these objects and supplies pcie_sw_rp_ops. pcie_sw_rp's code is the
entry point from the pci stack, via it's pcie_ops. A sw_rp bundles
num_ports worth of physical PCI-E ports together into a root complex
that has a single host bridge and a PCI-E bridge for every port. It
hides the PCI-E configuration space of the underlying hardware from
the kernel because the hardware is not a compliant with PCI.

For all configuration operations
 - If the target is 00:00.0 then return a static array of data
   representing a standard PCI-E host bridge. Discard all writes.
   This is easy
 - For 00:0x10+N.0 where N is between 0 and num_ports
   - Return static data for a bridge header
     - Static bridge header, static secondary status,
      slightly dynamic bridge ctrl
     - PCI-E Root Port capability block
       - Static Master state and caps
       - call ops->config_pcie_link_* for the slave caps
      (you should be able to get a prototype working without the PCI-E
       capability block)
    - No need for MSI, power management/etc.
    - Map the AER cap via ops (not needed for basic support)
   - Capture and cache writes to the four bridge window registers
     (IO, MMIO, prefetch and busnumber)
   - When the bridge window enable is set call ops->window_setup() on
     all four captured resource ranges. window_setup is expected
     to make it so CPU accesses to the given resource range appear on
     that port.

Most of the configuration block data can be a static array, only a
little actually needs to be dynamic. You can review and copy the lspci
dump from an Intel box to get this right.

I didn't check, but the alignment requirements of bridge configuration
and what the HW can do will have to match. If this can't be done then
some kind of fixup to the PCI-E configurator would be needed........

The purpose of all this is to correct the end-port focused PCI-E
configuration space that Marvell and other SOC vendors use to have a
correct root port configuration model. Hijacking the configuration IOs
to do this is a bit ugly, but does present a correct and consistent
view to userspace. Keeping it general will allow Samsung and others to
use it as well.

Probably a few hundred lines all told. It isn't 'hard' but it will be
a bit finicky..

The other approach would be to try and model all this directly via
PCI-E structures, but there is no existing code support for that, and
user space would see a very confusing view.

> > > Indeed. But for example, in Marvell's case, the address decoding
> > > windows mechanism is not specific to PCIe, it is also used for other
> > > devices, so the management of those decoding windows cannot be
> > > entirely left to the PCIe driver.
> > 
> > Yes, though you might want to think about having the window numbers
> > assigned staticly (for PCI-E and everything else) in device tree
> 
> Definitely not. We have a maximum of 20 address decoding windows, for
> all devices. We have 10 PCIe interfaces, each might require 2 windows:
> one for I/O BARs, one for memory BARs, that would make 20 windows,
> not

Right, that is the point.. If you are actually going to use all 10
PCI-E interfaces then the DT needs to control which interfaces get an
IO mapping window and you need to keep the total # of allocated
windows below 20. (perhaps by not mapping other units, like crypto or
xor)

You can't rely on fully dynamic allocation for this because there is
no way for the PCI layer to know if the IO or MMIO window is going to
be used by the driver that attaches. In the vast majority of cases the
MMIO window will be used and the IO is not necessary..

Jason
