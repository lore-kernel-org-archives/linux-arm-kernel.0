From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Aug 2010 12:24:03 +0100
Subject: [RFC] dove: fix __io() definition to use bus based offset
In-Reply-To: <201008021259.58376.arnd@arndb.de>
References: <AANLkTinuXRH0XeD=3b0Wmq32SEEBxdevfj58EmSybcWu@mail.gmail.com>
	<201007312121.40995.arnd@arndb.de>
	<20100731204727.GH27064@n2100.arm.linux.org.uk>
	<201008021259.58376.arnd@arndb.de>
Message-ID: <20100802112403.GE30670@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 02, 2010 at 12:59:58PM +0200, Arnd Bergmann wrote:
> For platforms that have no PCI/ISA/PCMCIA support, because they
> do not have support for I/O space either. The definition is present
> in a number of platforms right now and lets those build device drivers
> that use the inb/outb family of functions, but actually calling such
> a function with a hardcoded small number like 0x3f8 for the serial
> port will result in a NULL pointer exception.
> 
> Ideally those functions should only be called when CONFIG_HAS_IOPORT
> is set (I've started driver patches for that) and we should
> set CONFIG_NO_IOPORT when there is no support for PIO, rather than
> defining a bogus mapping to low memory.

Be very careful here - I don't think these mean quite what you think
they do.  They were introduced by Al Viro back in 2007 to work around
the mess that the devres stuff caused.

It's basically sorting out whether an architecture has support for
ioport_map(), and therefore whether devm_ioport_map() should be defined.

We, in ARM land, have several platforms where we support the standard
PC IO based stuff, but not the ioport_map stuff for one reason or
another.  Such cases tend to be that PC IO peripherals aren't connected
to an ISA bus, but directly onto the 32-bit system bus and this results
in them having a base offset plus a register spacing of 4 instead of 2.

Even more weird setups involve 8-bit IO peripherals having a spacing
of 4 between each register, but 16-bit IO peripherals having registers
at offset 0,1,2,3 at 0,1,4,5 on the bus - and games played to access
the odd address registers.  These don't support ioport mapping.

These platforms, Al's patch added a 'select NO_IOPORT' to - but this
does not mean they don't have ISA IO support.

> > which gives us the behaviour we desire.  I'd ideally like IOMEM() to
> > be in some generic header, but I don't think asm/io.h makes much sense
> > for that - neither does creating a new header just for it.  What do
> > other architectures do for accessing system device registers (excluding
> > x86 which of course uses ISA IO macros)?  I wonder if somewhere under
> > linux/ would be appropriate for it.
> 
> From what I've seen in other architectures, few others really use
> static memory space mappings, except for the legacy ISA range that
> includes the VGA memory space and the PCI/ISA IO space mapping if that
> is memory mapped. Both are normally only defined in one place though,
> since they are not board specific, so there is no need for a macro
> to abstract that.

Do no other architectures have system peripherals in MMIO space then?
I guess those which do have their system peripherals standardized
across all supported platforms?

> > There is one place in our architecture code where this goes wrong, and
> > that's the static map structures (struct map_desc) where the virtual
> > address is an unsigned long - this is because the underlying code really
> > wants it as a number and not a pointer (it wants to do stuff with page
> > tables.)  Converting this to a pointer results in casts-to-pointers
> > appearing elsewhere in the code, so you can't win on that.
> 
> I was thinking about making that an anonymous union for a transition
> time, like
> 
> struct map_desc {
>         union {
>                 unsigned long virtual;
>                 void __iomem *virt_base;
>         };
>         unsigned long pfn;
>         unsigned long length;
>         unsigned int type;
> };
> 
> Then we can do one platform at a time, moving all definitions from
> integer constants to pointer constants.
> 
> When the last use of map_desc->virtual is gone, we can remove the
> union again (that could be in the same patch series).

I think you missed my point.

map_desc->virtual really wants to be an integer type:

static void __init create_mapping(struct map_desc *md)
{
        if (md->virtual != vectors_base() && md->virtual < TASK_SIZE) {

        if ((md->type == MT_DEVICE || md->type == MT_ROM) &&
            md->virtual >= PAGE_OFFSET && md->virtual < VMALLOC_END) {

        addr = md->virtual & PAGE_MASK;
}

static void __init devicemaps_init(struct machine_desc *mdesc)
{
        map.virtual = MODULES_VADDR;
        map.virtual = FLUSH_BASE;
        map.virtual = FLUSH_BASE_MINICACHE;
        map.virtual = 0xffff0000;
                map.virtual = 0;
}

all end up needing casts.  If we make MODULES_VADDR a void __iomem pointer,
then (a) it's wrong because it's not a pointer to IOMEM, and (b):

arch/arm/mm/init.c:     BUILD_BUG_ON(TASK_SIZE                          > MODULES_VADDR);
arch/arm/mm/init.c:     BUG_ON(TASK_SIZE                                > MODULES_VADDR);

would need casts to unsigned long, as would:

        for (addr = 0; addr < MODULES_VADDR; addr += PGDIR_SIZE)
                pmd_clear(pmd_off_k(addr));

and so the game of chasing casts around the kernel will continue.

static inline void map_memory_bank(struct membank *bank)
{
        map.virtual = __phys_to_virt(bank_phys_start(bank));
}

can just become phys_to_virt() - but then sparse will complain about
differing address spaces.

There's no real answer here - whatever we do, we'll end up with casts
_somewhere_ for this structure.  As the underlying code naturally wants
it to be unsigned long, I think that's the correct type for it.

Maybe the solution is to have a macro to initialize its entries, which
contain the cast to unsigned long for 'virtual' ?
