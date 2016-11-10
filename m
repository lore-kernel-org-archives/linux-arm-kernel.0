From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 11 Nov 2016 06:32:33 +1100
Subject: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
In-Reply-To: <20161110112224.GB4418@leverpostej>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-2-git-send-email-yuanzhichang@hisilicon.com>
 <20161108120323.GC15297@leverpostej>
 <1478647002.7430.69.camel@kernel.crashing.org>
 <20161110112224.GB4418@leverpostej>
Message-ID: <1478806353.7430.137.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-11-10 at 11:22 +0000, Mark Rutland wrote:
> On POWER8, our PCIe doesn't do IO at all, but we have an LPC bus behind
> > firmware calls ;-) We use that infrastructure to plumb in the LPC bus.
> 
> Just to check, do you hook that in your inb/outb/etc?

Yes.

> Generally, it would seem nicer if we could have higher-level
> isa_{inb,outb,whatever} accessors that we could hook separately from
> other IO.

Maybe but generally speaking, we don't discriminate accessors per bus,
ie, readl etc... work on all memory mapped busses, inb... works on all
busses with an "IO space", at least that's been the idea. It probably
all comes from the fact that PCI IO and ISA are the same space on
x86 and most other platforms (not all).

> We don't necessarily have to move all ISA drivers over to that if we had
> a separate symbol for that interface.

What I do on ppc today is that I have a chunk of virtual address space
that is reserved for "IO space". The first 64k are "reserved" in that
they route to "the primary" ISA bus (for legacy crap that uses hard
coded addresses, though I use that for my LPC bus too). I "allocate"
space for the PCI IO spaces higher in that space. Was I to support more
LPC busses I could allocate them up there too.

The IO resource of a given device thus becomes the actual IO port plus
the offset of the base of the segment it's in.

For memory mapped IO, inb/outb will just add the virtual address of
the base of all IO space to that. The hooking mechanism will pickup
the stuff that isn't memory mapped.

It's a bit messy but then IO space performance has never been a huge
worry since IO cycles tend to be very slow to begin with.

Note: We also have the ISA memory and ISA FW spaces that we don't have
good accessors for. They somewhat exist (I think the fbdev layer uses
some for vga) but it's messy.

Cheers,
Ben.
