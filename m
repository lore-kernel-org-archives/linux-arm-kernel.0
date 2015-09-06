From: yalin.wang2010@gmail.com (yalin wang)
Date: Sun,  6 Sep 2015 12:04:10 +0800
Subject: [PATCH V2] arm64: add kc_offset_to_vaddr and kc_vaddr_to_offset macro
Message-ID: <1441512250-9667-1-git-send-email-yalin.wang2010@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add kc_offset_to_vaddr() and kc_vaddr_to_offset(),
the default version doesn't work on arm64, because arm64 kernel address
is below the PAGE_OFFSET, like module address and vmemmap address are
all below PAGE_OFFSET address.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 arch/arm64/include/asm/memory.h  | 1 +
 arch/arm64/include/asm/pgtable.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f800d45..2d09fe8 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -55,6 +55,7 @@
 #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
 #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
 #define TASK_SIZE_64		(UL(1) << VA_BITS)
+#define __VIRTUAL_MASK		((1UL << VA_BITS) - 1)
 
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32		UL(0x100000000)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index d374191..9da6681 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -660,6 +660,8 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 
 #define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
 
+#define	kc_vaddr_to_offset(v) ((v) & __VIRTUAL_MASK)
+#define	kc_offset_to_vaddr(o) ((o) | ~__VIRTUAL_MASK)
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
-- 
1.9.1
