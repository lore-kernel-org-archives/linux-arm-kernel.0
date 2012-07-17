From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 13:12:06 +0000
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <20120717121640.589780ce@skate>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <201207161554.04812.arnd@arndb.de> <20120717121640.589780ce@skate>
Message-ID: <201207171312.06987.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012, Thomas Petazzoni wrote:
> Le Mon, 16 Jul 2012 15:54:04 +0000,
> Arnd Bergmann <arnd@arndb.de> a ?crit :
> 
> > > +void mcs814x_restart(char mode, const char *cmd)
> > > +{
> > > +   __raw_writel(~(1 << 31), mcs814x_sysdbg_base);
> > > +}
> > 
> > You should generally avoid using __raw_readl etc. and instead use
> > readl/write or readl_relaxed/writel_relaxed.
> 
> I thought that readl/writel and readl_relaxed/writel_relaxed were used
> for PCI-style access, for which these macros/functions do automatically
> a conversion from the CPU-endianness to the PCI-endianness
> (little-endian). Here of course, this the SoC is used little-endian, it
> will just work because readl/writel will not do any endianness
> conversion, but if we were on a big-endian machine?
> 
> My understanding until now was that __raw_readl/__raw_writel should be
> used for accesses with native endianness, but apparently, it's more
> subtle than this. Would you mind expanding a bit on this?

The __raw_* versions are basically only valid if you access a memory
buffer, such as a video framebuffer. They do the conversion of an
__iomem pointer into something that can be accessed by the compiler.

The non-raw versions have fixed endianess, guarantee that the access
is done atomically (could be byte-wise otherwise) and that all the
necessary barriers are used to synchronize against DMA and out-of-order
execution.

We don't actually have accessors that are CPU-endian and guarantee that
you can access an MMIO register properly.

On powerpc, the convention is that readl/writel should only be used
to access PCI, but that is for the enhanced error handling, not for
endianess.

	Arnd
