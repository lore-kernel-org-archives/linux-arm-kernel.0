From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 20:10:00 +0100
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <CAGsJ_4xntJHz_CzCaTuyCbDrePzxO+esPFxTfZZ1TTnZFy4w=Q@mail.gmail.com>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-2-git-send-email-bs14@csr.com>
	<20110706122501.GU8286@n2100.arm.linux.org.uk>
	<CAGsJ_4xntJHz_CzCaTuyCbDrePzxO+esPFxTfZZ1TTnZFy4w=Q@mail.gmail.com>
Message-ID: <20110706191000.GN8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 12:09:24AM +0800, Barry Song wrote:
> if you define that in asm/io.h as you said:
> 
> #ifndef IO_SPACE_LIMIT
> #if defined(PCMCIA_SOC_COMMON)
> #define  IO_SPACE_LIMIT ((resource_size_t)0xffffffff)
> #else
> #if defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
> #define IO_SPACE_LIMIT ((resource_size_t)0xffff)
> #else
> #define IO_SPACE_LIMIT ((resource_size_t)0)
> #endif
> #endif
> #endif
> 
> i'd like to delete IO_SPACE_LIMIT in my io.h.
>
> otherwise, i'd like to try "#define IO_SPACE_LIMIT
> ((resource_size_t)0)" in my io.h since i have no real
> CONFIG_PCI/ISA/PCCARD/PCMCIA_SOC_COMMON.

Thanks - stopping the 0xffffffff madness in new platforms is great.

If you also omit the definition for __io() and set NO_IOPORT in your
Kconfig, you should also end up with inb() et.al. undefined by asm/io.h,
which should cause build-time failures if an ISA/PCI/PCMCIA driver
attempts to build.
