From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Jul 2015 11:07:24 +0100
Subject: [RFC] arm64:use set_fixmap_offset to make it more clear
In-Reply-To: <20150724095618.GB23074@leverpostej>
References: <A5D61263-B664-469F-9F49-160D6E17F432@gmail.com>
 <20150723130344.GC27052@e104818-lin.cambridge.arm.com>
 <9E910A45-D4AB-44F6-878F-3CB2372B3660@gmail.com>
 <20150724095618.GB23074@leverpostej>
Message-ID: <20150724100724.GA4348@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 10:56:18AM +0100, Mark Rutland wrote:
> On Fri, Jul 24, 2015 at 04:56:59AM +0100, yalin wang wrote:
> > 
> > > On Jul 23, 2015, at 21:03, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > 
> > > On Thu, Jul 23, 2015 at 07:45:53PM +0800, yalin wang wrote:
> > >> A little change to patch_map() function,
> > >> use set_fixmap_offset() to make code more clear.
> > >> 
> > >> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> > >> ---
> > >> arch/arm64/kernel/insn.c | 5 ++---
> > >> 1 file changed, 2 insertions(+), 3 deletions(-)
> > >> 
> > >> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> > >> index dd9671c..7dafd5a 100644
> > >> --- a/arch/arm64/kernel/insn.c
> > >> +++ b/arch/arm64/kernel/insn.c
> > >> @@ -101,9 +101,8 @@ static void __kprobes *patch_map(void *addr, int fixmap)
> > >> 		return addr;
> > >> 
> > >> 	BUG_ON(!page);
> > >> -	set_fixmap(fixmap, page_to_phys(page));
> > >> -
> > >> -	return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
> > >> +	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
> > >> +			(addr & ~PAGE_MASK));
> > > 
> > > It looks fine. Do you get any compiler warning for the automatic pointer
> > > to long conversion? You may want to add some explicit casts, otherwise:
> > > 
> > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > i have build it, there is no warning about this change. :)
> 
> I see no warnings with defconfig, but there's an (unrelated) set of warnings if
> CONFIG_DEBUG_SET_MODULE_RONX or CONFIG_DEBUG_RODATA are enabled:

Actually they aren't unrelated after all. the unsigned long addr in
__set_fixmap_offset shadows the void* addr from patch_map making the
types match.

With a few underscores addrd to __set_fixmap_offset's addr, I get the
following regarding patch_map:

----
In file included from ./arch/arm64/include/asm/fixmap.h:85:0,
                 from arch/arm64/kernel/insn.c:32:
arch/arm64/kernel/insn.c: In function ?patch_map?:
arch/arm64/kernel/insn.c:105:10: error: invalid operands to binary & (have ?void *? and ?long unsigned int?)
    (addr & ~PAGE_MASK));
          ^
include/asm-generic/fixmap.h:73:20: note: in definition of macro ?__set_fixmap_offset?
  __set_fixmap(idx, phys, flags);         \
                    ^
arch/arm64/kernel/insn.c:104:17: note: in expansion of macro ?set_fixmap_offset?
  return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
                 ^
arch/arm64/kernel/insn.c:105:10: error: invalid operands to binary & (have ?void *? and ?long unsigned int?)
    (addr & ~PAGE_MASK));
          ^
include/asm-generic/fixmap.h:74:32: note: in definition of macro ?__set_fixmap_offset?
  __addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1)); \
                                ^
arch/arm64/kernel/insn.c:104:17: note: in expansion of macro ?set_fixmap_offset?
  return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
                 ^
make[1]: *** [arch/arm64/kernel/insn.o] Error 1
make: *** [arch/arm64/kernel/insn.o] Error 2
----

we need both the cast in patch_map, and an update to __set_fixmap_offset to
prevent the name clash.

Thanks,
Mark.
