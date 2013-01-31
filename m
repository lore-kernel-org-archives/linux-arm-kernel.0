From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 31 Jan 2013 15:57:37 +0100
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130131145002.GZ23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130130113245.GH23505@n2100.arm.linux.org.uk>
 <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <20130130150856.GJ23505@n2100.arm.linux.org.uk>
 <20130130151934.GK23505@n2100.arm.linux.org.uk>
 <20130130163659.75360dba@skate>
 <20130130154602.GL23505@n2100.arm.linux.org.uk>
 <20130131153041.35fa3b60@skate>
 <20130131145002.GZ23505@n2100.arm.linux.org.uk>
Message-ID: <20130131155737.4ab97a0b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King - ARM Linux,

On Thu, 31 Jan 2013 14:50:02 +0000, Russell King - ARM Linux wrote:

> > > +	/* Ignore downstream buses */
> > > +	if (!bus->parent) {
> > > +		if (type & IORESOURCE_MEM)
> > > +			return sys->win_align_mem;
> > > +		if (type & IORESOURCE_IO)
> > > +			return sys->win_align_io;
> > > +	}
> > > +	return 1;
> > > +}
> > > +
> > 
> > Unfortunately, this doesn't work as is for me: the if (!bus->parent)
> > prevents the thing from being effective. Here my lspci output:
> > 
> > # /usr/sbin/lspci 
> > 00:00.0 Host bridge: Marvell Technology Group Ltd. Device 102d
> > 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> > 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> > 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> > 00:04.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> > 00:05.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> > 00:06.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> > 03:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)
> > 05:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)
> > 
> > And the function pcibios_window_alignment() only gets called for bus 1,
> > 2, 3, 4, 5, 6 and never for bus 0.
> 
> That's the exact reverse of what I'd expect: the child buses should
> have a non-NULL parent pointer.

Indeed. But this function never gets called with bus->number == 0, only
with bus->number = 1, 2, 3, 4, 5, 6. So those are child busses, and
therefore they have a parent.

If I had a debug message in this pcibios_window_alignment() function
(which gets shown unconditionally, i.e the debug message is outside the
if condition we are discussing), then I get:

pcibios_window_alignment: called for bus ef371c00 (sysdata=ef2f6bc0), number 1
pcibios_window_alignment: called for bus ef371c00 (sysdata=ef2f6bc0), number 1
pcibios_window_alignment: called for bus ef371c00 (sysdata=ef2f6bc0), number 1
pcibios_window_alignment: called for bus ef371a00 (sysdata=ef2f6bc0), number 2
pcibios_window_alignment: called for bus ef371a00 (sysdata=ef2f6bc0), number 2
pcibios_window_alignment: called for bus ef371a00 (sysdata=ef2f6bc0), number 2
pcibios_window_alignment: called for bus ef371800 (sysdata=ef2f6bc0), number 3
pcibios_window_alignment: called for bus ef371800 (sysdata=ef2f6bc0), number 3
pcibios_window_alignment: called for bus ef371800 (sysdata=ef2f6bc0), number 3
pcibios_window_alignment: called for bus ef371600 (sysdata=ef2f6bc0), number 4
pcibios_window_alignment: called for bus ef371600 (sysdata=ef2f6bc0), number 4
pcibios_window_alignment: called for bus ef371600 (sysdata=ef2f6bc0), number 4
pcibios_window_alignment: called for bus ef371400 (sysdata=ef2f6bc0), number 5
pcibios_window_alignment: called for bus ef371400 (sysdata=ef2f6bc0), number 5
pcibios_window_alignment: called for bus ef371400 (sysdata=ef2f6bc0), number 5
pcibios_window_alignment: called for bus ef371200 (sysdata=ef2f6bc0), number 6
pcibios_window_alignment: called for bus ef371200 (sysdata=ef2f6bc0), number 6
pcibios_window_alignment: called for bus ef371200 (sysdata=ef2f6bc0), number 6

See, never called bus bus number 0.

> Hmm.  Try changing that for !bus->self -
> that should make it effective only on the host bridge.
> 
> But... hang on...
> 
> /*
>  * Returns true if the pci bus is root (behind host-pci bridge),
>  * false otherwise
>  */
> static inline bool pci_is_root_bus(struct pci_bus *pbus)
> {
>         return !(pbus->parent);
> }
> 
> So the original test _is_ correct, and should only be triggered for
> the _root_ bus, that being bus 0 in the above case.

Except that this pcibios_window_alignement() function is apparently
never called for the root bus.

> 
> But... wait a moment, what are you saying?  Which bridges need this
> fixup?  The Marvell PCI-to-PCI bridges or the host bridge?

I am talking about the PCI-to-PCI bridges. I want the I/O windows
assigned to each PCI-to-PCI bridge to be 64K aligned. The PCI-to-PCI
bridges are devices that sit on bus 0, each giving access to the child
buses 1, 2, 3, 4, 5, 6.

I have the impression that the pcibios_window_alignment() function is
called on the *child* bus to know the requested alignments for the
bridge that sits on the parent bus and gives access to this child bus.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
