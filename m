From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 May 2014 16:34:30 +0100
Subject: [PATCHv3 1/3] ARM: mm: allow sub-architectures to override PCI
 I/O memory type
In-Reply-To: <4972763.mtuLYh6sDH@wuerfel>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140515155130.193c3181@free-electrons.com>
 <20140515142924.GI27594@arm.com> <4972763.mtuLYh6sDH@wuerfel>
Message-ID: <20140515153430.GM27594@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, May 15, 2014 at 03:32:43PM +0100, Arnd Bergmann wrote:
> On Thursday 15 May 2014 15:29:24 Will Deacon wrote:
> >  Thu, May 15, 2014 at 02:51:30PM +0100, Thomas Petazzoni wrote:
> > > On Thu, 15 May 2014 15:21:25 +0200, Arnd Bergmann wrote:
> > > > As discussed on IRC, I think we'd be better off making this a strong-ordered
> > > > mapping for all platforms unconditionally. The PCI I/O space semantics
> > > > require non-posted writes, which is the main difference between device
> > > > and SO mappings, so the same fix is required both for mvebu as a workaround
> > > > for the deadlock as well as for everyone else as a fix for an incorrect
> > > > PCI behavior.
> > > 
> > > Ok, I'll take that into account when posting a v4.
> > 
> > Actually, I don't think this reasoning is correct. The memory type here
> > applies to accesses mastered by the CPU onto AXI -- it is the job of the
> > AXI/PCI bridge (i.e. the host controller) to ensure that writes are not
> > posted, so this is irrelevant.
> > 
> > Of course, the erratum in question requires SO memory, but that's an
> > entirely different problem. The default should remain as device memory.
> 
> How can a write be non-posted on the PCI bus if it's posted on AXI?

>From the point-of-view of the CPU it would be posted, but the PCI bus would
see an unposted write (so I imagine there would be write buffering at the
host controller). However, I worry that I'm missing your point :)

> The way I understand it, the CPU would continue with the next instruction
> as soon as the write has made it out to the AXI fabric, i.e. before
> the PIO instruction is complete.

The CPU can continue regardless -- you'd need a DSB if you want to hold up
the instruction stream based on completion of a memory access. With the
posted write (device type), the write may complete as soon as it reaches an
ordered bus.

Note that nGnRnE accesses in AArch64 (the equivalent to strongly-ordered)
*can* still get an early write response -- that is simply a hint to the
memory subsystem.

> If this is used to synchronize with a DMA, there is no guarantee that the
> transaction from PCI will be visible in memory by then.

Can you elaborate on this scenario please? When would we use an I/O space
write to synchronise with a DMA transfer from a PCI endpoint? You're
definitely referring to I/O space as opposed to Configuration Space, right?

Will
