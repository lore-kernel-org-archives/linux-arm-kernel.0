From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Fri, 20 Nov 2009 12:29:11 -0800
Subject: [PATCH 2/2] dma: change coherent memory to normal noncached
In-Reply-To: <1258748951-10548-1-git-send-email-adharmap@codeaurora.org>
References: <1258748951-10548-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <1258748951-10548-2-git-send-email-adharmap@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need dma_alloc_coherent() to use its own page protection modifier,
which causes it to behave the same as dma_alloc_writecombine() on ARMv7,
and with the existing behaviour (for the time being) on ARMv6 and below.
We should leave pgprot_noncached() well alone until we know that its
other places need to be changed.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
---
 arch/arm/include/asm/pgtable.h |   15 +++++++++++++--
 arch/arm/mm/dma-mapping.c      |    4 ++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index a27ec4c..0fd8d83 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -307,16 +307,27 @@ PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
 
 static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
+#define __pgprot_modify(prot, mask, bits)                \
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
 #define pgprot_device(prot) \
 	__pgprot((pgprot_val(prot) & ~L_PTE_MT_MASK) | L_PTE_MT_DEV_NONSHARED)
 
+#if __LINUX_ARM_ARCH__ >= 7
+#define pgprot_dmacoherent(prot) \
+	__pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_BUFFERABLE)
+#else
+#define pgprot_dmacoherent(prot) \
+	__pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_UNCACHED)
+#endif
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define pmd_present(pmd)	(pmd_val(pmd))
 #define pmd_bad(pmd)		(pmd_val(pmd) & 2)
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 0b38ec8..8e2ff87 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -291,7 +291,7 @@ dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gf
 	}
 
 	return __dma_alloc(dev, size, handle, gfp,
-			   pgprot_noncached(pgprot_kernel));
+			   pgprot_dmacoherent(pgprot_kernel));
 }
 EXPORT_SYMBOL(dma_alloc_coherent);
 
@@ -340,7 +340,7 @@ static int dma_mmap(struct device *dev, struct vm_area_struct *vma,
 int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 		      void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_page_prot = pgprot_dmacoherent(vma->vm_page_prot);
 	return dma_mmap(dev, vma, cpu_addr, dma_addr, size);
 }
 EXPORT_SYMBOL(dma_mmap_coherent);
-- 
1.5.6.3
