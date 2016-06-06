From: wmills@ti.com (Bill Mills)
Date: Sun, 5 Jun 2016 23:20:27 -0400
Subject: [RFC v2 2/4] ARM: mm: Add LPAE support for outer shared
In-Reply-To: <1465183229-24147-1-git-send-email-wmills@ti.com>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
Message-ID: <1465183229-24147-3-git-send-email-wmills@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support early init selection of inner or outer shared page table
attributes.

In LPAE shared is 3 valued: non-shared, inner-shared, and outer-shared.
Provide a mask and both shared values.  Shared value in use is stored in
variables.  The old constants are eliminated to avoid accidental use.

Early page tables and variables are initialized to inner shared.

If a platform needs outer shared, it calls use_outer_shared()
during early_paging_init.  The variables and early page table are
fixed up. The mem_types built during paging_init are fixed to match
the value in effect.

No functional change for non-LPAE.  We only add a few extra aliases for
existing constants and use some extra vars at boot.

This patch is based in part on an earlier RFC patch by
    Tero Kristo <t-kristo@ti.com>

Signed-off-by: Bill Mills <wmills@ti.com>
---
 arch/arm/include/asm/pgtable-2level-hwdef.h |  6 +++
 arch/arm/include/asm/pgtable-3level-hwdef.h | 14 ++++-
 arch/arm/include/asm/pgtable-3level.h       |  2 +-
 arch/arm/include/asm/pgtable-hwdef.h        |  1 +
 arch/arm/include/asm/pgtable.h              |  3 ++
 arch/arm/mm/dump.c                          | 28 ++++++++++
 arch/arm/mm/mmu.c                           | 80 +++++++++++++++++++++++------
 arch/arm/mm/proc-v7-3level.S                |  2 +-
 8 files changed, 115 insertions(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level-hwdef.h b/arch/arm/include/asm/pgtable-2level-hwdef.h
index d0131ee..d62e20f 100644
--- a/arch/arm/include/asm/pgtable-2level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-2level-hwdef.h
@@ -93,4 +93,10 @@
 
 #define PHYS_MASK		(~0UL)
 
+/* These are here to share more code between 2level & 3level */
+#define L_PTE_EARLY_SHARED	PTE_EXT_SHARED
+#define PTE_EXT_SMASK		PTE_EXT_SHARED
+#define PMD_SECT_EARLY_S	PMD_SECT_S
+#define PMD_SECT_SMASK		PMD_SECT_S
+
 #endif
diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
index f8f1cff..3ffc0ce 100644
--- a/arch/arm/include/asm/pgtable-3level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
@@ -44,7 +44,9 @@
 #define PMD_SECT_CACHEABLE	(_AT(pmdval_t, 1) << 3)
 #define PMD_SECT_USER		(_AT(pmdval_t, 1) << 6)		/* AP[1] */
 #define PMD_SECT_AP2		(_AT(pmdval_t, 1) << 7)		/* read only */
-#define PMD_SECT_S		(_AT(pmdval_t, 3) << 8)
+#define PMD_SECT_SMASK		(_AT(pmdval_t, 3) << 8)		/* shareable bits */
+#define PMD_SECT_ISHARED	(_AT(pmdval_t, 3) << 8)		/* inner sharable */
+#define PMD_SECT_OSHARED	(_AT(pmdval_t, 2) << 8)		/* outer sharable */
 #define PMD_SECT_AF		(_AT(pmdval_t, 1) << 10)
 #define PMD_SECT_nG		(_AT(pmdval_t, 1) << 11)
 #define PMD_SECT_PXN		(_AT(pmdval_t, 1) << 53)
@@ -73,12 +75,20 @@
 #define PTE_BUFFERABLE		(_AT(pteval_t, 1) << 2)		/* AttrIndx[0] */
 #define PTE_CACHEABLE		(_AT(pteval_t, 1) << 3)		/* AttrIndx[1] */
 #define PTE_AP2			(_AT(pteval_t, 1) << 7)		/* AP[2] */
-#define PTE_EXT_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
+#define PTE_EXT_SMASK		(_AT(pteval_t, 3) << 8)		/* SH[1:0], shareable */
+#define PTE_EXT_ISHARED	(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
+#define PTE_EXT_OSHARED	(_AT(pteval_t, 2) << 8)		/* SH[1:0], outer shareable */
 #define PTE_EXT_AF		(_AT(pteval_t, 1) << 10)	/* Access Flag */
 #define PTE_EXT_NG		(_AT(pteval_t, 1) << 11)	/* nG */
 #define PTE_EXT_PXN		(_AT(pteval_t, 1) << 53)	/* PXN */
 #define PTE_EXT_XN		(_AT(pteval_t, 1) << 54)	/* XN */
 
+/* in early boot we assume inner shared,
+ * afterward use L_PTE_SHARED but only in code, can't be static initializer
+ */
+#define L_PTE_EARLY_SHARED	PTE_EXT_ISHARED
+#define PMD_SECT_EARLY_S	PMD_SECT_ISHARED
+
 /*
  * 40-bit physical address supported.
  */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index fa70db7..af5b9cb 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -78,7 +78,7 @@
 #define L_PTE_VALID		(_AT(pteval_t, 1) << 0)		/* Valid */
 #define L_PTE_PRESENT		(_AT(pteval_t, 3) << 0)		/* Present */
 #define L_PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
-#define L_PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
+#define L_PTE_SHARED		(l_pte_shared)			/* inner or outer shareable */
 #define L_PTE_YOUNG		(_AT(pteval_t, 1) << 10)	/* AF */
 #define L_PTE_XN		(_AT(pteval_t, 1) << 54)	/* XN */
 #define L_PTE_DIRTY		(_AT(pteval_t, 1) << 55)
diff --git a/arch/arm/include/asm/pgtable-hwdef.h b/arch/arm/include/asm/pgtable-hwdef.h
index c35d71f..27654a9 100644
--- a/arch/arm/include/asm/pgtable-hwdef.h
+++ b/arch/arm/include/asm/pgtable-hwdef.h
@@ -30,6 +30,7 @@ struct attr_mod_entry {
 };
 
 bool attr_mod_add(struct attr_mod_entry *pmod);
+bool use_outer_shared(void);
 
 extern int num_attr_mods;
 extern struct attr_mod_entry attr_mod_table[MAX_ATTR_MOD_ENTRIES];
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 348caab..4d2e412 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -86,6 +86,9 @@ extern pgprot_t		pgprot_hyp_device;
 extern pgprot_t		pgprot_s2;
 extern pgprot_t		pgprot_s2_device;
 
+extern pmdval_t		pmd_sect_s;
+extern pteval_t		l_pte_shared;
+
 #define _MOD_PROT(p, b)	__pgprot(pgprot_val(p) | (b))
 
 #define PAGE_NONE		_MOD_PROT(pgprot_user, L_PTE_XN | L_PTE_RDONLY | L_PTE_NONE)
diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 9fe8e24..fb98fa6 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -68,10 +68,24 @@ static const struct prot_bits pte_bits[] = {
 		.set	= "NX",
 		.clear	= "x ",
 	}, {
+#ifndef CONFIG_ARM_LPAE
 		.mask	= L_PTE_SHARED,
 		.val	= L_PTE_SHARED,
 		.set	= "SHD",
 		.clear	= "   ",
+#else
+		.mask	= PTE_EXT_SMASK,
+		.val	= PTE_EXT_ISHARED,
+		.set	= "ISHD",
+	}, {
+		.mask	= PTE_EXT_SMASK,
+		.val	= PTE_EXT_OSHARED,
+		.set	= "OSHD",
+	}, {
+		.mask	= PTE_EXT_SMASK,
+		.val	= 0,
+		.set	= "    ",
+#endif
 	}, {
 		.mask	= L_PTE_MT_MASK,
 		.val	= L_PTE_MT_UNCACHED,
@@ -172,10 +186,24 @@ static const struct prot_bits section_bits[] = {
 		.set	= "NX",
 		.clear	= "x ",
 	}, {
+#ifndef CONFIG_ARM_LPAE
 		.mask	= PMD_SECT_S,
 		.val	= PMD_SECT_S,
 		.set	= "SHD",
 		.clear	= "   ",
+#else
+		.mask	= PMD_SECT_SMASK,
+		.val	= PMD_SECT_ISHARED,
+		.set	= "ISHD",
+	}, {
+		.mask	= PMD_SECT_SMASK,
+		.val	= PMD_SECT_OSHARED,
+		.set	= "OSHD",
+	}, {
+		.mask	= PMD_SECT_SMASK,
+		.val	= 0,
+		.set	= "    ",
+#endif
 	},
 };
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index a608980..8aaccf2 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -70,6 +70,13 @@ pgprot_t pgprot_hyp_device;
 pgprot_t pgprot_s2;
 pgprot_t pgprot_s2_device;
 
+/* For LPAE hold the value of Inner or Outer Shared attribute selected at
+ * early init, which starts out as inner shared
+ * For non_LPAE these are always just the single S Bit
+ */
+pmdval_t pmd_sect_s    = PMD_SECT_EARLY_S;
+pteval_t l_pte_shared  = L_PTE_EARLY_SHARED;
+
 EXPORT_SYMBOL(pgprot_user);
 EXPORT_SYMBOL(pgprot_kernel);
 
@@ -246,12 +253,12 @@ __setup("noalign", noalign_setup);
 static struct mem_type mem_types[] = {
 	[MT_DEVICE] = {		  /* Strongly ordered / ARMv6 shared device */
 		.prot_pte	= PROT_PTE_DEVICE | L_PTE_MT_DEV_SHARED |
-				  L_PTE_SHARED,
+				  L_PTE_EARLY_SHARED,
 		.prot_pte_s2	= s2_policy(PROT_PTE_S2_DEVICE) |
 				  s2_policy(L_PTE_S2_MT_DEV_SHARED) |
-				  L_PTE_SHARED,
+				  L_PTE_EARLY_SHARED,
 		.prot_l1	= PMD_TYPE_TABLE,
-		.prot_sect	= PROT_SECT_DEVICE | PMD_SECT_S,
+		.prot_sect	= PROT_SECT_DEVICE | PMD_SECT_EARLY_S,
 		.domain		= DOMAIN_IO,
 	},
 	[MT_DEVICE_NONSHARED] = { /* ARMv6 non-shared device */
@@ -340,8 +347,9 @@ static struct mem_type mem_types[] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
 				L_PTE_MT_UNCACHED | L_PTE_XN,
 		.prot_l1   = PMD_TYPE_TABLE,
-		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_S |
-				PMD_SECT_UNCACHED | PMD_SECT_XN,
+		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE |
+				PMD_SECT_EARLY_S | PMD_SECT_UNCACHED |
+				PMD_SECT_XN,
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_DMA_READY] = {
@@ -422,6 +430,15 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
 }
 
+#ifdef CONFIG_ARM_LPAE
+static void __init fixup_mem_type_shared(struct mem_type *pmt)
+{
+	pmt->prot_sect   = (pmt->prot_sect   & ~PMD_SECT_SMASK) | pmd_sect_s;
+	pmt->prot_pte    = (pmt->prot_pte    & ~PTE_EXT_SMASK)  | l_pte_shared;
+	pmt->prot_pte_s2 = (pmt->prot_pte_s2 & ~PTE_EXT_SMASK)  | l_pte_shared;
+}
+#endif
+
 /*
  * Adjust the PMD section entries according to the CPU in use.
  */
@@ -449,14 +466,24 @@ static void __init build_mem_type_table(void)
 		ecc_mask = 0;
 	}
 
+#ifdef CONFIG_ARM_LPAE
+	if (pmd_sect_s != PMD_SECT_EARLY_S)
+		/* we are using different sharable value than was set at
+		 * compile time, fixup the mem types
+		 */
+		for (i = 0; i < ARRAY_SIZE(mem_types); i++)
+			if (mem_types[i].prot_sect & PMD_SECT_SMASK)
+				fixup_mem_type_shared(&mem_types[i]);
+#endif
+
 	if (is_smp()) {
 		if (cachepolicy != CPOLICY_WRITEALLOC) {
 			pr_warn("Forcing write-allocate cache policy for SMP\n");
 			cachepolicy = CPOLICY_WRITEALLOC;
 		}
-		if (!(initial_pmd_value & PMD_SECT_S)) {
+		if (!(initial_pmd_value & PMD_SECT_SMASK)) {
 			pr_warn("Forcing shared mappings for SMP\n");
-			initial_pmd_value |= PMD_SECT_S;
+			initial_pmd_value |= pmd_sect_s;
 		}
 	}
 
@@ -470,7 +497,7 @@ static void __init build_mem_type_table(void)
 			mem_types[i].prot_sect &= ~PMD_SECT_TEX(7);
 	if ((cpu_arch < CPU_ARCH_ARMv6 || !(cr & CR_XP)) && !cpu_is_xsc3())
 		for (i = 0; i < ARRAY_SIZE(mem_types); i++)
-			mem_types[i].prot_sect &= ~PMD_SECT_S;
+			mem_types[i].prot_sect &= ~PMD_SECT_SMASK;
 
 	/*
 	 * ARMv5 and lower, bit 4 must be set for page tables (was: cache
@@ -592,25 +619,25 @@ static void __init build_mem_type_table(void)
 #endif
 
 		/*
-		 * If the initial page tables were created with the S bit
-		 * set, then we need to do the same here for the same
-		 * reasons given in early_cachepolicy().
+		 * If we are using shared mode (ex SMP)
+		 * then we need to add the shared attribute to all needed
+		 * mem_types
 		 */
-		if (initial_pmd_value & PMD_SECT_S) {
+		if (initial_pmd_value & PMD_SECT_SMASK) {
 			user_pgprot |= L_PTE_SHARED;
 			kern_pgprot |= L_PTE_SHARED;
 			vecs_pgprot |= L_PTE_SHARED;
 			s2_pgprot |= L_PTE_SHARED;
-			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
+			mem_types[MT_DEVICE_WC].prot_sect |= pmd_sect_s;
 			mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
-			mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
+			mem_types[MT_DEVICE_CACHED].prot_sect |= pmd_sect_s;
 			mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
-			mem_types[MT_MEMORY_RWX].prot_sect |= PMD_SECT_S;
+			mem_types[MT_MEMORY_RWX].prot_sect |= pmd_sect_s;
 			mem_types[MT_MEMORY_RWX].prot_pte |= L_PTE_SHARED;
-			mem_types[MT_MEMORY_RW].prot_sect |= PMD_SECT_S;
+			mem_types[MT_MEMORY_RW].prot_sect |= pmd_sect_s;
 			mem_types[MT_MEMORY_RW].prot_pte |= L_PTE_SHARED;
 			mem_types[MT_MEMORY_DMA_READY].prot_pte |= L_PTE_SHARED;
-			mem_types[MT_MEMORY_RWX_NONCACHED].prot_sect |= PMD_SECT_S;
+			mem_types[MT_MEMORY_RWX_NONCACHED].prot_sect |= pmd_sect_s;
 			mem_types[MT_MEMORY_RWX_NONCACHED].prot_pte |= L_PTE_SHARED;
 		}
 	}
@@ -1510,6 +1537,25 @@ bool __init attr_mod_add(struct attr_mod_entry *pmod)
 	return true;
 }
 
+/* use outer shared wherever we would have used inner shared */
+bool __init use_outer_shared(void)
+{
+	struct attr_mod_entry mod = {
+		.test_mask   = PTE_EXT_SMASK,
+		.test_value  = PTE_EXT_ISHARED,
+		.clear_mask  = PTE_EXT_SMASK,
+		.set_mask    = PTE_EXT_OSHARED
+	};
+
+	if (attr_mod_add(&mod) >= 0) {
+		l_pte_shared = PTE_EXT_OSHARED;
+		pmd_sect_s   = PMD_SECT_OSHARED;
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * early_paging_init() recreates boot time page table setup, allowing machines
  * to switch over to a high (>4G) address space on LPAE systems
diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 5e5720e..a518b3b 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -38,7 +38,7 @@
 
 /* PTWs cacheable, inner WBWA shareable, outer WBWA not shareable */
 #define TTB_FLAGS_SMP	(TTB_IRGN_WBWA|TTB_S|TTB_RGN_OC_WBWA)
-#define PMD_FLAGS_SMP	(PMD_SECT_WBWA|PMD_SECT_S)
+#define PMD_FLAGS_SMP	(PMD_SECT_WBWA|PMD_SECT_EARLY_S)
 
 #ifndef __ARMEB__
 #  define rpgdl	r0
-- 
1.9.1
