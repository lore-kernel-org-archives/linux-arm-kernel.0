From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 22 Oct 2012 02:49:04 -0400
Subject: [PATCH v3 01/14] ARM: Add page table and page defines needed by KVM
In-Reply-To: <20121022064831.18444.73273.stgit@ubuntu>
References: <20121022064831.18444.73273.stgit@ubuntu>
Message-ID: <20121022064904.18444.6901.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KVM uses the stage-2 page tables and the Hyp page table format,
so we define the fields and page protection flags needed by KVM.

The nomenclature is this:
 - page_hyp:        PL2 code/data mappings
 - page_hyp_device: PL2 device mappings (vgic access)
 - page_s2:         Stage-2 code/data page mappings
 - page_s2_device:  Stage-2 device mappings (vgic access)

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/pgtable-3level.h |   18 ++++++++++++++++++
 arch/arm/include/asm/pgtable.h        |    7 +++++++
 arch/arm/mm/mmu.c                     |   25 +++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index b249035..eaba5a4 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -102,11 +102,29 @@
  */
 #define L_PGD_SWAPPER		(_AT(pgdval_t, 1) << 55)	/* swapper_pg_dir entry */
 
+/*
+ * 2nd stage PTE definitions for LPAE.
+ */
+#define L_PTE_S2_MT_UNCACHED	 (_AT(pteval_t, 0x5) << 2) /* MemAttr[3:0] */
+#define L_PTE_S2_MT_WRITETHROUGH (_AT(pteval_t, 0xa) << 2) /* MemAttr[3:0] */
+#define L_PTE_S2_MT_WRITEBACK	 (_AT(pteval_t, 0xf) << 2) /* MemAttr[3:0] */
+#define L_PTE_S2_RDONLY		 (_AT(pteval_t, 1) << 6)   /* HAP[1]   */
+#define L_PTE_S2_RDWR		 (_AT(pteval_t, 2) << 6)   /* HAP[2:1] */
+
+/*
+ * Hyp-mode PL2 PTE definitions for LPAE.
+ */
+#define L_PTE_HYP		L_PTE_USER
+
 #ifndef __ASSEMBLY__
 
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!(pud_val(pud) & 2))
 #define pud_present(pud)	(pud_val(pud))
+#define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
+						 PMD_TYPE_TABLE)
+#define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
+						 PMD_TYPE_SECT)
 
 #define pud_clear(pudp)			\
 	do {				\
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 08c1231..dfb3918 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -70,6 +70,9 @@ extern void __pgd_error(const char *file, int line, pgd_t);
 
 extern pgprot_t		pgprot_user;
 extern pgprot_t		pgprot_kernel;
+extern pgprot_t		pgprot_hyp_device;
+extern pgprot_t		pgprot_s2;
+extern pgprot_t		pgprot_s2_device;
 
 #define _MOD_PROT(p, b)	__pgprot(pgprot_val(p) | (b))
 
@@ -82,6 +85,10 @@ extern pgprot_t		pgprot_kernel;
 #define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY)
 #define PAGE_KERNEL		_MOD_PROT(pgprot_kernel, L_PTE_XN)
 #define PAGE_KERNEL_EXEC	pgprot_kernel
+#define PAGE_HYP		_MOD_PROT(pgprot_kernel, L_PTE_HYP)
+#define PAGE_HYP_DEVICE		_MOD_PROT(pgprot_hyp_device, L_PTE_HYP)
+#define PAGE_S2			_MOD_PROT(pgprot_s2, L_PTE_S2_RDONLY)
+#define PAGE_S2_DEVICE		_MOD_PROT(pgprot_s2_device, L_PTE_USER | L_PTE_S2_RDONLY)
 
 #define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY | L_PTE_XN)
 #define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 941dfb9..087d949 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -57,43 +57,61 @@ static unsigned int cachepolicy __initdata = CPOLICY_WRITEBACK;
 static unsigned int ecc_mask __initdata = 0;
 pgprot_t pgprot_user;
 pgprot_t pgprot_kernel;
+pgprot_t pgprot_hyp_device;
+pgprot_t pgprot_s2;
+pgprot_t pgprot_s2_device;
 
 EXPORT_SYMBOL(pgprot_user);
 EXPORT_SYMBOL(pgprot_kernel);
+EXPORT_SYMBOL(pgprot_hyp_device);
+EXPORT_SYMBOL(pgprot_s2);
+EXPORT_SYMBOL(pgprot_s2_device);
 
 struct cachepolicy {
 	const char	policy[16];
 	unsigned int	cr_mask;
 	pmdval_t	pmd;
 	pteval_t	pte;
+	pteval_t	pte_s2;
 };
 
+#ifdef CONFIG_ARM_LPAE
+#define s2_policy(policy)	policy
+#else
+#define s2_policy(policy)	0
+#endif
+
 static struct cachepolicy cache_policies[] __initdata = {
 	{
 		.policy		= "uncached",
 		.cr_mask	= CR_W|CR_C,
 		.pmd		= PMD_SECT_UNCACHED,
 		.pte		= L_PTE_MT_UNCACHED,
+		.pte_s2		= s2_policy(L_PTE_S2_MT_UNCACHED),
 	}, {
 		.policy		= "buffered",
 		.cr_mask	= CR_C,
 		.pmd		= PMD_SECT_BUFFERED,
 		.pte		= L_PTE_MT_BUFFERABLE,
+		.pte_s2		= s2_policy(L_PTE_S2_MT_UNCACHED),
 	}, {
 		.policy		= "writethrough",
 		.cr_mask	= 0,
 		.pmd		= PMD_SECT_WT,
 		.pte		= L_PTE_MT_WRITETHROUGH,
+		.pte_s2		= s2_policy(L_PTE_S2_MT_WRITETHROUGH),
 	}, {
 		.policy		= "writeback",
 		.cr_mask	= 0,
 		.pmd		= PMD_SECT_WB,
 		.pte		= L_PTE_MT_WRITEBACK,
+		.pte_s2		= s2_policy(L_PTE_S2_MT_WRITEBACK),
 	}, {
 		.policy		= "writealloc",
 		.cr_mask	= 0,
 		.pmd		= PMD_SECT_WBWA,
 		.pte		= L_PTE_MT_WRITEALLOC,
+		.pte_s2		= s2_policy(L_PTE_S2_MT_WRITEBACK),
 	}
 };
 
@@ -310,6 +328,7 @@ static void __init build_mem_type_table(void)
 	struct cachepolicy *cp;
 	unsigned int cr = get_cr();
 	pteval_t user_pgprot, kern_pgprot, vecs_pgprot;
+	pteval_t hyp_device_pgprot, s2_pgprot, s2_device_pgprot;
 	int cpu_arch = cpu_architecture();
 	int i;
 
@@ -421,6 +440,8 @@ static void __init build_mem_type_table(void)
 	 */
 	cp = &cache_policies[cachepolicy];
 	vecs_pgprot = kern_pgprot = user_pgprot = cp->pte;
+	s2_pgprot = cp->pte_s2;
+	hyp_device_pgprot = s2_device_pgprot = mem_types[MT_DEVICE].prot_pte;
 
 	/*
 	 * ARMv6 and above have extended page tables.
@@ -444,6 +465,7 @@ static void __init build_mem_type_table(void)
 			user_pgprot |= L_PTE_SHARED;
 			kern_pgprot |= L_PTE_SHARED;
 			vecs_pgprot |= L_PTE_SHARED;
+			s2_pgprot |= L_PTE_SHARED;
 			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
 			mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
 			mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
@@ -498,6 +520,9 @@ static void __init build_mem_type_table(void)
 	pgprot_user   = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | user_pgprot);
 	pgprot_kernel = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG |
 				 L_PTE_DIRTY | kern_pgprot);
+	pgprot_s2  = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | s2_pgprot);
+	pgprot_s2_device  = __pgprot(s2_device_pgprot);
+	pgprot_hyp_device  = __pgprot(hyp_device_pgprot);
 
 	mem_types[MT_LOW_VECTORS].prot_l1 |= ecc_mask;
 	mem_types[MT_HIGH_VECTORS].prot_l1 |= ecc_mask;
