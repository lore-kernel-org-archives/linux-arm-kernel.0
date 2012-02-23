From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Feb 2012 12:33:04 +0000
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <20120223113801.GV22562@n2100.arm.linux.org.uk>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
 <4F462444.8060406@st.com> <20120223113801.GV22562@n2100.arm.linux.org.uk>
Message-ID: <201202231233.05622.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 February 2012, Russell King - ARM Linux wrote:
> On Thu, Feb 23, 2012 at 05:04:28PM +0530, Pratyush Anand wrote:
> > On 2/23/2012 4:49 PM, Russell King - ARM Linux wrote:
> >> On Thu, Feb 23, 2012 at 04:23:11PM +0530, Viresh Kumar wrote:
> >>> On 2/23/2012 3:23 PM, Russell King - ARM Linux wrote:
> >>>> 1. Using the PCI/ISA IO macros for non-PCI/ISA IO purposes is silly
> >>>
> >>> We mistakenly placed it outside #ifdef __io, #endif
> >>> Sorry, i am still missing your point.
> >>
> >> inb() et.al. are for PCI/ISA IO, not for general platform MMIO.
> >>
> >
> > Ok.. So, will it be fine if we keep it outside #ifdef __io and do not  
> > use __io macro in their implementation?

It would be technically correct unlike an implementation based on inb/outb,
the question is whether it would be a good solution for the problem at
hand. We've had too many ad-hoc fixes in this area leading us to the
mess we're in now, so we should be very careful about getting it right
this time.

> No, I refuse to add another set of accessors to ARMs io.h.  They're private
> to PPC - it even says so in their header file.  They should not have leaked
> out of PPC.
> 
> The fact that 73 drivers in the kernel source use their accessors is their
> problem to solve.

The reason why for ppc to have introduced these is the need for accessors
that work for on-chip devices on machines where the PCI readl/writel and
ioread32/iowrite32 do something funny like using an indirect register
or a hypercall. We have a similar problem on ARM with
CONFIG_IXP4XX_INDIRECT_PCI and possibly the new highbank platforms
that might be doing the same thing in order to get the most out of the
4GB address space.

The mistake on ppc was to make them private to one architecture instead of
coming up with a well-defined set of accessors that are provided on all
architectures. We certainly have too many accessors already between
inl/readl/ioread32/__raw_readl/readl_relaxed/in_le32, which makes this
rather confusing, but IMHO there is still the need for cleanup and
addition of missing variants like cpu-endian non-relaxed and
big-endian relaxed as well as a replacement for __raw_* that actually
defines them to something useful across architectures.

In case of the dgw otg driver, we can add a simple hack like

#if defined(CONFIG_PPC) || defined(CONFIG_MICROBLAZE) || defined(CONFIG_M68K)
#define dwg_readl(x)	in_le32(x)
#else
#define dwg_readl(x)	readl(x)
#endif

But there is a danger of spreading such hacks everywhere across the
kernel and making the mess bigger. I think a better direction would be
to define one set of accessors across architectures that can be
safely used in this driver. The choices that I can see are:

1. define the {in,out}_{le,be}{8,16,32,64} accessors for *all* architectures
following the ppc semantics (fixed endianess, strict ordering, __iomem but
not PCI). On ARM, this would be the same as the readl() family for all
platforms that have a memory mapped PCI memory space.

2. change the ppc definition of the readl_relaxed() family to something
useful (fixed endian, relaxed ordering, iomem (possibly including PCI
-- same as in_le32 but without the ordering guarantee) and make any
driver that wants to be portable use those accessors with explicit I/O
barriers on spinlocks and DMA.

3. Add a new set of consistent accessors that are explicitly meant for
non-PCI on-chip components and make sure we really get them right this
time and can retire some of the other ones eventually. This means it
needs to be completely arch independent, include relaxed and strict
accesses, little-endian/cpu-endian/native-endian and a well-documented
address space (or more than one).

	Arnd
