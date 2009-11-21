From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 19:39:22 +0000
Subject: [PATCH 10/10] ARM: dma-mapping: switch ARMv7 DMA mappings to retain
	'memory' attribute
In-Reply-To: <20091121193539.GG13956@n2100.arm.linux.org.uk>
References: <20091121193539.GG13956@n2100.arm.linux.org.uk>
Message-ID: <E1NBvnm-0007rA-7T@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARMv7, it is invalid to map the same physical address multiple times
with different memory types.  Since system RAM is already mapped as
'memory', subsequent remapping of it must retain this attribute.

However, DMA memory maps it as "strongly ordered".  Fix this by introducing
'pgprot_dmacoherent()' which provides the necessary page table bits for
DMA mappings.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/pgtable.h |   14 ++++++++++++--
 arch/arm/include/asm/system.h  |   19 ++++++++++++-------
 arch/arm/mm/dma-mapping.c      |    4 ++--
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 201ccaa..1139768 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -304,13 +304,23 @@ PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
 
 static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
+#define __pgprot_modify(prot,mask,bits)		\
+	__pgprot((pgprot_val(prot) & ~(mask)) | (bits))
+
 /*
  * Mark the prot value as uncacheable and unbufferable.
  */
 #define pgprot_noncached(prot) \
-	__pgprot((pgprot_val(prot) & ~L_PTE_MT_MASK) | L_PTE_MT_UNCACHED)
+	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_UNCACHED)
 #define pgprot_writecombine(prot) \
-	__pgprot((pgprot_val(prot) & ~L_PTE_MT_MASK) | L_PTE_MT_BUFFERABLE)
+	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE)
+#if __LINUX_ARM_ARCH__ >= 7
+#define pgprot_dmacoherent(prot) \
+	__pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_BUFFERABLE)
+#else
+#define pgprot_dmacoherent(prot) \
+	__pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_UNCACHED)
+#endif
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define pmd_present(pmd)	(pmd_val(pmd))
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index d65b2f5..058e7e9 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -138,21 +138,26 @@ extern unsigned int user_debug;
 #define dmb() __asm__ __volatile__ ("" : : : "memory")
 #endif
 
-#ifndef CONFIG_SMP
+#if __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
+#define mb()		dmb()
+#define rmb()		dmb()
+#define wmb()		dmb()
+#else
 #define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
 #define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
 #define wmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
+#endif
+
+#ifndef CONFIG_SMP
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
 #else
-#define mb()		dmb()
-#define rmb()		dmb()
-#define wmb()		dmb()
-#define smp_mb()	dmb()
-#define smp_rmb()	dmb()
-#define smp_wmb()	dmb()
+#define smp_mb()	mb()
+#define smp_rmb()	rmb()
+#define smp_wmb()	wmb()
 #endif
+
 #define read_barrier_depends()		do { } while(0)
 #define smp_read_barrier_depends()	do { } while(0)
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 9807035..7c1d2c7 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -318,7 +318,7 @@ dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gf
 		return memory;
 
 	return __dma_alloc(dev, size, handle, gfp,
-			   pgprot_noncached(pgprot_kernel));
+			   pgprot_dmacoherent(pgprot_kernel));
 }
 EXPORT_SYMBOL(dma_alloc_coherent);
 
@@ -366,7 +366,7 @@ static int dma_mmap(struct device *dev, struct vm_area_struct *vma,
 int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 		      void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_page_prot = pgprot_dmacoherent(vma->vm_page_prot);
 	return dma_mmap(dev, vma, cpu_addr, dma_addr, size);
 }
 EXPORT_SYMBOL(dma_mmap_coherent);
-- 
1.6.2.5
