From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 18:46:04 +0100
Subject: [PATCH 2/2] arm64: mm: use bit ops rather than arithmetic in pa/va
 translations
In-Reply-To: <1456163164-23251-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456163164-23251-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456163164-23251-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since PAGE_OFFSET is chosen such that it cuts the kernel VA space right
in half, and since the size of the kernel VA space itself is always a
power of 2, we can treat PAGE_OFFSET as a bitmask and replace the
additions/subtractions with 'or' and 'and-not' operations.

For the comparison against PAGE_OFFSET, a mov/cmp/branch sequence ends
up getting replaced with a single tbz instruction. For the additions and
subtractions, we save a mov instruction since the mask is folded into the
instruction's immediate field.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 771d0b506e4b..2296b32130a1 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -88,10 +88,10 @@
  */
 #define __virt_to_phys(x) ({						\
 	phys_addr_t __x = (phys_addr_t)(x);				\
-	__x >= PAGE_OFFSET ? (__x - PAGE_OFFSET + PHYS_OFFSET) :	\
-			     (__x - kimage_voffset); })
+	__x & BIT(VA_BITS - 1) ? (__x & ~PAGE_OFFSET) + PHYS_OFFSET :	\
+				 (__x - kimage_voffset); })
 
-#define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET + PAGE_OFFSET))
+#define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
 #define __phys_to_kimg(x)	((unsigned long)((x) + kimage_voffset))
 
 /*
@@ -131,6 +131,7 @@
 #endif
 
 #ifndef __ASSEMBLY__
+#include <linux/bitops.h>
 
 extern phys_addr_t		memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
-- 
2.5.0
