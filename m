From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Dec 2010 18:51:06 +0100
Subject: [PATCH v6 01/15] ARM: mxs: Add core definitions
In-Reply-To: <20101215172305.GH9937@n2100.arm.linux.org.uk>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<201012151808.41969.arnd@arndb.de>
	<20101215172305.GH9937@n2100.arm.linux.org.uk>
Message-ID: <201012151851.06217.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 December 2010, Russell King - ARM Linux wrote:
> On Wed, Dec 15, 2010 at 06:08:41PM +0100, Arnd Bergmann wrote:
> > On Wednesday 15 December 2010, Russell King - ARM Linux wrote:
> > > The alternative is we end up with:
> > > 
> > > #define FOO_ASM_BASE            0xf0000000
> > > #define FOO_C_BASE              ((void __force __iomem *)0xf0000000)
> > 
> > But isn't a hardwire virtual I/O address something that should be
> > used only very rarely?
> 
> You'd be surprised.  With x86, the answer is clearly yes, because you
> have the special IO space.
>
> On architectures with no special IO space, everything is MMIO, including
> system peripherals.  So when you come to the basics such as interrupt
> controllers and timers, which don't lend themselves to being ioremap()'d,
> you have to come up with a different scheme.

I don't know too much about x86, but on most architectures I've looked
at recently (powerpc, tile, microblaze, ...), the peripherals get
initialized way after the memory management, so actually everything
can get mapped using ioremap.

I understand that it's convenient for the system devices on ARM,
especially if they get used from assembly code, but I still thought
this would be an exception for stuff that is rather low-level.

> With statically mapped MMIO devices, we define the v:p mapping explicitly,
> and define constants above.  And its these kinds of basic system
> peripherals that need to be accessed in one way or another from assembly
> code (eg, for stuff like sleep support.)

Right, I know.

> > I would assume that we only need to have the base address of the
> > mapping window defined somewhere and then use offsets:
> > 
> > #ifdef __ASSEMBLY__
> > #define IOMEM_BASE	0xf0000000
> > #else
> > #define IOMEM_BASE	((void __iomem *)0xf0000000)
> > #endif
> > 
> > #define FOO_BASE	IOMEM_BASE + 0x18000
> > #define BAR_BASE	IOMEM_BASE + 0x20000
> 
> What if your interrupt controller and system controller are 1GB apart?

Well, we already map them them through a table, so we can always
define the table in a way that physically distinct ranges get mapped
to virtually contiguous locations.

> The reason I haven't done so is because it doesn't fit into an existing
> header file (we could create asm/iomem.h to contain it for people to
> include, but for the sake of five lines that's OTT.)
> 
> Putting it in asm/io.h doesn't work because that's generally not safe
> for assembly code (and also causes issues with checkpatch wanting people
> rightfully to be using linux/io.h).

A lot of platforms have a mach/hardware.h file that defines the
actual addresses, so maybe an asm/hardware.h would work as a
place to keep definitions like this, and that includes the
underlying mach/hardware.h.

	Arnd
