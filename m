From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Dec 2010 17:23:05 +0000
Subject: [PATCH v6 01/15] ARM: mxs: Add core definitions
In-Reply-To: <201012151808.41969.arnd@arndb.de>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<201012151722.21939.arnd@arndb.de>
	<20101215164757.GF9937@n2100.arm.linux.org.uk>
	<201012151808.41969.arnd@arndb.de>
Message-ID: <20101215172305.GH9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 06:08:41PM +0100, Arnd Bergmann wrote:
> On Wednesday 15 December 2010, Russell King - ARM Linux wrote:
> > Err, no - you're not understanding its purpose.  It's used like so:
> > 
> > #define FOO_BASE                IOMEM(0xf0000000)
> > 
> > in headers, which means you can use FOO_BASE both in C code (and it'll
> > be correctly typed) and also use it in assembly code (where it will be
> > an assembly expression.)
> > 
> > The alternative is we end up with:
> > 
> > #define FOO_ASM_BASE            0xf0000000
> > #define FOO_C_BASE              ((void __force __iomem *)0xf0000000)
> 
> But isn't a hardwire virtual I/O address something that should be
> used only very rarely?

You'd be surprised.  With x86, the answer is clearly yes, because you
have the special IO space.

On architectures with no special IO space, everything is MMIO, including
system peripherals.  So when you come to the basics such as interrupt
controllers and timers, which don't lend themselves to being ioremap()'d,
you have to come up with a different scheme.

With statically mapped MMIO devices, we define the v:p mapping explicitly,
and define constants above.  And its these kinds of basic system
peripherals that need to be accessed in one way or another from assembly
code (eg, for stuff like sleep support.)

> I would assume that we only need to have the base address of the
> mapping window defined somewhere and then use offsets:
> 
> #ifdef __ASSEMBLY__
> #define IOMEM_BASE	0xf0000000
> #else
> #define IOMEM_BASE	((void __iomem *)0xf0000000)
> #endif
> 
> #define FOO_BASE	IOMEM_BASE + 0x18000
> #define BAR_BASE	IOMEM_BASE + 0x20000

What if your interrupt controller and system controller are 1GB apart?

> > Having IOMEM(), which can be audited to only be used in header files
> > defining registers gets around such problems, and ensures that the C
> > code is written more correctly than it otherwise would be.
> 
> With the autiting, it certainly isn't that bad. One problem
> I still see is that it's defined in the platform directory,
> rather than somewhere in arch/arm/include/asm/, where it could
> be mandated for use across all (or all new) platforms.
> 
> Introducing generic infrastructure at a platform level seems
> problematic because the good parts will need to get copied
> everywhere while the bad parts get stuck in obsolete platforms
> forever.

The reason I haven't done so is because it doesn't fit into an existing
header file (we could create asm/iomem.h to contain it for people to
include, but for the sake of five lines that's OTT.)

Putting it in asm/io.h doesn't work because that's generally not safe
for assembly code (and also causes issues with checkpatch wanting people
rightfully to be using linux/io.h).
