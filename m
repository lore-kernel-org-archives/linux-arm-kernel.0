From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Feb 2016 17:22:50 +0000
Subject: [RFC PATCH 10/10] arm64: mm: restrict __pa() translations to
 linear virtual addresses
In-Reply-To: <CAKv+Gu_zdt-sk_moCeF8u95DCZgcT26CDH1gL87Q4qXKA_hKrg@mail.gmail.com>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456174472-30028-11-git-send-email-ard.biesheuvel@linaro.org>
 <20160223122615.GJ3966@arm.com>
 <CAKv+Gu_zdt-sk_moCeF8u95DCZgcT26CDH1gL87Q4qXKA_hKrg@mail.gmail.com>
Message-ID: <20160223172250.GF4777@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 01:29:21PM +0100, Ard Biesheuvel wrote:
> On 23 February 2016 at 13:26, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Feb 22, 2016 at 09:54:32PM +0100, Ard Biesheuvel wrote:
> >> Now that we have replaced all occurrences of __pa() translations
> >> involving virtual addresses that are covered by the kernel text,
> >> we can redefine __virt_to_phys and __pa() etc to only take virtual
> >> address that are covered by the linear mapping. This means we can
> >> remove the comparison with PAGE_OFFSET in the definition of
> >> __virt_to_phys().
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/include/asm/memory.h | 12 +++++++-----
> >>  1 file changed, 7 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> >> index 56d6739430f3..3b5dc5b243ac 100644
> >> --- a/arch/arm64/include/asm/memory.h
> >> +++ b/arch/arm64/include/asm/memory.h
> >> @@ -86,11 +86,14 @@
> >>   * private definitions which should NOT be used outside memory.h
> >>   * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
> >>   */
> >> -#define __virt_to_phys(x) ({                                         \
> >> +#ifndef CONFIG_DEBUG_VM
> >> +#define __virt_to_phys(x)    (((phys_addr_t)(x) & ~PAGE_OFFSET) + PHYS_OFFSET)
> >> +#else
> >> +#define __virt_to_phys(x)    ({                                      \
> >>       phys_addr_t __x = (phys_addr_t)(x);                             \
> >> -     __x & BIT(VA_BITS - 1) ? (__x & ~PAGE_OFFSET) + PHYS_OFFSET :   \
> >> -                              (__x - kimage_voffset); })
> >> -
> >> +     BUG_ON(__x < PAGE_OFFSET);                                      \
> >> +     (((phys_addr_t)__x & ~PAGE_OFFSET) + PHYS_OFFSET); })
> >
> > What's the #include-hell like if you try to use VM_BUG_ON instead?
> >
> 
> The #include hell would not change I think, since
> 
> include/linux/mmdebug.h:18:#define VM_BUG_ON(cond) BUG_ON(cond)
> 
> but it would certainly make this code look a lot cleaner.

I just tried the fixup below on top of your PHYS_OFFSET patch from
yesterday and it seems to work (I can fold it in once I finish testing
more build configurations):

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index d862c62a33b8..e02bfef18552 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -132,14 +132,11 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/bitops.h>
+#include <linux/mmdebug.h>
 
 extern phys_addr_t		memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
-#ifndef CONFIG_DEBUG_VM
-#define PHYS_OFFSET		({ memstart_addr; })
-#else
-#define PHYS_OFFSET		({ BUG_ON(memstart_addr & 1); memstart_addr; })
-#endif
+#define PHYS_OFFSET		({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
 
 /* the offset between the kernel virtual and physical mappings */
 extern u64			kimage_voffset;

-- 
Catalin
