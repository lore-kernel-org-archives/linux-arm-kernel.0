From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 24 Feb 2012 07:25:38 +1100
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <201202231233.05622.arnd@arndb.de>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
 <4F462444.8060406@st.com> <20120223113801.GV22562@n2100.arm.linux.org.uk>
 <201202231233.05622.arnd@arndb.de>
Message-ID: <1330028738.20389.34.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The reason why for ppc to have introduced these is the need for accessors
> that work for on-chip devices on machines where the PCI readl/writel and
> ioread32/iowrite32 do something funny like using an indirect register
> or a hypercall. We have a similar problem on ARM with
> CONFIG_IXP4XX_INDIRECT_PCI and possibly the new highbank platforms
> that might be doing the same thing in order to get the most out of the
> 4GB address space.

Well, the "generic" ones can do the workarounds conditionally based on
bits of the address. However it does add overhead to SoC drivers that
don't need it.

That's indeed one of the reasons for some drivers to use our specific
ones.

> The mistake on ppc was to make them private to one architecture instead of
> coming up with a well-defined set of accessors that are provided on all
> architectures.

That was never going to fly, we already have too many.

>  We certainly have too many accessors already between
> inl/readl/ioread32/__raw_readl/readl_relaxed/in_le32, which makes this
> rather confusing, but IMHO there is still the need for cleanup and
> addition of missing variants like cpu-endian non-relaxed and
> big-endian relaxed as well as a replacement for __raw_* that actually
> defines them to something useful across architectures.

Right, the _relaxed don't have clear semantics and we do need "real"
relaxed ones badly as in "don't have memory barriers". Currently, a
driver that wants to avoid the sync's we have all over the place in our
accessors for performance reasons has to use __raw_* and thus handle
endian manually as well, which sucks since it also cannot use the
reverse-load/store instructions in that case.

I tried to propose a uniform set a while back, but that never went
anywhere, I should have fought harder. You are welcome to bring that
back on the table :-)

> In case of the dgw otg driver, we can add a simple hack like
> 
> #if defined(CONFIG_PPC) || defined(CONFIG_MICROBLAZE) || defined(CONFIG_M68K)
> #define dwg_readl(x)	in_le32(x)
> #else
> #define dwg_readl(x)	readl(x)
> #endif
> 
> But there is a danger of spreading such hacks everywhere across the
> kernel and making the mess bigger. I think a better direction would be
> to define one set of accessors across architectures that can be
> safely used in this driver. The choices that I can see are:

Yes. We used to have that sort of hacks in the early days as well, I'd
rather not go back down that path.

> 1. define the {in,out}_{le,be}{8,16,32,64} accessors for *all* architectures
> following the ppc semantics (fixed endianess, strict ordering, __iomem but
> not PCI). On ARM, this would be the same as the readl() family for all
> platforms that have a memory mapped PCI memory space.

I'm sure there's going to be resistance here. A better option would be
to properly define __readX/__writeX or something like that (maybe using
iomap variants) as having no built-in PCI specific workarounds.

That still leaves us with the need for properly defined relaxed ones.

> 2. change the ppc definition of the readl_relaxed() family to something
> useful (fixed endian, relaxed ordering, iomem (possibly including PCI
> -- same as in_le32 but without the ordering guarantee) and make any
> driver that wants to be portable use those accessors with explicit I/O
> barriers on spinlocks and DMA.

Last I looked, __relaxed() had a completely different meaning (relaxed
ordering -on-the-bus- which is a totally different thing, so iirc only
one arch ever implemented it).

> 3. Add a new set of consistent accessors that are explicitly meant for
> non-PCI on-chip components and make sure we really get them right this
> time and can retire some of the other ones eventually. This means it
> needs to be completely arch independent, include relaxed and strict
> accesses, little-endian/cpu-endian/native-endian and a well-documented

I don't mind either, it's trivial for us to add them, it's all macro
generated anyway :-)

Cheers,
Ben.
