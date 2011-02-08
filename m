From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 Feb 2011 17:58:14 +0100
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <20110208163229.GC6188@n2100.arm.linux.org.uk>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081617.59092.arnd@arndb.de>
	<20110208163229.GC6188@n2100.arm.linux.org.uk>
Message-ID: <201102081758.14606.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 February 2011 17:32:29 Russell King - ARM Linux wrote:
> On Tue, Feb 08, 2011 at 04:17:58PM +0100, Arnd Bergmann wrote:
> > On Tuesday 08 February 2011, Dave Martin wrote:
> > > CFLAGS_cpu_specific_object.o        += -march=armv7-a
> > > 
> > > Whether it's safe to do it depends on whether code from that file
> > > could ever get run on other processors.  I'm not so sure of the answer
> > > to that..., but perhaps someone else has a better idea.
> > 
> > We already do this a lot from arch/arm/mm/Makefile, and those
> > files are typically just one function per file, so they can easily
> > be proven to be safe that way.
> 
> No, we do that with assembly files.  It doesn't work soo well with
> C files as we really don't want GCC itself to generate v7 instructions
> unless we explicitly ask for them.
>
> The other issue here is that somtimes generating code with different
> -march options leads to the linker refusing to link them together...

Ok, I see. Is that a bug in existing toolchains, or something more
fundamental?

I would have expected that you could at least mix all compiler options
that don't impact the ABI or the instruction set like -mthumb.

Also, I think we can still build with e.g. "-march=armv6 -Wa,-march=armv7",
which should tell the compiler to only emit armv6 instructions, but make
the assembler more permissive for inline assembly.

	Arnd
