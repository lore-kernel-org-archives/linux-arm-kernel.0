From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 22:31:50 +0200
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <20110706191000.GN8286@n2100.arm.linux.org.uk>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<CAGsJ_4xntJHz_CzCaTuyCbDrePzxO+esPFxTfZZ1TTnZFy4w=Q@mail.gmail.com>
	<20110706191000.GN8286@n2100.arm.linux.org.uk>
Message-ID: <201107062231.51117.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011 21:10:00 Russell King - ARM Linux wrote:
> On Thu, Jul 07, 2011 at 12:09:24AM +0800, Barry Song wrote:
> > if you define that in asm/io.h as you said:
> > 
> > #ifndef IO_SPACE_LIMIT
> > #if defined(PCMCIA_SOC_COMMON)
> > #define  IO_SPACE_LIMIT ((resource_size_t)0xffffffff)
> > #else
> > #if defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
> > #define IO_SPACE_LIMIT ((resource_size_t)0xffff)
> > #else
> > #define IO_SPACE_LIMIT ((resource_size_t)0)
> > #endif
> > #endif
> > #endif
> > 
> > i'd like to delete IO_SPACE_LIMIT in my io.h.
> >
> > otherwise, i'd like to try "#define IO_SPACE_LIMIT
> > ((resource_size_t)0)" in my io.h since i have no real
> > CONFIG_PCI/ISA/PCCARD/PCMCIA_SOC_COMMON.
> 
> Thanks - stopping the 0xffffffff madness in new platforms is great.

FWIW, I've double-checked the Xilinx zynq platform that I've already queued
up for 3.1: this one defines IO_SPACE_LIMIT to 0xffff because PCI support
will get merged later, so that's fine.

> If you also omit the definition for __io() and set NO_IOPORT in your
> Kconfig, you should also end up with inb() et.al. undefined by asm/io.h,
> which should cause build-time failures if an ISA/PCI/PCMCIA driver
> attempts to build.

Just as a follow-up, this is what I was referring to in the other
sub-thread. Setting NO_IOPORT and removing __io does work for a lot
of things today, but breaks randconfig builds left and right. I want
to clean that up by adding 'depends on HAS_IOPORT' at the correct places
and then switch all platforms that don't need it to remove __io.

	Arnd
