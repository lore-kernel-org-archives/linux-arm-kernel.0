From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Dec 2012 21:46:05 +0000
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <20121213201206.69452b8f@skate>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121213175442.GC14619@obsidianresearch.com> <20121213201206.69452b8f@skate>
Message-ID: <201212132146.05829.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 December 2012, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Thu, 13 Dec 2012 10:54:42 -0700, Jason Gunthorpe wrote:
> > On Thu, Dec 13, 2012 at 12:19:39PM +0000, Arnd Bergmann wrote:
> >  
> > > Do those ten ports have a shared I/O space window, or does each one
> > > have its own 64K? 
> > 
> > The smallest mbus routing window size is 64k, and you need to use a
> > mbus routing window per PEX to decode into IO.
> 
> Correct.
> 
> > Thomas: Note this complicates my earlier suggestion of just using
> > config transactions because this is horribly non-conformant, PCIe
> > requires a much finer granularity for the root port bridge, it would
> > need some kind of specialness to make the standard Linux resource
> > allocator work properly.... :|
> 
> Hum, not sure to follow you here. What sort of finer granularity does
> PCIe requires?

It's common for multiple buses to share a single I/O address space,
and just allocate port numbers for each BAR from a global 64KB
window, because x86 only has a single 64KB I/O space in hardware.

Maybe it works correctly if you set up all ten I/O windows to point
to the same addresses? I don't have the documentation, so it might
say that this is unsupported, but otherwise it may be worth trying.

> > By far the easiest thing is to keep them as separate PCI busses and
> > require DT to manage each one individually, address ranges and
> > all. :(
> 
> Does that mean that your earlier suggestion of emulating a PCI-to-PCI
> bridge in software is no longer your preferred suggestion?

If the child buses of that virtual bridge can't use the same I/O
space window, that would require significant changes to the Linux
PCI implementation, which does not sound right.

One possibility would be to declare I/O space accesses invalid on this
driver, but that would break support for a number of (older) devices.

	Arnd
