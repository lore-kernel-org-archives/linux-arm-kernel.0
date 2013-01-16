From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 12:57:34 -0500
Subject: [PATCH v6 02/15] ARM: Section based HYP idmap
In-Reply-To: <20130116175716.29147.15348.stgit@ubuntu>
References: <20130116175716.29147.15348.stgit@ubuntu>
Message-ID: <20130116175734.29147.19552.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a method (hyp_idmap_setup) to populate a hyp pgd with an
identity mapping of the code contained in the .hyp.idmap.text
section.

Offer a method to drop this identity mapping through
hyp_idmap_teardown.

Make all the above depend on CONFIG_ARM_VIRT_EXT and CONFIG_ARM_LPAE.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/idmap.h                |    1 
 arch/arm/include/asm/pgtable-3level-hwdef.h |    1 
 arch/arm/kernel/vmlinux.lds.S               |    6 ++-
 arch/arm/mm/idmap.c                         |   55 ++++++++++++++++++++++-----
 4 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
index bf863ed..1a66f907 100644
--- a/arch/arm/include/asm/idmap.h
+++ b/arch/arm/include/asm/idmap.h
@@ -8,6 +8,7 @@
 #define __idmap __section(.idmap.text) noinline notrace
 
 extern pgd_t *idmap_pgd;
+extern pgd_t *hyp_pgd;
 
 void setup_mm_for_reboot(void);
 
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
index 11c1785..b571484 100644
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
index 99db769..b9ae344 100644
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
 
@@ -59,11 +62,17 @@ static void idmap_add_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
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
+	prot |= PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
 
-	prot = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
 	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
 		prot |= PMD_BIT4;
 
@@ -74,28 +83,52 @@ static void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long e
 	} while (pgd++, addr = next, addr != end);
 }
 
+#ifdef CONFIG_ARM_VIRT_EXT
+pgd_t *hyp_pgd;
+
+extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
+
+static int __init init_static_idmap_hyp(void)
+{
+	hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
+	if (!hyp_pgd)
+		return -ENOMEM;
+
+	pr_info("Setting up static HYP identity map for 0x%p - 0x%p\n",
+		__hyp_idmap_text_start, __hyp_idmap_text_end);
+	identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
+			     __hyp_idmap_text_end, PMD_SECT_AP1);
+
+	return 0;
+}
+#else
+static int __init init_static_idmap_hyp(void)
+{
+	return 0;
+}
+#endif
+
 extern char  __idmap_text_start[], __idmap_text_end[];
 
 static int __init init_static_idmap(void)
 {
-	phys_addr_t idmap_start, idmap_end;
+	int ret;
 
 	idmap_pgd = pgd_alloc(&init_mm);
 	if (!idmap_pgd)
 		return -ENOMEM;
 
-	/* Add an identity mapping for the physical address of the section. */
-	idmap_start = virt_to_phys((void *)__idmap_text_start);
-	idmap_end = virt_to_phys((void *)__idmap_text_end);
+	pr_info("Setting up static identity map for 0x%p - 0x%p\n",
+		__idmap_text_start, __idmap_text_end);
+	identity_mapping_add(idmap_pgd, __idmap_text_start,
+			     __idmap_text_end, 0);
 
-	pr_info("Setting up static identity map for 0x%llx - 0x%llx\n",
-		(long long)idmap_start, (long long)idmap_end);
-	identity_mapping_add(idmap_pgd, idmap_start, idmap_end);
+	ret = init_static_idmap_hyp();
 
 	/* Flush L1 for the hardware to see this page table content */
 	flush_cache_louis();
 
-	return 0;
+	return ret;
 }
 early_initcall(init_static_idmap);
 
