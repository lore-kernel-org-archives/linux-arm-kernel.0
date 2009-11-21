From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 19:38:21 +0000
Subject: [PATCH 05/10] ARM: dma-mapping: factor dma_free_coherent() common code
In-Reply-To: <20091121193539.GG13956@n2100.arm.linux.org.uk>
References: <20091121193539.GG13956@n2100.arm.linux.org.uk>
Message-ID: <E1NBvmn-0007qo-2D@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We effectively have three implementations of dma_free_coherent() mixed up
in the code; the incoherent MMU, coherent MMU and noMMU versions.

The coherent MMU and noMMU versions are actually functionally identical.
The incoherent MMU version is almost the same, but with the additional
step of unmapping the secondary mapping.

Separate out this additional step into __dma_free_remap() and simplify
the resulting dma_free_coherent() code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/dma-mapping.c |  141 ++++++++++++++++++++++-----------------------
 1 files changed, 68 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 44be5ad..2e025f6 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -207,7 +207,70 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 	*handle = ~0;
 	return NULL;
 }
+
+static void __dma_free_remap(void *cpu_addr, size_t size)
+{
+	struct arm_vmregion *c;
+	unsigned long addr;
+	pte_t *ptep;
+	int idx;
+	u32 off;
+
+	c = arm_vmregion_find_remove(&consistent_head, (unsigned long)cpu_addr);
+	if (!c) {
+		printk(KERN_ERR "%s: trying to free invalid coherent area: %p\n",
+		       __func__, cpu_addr);
+		dump_stack();
+		return;
+	}
+
+	if ((c->vm_end - c->vm_start) != size) {
+		printk(KERN_ERR "%s: freeing wrong coherent size (%ld != %d)\n",
+		       __func__, c->vm_end - c->vm_start, size);
+		dump_stack();
+		size = c->vm_end - c->vm_start;
+	}
+
+	idx = CONSISTENT_PTE_INDEX(c->vm_start);
+	off = CONSISTENT_OFFSET(c->vm_start) & (PTRS_PER_PTE-1);
+	ptep = consistent_pte[idx] + off;
+	addr = c->vm_start;
+	do {
+		pte_t pte = ptep_get_and_clear(&init_mm, addr, ptep);
+		unsigned long pfn;
+
+		ptep++;
+		addr += PAGE_SIZE;
+		off++;
+		if (off >= PTRS_PER_PTE) {
+			off = 0;
+			ptep = consistent_pte[++idx];
+		}
+
+		if (!pte_none(pte) && pte_present(pte)) {
+			pfn = pte_pfn(pte);
+
+			if (pfn_valid(pfn)) {
+				struct page *page = pfn_to_page(pfn);
+
+				/*
+				 * x86 does not mark the pages reserved...
+				 */
+				ClearPageReserved(page);
+				continue;
+			}
+		}
+		printk(KERN_CRIT "%s: bad page in kernel page table\n",
+		       __func__);
+	} while (size -= PAGE_SIZE);
+
+	flush_tlb_kernel_range(c->vm_start, c->vm_end);
+
+	arm_vmregion_free(&consistent_head, c);
+}
+
 #else	/* !CONFIG_MMU */
+
 static void *
 __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 	    pgprot_t prot)
@@ -224,6 +287,9 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 	*handle = page_to_dma(dev, page);
 	return page_address(page);
 }
+
+#define __dma_free_remap(addr, size)	do { } while (0)
+
 #endif	/* CONFIG_MMU */
 
 /*
@@ -317,15 +383,8 @@ EXPORT_SYMBOL(dma_mmap_writecombine);
  * free a page as defined by the above mapping.
  * Must not be called with IRQs disabled.
  */
-#ifdef CONFIG_MMU
 void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr_t handle)
 {
-	struct arm_vmregion *c;
-	unsigned long addr;
-	pte_t *ptep;
-	int idx;
-	u32 off;
-
 	WARN_ON(irqs_disabled());
 
 	if (dma_release_from_coherent(dev, get_order(size), cpu_addr))
@@ -333,75 +392,11 @@ void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr
 
 	size = PAGE_ALIGN(size);
 
-	if (arch_is_coherent()) {
-		__dma_free_buffer(dma_to_page(dev, handle), size);
-		return;
-	}
-
-	c = arm_vmregion_find_remove(&consistent_head, (unsigned long)cpu_addr);
-	if (!c)
-		goto no_area;
-
-	if ((c->vm_end - c->vm_start) != size) {
-		printk(KERN_ERR "%s: freeing wrong coherent size (%ld != %d)\n",
-		       __func__, c->vm_end - c->vm_start, size);
-		dump_stack();
-		size = c->vm_end - c->vm_start;
-	}
-
-	idx = CONSISTENT_PTE_INDEX(c->vm_start);
-	off = CONSISTENT_OFFSET(c->vm_start) & (PTRS_PER_PTE-1);
-	ptep = consistent_pte[idx] + off;
-	addr = c->vm_start;
-	do {
-		pte_t pte = ptep_get_and_clear(&init_mm, addr, ptep);
-		unsigned long pfn;
-
-		ptep++;
-		addr += PAGE_SIZE;
-		off++;
-		if (off >= PTRS_PER_PTE) {
-			off = 0;
-			ptep = consistent_pte[++idx];
-		}
-
-		if (!pte_none(pte) && pte_present(pte)) {
-			pfn = pte_pfn(pte);
-
-			if (pfn_valid(pfn)) {
-				struct page *page = pfn_to_page(pfn);
-
-				/*
-				 * x86 does not mark the pages reserved...
-				 */
-				ClearPageReserved(page);
-				continue;
-			}
-		}
-		printk(KERN_CRIT "%s: bad page in kernel page table\n",
-		       __func__);
-	} while (size -= PAGE_SIZE);
-
-	flush_tlb_kernel_range(c->vm_start, c->vm_end);
-
-	arm_vmregion_free(&consistent_head, c);
+	if (!arch_is_coherent())
+		__dma_free_remap(cpu_addr, size);
 
 	__dma_free_buffer(dma_to_page(dev, handle), size);
-	return;
-
- no_area:
-	printk(KERN_ERR "%s: trying to free invalid coherent area: %p\n",
-	       __func__, cpu_addr);
-	dump_stack();
 }
-#else	/* !CONFIG_MMU */
-void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr_t handle)
-{
-	if (dma_release_from_coherent(dev, get_order(size), cpu_addr))
-		return;
-	__dma_free_buffer(dma_to_page(dev, handle), PAGE_ALIGN(size));
-}
-#endif	/* CONFIG_MMU */
 EXPORT_SYMBOL(dma_free_coherent);
 
 /*
-- 
1.6.2.5
