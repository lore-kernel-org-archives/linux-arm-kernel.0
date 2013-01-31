From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 31 Jan 2013 16:22:37 +0100
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130131150801.GA23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130130113245.GH23505@n2100.arm.linux.org.uk>
 <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <20130130150856.GJ23505@n2100.arm.linux.org.uk>
 <20130130151934.GK23505@n2100.arm.linux.org.uk>
 <20130130163659.75360dba@skate>
 <20130130154602.GL23505@n2100.arm.linux.org.uk>
 <20130131153041.35fa3b60@skate>
 <20130131145002.GZ23505@n2100.arm.linux.org.uk>
 <20130131155737.4ab97a0b@skate>
 <20130131150801.GA23505@n2100.arm.linux.org.uk>
Message-ID: <20130131162237.79de29c4@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King - ARM Linux,

On Thu, 31 Jan 2013 15:08:01 +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 31, 2013 at 03:57:37PM +0100, Thomas Petazzoni wrote:
> > Indeed. But this function never gets called with bus->number == 0, only
> > with bus->number = 1, 2, 3, 4, 5, 6. So those are child busses, and
> > therefore they have a parent.
> 
> Having thought about it, yes, that's what I expect, because root bus
> resources are never resized.  Root bus resources are normally setup
> before probing to indicate what size they _can_ be and define what
> space is available to the downstream devices.
> 
> Child busses (behind a PCI-2-PCI bridge) are a different matter - these
> will be adjusted according to their on-bus devices and the windows for
> them sized and allocated appropriately _within_ the confines of the
> root bus resource.

Ok.

> > I am talking about the PCI-to-PCI bridges. I want the I/O windows
> > assigned to each PCI-to-PCI bridge to be 64K aligned. The PCI-to-PCI
> > bridges are devices that sit on bus 0, each giving access to the child
> > buses 1, 2, 3, 4, 5, 6.
> 
> Right, so you've just confirmed that this _is_ the right hook and it
> _is_ being called at the right time.

Ok.

> However, I had interpreted your requirement as the _host_ bridge only
> (insufficient information in your previous emails, or I missed it).

Might be insufficient information, or wrong terminology on my side.

> If that's what your bridge requires, then we need to detect it via
> its vendor and device IDs and only apply this fixup to those bridges
> which require a 64K alignment.
> 
> So, the IDs are vendor:device = 0x11ab:0x1092 ?  And let me get this
> straight, it _is_ a specific requirement for this particular bridge
> P2P bridge?

The vendor/device ID will change. This P2P bridge is emulated. However,
I'm not sure why you need to know the vendor:device ID to make the
fixup specific.

The fixup is already specific to those bridges, since I am just setting
pci_sys_data->win_align_io to 64K for the particular buses that are
downstream the problematic bridges. So it doesn't affect any other bus
on the system, and therefore I don't think this fixup needs to be made
specific to a given vendor:device, no?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
