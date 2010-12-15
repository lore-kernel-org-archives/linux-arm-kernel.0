From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Dec 2010 16:47:57 +0000
Subject: [PATCH v6 01/15] ARM: mxs: Add core definitions
In-Reply-To: <201012151722.21939.arnd@arndb.de>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<1292244903-30392-2-git-send-email-shawn.guo@freescale.com>
	<201012151722.21939.arnd@arndb.de>
Message-ID: <20101215164757.GF9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 05:22:21PM +0100, Arnd Bergmann wrote:
> On Monday 13 December 2010, Shawn Guo wrote:
> > +#ifdef __ASSEMBLER__
> > +#define IOMEM(addr)	(addr)
> > +#else
> > +#define IOMEM(addr)	((void __force __iomem *)(addr))
> > +#endif
> 
> This looks like a rather ugly hack to hide misuse of __iomem
> pointers. If you pass virtual addresses of I/O registers,
> just make them always be of type (void __iomem *), so you
> can actually benefit from the sparse annotations, rather
> working against them.

Err, no - you're not understanding its purpose.  It's used like so:

#define FOO_BASE		IOMEM(0xf0000000)

in headers, which means you can use FOO_BASE both in C code (and it'll
be correctly typed) and also use it in assembly code (where it will be
an assembly expression.)

The alternative is we end up with:

#define FOO_ASM_BASE		0xf0000000
#define FOO_C_BASE		((void __force __iomem *)0xf0000000)

Or worse still, we end up with stuff like:

#define FOO_BASE		0xf0000000

struct blah {
	unsigned long base;
};

unsigned int blah(struct blah *b, unsigned int reg)
{
	return readl(b->base + reg);
}

Having IOMEM(), which can be audited to only be used in header files
defining registers gets around such problems, and ensures that the C
code is written more correctly than it otherwise would be.
