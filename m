From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Aug 2010 12:59:58 +0200
Subject: [RFC] dove: fix __io() definition to use bus based offset
In-Reply-To: <20100731204727.GH27064@n2100.arm.linux.org.uk>
References: <AANLkTinuXRH0XeD=3b0Wmq32SEEBxdevfj58EmSybcWu@mail.gmail.com>
	<201007312121.40995.arnd@arndb.de>
	<20100731204727.GH27064@n2100.arm.linux.org.uk>
Message-ID: <201008021259.58376.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 31 July 2010, Russell King - ARM Linux wrote:
> On Sat, Jul 31, 2010 at 09:21:40PM +0200, Arnd Bergmann wrote:
> > 
> > On a related note, is there a particular reason why most of the
> > *_*_VIRT_BASE macros are just numbers instead of void __iomem
> > pointers?
> 
> Let me expand a little, and then I'll answer your question.
> 
> As already covered, __io() is the macro to enable the PC-like IO port
> macros, and if there's a simple 1:1 mapping, defining it to be the
> __typesafe_io() function is what's required.  __typesafe_io() should
> not appear anywhere else, and as I've said in the URL above, it
> shouldn't be aliased to __io() with offsets.  So I wouldn't want to
> see stuff using __io() nor __typesafe_io() for other stuff (such as
> _VIRT_BASE macros.)

Right, this absolutely makes sense and we already talked about it.
I would even go further and try to remove the definitions that
contain just

#define __io(a) __typesafe_io(a)

For platforms that have no PCI/ISA/PCMCIA support, because they
do not have support for I/O space either. The definition is present
in a number of platforms right now and lets those build device drivers
that use the inb/outb family of functions, but actually calling such
a function with a hardcoded small number like 0x3f8 for the serial
port will result in a NULL pointer exception.

Ideally those functions should only be called when CONFIG_HAS_IOPORT
is set (I've started driver patches for that) and we should
set CONFIG_NO_IOPORT when there is no support for PIO, rather than
defining a bogus mapping to low memory.

> Now, when it comes to _VIRT_BASE macros, they tend to end up being
> used not only in C code, but also assembly.  In C, it's useful to
> have virtual addresses typed correctly - which as you say are void
> __iomem pointers.  When it comes to assembly, to avoid defining a
> set of additional pointers, I've suggested in the past to do this:
> 
> #ifndef __ASSEMBLY__
> #define IOMEM(x)	((void __iomem __force *)(x))
> #else
> #define IOMEM(x)	(x)
> #endif
> 
> #define FOO_VIRT_BASE	IOMEM(0xfeedface)

Ok.

> which gives us the behaviour we desire.  I'd ideally like IOMEM() to
> be in some generic header, but I don't think asm/io.h makes much sense
> for that - neither does creating a new header just for it.  What do
> other architectures do for accessing system device registers (excluding
> x86 which of course uses ISA IO macros)?  I wonder if somewhere under
> linux/ would be appropriate for it.

>From what I've seen in other architectures, few others really use
static memory space mappings, except for the legacy ISA range that
includes the VGA memory space and the PCI/ISA IO space mapping if that
is memory mapped. Both are normally only defined in one place though,
since they are not board specific, so there is no need for a macro
to abstract that.

> There is one place in our architecture code where this goes wrong, and
> that's the static map structures (struct map_desc) where the virtual
> address is an unsigned long - this is because the underlying code really
> wants it as a number and not a pointer (it wants to do stuff with page
> tables.)  Converting this to a pointer results in casts-to-pointers
> appearing elsewhere in the code, so you can't win on that.

I was thinking about making that an anonymous union for a transition
time, like

struct map_desc {
        union {
                unsigned long virtual;
                void __iomem *virt_base;
        };
        unsigned long pfn;
        unsigned long length;
        unsigned int type;
};

Then we can do one platform at a time, moving all definitions from
integer constants to pointer constants.

When the last use of map_desc->virtual is gone, we can remove the
union again (that could be in the same patch series).

> However, for the vast majority of definitions (being registers) then
> defining them to be void __iomem pointer like is definitely the right
> thing.
> 
> I've toyed in the past with making the IO macros have tigher type-
> checking, but I've found each time I've tried it that it causes gcc
> to become less efficient with code generation, resulting in larger
> kernels.

Ok, I'll make sure that whatever I come up with doesn't regress
on code size.

	Arnd
