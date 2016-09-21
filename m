From: labbott@redhat.com (Laura Abbott)
Date: Wed, 21 Sep 2016 10:28:48 -0700
Subject: [PATCH] arm64: Correctly bounds check virt_addr_valid
Message-ID: <1474478928-25022-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

virt_addr_valid is supposed to return true if and only if virt_to_page
returns a valid page structure. The current macro does math on whatever
address is given and passes that to pfn_valid to verify. vmalloc and
module addresses can happen to generate a pfn that 'happens' to be
valid. Fix this by only performing the pfn_valid check on addresses that
have the potential to be valid.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
This caused a bug at least twice in hardened usercopy so it is an
actual problem. A further TODO is full DEBUG_VIRTUAL support to
catch these types of mistakes.
---
 arch/arm64/include/asm/memory.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 31b7322..f741e19 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -214,7 +214,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_addr_valid(kaddr)	(((u64)kaddr) >= PAGE_OFFSET && pfn_valid(__pa(kaddr) >> PAGE_SHIFT))
 #else
 #define __virt_to_pgoff(kaddr)	(((u64)(kaddr) & ~PAGE_OFFSET) / PAGE_SIZE * sizeof(struct page))
 #define __page_to_voff(kaddr)	(((u64)(page) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
@@ -222,8 +222,8 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define page_to_virt(page)	((void *)((__page_to_voff(page)) | PAGE_OFFSET))
 #define virt_to_page(vaddr)	((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))
 
-#define virt_addr_valid(kaddr)	pfn_valid((((u64)(kaddr) & ~PAGE_OFFSET) \
-					   + PHYS_OFFSET) >> PAGE_SHIFT)
+#define virt_addr_valid(kaddr)	(((u64)kaddr) >= PAGE_OFFSET && pfn_valid((((u64)(kaddr) & ~PAGE_OFFSET) \
+					   + PHYS_OFFSET) >> PAGE_SHIFT))
 #endif
 #endif
 
-- 
2.7.4
