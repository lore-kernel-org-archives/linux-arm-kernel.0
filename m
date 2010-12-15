From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Dec 2010 18:08:41 +0100
Subject: [PATCH v6 01/15] ARM: mxs: Add core definitions
In-Reply-To: <20101215164757.GF9937@n2100.arm.linux.org.uk>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<201012151722.21939.arnd@arndb.de>
	<20101215164757.GF9937@n2100.arm.linux.org.uk>
Message-ID: <201012151808.41969.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 December 2010, Russell King - ARM Linux wrote:
> Err, no - you're not understanding its purpose.  It's used like so:
> 
> #define FOO_BASE                IOMEM(0xf0000000)
> 
> in headers, which means you can use FOO_BASE both in C code (and it'll
> be correctly typed) and also use it in assembly code (where it will be
> an assembly expression.)
> 
> The alternative is we end up with:
> 
> #define FOO_ASM_BASE            0xf0000000
> #define FOO_C_BASE              ((void __force __iomem *)0xf0000000)

But isn't a hardwire virtual I/O address something that should be
used only very rarely?

I would assume that we only need to have the base address of the
mapping window defined somewhere and then use offsets:

#ifdef __ASSEMBLY__
#define IOMEM_BASE	0xf0000000
#else
#define IOMEM_BASE	((void __iomem *)0xf0000000)
#endif

#define FOO_BASE	IOMEM_BASE + 0x18000
#define BAR_BASE	IOMEM_BASE + 0x20000

> Or worse still, we end up with stuff like:
> 
> #define FOO_BASE                0xf0000000
> 
> struct blah {
>         unsigned long base;
> };
> 
> unsigned int blah(struct blah *b, unsigned int reg)
> {
>         return readl(b->base + reg);
> }
> 
> Having IOMEM(), which can be audited to only be used in header files
> defining registers gets around such problems, and ensures that the C
> code is written more correctly than it otherwise would be.

With the autiting, it certainly isn't that bad. One problem
I still see is that it's defined in the platform directory,
rather than somewhere in arch/arm/include/asm/, where it could
be mandated for use across all (or all new) platforms.

Introducing generic infrastructure at a platform level seems
problematic because the good parts will need to get copied
everywhere while the bad parts get stuck in obsolete platforms
forever.

	Arnd
