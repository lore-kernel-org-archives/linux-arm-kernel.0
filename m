From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 22 Jun 2012 14:43:11 +0200
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <CAErSpo6vHn3p96o7DSdL28cjapk2UnQ4ZVJ1oH6ksxbqD=Hh-g@mail.gmail.com>
References: <4FDA2DDA.1030704@wwwdotorg.org>
 <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de>
 <4FDA40A0.4030206@wwwdotorg.org>
 <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de>
 <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
 <4FE0EFBB.6090206@firmworks.com>
 <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6Bpfqm-0yGiBOXEhF4kD3PTDYvWVr0babLZ4GkBLXJiA@mail.gmail.com>
 <20120622110038.GA15212@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6vHn3p96o7DSdL28cjapk2UnQ4ZVJ1oH6ksxbqD=Hh-g@mail.gmail.com>
Message-ID: <20120622124311.GA21606@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2012 at 05:46:52AM -0600, Bjorn Helgaas wrote:
> On Fri, Jun 22, 2012 at 5:00 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Fri, Jun 22, 2012 at 04:18:05AM -0600, Bjorn Helgaas wrote:
> >> On Thu, Jun 21, 2012 at 12:47 AM, Thierry Reding
> >> <thierry.reding@avionic-design.de> wrote:
> >> > On Tue, Jun 19, 2012 at 11:31:39AM -1000, Mitch Bradley wrote:
> >>
> >> >> Version A - 3 address cells: ?In this version, the intermediate
> >> >> address space has 3 cells: ?port#, address type, offset. ?Address
> >> >> type is
> >> >> ? 0 : root port
> >> >> ? 1 : config space
> >> >> ? 2 : extended config space
> >> >> ? 3 : I/O
> >> >> ? 4 : non-prefetchable memory
> >> >> ? 5 : prefetchable memory.
> >> >>
> >> >> The third cell "offset" is necessary so that the size field has a
> >> >> number space that can include it.
> >> >>
> >> >> ? ? ? pcie-controller {
> >> >> ? ? ? ? ? ? ? compatible = "nvidia,tegra20-pcie";
> >> >> ? ? ? ? ? ? ? reg = <0x80003000 0x00000800 ? /* PADS registers */
> >> >> ? ? ? ? ? ? ? ? ? ? ?0x80003800 0x00000200>; /* extended configuration space */
> >> >> ? ? ? ? ? ? ? interrupts = <0 98 0x04 ? /* controller interrupt */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? 0 99 0x04>; /* MSI interrupt */
> >> >> ? ? ? ? ? ? ? status = "disabled";
> >> >>
> >> >> ? ? ? ? ? ? ? ranges = <0 0 0 ?0x80000000 0x00001000 ? /* Root port 0 */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? 0 1 0 ?0x80004000 0x00080000 ? /* Port 0 config space */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? 0 2 0 ?0x80104000 0x00080000 ? /* Port 0 ext config space *
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? 0 3 0 ?0x80400000 0x00008000 ? /* Port 0 downstream I/O */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? 0 4 0 ?0x90000000 0x08000000 ? /* Port 0 non-prefetchable memory */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? 0 5 0 ?0xa0000000 0x08000000 ? /* Port 0 prefetchable memory */
> >> >>
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? 1 0 0 ?0x80001000 0x00001000 ? /* Root port 1 */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? 1 1 0 ?0x80004000 0x00080000 ? /* Port 1 config space */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? 1 2 0 ?0x80184000 0x00080000 ? /* Port 1 ext config space */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? 1 3 0 ?0x80408000 0x00010000 ? /* Port 1 downstream I/O */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? 1 4 0 ?0x98000000 0x08000000 ? /* Port 1 non-prefetchable memory */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? 1 5 0 ?0xa0000000 0x08000000>; /* Port 1 prefetchable memory */
> >> >>
> >> >> ? ? ? ? ? ? ? #address-cells = <3>;
> >> >> ? ? ? ? ? ? ? #size-cells = <1>;
> >> >>
> >> >> ? ? ? ? ? ? ? pci at 0 {
> >> >> ? ? ? ? ? ? ? ? ? ? ? reg = <0 0 0 0x1000>;
> >> >> ? ? ? ? ? ? ? ? ? ? ? status = "disabled";
> >> >>
> >> >> ? ? ? ? ? ? ? ? ? ? ? #address-cells = <3>;
> >> >> ? ? ? ? ? ? ? ? ? ? ? #size-cells = <2>;
> >> >>
> >> >> ? ? ? ? ? ? ? ? ? ? ? ranges = <0x80000000 0 0 ?0 1 0 ?0 0x00080000 ? /* config */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 0x90000000 0 0 ?0 2 0 ?0 0x00080000 ? /* extended config */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 0x81000000 0 0 ?0 3 0 ?0 0x00008000 ? /* I/O */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 0x82000000 0 0 ?0 4 0 ?0 0x08000000 ? /* non-prefetchable memory */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 0xc2000000 0 0 ?0 5 0 ?0 0x08000000>; /* prefetchable memory */
> >> >>
> >> >> ? ? ? ? ? ? ? ? ? ? ? nvidia,ctrl-offset = <0x110>;
> >> >> ? ? ? ? ? ? ? ? ? ? ? nvidia,num-lanes = <2>;
> >> >> ? ? ? ? ? ? ? };
> >> >>
> >> >>
> >> >> ? ? ? ? ? ? ? pci at 1 {
> >> >> ? ? ? ? ? ? ? ? ? ? ? reg = <1 0 0 0x1000>;
> >> >> ? ? ? ? ? ? ? ? ? ? ? status = "disabled";
> >> >>
> >> >> ? ? ? ? ? ? ? ? ? ? ? #address-cells = <3>;
> >> >> ? ? ? ? ? ? ? ? ? ? ? #size-cells = <2>;
> >> >>
> >> >> ? ? ? ? ? ? ? ? ? ? ? ranges = <0x80000000 0 0 ?1 1 0 ?0 0x00080000 ? /* config */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 0x90000000 0 0 ?1 2 0 ?0 0x00080000 ? /* extended config */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 0x81000000 0 0 ?1 3 0 ?0 0x00008000 ? /* I/O */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 0x82000000 0 0 ?1 4 0 ?0 0x08000000 ? /* non-prefetchable memory */
> >> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 0xc2000000 0 0 ?1 5 0 ?0 0x08000000>; /* prefetchable memory */
> >> >>
> >> >> ? ? ? ? ? ? ? ? ? ? ? nvidia,ctrl-offset = <0x118>;
> >> >> ? ? ? ? ? ? ? ? ? ? ? nvidia,num-lanes = <2>;
> >> >> ? ? ? ? ? ? ? };
> >>
> >> I'm not familiar with device tree, so pardon me if these are stupid
> >> questions. ?These seem to be describing PCI host bridges.
> >
> > Yes, correct.
> >
> >> I assume some of these ranges describe MMIO, prefetchable MMIO, and
> >> I/O port apertures that the bridge forwards to the PCI bus.
> >
> > Yes.
> >
> >> Is there provision for any address offset applied by the bridge when
> >> it forwards downstream? ?(Maybe these bridges don't apply any offset?)
> >> ?"0xa0000000 0x08000000" appears for both ports 0 and 1 prefetchable
> >> memory; I don't know if that's an error, an indication that each
> >> bridge applies a different offset, or that both bridges forward the
> >> same aperture (I hope not the latter, because Linux can't really deal
> >> with that).
> >
> > That seems to be a typo. It should have been 0xa8000000 in the second
> > case. The PCIe controller has registers that are programmed with the
> > aperture for the configuration and extended configuration spaces, as
> > well as the downstream I/O, prefetchable and non-prefetchable memory
> > regions.
> >
> > The configuration spaces aren't actually forwarded by the bridges, but
> > are handled only by the controller.
> 
> Right.  The host bridge (controller) would convert memory accesses on
> the upstream side into PCI config accesses on its downstream PCI
> interface.
> 
> > The other apertures are programmed
> > into the bridges using standard PCI registers.
> 
> If you're talking about programming host bridge apertures, there are
> no "standard PCI registers" to do that.  The programming model of the
> host bridge itself is not part of the PCI spec.  PCI-to-PCI bridge
> apertures *are* specified by the PCI Bridge spec, so those are
> standard.

Each of the root ports has a PCI-compatible set of configuration
registers, so I guess what is meant is that the apertures a programmed
according to the PCI bridge specification.

> >> Is the bus number aperture included somewhere? ?How do we know what
> >> bus numbers are available for allocation under each bridge?
> >
> > Not yet. I don't think DT imposes a bus number allocation on PCI
> > bridges. However the matching of DT nodes to PCI bridges is done based
> > on the bus number. For that you provide a bus-ranges property which
> > defines the bus aperture of the given PCI bridge. The DT matching code
> > compares the first cell of this property with the primary bus number of
> > the bridge.
> 
> I don't fully understand this, but I can tell you that things don't
> work very well if we don't know the aperture.  We can make
> assumptions, like the root bus is 00, and then enumerate everything
> reachable from there.  But then all we know is the largest bus number
> actually reachable from bus 00, which is usually smaller then the end
> of the aperture.  We don't know how many unused bus numbers there are
> in the aperture, so we can't safely allocate any for hot-added
> devices.

I think DT support for PCI is lacking in a lot of areas. PowerPC seems
to be the only architecture actively setting up busses according to the
bus-range property specified in the DT. All other architectures seem to
not pre-allocate bus apertures and go with the default instead. From
what you say that means hot-plugging is out. Although I don't think the
Tegra PCIe controller even supports hot-plugging.

> > This is in fact somewhat counter-productive because it requires you to
> > hard-code the PCI hierarchy within the DT and you loose a lot of the
> > probing functionality. This is not much of an issue for typical PCI
> > endpoints (like network cards) but becomes a problem if you have a PCI
> > endpoint that implements an I2C bus and you want to match I2C slaves on
> > that bus to device nodes so that the kernel can parse and instantiate
> > them properly. I guess in the latter cases hard-coding the PCI tree in
> > DT is not actually a drawback, though.
> >
> >> I see mention of config space. ?Is some of that referring to the ECAM
> >> as in 7.2.2 of the PCIe spec v3.0 (what we refer to as MMCONFIG on
> >> x86)?
> >
> > I only have access to the PCIe 2.0 specification, but it seems to
> > contain the same 7.2.2 section. In fact it looks as though this
> > particular controller indeed implements something similar to ECAM. The
> > address mapping is a little different, though:
> >
> > ? ? ? ?A[(16 + n - 1):16]: bus number
> > ? ? ? ?A[15:11]: device number
> > ? ? ? ?A[10:8]: function number
> > ? ? ? ?A[7:2]: register number
> > ? ? ? ?A[1:0]: unused
> >
> > That information comes directly from the driver and I have no access to
> > the corresponding documentation. It seems like the extended
> > configuration space is accessed using the same mapping but starting at a
> > different base address.
> >
> > But now that you mention it, maybe the driver code is buggy here, and
> > the controller indeed implements ECAM. Furthermore it also seems like
> > the current code doesn't work for the extended configuration space
> > because while the correct offset into the extended configuration space
> > is chosen, the access to registers is done using the same mapping as
> > above, so instead of the 12 (10) bits required for the register number
> > only 8 (6) are in fact used.
> >
> > I wonder whether anyone's actually tested this.
> >
> > Stephen: can you try to find out whether the Tegra PCIe controller
> > indeed implements ECAM, or if this scheme is actually just a proprietary
> > variant?
> 
> It'd be a real shame if they made up a proprietary scheme when ECAM
> seems to be required by the spec.  I'm interested because the current
> MMCONFIG code seems unnecessarily x86-specific, and I expect every
> arch with PCIe would want to use ECAM, so maybe there's some chance
> for a generic implementation.

Since this is pretty well specified by PCIe, a generic implementation
should be possible. We'll have to wait for some better documentation on
Tegra to know whether this is actually ECAM or not.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120622/92ed485b/attachment-0001.sig>
