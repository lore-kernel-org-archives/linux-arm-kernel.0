From: wmills@ti.com (Bill Mills)
Date: Sun, 5 Jun 2016 23:20:28 -0400
Subject: [RFC v2 3/4] ARM: mm: add inner/outer sharing value command line
In-Reply-To: <1465183229-24147-1-git-send-email-wmills@ti.com>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
Message-ID: <1465183229-24147-4-git-send-email-wmills@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds defsharing=inner|outer as an early command line option.
Any such command line option will override a platform's choice.

Signed-off-by: Bill Mills <wmills@ti.com>
---
 arch/arm/include/asm/pgtable-hwdef.h |  1 +
 arch/arm/mm/mmu.c                    | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-hwdef.h b/arch/arm/include/asm/pgtable-hwdef.h
index 27654a9..2a9e24b 100644
--- a/arch/arm/include/asm/pgtable-hwdef.h
+++ b/arch/arm/include/asm/pgtable-hwdef.h
@@ -31,6 +31,7 @@ struct attr_mod_entry {
 
 bool attr_mod_add(struct attr_mod_entry *pmod);
 bool use_outer_shared(void);
+bool use_inner_shared(void);
 
 extern int num_attr_mods;
 extern struct attr_mod_entry attr_mod_table[MAX_ATTR_MOD_ENTRIES];
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 8aaccf2..cc4a803 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1524,6 +1524,7 @@ typedef void pgtables_remap(long long offset, unsigned long pgd, void *bdata);
 pgtables_remap lpae_pgtables_remap_asm;
 
 int num_attr_mods;
+static const char *defshared_seen;
 
 /* add an entry to the early page table attribute modification list */
 bool __init attr_mod_add(struct attr_mod_entry *pmod)
@@ -1547,15 +1548,50 @@ bool __init use_outer_shared(void)
 		.set_mask    = PTE_EXT_OSHARED
 	};
 
+	if (defshared_seen) {
+		pr_err("Default Sharing already set to %s\n", defshared_seen);
+		return false;
+	}
+
 	if (attr_mod_add(&mod) >= 0) {
 		l_pte_shared = PTE_EXT_OSHARED;
 		pmd_sect_s   = PMD_SECT_OSHARED;
+		defshared_seen = "outer";
 		return true;
 	}
 
 	return false;
 }
 
+/* explicitly use inner shared */
+bool __init use_inner_shared(void)
+{
+	if (defshared_seen) {
+		pr_err("Default Sharing already set to %s\n", defshared_seen);
+		return false;
+	}
+
+	defshared_seen = "inner";
+	return true;
+}
+
+/*
+ * Allow sharing type to be set
+ */
+static int __init early_defshared(char *p)
+{
+	if (strcmp(p, "outer") == 0)
+		use_outer_shared();
+	else if (strcmp(p, "inner") == 0)
+		use_inner_shared();
+	else
+		pr_err("Unknown defshared mode %s\n", p);
+
+	return 0;
+}
+
+early_param("defshared", early_defshared);
+
 /*
  * early_paging_init() recreates boot time page table setup, allowing machines
  * to switch over to a high (>4G) address space on LPAE systems
-- 
1.9.1
