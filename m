From: robherring2@gmail.com (Rob Herring)
Date: Tue,  6 May 2014 17:58:05 -0500
Subject: [PATCH 1/3] arm: use generic fixmap.h
In-Reply-To: <1399417087-24772-1-git-send-email-robherring2@gmail.com>
References: <1399417087-24772-1-git-send-email-robherring2@gmail.com>
Message-ID: <1399417087-24772-2-git-send-email-robherring2@gmail.com>
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
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/arm/include/asm/fixmap.h | 29 ++++++++---------------------
 arch/arm/mm/init.c            |  2 +-
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index bbae919..68ea615 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -14,28 +14,15 @@
  */
 
 #define FIXADDR_START		0xfff00000UL
-#define FIXADDR_TOP		0xfffe0000UL
-#define FIXADDR_SIZE		(FIXADDR_TOP - FIXADDR_START)
+#define FIXADDR_END		0xfffe0000UL
+#define FIXADDR_TOP		(FIXADDR_END - PAGE_SIZE)
 
-#define FIX_KMAP_BEGIN		0
-#define FIX_KMAP_END		(FIXADDR_SIZE >> PAGE_SHIFT)
+enum fixed_addresses {
+	FIX_KMAP_BEGIN,
+	FIX_KMAP_END = (FIXADDR_TOP - FIXADDR_START) >> PAGE_SHIFT,
+	__end_of_fixed_addresses
+};
 
-#define __fix_to_virt(x)	(FIXADDR_START + ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	(((x) - FIXADDR_START) >> PAGE_SHIFT)
-
-extern void __this_fixmap_does_not_exist(void);
-
-static inline unsigned long fix_to_virt(const unsigned int idx)
-{
-	if (idx >= FIX_KMAP_END)
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
index 2a77ba8..91a4682 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -578,7 +578,7 @@ void __init mem_init(void)
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
