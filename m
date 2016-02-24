From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Feb 2016 17:21:33 +0100
Subject: [RFC PATCH 6/6] arm64: mm: disregard PHYS_OFFSET in virt_to_page()
In-Reply-To: <1456330893-19228-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456330893-19228-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456330893-19228-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mm layer makes heavy use of virt_to_page(), which translates from
virtual addresses to offsets in the struct page array using an intermediate
translation to physical addresses. However, these physical translations
are based on the actual placement of physical memory, which can only be
discovered at runtime. This means virt_to_page() translations involve a
global PHYS_OFFSET variable, and hence a memory access.
    
Now that the vmemmap region has been redefined to cover the linear region
rather than the entire physical address space, we no longer need to perform
a virtual-to-physical translation in the implementation of virt_to_page(),
which means we can get rid of the memory access.

This restricts virt_to_page() translations to the linear region, so
redefine virt_addr_valid() as well.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index eb798156cf56..9d4b7733caa3 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -189,8 +189,15 @@ static inline void *phys_to_virt(phys_addr_t x)
  */
 #define ARCH_PFN_OFFSET		((unsigned long)PHYS_PFN_OFFSET)
 
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-#define	virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
+#else
+#define virt_to_page(kaddr)	((struct page *)VMEMMAP_START + \
+				 (((u64)(kaddr) & ~PAGE_OFFSET) >> PAGE_SHIFT))
+#define virt_addr_valid(kaddr)	pfn_valid((((u64)(kaddr) & ~PAGE_OFFSET) \
+					   + PHYS_OFFSET) >> PAGE_SHIFT)
+#endif
 
 #endif
 
-- 
2.5.0
