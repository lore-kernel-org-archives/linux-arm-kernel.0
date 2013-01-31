From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Jan 2013 15:08:01 +0000
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130131155737.4ab97a0b@skate>
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
Message-ID: <20130131150801.GA23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 03:57:37PM +0100, Thomas Petazzoni wrote:
> Indeed. But this function never gets called with bus->number == 0, only
> with bus->number = 1, 2, 3, 4, 5, 6. So those are child busses, and
> therefore they have a parent.

Having thought about it, yes, that's what I expect, because root bus
resources are never resized.  Root bus resources are normally setup
before probing to indicate what size they _can_ be and define what
space is available to the downstream devices.

Child busses (behind a PCI-2-PCI bridge) are a different matter - these
will be adjusted according to their on-bus devices and the windows for
them sized and allocated appropriately _within_ the confines of the
root bus resource.

> I am talking about the PCI-to-PCI bridges. I want the I/O windows
> assigned to each PCI-to-PCI bridge to be 64K aligned. The PCI-to-PCI
> bridges are devices that sit on bus 0, each giving access to the child
> buses 1, 2, 3, 4, 5, 6.

Right, so you've just confirmed that this _is_ the right hook and it
_is_ being called at the right time.

However, I had interpreted your requirement as the _host_ bridge only
(insufficient information in your previous emails, or I missed it).

If that's what your bridge requires, then we need to detect it via
its vendor and device IDs and only apply this fixup to those bridges
which require a 64K alignment.

So, the IDs are vendor:device = 0x11ab:0x1092 ?  And let me get this
straight, it _is_ a specific requirement for this particular bridge
P2P bridge?
