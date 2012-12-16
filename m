From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 16 Dec 2012 14:02:23 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121212200910.GA11530@obsidianresearch.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
 <50C62161.9080708@wwwdotorg.org>
 <20121210184439.GA4687@obsidianresearch.com>
 <20121210200350.0f930e27@skate>
 <20121210191843.GB17336@obsidianresearch.com>
 <20121212170417.0bff22e6@skate>
 <20121212200910.GA11530@obsidianresearch.com>
Message-ID: <20121216130223.GA32037@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 01:09:10PM -0700, Jason Gunthorpe wrote:
> On Wed, Dec 12, 2012 at 05:04:17PM +0100, Thomas Petazzoni wrote:
> > Dear Jason Gunthorpe,
> > 
> > On Mon, 10 Dec 2012 12:18:43 -0700, Jason Gunthorpe wrote:
> > 
> > > I haven't studied the Linux code specifically for this, but a quick
> > > perusal through the header file isn't showing up any existing support.
> > > 
> > > You'd have to confer with the PCI maintainers what they want, but a
> > > possible way to start would be to fake the configuration query
> > > results. This is already being done via a fixup to make the root port
> > > report as a host bridge.
> > 
> > So I should implement fake PCI configuration read/write operations, and
> > emulate a PCIe bridge? Sounds complicated...
> 
> Well, I can give you an outline what that would look like and you can
> think about it.
> 
> I'd suggest something like
> 
> struct pcie_sw_rp_ops 
> {
>     int (*setup_port)(unsigned int portnum,..);
>     int (*config_read)(unsigned int portnum,..);
>     int (*config_write)(unsigned int portnum,..);
>     int (*window_setup)(unsigned int portnum,..);
>     int (*config_pcie_link_read)(unsgined int portnum,..);
>     int (*config_pcie_link_write)(unsigned int portnum,..);
> };
> 
> // This gets passed to pci_common_init or something more general
> struct pcie_sw_rp
> {
>     // pcie_sw_rp's code has a pcie_ops associated with this
>     struct hw_pci pci; 
>     unsigned int num_ports;
>     const struct pcie_sw_rp_ops *ops
> };
> 
> pcie_sw_rp models a soft root port, a low level driver creates one of
> these objects and supplies pcie_sw_rp_ops. pcie_sw_rp's code is the
> entry point from the pci stack, via it's pcie_ops. A sw_rp bundles
> num_ports worth of physical PCI-E ports together into a root complex
> that has a single host bridge and a PCI-E bridge for every port. It
> hides the PCI-E configuration space of the underlying hardware from
> the kernel because the hardware is not a compliant with PCI.
> 
> For all configuration operations
>  - If the target is 00:00.0 then return a static array of data
>    representing a standard PCI-E host bridge. Discard all writes.
>    This is easy
>  - For 00:0x10+N.0 where N is between 0 and num_ports
>    - Return static data for a bridge header
>      - Static bridge header, static secondary status,
>       slightly dynamic bridge ctrl
>      - PCI-E Root Port capability block
>        - Static Master state and caps
>        - call ops->config_pcie_link_* for the slave caps
>       (you should be able to get a prototype working without the PCI-E
>        capability block)
>     - No need for MSI, power management/etc.
>     - Map the AER cap via ops (not needed for basic support)
>    - Capture and cache writes to the four bridge window registers
>      (IO, MMIO, prefetch and busnumber)
>    - When the bridge window enable is set call ops->window_setup() on
>      all four captured resource ranges. window_setup is expected
>      to make it so CPU accesses to the given resource range appear on
>      that port.
> 
> Most of the configuration block data can be a static array, only a
> little actually needs to be dynamic. You can review and copy the lspci
> dump from an Intel box to get this right.
> 
> I didn't check, but the alignment requirements of bridge configuration
> and what the HW can do will have to match. If this can't be done then
> some kind of fixup to the PCI-E configurator would be needed........
> 
> The purpose of all this is to correct the end-port focused PCI-E
> configuration space that Marvell and other SOC vendors use to have a
> correct root port configuration model. Hijacking the configuration IOs
> to do this is a bit ugly, but does present a correct and consistent
> view to userspace. Keeping it general will allow Samsung and others to
> use it as well.
> 
> Probably a few hundred lines all told. It isn't 'hard' but it will be
> a bit finicky..

This sounds like something we could very much use on Tegra as well. It's
the final piece of the puzzle if I understand correctly. Some entity
that the root ports can hang off of.

> The other approach would be to try and model all this directly via
> PCI-E structures, but there is no existing code support for that, and
> user space would see a very confusing view.

I agree, the configuration IO accessors seem to be the only way to get
the kernel and userspace to see the same view.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121216/22d4f2df/attachment.sig>
