From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 May 2014 18:40:51 +0200
Subject: [PATCHv3 1/3] ARM: mm: allow sub-architectures to override PCI
 I/O memory type
In-Reply-To: <20140519142355.GD15130@arm.com>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <66413148.lBD9c9XUns@wuerfel> <20140519142355.GD15130@arm.com>
Message-ID: <4669695.sl9JY8Fb9h@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 May 2014 15:23:55 Will Deacon wrote:
> On Mon, May 19, 2014 at 02:19:58PM +0100, Arnd Bergmann wrote:
> > On Friday 16 May 2014 10:53:33 Will Deacon wrote:
> > > On Thu, May 15, 2014 at 04:55:52PM +0100, Arnd Bergmann wrote:
> > > > On Thursday 15 May 2014 16:34:30 Will Deacon wrote:
> > > > > > If this is used to synchronize with a DMA, there is no guarantee that the
> > > > > > transaction from PCI will be visible in memory by then.
> > > > > 
> > > > > Can you elaborate on this scenario please? When would we use an I/O space
> > > > > write to synchronise with a DMA transfer from a PCI endpoint? You're
> > > > > definitely referring to I/O space as opposed to Configuration Space, right?
> > > > 
> > > > Correct. Assume a PCI device uses PIO and DMA. It sends a DMA to main memory
> > > > and lets the CPU know about the data using a level (IntA as opposed to MSI)
> > > > interrupt. The CPU performs an outl() operation to an I/O port to let the
> > > > hardware know it has received the IRQ and the response of the outl() is
> > > > guaranteed to flush the DMA transaction: by the time the outl() completes
> > > > we know that the data in memory is valid because it is strongly ordered
> > > > relative to the DMA.
> > > 
> > > Hmm, when you say `guaranteed to flush the DMA transaction', is that a PCI
> > > requirement? If so, whether or not that DMA data is then visible to the CPU
> > > is really specific to the host-controller implementation. It could easily be
> > > buffered somewhere between the host controller and memory, for example.
> > 
> > It's something that drivers are supposed to rely on, and the PCI host
> > already has to make the same guarantee about ordering of MSI, MMIO-read
> > and DMA transactions, all of which we definitely rely on in the kernel.
> 
> Supposed to rely on for x86, sure. I don't think we can even give you this
> guarantee for arm64, where nE is nothing more than a *hint* to the memory
> subsystem.

That might be why SBSA actually doesn't specify I/O space at all ;-)
 
> For the MSI case, I thought we had to go and poke the SCU for the Marvell
> SoC?

I'd consider that a bug workaround for a case where the hardware doesn't
do the reasonably thing.

> > > > outl() actually does a dsb() internally, but unfortunately that is
> > > > before the store, not after, so I assume that a driver relying on the
> > > > behavior above would still be racy.
> > > 
> > > Yup, we'd need an additional dsb. I think we're confusing what the PCI
> > > specification says about ordering and what the inb/outb instructions provide
> > > on x86. It may well be that we want to emulate the x86 behaviour on ARM, but
> > > that's not going to come cheap and I don't think it's a decision we should
> > > take lightly.
> > 
> > outb() is expected to be an extremely heavyweight operation, that's why nobody
> > uses it. Why would you care about whether it's one or two microsecond latency
> > on a MIDI port or an ISDN adapter?
> 
> Fair enough -- I just don't think we should dress up an erratum workaround as
> a bug fix, especially when it's adding a new user of strongly-ordered memory
> to the kernel which we can't honour for arm64.

Makes sense. How about a patch then that just changes the memory type for
the I/O space and adds a comment explaining all we found out? From what
I can tell, strict ordering is required for Armada 3xx, may or may not
be required elsewhere but should never hurt noticeably. We may want to restrict
it to ARMv6/v7 so we don't have to pick the right domain.

	Arnd
