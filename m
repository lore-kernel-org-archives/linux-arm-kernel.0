From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 May 2014 15:19:58 +0200
Subject: [PATCHv3 1/3] ARM: mm: allow sub-architectures to override PCI
 I/O memory type
In-Reply-To: <20140516095333.GE12341@arm.com>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <11787153.NWVGbVfAPV@wuerfel> <20140516095333.GE12341@arm.com>
Message-ID: <66413148.lBD9c9XUns@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 May 2014 10:53:33 Will Deacon wrote:
> On Thu, May 15, 2014 at 04:55:52PM +0100, Arnd Bergmann wrote:
> > On Thursday 15 May 2014 16:34:30 Will Deacon wrote:
> > > > If this is used to synchronize with a DMA, there is no guarantee that the
> > > > transaction from PCI will be visible in memory by then.
> > > 
> > > Can you elaborate on this scenario please? When would we use an I/O space
> > > write to synchronise with a DMA transfer from a PCI endpoint? You're
> > > definitely referring to I/O space as opposed to Configuration Space, right?
> > 
> > Correct. Assume a PCI device uses PIO and DMA. It sends a DMA to main memory
> > and lets the CPU know about the data using a level (IntA as opposed to MSI)
> > interrupt. The CPU performs an outl() operation to an I/O port to let the
> > hardware know it has received the IRQ and the response of the outl() is
> > guaranteed to flush the DMA transaction: by the time the outl() completes
> > we know that the data in memory is valid because it is strongly ordered
> > relative to the DMA.
> 
> Hmm, when you say `guaranteed to flush the DMA transaction', is that a PCI
> requirement? If so, whether or not that DMA data is then visible to the CPU
> is really specific to the host-controller implementation. It could easily be
> buffered somewhere between the host controller and memory, for example.

It's something that drivers are supposed to rely on, and the PCI host
already has to make the same guarantee about ordering of MSI, MMIO-read
and DMA transactions, all of which we definitely rely on in the kernel.

> > outl() actually does a dsb() internally, but unfortunately that is
> > before the store, not after, so I assume that a driver relying on the
> > behavior above would still be racy.
> 
> Yup, we'd need an additional dsb. I think we're confusing what the PCI
> specification says about ordering and what the inb/outb instructions provide
> on x86. It may well be that we want to emulate the x86 behaviour on ARM, but
> that's not going to come cheap and I don't think it's a decision we should
> take lightly.

outb() is expected to be an extremely heavyweight operation, that's why nobody
uses it. Why would you care about whether it's one or two microsecond latency
on a MIDI port or an ISDN adapter?

We can decide that we don't care about correctness here, but the performance
argument doesn't seem overly important.

	Arnd
