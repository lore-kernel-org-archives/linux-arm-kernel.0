From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 May 2014 17:35:01 +0200
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400600105-3013-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the default cache policy for ARMv6+ platform is writeback
in UP mode and write allocate in SMP mode.

Some platforms that provide hardware I/O coherency capabilities (such
as Marvell Armada 370/XP/375/38x) require the cache policy to be write
allocate even in UP mode. This is especially true on Armada 370, which
is a single core processor, so even with CONFIG_SMP=y, is_smp()
returns false and the cache policy remains defined to writeback.

As suggested by Catalin Marinas and Rob Herring, there is in fact no
good reason to keep using writeback by default on ARMv6+, and we could
switch to write allocate by default for all ARMv6+ platforms instead
of special-casing the Marvell platforms.

This patch implements this switch to use write allocate by default on
ARMv6+ platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mm/mmu.c            | 10 +++++-----
 arch/arm/mm/proc-v6.S        |  2 +-
 arch/arm/mm/proc-v7-2level.S |  6 +++---
 arch/arm/mm/proc-v7-3level.S |  6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b68c6b2..5e7ab39 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -57,7 +57,7 @@ pmd_t *top_pmd;
 #define CPOLICY_WRITEBACK	3
 #define CPOLICY_WRITEALLOC	4
 
-static unsigned int cachepolicy __initdata = CPOLICY_WRITEBACK;
+static unsigned int cachepolicy __initdata = CPOLICY_WRITEALLOC;
 static unsigned int ecc_mask __initdata = 0;
 pgprot_t pgprot_user;
 pgprot_t pgprot_kernel;
@@ -147,8 +147,8 @@ static int __init early_cachepolicy(char *p)
 	 * page tables.
 	 */
 	if (cpu_architecture() >= CPU_ARCH_ARMv6) {
-		printk(KERN_WARNING "Only cachepolicy=writeback supported on ARMv6 and later\n");
-		cachepolicy = CPOLICY_WRITEBACK;
+		printk(KERN_WARNING "Only cachepolicy={writeback,writealloc} supported on ARMv6 and later\n");
+		cachepolicy = CPOLICY_WRITEALLOC;
 	}
 	flush_cache_all();
 	set_cr(cr_alignment);
@@ -408,14 +408,14 @@ static void __init build_mem_type_table(void)
 		if (cachepolicy > CPOLICY_WRITETHROUGH)
 			cachepolicy = CPOLICY_WRITETHROUGH;
 #endif
+		if (cachepolicy > CPOLICY_WRITEBACK)
+			cachepolicy = CPOLICY_WRITEBACK;
 	}
 	if (cpu_arch < CPU_ARCH_ARMv5) {
 		if (cachepolicy >= CPOLICY_WRITEALLOC)
 			cachepolicy = CPOLICY_WRITEBACK;
 		ecc_mask = 0;
 	}
-	if (is_smp())
-		cachepolicy = CPOLICY_WRITEALLOC;
 
 	/*
 	 * Strip out features not present on earlier architectures.
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 32b3558..950d4c2 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -31,7 +31,7 @@
 #define TTB_RGN_WB	(3 << 3)
 
 #define TTB_FLAGS_UP	TTB_RGN_WBWA
-#define PMD_FLAGS_UP	PMD_SECT_WB
+#define PMD_FLAGS_UP	PMD_SECT_WBWA
 #define TTB_FLAGS_SMP	TTB_RGN_WBWA|TTB_S
 #define PMD_FLAGS_SMP	PMD_SECT_WBWA|PMD_SECT_S
 
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index 1f52915..1032e00 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -19,9 +19,9 @@
 #define TTB_IRGN_WT	((1 << 0) | (0 << 6))
 #define TTB_IRGN_WB	((1 << 0) | (1 << 6))
 
-/* PTWs cacheable, inner WB not shareable, outer WB not shareable */
-#define TTB_FLAGS_UP	TTB_IRGN_WB|TTB_RGN_OC_WB
-#define PMD_FLAGS_UP	PMD_SECT_WB
+/* PTWs cacheable, inner WBWA not shareable, outer WBWA not shareable */
+#define TTB_FLAGS_UP	TTB_IRGN_WBWA|TTB_RGN_OC_WBWA
+#define PMD_FLAGS_UP	PMD_SECT_WBWA
 
 /* PTWs cacheable, inner WBWA shareable, outer WBWA not shareable */
 #define TTB_FLAGS_SMP	TTB_IRGN_WBWA|TTB_S|TTB_NOS|TTB_RGN_OC_WBWA
diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 01a719e..e3cb8f7 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -31,9 +31,9 @@
 #define TTB_S		(3 << 12)
 #define TTB_EAE		(1 << 31)
 
-/* PTWs cacheable, inner WB not shareable, outer WB not shareable */
-#define TTB_FLAGS_UP	(TTB_IRGN_WB|TTB_RGN_OC_WB)
-#define PMD_FLAGS_UP	(PMD_SECT_WB)
+/* PTWs cacheable, inner WBWA not shareable, outer WBWA not shareable */
+#define TTB_FLAGS_UP	(TTB_IRGN_WBWA|TTB_RGN_OC_WBWA)
+#define PMD_FLAGS_UP	(PMD_SECT_WBWA)
 
 /* PTWs cacheable, inner WBWA shareable, outer WBWA not shareable */
 #define TTB_FLAGS_SMP	(TTB_IRGN_WBWA|TTB_S|TTB_RGN_OC_WBWA)
-- 
1.9.3
