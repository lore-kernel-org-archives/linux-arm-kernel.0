From: keescook@chromium.org (Kees Cook)
Date: Wed,  3 Sep 2014 14:57:02 -0700
Subject: [PATCH v5 1/8] arm: use generic fixmap.h
In-Reply-To: <1409781429-27593-1-git-send-email-keescook@chromium.org>
References: <1409781429-27593-1-git-send-email-keescook@chromium.org>
Message-ID: <1409781429-27593-2-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Salter <msalter@redhat.com>

ARM is different from other architectures in that fixmap pages are indexed
with a positive offset from FIXADDR_START.  Other architectures index with
a negative offset from FIXADDR_TOP.  In order to use the generic fixmap.h
definitions, this patch redefines FIXADDR_TOP to be inclusive of the
useable range.  That is, FIXADDR_TOP is the virtual address of the topmost
fixed page.  The newly defined FIXADDR_END is the first virtual address
past the fixed mappings.

Signed-off-by: Mark Salter <msalter@redhat.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
[kees: update for a05e54c103b0 ("ARM: 8031/2: change fixmap ...")]
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Rob Herring <robh@kernel.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/fixmap.h | 27 +++++++++------------------
 arch/arm/mm/init.c            |  2 +-
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index 74124b0d0d79..a7add6f9315d 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -2,27 +2,18 @@
 #define _ASM_FIXMAP_H
 
 #define FIXADDR_START		0xffc00000UL
-#define FIXADDR_TOP		0xffe00000UL
-#define FIXADDR_SIZE		(FIXADDR_TOP - FIXADDR_START)
+#define FIXADDR_END		0xffe00000UL
+#define FIXADDR_TOP		(FIXADDR_END - PAGE_SIZE)
 
-#define FIX_KMAP_NR_PTES	(FIXADDR_SIZE >> PAGE_SHIFT)
+#include <asm/kmap_types.h>
 
-#define __fix_to_virt(x)	(FIXADDR_START + ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	(((x) - FIXADDR_START) >> PAGE_SHIFT)
+enum fixed_addresses {
+	FIX_KMAP_BEGIN,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
 
-extern void __this_fixmap_does_not_exist(void);
+	__end_of_fixed_addresses
+};
 
-static inline unsigned long fix_to_virt(const unsigned int idx)
-{
-	if (idx >= FIX_KMAP_NR_PTES)
-		__this_fixmap_does_not_exist();
-	return __fix_to_virt(idx);
-}
-
-static inline unsigned int virt_to_fix(const unsigned long vaddr)
-{
-	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
-	return __virt_to_fix(vaddr);
-}
+#include <asm-generic/fixmap.h>
 
 #endif
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 659c75d808dc..ad82c05bfc3a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -570,7 +570,7 @@ void __init mem_init(void)
 			MLK(DTCM_OFFSET, (unsigned long) dtcm_end),
 			MLK(ITCM_OFFSET, (unsigned long) itcm_end),
 #endif
-			MLK(FIXADDR_START, FIXADDR_TOP),
+			MLK(FIXADDR_START, FIXADDR_END),
 			MLM(VMALLOC_START, VMALLOC_END),
 			MLM(PAGE_OFFSET, (unsigned long)high_memory),
 #ifdef CONFIG_HIGHMEM
-- 
1.9.1
