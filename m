From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 20 May 2015 18:48:17 +0100
Subject: [RFC/RFT PATCH 2/2] ARM64: kernel: pci: implement PCI device
 resources claiming
In-Reply-To: <CAErSpo4OY+mm4R34_1DG5tb+tTJVGQbjuQ75esSF26LUzNWL9A@mail.gmail.com>
References: <1431614537-16136-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1431614537-16136-2-git-send-email-lorenzo.pieralisi@arm.com>
 <5555553F.9070608@amd.com> <20150520085656.GB29274@red-moon>
 <CAErSpo4OY+mm4R34_1DG5tb+tTJVGQbjuQ75esSF26LUzNWL9A@mail.gmail.com>
Message-ID: <20150520174817.GA10750@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 02:02:52PM +0100, Bjorn Helgaas wrote:

[...]

> >> @@ -48,6 +48,11 @@ int pcibios_add_device(struct pci_dev *dev)
> >>
> >>          dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> >>
> >> +       if (pci_has_flag(PCI_PROBE_ONLY) &&
> >
> > Does it really matter if PCI_PROBE_ONLY is set ?
> >
> >> +           !pci_is_root_bus(dev->bus) &&
> >
> > This check is useless, since pci_read_bridge_bases checks that already.
> >
> >> +           !pci_bridge_bases_is_read(dev->bus))
> >> +               pci_read_bridge_bases(dev->bus);
> >> +
> >
> > Ok. Most of the archs do that in pcibios_fixup_bus, I would like to
> > understand:
> >
> > 1) Should we do it on PCI_PROBE_ONLY only
> > 2) Can we move this to generic code - ie pci_scan_child_bus (I guess answer
> >    is no, because there are corner cases I am not aware of)
> 
> In my opinion, we should call pci_read_bridge_bases() in all cases,
> regardless of PCI_PROBE_ONLY.  pci_read_bridge_bases() doesn't
> *change* anything in the hardware; it only reads what's there.  (It
> should attempt writes to learn whether I/O and prefetchable memory
> apertures are implemented, but those should be done as in
> pci_bridge_check_ranges(), where the original value is restored.)
> 
> I also think this should be done in generic code, since there's
> nothing architecture-specific about bridge operation.
> 
> I've been hoping to get rid of pcibios_fixup_bus() completely for
> years, and doing pci_read_bridge_bases() in generic code would be a
> big step.

I put together a patch to move it to pci_scan_child_bus, and to
remove it from almost all archs pcibios_fixup_bus implementations,
let's see how it goes.

> No doubt there are corner cases we'll trip over, but I'm not aware of them yet.
> 

Let's find out :), posting tomorrow.

Thanks,
Lorenzo
