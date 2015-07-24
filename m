From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Jul 2015 10:56:18 +0100
Subject: [RFC] arm64:use set_fixmap_offset to make it more clear
In-Reply-To: <9E910A45-D4AB-44F6-878F-3CB2372B3660@gmail.com>
References: <A5D61263-B664-469F-9F49-160D6E17F432@gmail.com>
 <20150723130344.GC27052@e104818-lin.cambridge.arm.com>
 <9E910A45-D4AB-44F6-878F-3CB2372B3660@gmail.com>
Message-ID: <20150724095618.GB23074@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 04:56:59AM +0100, yalin wang wrote:
> 
> > On Jul 23, 2015, at 21:03, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > On Thu, Jul 23, 2015 at 07:45:53PM +0800, yalin wang wrote:
> >> A little change to patch_map() function,
> >> use set_fixmap_offset() to make code more clear.
> >> 
> >> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> >> ---
> >> arch/arm64/kernel/insn.c | 5 ++---
> >> 1 file changed, 2 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> >> index dd9671c..7dafd5a 100644
> >> --- a/arch/arm64/kernel/insn.c
> >> +++ b/arch/arm64/kernel/insn.c
> >> @@ -101,9 +101,8 @@ static void __kprobes *patch_map(void *addr, int fixmap)
> >> 		return addr;
> >> 
> >> 	BUG_ON(!page);
> >> -	set_fixmap(fixmap, page_to_phys(page));
> >> -
> >> -	return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
> >> +	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
> >> +			(addr & ~PAGE_MASK));
> > 
> > It looks fine. Do you get any compiler warning for the automatic pointer
> > to long conversion? You may want to add some explicit casts, otherwise:
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> i have build it, there is no warning about this change. :)

I see no warnings with defconfig, but there's an (unrelated) set of warnings if
CONFIG_DEBUG_SET_MODULE_RONX or CONFIG_DEBUG_RODATA are enabled:

----
In file included from ./arch/arm64/include/asm/fixmap.h:85:0,
                 from arch/arm64/kernel/insn.c:32:
arch/arm64/kernel/insn.c: In function ?__aarch64_insn_write?:
include/asm-generic/fixmap.h:73:2: warning: ?addr? may be used uninitialized in this function [-Wmaybe-uninitialized]
  __set_fixmap(idx, phys, flags);         \
  ^
include/asm-generic/fixmap.h:72:16: note: ?addr? was declared here
  unsigned long addr;          \
                ^
include/asm-generic/fixmap.h:79:2: note: in expansion of macro ?__set_fixmap_offset?
  __set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
  ^
arch/arm64/kernel/insn.c:104:17: note: in expansion of macro ?set_fixmap_offset?
  return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
                 ^
----

That seems to be due to the definition of __set_fixmap_offset in
asm-generic/fixmap.h:

/* Return a pointer with offset calculated */
#define __set_fixmap_offset(idx, phys, flags)		      \
({							      \
	unsigned long addr;				      \
	__set_fixmap(idx, phys, flags);			      \
	addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1)); \
	addr;						      \
})

Where that new addr variable shadows patch_map's addr argument when the call to
__set_fixmap is expanded.

Which means that this patch currently breaks CONFIG_DEBUG_SET_MODULE_RONX and
CONFIG_DEBUG_RODATA.

Thanks,
Mark.
