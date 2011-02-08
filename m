From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 Feb 2011 16:42:52 +0100
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <AANLkTim6aBUJtkQHZBWfTWsjh2+ijFqOgf9cPGSrRtMD@mail.gmail.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081615.15713.arnd@arndb.de>
	<AANLkTim6aBUJtkQHZBWfTWsjh2+ijFqOgf9cPGSrRtMD@mail.gmail.com>
Message-ID: <201102081642.52774.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 February 2011, Dave Martin wrote:
> Why not have macros for these cases?  (Which kinda brings the
> discussion full-circle...)
> 
> My immediate concern is that too often, the Thumb-2 case will be
> handled incorrectly or not at all ... and the kernel will silently
> build without flagging any error.  Macros would allow the fragile
> definitions to go in one place.

A macro to handle the thumb2 case and weird toolchains sounds good,
but if we want to build code for multiple CPUs, we need multiple
macros, not one macro that works on a specific CPU.

We could put all those macros unconditionally into a arch
specific header, e.g.

arch/arm/include/asm/system-v7.h:
#define wfi() __asm__ __volatile__ ("wfi" : : : "memory")


arch/arm/include/asm/system-v6k.h:
#define wfi() __asm__ __volatile__ ("mcr p15, 0, %0, c7, c0, 4" \
		: : "r" (0) : "memory")

And then have each C file using them be CPU specific and include
only one (you get an gcc warning if you try to include both).
This should work fine, but it's different again from how we handle
other things like spinlocks or cache management across multiple
CPUs.

	Arnd
