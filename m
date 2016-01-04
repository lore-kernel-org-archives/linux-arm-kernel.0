From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  4 Jan 2016 17:56:34 +0000
Subject: [PATCHv2 01/18] asm-generic: make __set_fixmap_offset a static inline
In-Reply-To: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1451930211-22460-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently __set_fixmap_offset is a macro function which has a local
variable called 'addr'. If a caller passes a 'phys' parameter which is
derived from a variable also called 'addr', the local variable will
shadow this, and the compiler will complain about the use of an
uninitialized variable.

It is likely that fixmap users may use the name 'addr' for variables
that may be directly passed to __set_fixmap_offset, or that may be
indirectly generated via other macros. Rather than placing the burden on
callers to avoid the name 'addr', this patch changes __set_fixmap_offset
into a static inline function, avoiding namespace collisions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/fixmap.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 1cbb833..f9c27b6 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -70,13 +70,13 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 #endif
 
 /* Return a pointer with offset calculated */
-#define __set_fixmap_offset(idx, phys, flags)		      \
-({							      \
-	unsigned long addr;				      \
-	__set_fixmap(idx, phys, flags);			      \
-	addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1)); \
-	addr;						      \
-})
+static inline unsigned long __set_fixmap_offset(enum fixed_addresses idx,
+						phys_addr_t phys,
+						pgprot_t flags)
+{
+	__set_fixmap(idx, phys, flags);
+	return fix_to_virt(idx) + (phys & (PAGE_SIZE - 1));
+}
 
 #define set_fixmap_offset(idx, phys) \
 	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
-- 
1.9.1
