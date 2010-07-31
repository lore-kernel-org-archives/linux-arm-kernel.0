From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jul 2010 21:47:27 +0100
Subject: [RFC] dove: fix __io() definition to use bus based offset
In-Reply-To: <201007312121.40995.arnd@arndb.de>
References: <AANLkTinuXRH0XeD=3b0Wmq32SEEBxdevfj58EmSybcWu@mail.gmail.com>
	<20100731110802.GL23886@n2100.arm.linux.org.uk>
	<201007312121.40995.arnd@arndb.de>
Message-ID: <20100731204727.GH27064@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 31, 2010 at 09:21:40PM +0200, Arnd Bergmann wrote:
> On Saturday 31 July 2010 13:08:02 Russell King - ARM Linux wrote:
> > On Thu, Jul 29, 2010 at 01:45:35PM +0800, Eric Miao wrote:
> > > diff --git a/arch/arm/mach-dove/include/mach/io.h
> > > b/arch/arm/mach-dove/include/mach/io.h
> > > index 3b3e472..067435e 100644
> > > --- a/arch/arm/mach-dove/include/mach/io.h
> > > +++ b/arch/arm/mach-dove/include/mach/io.h
> > > @@ -11,10 +11,9 @@
> > > 
> > >  #include "dove.h"
> > > 
> > > -#define IO_SPACE_LIMIT               0xffffffff
> > > -
> > > -#define __io(a)  ((void __iomem *)(((a) - DOVE_PCIE0_IO_PHYS_BASE) +\
> > > -                                DOVE_PCIE0_IO_VIRT_BASE))
> > > -#define __mem_pci(a)         (a)
> > > +#define IO_SPACE_LIMIT       0xffffffff
> > > +#define __io(a)              __typesafe_io((a) - DOVE_PCIE0_IO_BUS_BASE + \
> > > +                                         DOVE_PCIE0_IO_VIRT_BASE)
> > 
> > I recommend against this use of __typesafe_io():
> > 
> > http://lists.arm.linux.org.uk/lurker/message/20090214.154245.6325bc9d.en.html
> > 
> 
> On a related note, is there a particular reason why most of the
> *_*_VIRT_BASE macros are just numbers instead of void __iomem
> pointers?

Let me expand a little, and then I'll answer your question.

As already covered, __io() is the macro to enable the PC-like IO port
macros, and if there's a simple 1:1 mapping, defining it to be the
__typesafe_io() function is what's required.  __typesafe_io() should
not appear anywhere else, and as I've said in the URL above, it
shouldn't be aliased to __io() with offsets.  So I wouldn't want to
see stuff using __io() nor __typesafe_io() for other stuff (such as
_VIRT_BASE macros.)

Now, when it comes to _VIRT_BASE macros, they tend to end up being
used not only in C code, but also assembly.  In C, it's useful to
have virtual addresses typed correctly - which as you say are void
__iomem pointers.  When it comes to assembly, to avoid defining a
set of additional pointers, I've suggested in the past to do this:

#ifndef __ASSEMBLY__
#define IOMEM(x)	((void __iomem __force *)(x))
#else
#define IOMEM(x)	(x)
#endif

#define FOO_VIRT_BASE	IOMEM(0xfeedface)

which gives us the behaviour we desire.  I'd ideally like IOMEM() to
be in some generic header, but I don't think asm/io.h makes much sense
for that - neither does creating a new header just for it.  What do
other architectures do for accessing system device registers (excluding
x86 which of course uses ISA IO macros)?  I wonder if somewhere under
linux/ would be appropriate for it.

There is one place in our architecture code where this goes wrong, and
that's the static map structures (struct map_desc) where the virtual
address is an unsigned long - this is because the underlying code really
wants it as a number and not a pointer (it wants to do stuff with page
tables.)  Converting this to a pointer results in casts-to-pointers
appearing elsewhere in the code, so you can't win on that.

However, for the vast majority of definitions (being registers) then
defining them to be void __iomem pointer like is definitely the right
thing.

I've toyed in the past with making the IO macros have tigher type-
checking, but I've found each time I've tried it that it causes gcc
to become less efficient with code generation, resulting in larger
kernels.

If someone can come up with a script or put the work into fixing the
integer-likeness of some of the _VIRT_BASE stuff and create a set of
reasonable patches, I'm personally all for it.
