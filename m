From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 29 Feb 2016 15:44:41 +0100
Subject: [PATCH v2 6/9] arm64: mm: restrict virt_to_page() to the linear
 mapping
In-Reply-To: <1456757084-1078-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456757084-1078-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456757084-1078-7-git-send-email-ard.biesheuvel@linaro.org>
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
which means we can get rid of the memory access. Since VMEMMAP_START is
guaranteed to be aligned to a power-of-two upper bound of the size of the
vmemmap region, we can also treat VMEMMAP_START as a mask rather than an
offset.

This restricts virt_to_page() translations to the linear region, so
redefine virt_addr_valid() as well.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 8a2ab195ca77..f412f502ccdd 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -208,9 +208,19 @@ static inline void *phys_to_virt(phys_addr_t x)
  */
 #define ARCH_PFN_OFFSET		((unsigned long)PHYS_PFN_OFFSET)
 
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-#define	virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
+#else
+#define __virt_to_pgoff(kaddr)	(((u64)(kaddr) & ~PAGE_OFFSET) / PAGE_SIZE * sizeof(struct page))
+#define __page_to_voff(kaddr)	(((u64)(page) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
+
+#define page_to_virt(page)	((void *)((__page_to_voff(page)) | PAGE_OFFSET))
+#define virt_to_page(vaddr)	((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))
 
+#define virt_addr_valid(kaddr)	pfn_valid((((u64)(kaddr) & ~PAGE_OFFSET) \
+					   + PHYS_OFFSET) >> PAGE_SHIFT)
+#endif
 #endif
 
 #include <asm-generic/memory_model.h>
-- 
2.5.0
