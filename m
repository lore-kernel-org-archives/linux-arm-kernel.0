From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 10 Apr 2012 13:04:04 +0200
Subject: [PATCHv8 02/10] ARM: dma-mapping: use pr_* instread of printk
In-Reply-To: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1334055852-19500-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace all calls to printk with pr_* functions family.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mm/dma-mapping.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index db23ae4..366f3a2 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -184,14 +184,14 @@ static int __init consistent_init(void)
 
 		pud = pud_alloc(&init_mm, pgd, base);
 		if (!pud) {
-			printk(KERN_ERR "%s: no pud tables\n", __func__);
+			pr_err("%s: no pud tables\n", __func__);
 			ret = -ENOMEM;
 			break;
 		}
 
 		pmd = pmd_alloc(&init_mm, pud, base);
 		if (!pmd) {
-			printk(KERN_ERR "%s: no pmd tables\n", __func__);
+			pr_err("%s: no pmd tables\n", __func__);
 			ret = -ENOMEM;
 			break;
 		}
@@ -199,7 +199,7 @@ static int __init consistent_init(void)
 
 		pte = pte_alloc_kernel(pmd, base);
 		if (!pte) {
-			printk(KERN_ERR "%s: no pte tables\n", __func__);
+			pr_err("%s: no pte tables\n", __func__);
 			ret = -ENOMEM;
 			break;
 		}
@@ -222,7 +222,7 @@ __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot,
 	int bit;
 
 	if (!consistent_pte) {
-		printk(KERN_ERR "%s: not initialised\n", __func__);
+		pr_err("%s: not initialised\n", __func__);
 		dump_stack();
 		return NULL;
 	}
@@ -281,14 +281,14 @@ static void __dma_free_remap(void *cpu_addr, size_t size)
 
 	c = arm_vmregion_find_remove(&consistent_head, (unsigned long)cpu_addr);
 	if (!c) {
-		printk(KERN_ERR "%s: trying to free invalid coherent area: %p\n",
+		pr_err("%s: trying to free invalid coherent area: %p\n",
 		       __func__, cpu_addr);
 		dump_stack();
 		return;
 	}
 
 	if ((c->vm_end - c->vm_start) != size) {
-		printk(KERN_ERR "%s: freeing wrong coherent size (%ld != %d)\n",
+		pr_err("%s: freeing wrong coherent size (%ld != %d)\n",
 		       __func__, c->vm_end - c->vm_start, size);
 		dump_stack();
 		size = c->vm_end - c->vm_start;
@@ -310,8 +310,8 @@ static void __dma_free_remap(void *cpu_addr, size_t size)
 		}
 
 		if (pte_none(pte) || !pte_present(pte))
-			printk(KERN_CRIT "%s: bad page in kernel page table\n",
-			       __func__);
+			pr_crit("%s: bad page in kernel page table\n",
+				__func__);
 	} while (size -= PAGE_SIZE);
 
 	flush_tlb_kernel_range(c->vm_start, c->vm_end);
-- 
1.7.1.569.g6f426
