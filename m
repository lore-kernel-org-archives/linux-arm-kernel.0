From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Feb 2012 13:35:04 +0000
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <20120223125044.GW22562@n2100.arm.linux.org.uk>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
 <201202231233.05622.arnd@arndb.de>
 <20120223125044.GW22562@n2100.arm.linux.org.uk>
Message-ID: <201202231335.04923.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 February 2012, Russell King - ARM Linux wrote:
> On Thu, Feb 23, 2012 at 12:33:04PM +0000, Arnd Bergmann wrote:
> > 3. Add a new set of consistent accessors that are explicitly meant for
> > non-PCI on-chip components and make sure we really get them right this
> > time and can retire some of the other ones eventually. This means it
> > needs to be completely arch independent, include relaxed and strict
> > accesses, little-endian/cpu-endian/native-endian and a well-documented
> > address space (or more than one).
> 
> That won't work.  What's behind PCI in one area is on-chip on another.
> See that with various PXA peripherals appearing behind PCI devices on
> x86.  That's also happening with AMBA peripherals as well.
> 
> We really need to get away from that "PCI is special and has its own
> accessors" or "on chip is special and has its own accessors" madness.
> That's already starting to bite as being wrong.

This would mean going through an indirect function call for platforms
where PCI is fundamentally different in hardware. We already do this
for CONFIG_PPC_INDIRECT_PCI, but I'd hope we can avoid this on ARM.

Since devices that can bei either PCI or not are relatively rare, I'd
rather put them in the same category as those that can either use
PCI I/O space or some form of memory space and require that the
drivers use the "I don't care what you are, just do what I want"
accessors in the ioread/iowrite family that are already going through
an indirect function call on most architectures.

Also, the PCI aware readl/writel functions are already more heavyweight
on most architectures (not on x86 though) than we want them to be,
because they have to do extra synchronizing operations against DMA
and/or spinlocks on weakly ordered architectures. We now have
the readl_relaxed family here, but I believe they are only used
for on-chip components at the moment.

	Arnd
