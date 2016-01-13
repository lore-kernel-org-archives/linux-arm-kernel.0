From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 11:29:53 +0100
Subject: [PATCH v1 3/3] ARM64 LPC: update binding doc
In-Reply-To: <20160113100911.GU13633@e106497-lin.cambridge.arm.com>
References: <1451396032-23708-1-git-send-email-zourongrong@gmail.com>
 <4052627.BRvFkUij6q@wuerfel>
 <20160113100911.GU13633@e106497-lin.cambridge.arm.com>
Message-ID: <10121075.WaQr9PQ2xh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 January 2016 10:09:11 liviu.dudau at arm.com wrote:
> On Tue, Jan 12, 2016 at 11:54:59PM +0100, Arnd Bergmann wrote:
> > On Tuesday 12 January 2016 10:14:18 liviu.dudau at arm.com wrote:
> > > 
> > > OK, looking at of_translate_one() comments it looks like a missing "ranges" property is
> > > only accepted on PowerPC. I suggest you have an empty "ranges" property in your isa
> > > parent node, that will signal to the OF parsing code that the mapping is 1:1. Then have
> > > the IPMI node use the reg = <0x0 0xe4 4>; property values instead of reg = <0x1 0xe4 4>;
> > > 
> > > 
> > 
> > A missing ranges property means that there is no translation, while an
> > empty ranges means a 1:1 translation to the parent bus.
> > 
> > We really want the former here, as I/O port addresses are not mapped into
> > the MMIO space of the parent bus.
> 
> Agree. However of_translate_one()'s behaviour doesn't match our expectations and I have no
> useful suggestions on what the right behaviour should be.

I believe of_get_address() already has the correct number (local to the
ISA/LPC bus here), an we just need to teach __of_address_to_resource
about ISA buses that have their own translation. We have the device
node of the ISA bus here, so we just need to stop translating further
using the ranges property and instead use the io_offset for that bus.

In fact we can use the same method for both ISA and PCI buses, if
we just remember which device node is the root for an I/O space
and what its offset is relative to the Linux I/O space. Going all
the way to a physical CPU address and then back to an I/O port number
through pci_address_to_pio() is awkward anyway, but here it's wrong
specifically because there is no physical address for it.

	Arnd
