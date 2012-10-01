From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:10:13 -0400
Subject: [PATCH v2 02/14] ARM: Section based HYP idmap
In-Reply-To: <20121001090945.49198.68950.stgit@ubuntu>
References: <20121001090945.49198.68950.stgit@ubuntu>
Message-ID: <20121001091013.49198.93348.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a method (hyp_idmap_setup) to populate a hyp pgd with an
identity mapping of the code contained in the .hyp.idmap.text
section.

Offer a method to drop the this identity mapping through
hyp_idmap_teardown.

Make all the above depend on CONFIG_ARM_VIRT_EXT and CONFIG_ARM_LPAE.

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/idmap.h                |    5 ++
 arch/arm/include/asm/pgtable-3level-hwdef.h |    1 
 arch/arm/kernel/vmlinux.lds.S               |    6 ++
 arch/arm/mm/idmap.c                         |   74 +++++++++++++++++++++++----
 4 files changed, 73 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
index bf863ed..36708ba 100644
--- a/arch/arm/include/asm/idmap.h
+++ b/arch/arm/include/asm/idmap.h
@@ -11,4 +11,9 @@ extern pgd_t *idmap_pgd;
 
 void setup_mm_for_reboot(void);
 
+#ifdef CONFIG_ARM_VIRT_EXT
+void hyp_idmap_teardown(pgd_t *hyp_pgd);
+void hyp_idmap_setup(pgd_t *hyp_pgd);
+#endif
+
 #endif	/* __ASM_IDMAP_H */
diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
index d795282..a2d404e 100644
--- a/arch/arm/include/asm/pgtable-3level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
@@ -44,6 +44,7 @@
 #define PMD_SECT_XN		(_AT(pmdval_t, 1) << 54)
 #define PMD_SECT_AP_WRITE	(_AT(pmdval_t, 0))
 #define PMD_SECT_AP_READ	(_AT(pmdval_t, 0))
+#define PMD_SECT_AP1		(_AT(pmdval_t, 1) << 6)
 #define PMD_SECT_TEX(x)		(_AT(pmdval_t, 0))
 
 /*
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 36ff15b..12fd2eb 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -19,7 +19,11 @@
 	ALIGN_FUNCTION();						\
 	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
 	*(.idmap.text)							\
-	VMLINUX_SYMBOL(__idmap_text_end) = .;
+	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
+	ALIGN_FUNCTION();						\
+	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
+	*(.hyp.idmap.text)						\
+	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define ARM_CPU_DISCARD(x)
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index ab88ed4..ea7430e 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -1,4 +1,6 @@
+#include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 
 #include <asm/cputype.h>
 #include <asm/idmap.h>
@@ -6,6 +8,7 @@
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 #include <asm/system_info.h>
+#include <asm/virt.h>
 
 pgd_t *idmap_pgd;
 
@@ -59,11 +62,20 @@ static void idmap_add_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 	} while (pud++, addr = next, addr != end);
 }
 
-static void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end)
+static void identity_mapping_add(pgd_t *pgd, const char *text_start,
+				 const char *text_end, unsigned long prot)
 {
-	unsigned long prot, next;
+	unsigned long addr, end;
+	unsigned long next;
+
+	addr = virt_to_phys(text_start);
+	end = virt_to_phys(text_end);
+
+	pr_info("Setting up static %sidentity map for 0x%llx - 0x%llx\n",
+		prot ? "HYP " : "",
+		(long long)addr, (long long)end);
+	prot |= PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
 
-	prot = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
 	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
 		prot |= PMD_BIT4;
 
@@ -78,24 +90,62 @@ extern char  __idmap_text_start[], __idmap_text_end[];
 
 static int __init init_static_idmap(void)
 {
-	phys_addr_t idmap_start, idmap_end;
-
 	idmap_pgd = pgd_alloc(&init_mm);
 	if (!idmap_pgd)
 		return -ENOMEM;
 
-	/* Add an identity mapping for the physical address of the section. */
-	idmap_start = virt_to_phys((void *)__idmap_text_start);
-	idmap_end = virt_to_phys((void *)__idmap_text_end);
-
-	pr_info("Setting up static identity map for 0x%llx - 0x%llx\n",
-		(long long)idmap_start, (long long)idmap_end);
-	identity_mapping_add(idmap_pgd, idmap_start, idmap_end);
+	identity_mapping_add(idmap_pgd, __idmap_text_start,
+			     __idmap_text_end, 0);
 
 	return 0;
 }
 early_initcall(init_static_idmap);
 
+#if defined(CONFIG_ARM_VIRT_EXT) && defined(CONFIG_ARM_LPAE)
+static void hyp_idmap_del_pmd(pgd_t *pgd, unsigned long addr)
+{
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pud = pud_offset(pgd, addr);
+	pmd = pmd_offset(pud, addr);
+	pud_clear(pud);
+	clean_pmd_entry(pmd);
+	pmd_free(NULL, (pmd_t *)((unsigned long)pmd & PAGE_MASK));
+}
+
+extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
+
+/*
+ * This version actually frees the underlying pmds for all pgds in range and
+ * clear the pgds themselves afterwards.
+ */
+void hyp_idmap_teardown(pgd_t *hyp_pgd)
+{
+	unsigned long addr, end;
+	unsigned long next;
+	pgd_t *pgd = hyp_pgd;
+
+	addr = virt_to_phys(__hyp_idmap_text_start);
+	end = virt_to_phys(__hyp_idmap_text_end);
+
+	pgd += pgd_index(addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (!pgd_none_or_clear_bad(pgd))
+			hyp_idmap_del_pmd(pgd, addr);
+	} while (pgd++, addr = next, addr < end);
+}
+EXPORT_SYMBOL_GPL(hyp_idmap_teardown);
+
+void hyp_idmap_setup(pgd_t *hyp_pgd)
+{
+	identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
+			     __hyp_idmap_text_end, PMD_SECT_AP1);
+}
+EXPORT_SYMBOL_GPL(hyp_idmap_setup);
+#endif
+
 /*
  * In order to soft-boot, we need to switch to a 1:1 mapping for the
  * cpu_reset functions. This will then ensure that we have predictable
