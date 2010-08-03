From: gking@nvidia.com (Gary King)
Date: Mon,  2 Aug 2010 19:42:48 -0700
Subject: [PATCH 3/4] [ARM] mm: add memory type for inner-writeback
In-Reply-To: <1280803369-13362-1-git-send-email-gking@nvidia.com>
References: <1280803369-13362-1-git-send-email-gking@nvidia.com>
Message-ID: <1280803369-13362-4-git-send-email-gking@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For streaming-style operations (e.g., software rendering of graphics
surfaces shared with non-coherent DMA devices), the cost of performing
L2 cache maintenance can exceed the benefit of having the larger cache
(this is particularly true for OUTER_CACHE configurations like the ARM
PL2x0).

This change uses the currently-unused mapping 5 (TEX[0]=1, C=0, B=1)
in the tex remapping tables as an inner-writeback-write-allocate, outer
non-cacheable memory type, so that this mapping will be available to
clients which will benefit from the reduced L2 maintenance.

Signed-off-by: Gary King <gking@nvidia.com>
---
 arch/arm/include/asm/pgtable.h |    3 +++
 arch/arm/mm/proc-macros.S      |    2 +-
 arch/arm/mm/proc-v7.S          |    4 ++--
 arch/arm/mm/proc-xsc3.S        |    2 +-
 arch/arm/mm/proc-xscale.S      |    2 +-
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index ab68cf1..4739ffe 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -184,6 +184,7 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 #define L_PTE_MT_DEV_NONSHARED	(0x0c << 2)	/* 1100 */
 #define L_PTE_MT_DEV_WC		(0x09 << 2)	/* 1001 */
 #define L_PTE_MT_DEV_CACHED	(0x0b << 2)	/* 1011 */
+#define L_PTE_MT_INNER_WB	(0x05 << 2)	/* 0101 (armv6, armv7) */
 #define L_PTE_MT_MASK		(0x0f << 2)
 
 #ifndef __ASSEMBLY__
@@ -321,6 +322,8 @@ static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 #define pgprot_dmacoherent(prot) \
 	__pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_UNCACHED)
 #endif
+#define pgprot_inner_writeback(prot) \
+	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_INNER_WB)
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define pmd_present(pmd)	(pmd_val(pmd))
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 7d63bea..6da85e3 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -107,7 +107,7 @@
 	.long	PTE_CACHEABLE					@ L_PTE_MT_WRITETHROUGH
 	.long	PTE_CACHEABLE | PTE_BUFFERABLE			@ L_PTE_MT_WRITEBACK
 	.long	PTE_BUFFERABLE					@ L_PTE_MT_DEV_SHARED
-	.long	0x00						@ unused
+	.long	PTE_EXT_TEX(4) | PTE_BUFFERABLE			@ L_PTE_MT_INNER_WB
 	.long	0x00						@ L_PTE_MT_MINICACHE (not present)
 	.long	PTE_EXT_TEX(1) | PTE_CACHEABLE | PTE_BUFFERABLE	@ L_PTE_MT_WRITEALLOC
 	.long	0x00						@ unused
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 7aaf88a..fa21329 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -270,8 +270,8 @@ __v7_setup:
 	 *   NS1 = PRRR[19] = 1		- normal shareable property
 	 *   NOS = PRRR[24+n] = 1	- not outer shareable
 	 */
-	ldr	r5, =0xff0a81a8			@ PRRR
-	ldr	r6, =0x40e040e0			@ NMRR
+	ldr	r5, =0xff0a89a8
+	ldr	r6, =0x40e044e0
 	mcr	p15, 0, r5, c10, c2, 0		@ write PRRR
 	mcr	p15, 0, r6, c10, c2, 1		@ write NMRR
 #endif
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index e5797f1..47756dc 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -377,7 +377,7 @@ cpu_xsc3_mt_table:
 	.long	PTE_EXT_TEX(5) | PTE_CACHEABLE			@ L_PTE_MT_WRITETHROUGH
 	.long	PTE_CACHEABLE | PTE_BUFFERABLE			@ L_PTE_MT_WRITEBACK
 	.long	PTE_EXT_TEX(1) | PTE_BUFFERABLE			@ L_PTE_MT_DEV_SHARED
-	.long	0x00						@ unused
+	.long	PTE_EXT_TEX(4) | PTE_BUFFERABLE			@ L_PTE_MT_INNER_WB (not present?)
 	.long	0x00						@ L_PTE_MT_MINICACHE (not present)
 	.long	PTE_EXT_TEX(5) | PTE_CACHEABLE | PTE_BUFFERABLE	@ L_PTE_MT_WRITEALLOC (not present?)
 	.long	0x00						@ unused
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 63037e2..647296b 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -473,7 +473,7 @@ cpu_xscale_mt_table:
 	.long	PTE_CACHEABLE					@ L_PTE_MT_WRITETHROUGH
 	.long	PTE_CACHEABLE | PTE_BUFFERABLE			@ L_PTE_MT_WRITEBACK
 	.long	PTE_EXT_TEX(1) | PTE_BUFFERABLE			@ L_PTE_MT_DEV_SHARED
-	.long	0x00						@ unused
+	.long	PTE_EXT_TEX(1) | PTE_CACHEABLE | PTE_BUFFERABLE	@ L_PTE_MT_INNER_WB
 	.long	PTE_EXT_TEX(1) | PTE_CACHEABLE			@ L_PTE_MT_MINICACHE
 	.long	PTE_EXT_TEX(1) | PTE_CACHEABLE | PTE_BUFFERABLE	@ L_PTE_MT_WRITEALLOC
 	.long	0x00						@ unused
-- 
1.7.0.4
