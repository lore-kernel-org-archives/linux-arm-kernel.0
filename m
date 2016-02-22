From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 21:54:32 +0100
Subject: [RFC PATCH 10/10] arm64: mm: restrict __pa() translations to linear
 virtual addresses
In-Reply-To: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456174472-30028-11-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have replaced all occurrences of __pa() translations
involving virtual addresses that are covered by the kernel text,
we can redefine __virt_to_phys and __pa() etc to only take virtual
address that are covered by the linear mapping. This means we can
remove the comparison with PAGE_OFFSET in the definition of
__virt_to_phys().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 56d6739430f3..3b5dc5b243ac 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -86,11 +86,14 @@
  * private definitions which should NOT be used outside memory.h
  * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
  */
-#define __virt_to_phys(x) ({						\
+#ifndef CONFIG_DEBUG_VM
+#define __virt_to_phys(x)	(((phys_addr_t)(x) & ~PAGE_OFFSET) + PHYS_OFFSET)
+#else
+#define __virt_to_phys(x)	({					\
 	phys_addr_t __x = (phys_addr_t)(x);				\
-	__x & BIT(VA_BITS - 1) ? (__x & ~PAGE_OFFSET) + PHYS_OFFSET :	\
-				 (__x - kimage_voffset); })
-
+	BUG_ON(__x < PAGE_OFFSET);					\
+	(((phys_addr_t)__x & ~PAGE_OFFSET) + PHYS_OFFSET); })
+#endif
 #define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
 
 #define __kimg_to_phys(x)	((phys_addr_t)(x) - kimage_voffset)
@@ -134,7 +137,6 @@
 #endif
 
 #ifndef __ASSEMBLY__
-#include <linux/bitops.h>
 
 extern phys_addr_t		memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
-- 
2.5.0
