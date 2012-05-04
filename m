From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 May 2012 16:02:53 +0100
Subject: [RFC] Remove support for ARMv3 ARM610 and ARM710 CPUs
In-Reply-To: <20120504144643.GG26481@n2100.arm.linux.org.uk>
References: <20120504095645.GD26481@n2100.arm.linux.org.uk>
 <201205041441.24573.arnd@arndb.de>
 <20120504144643.GG26481@n2100.arm.linux.org.uk>
Message-ID: <20120504150253.GH26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 03:46:43PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 04, 2012 at 02:41:24PM +0000, Arnd Bergmann wrote:
> > On Friday 04 May 2012, Russell King - ARM Linux wrote:
> > > This patch removes support for ARMv3 CPUs, which haven't worked properly
> > > for quite some time (see the FIXME comment in arch/arm/mm/fault.c).  The
> > > only V3 parts left is the cache model for ARMv3, which is needed for some
> > > odd reason by ARM740T CPUs, and being able to build with -march=armv3,
> > > which is required for the RiscPC platform due to its bus structure.
> > 
> > No objections to the patch, but I wonder if this change obsoletes any
> > hardware drivers in turn.  Are there any RiscPC peripherals that are
> > only available on the older models?
> 
> "older models" ?  It's not a machine where the CPU is soldered to the
> motherboard.  I could describe it as being like an x86 motherboard where
> you can plug either an ARM610, ARM710 or StrongARM CPU into it.  The
> CPU type is merely incidental.

I'll point out that we can remove drivers if we kill off ARMv4 support,
which would mean getting rid of all the StrongARM and FA526 CPU support.
That would also mean removing all of ebsa110, footbridge, riscpc, gemini,
sa1100, and shark mach- subdirectories.

It also means I would no longer be able to test various chunks of code
which I currently look after, such as ARM PCI stuff, PCMCIA soc-common,
and some DMA engine stuff.

What I'm basically pointing out is that the majority of my infrastructure
here runs on ARMv4 StrongARM based platforms, and I don't see this
changing any time soon.  As long as that is the case, I have a vested
and selfish interest in keeping the kernel buildable for ARMv4.
