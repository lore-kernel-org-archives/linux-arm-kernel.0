From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Nov 2011 18:28:52 +0000
Subject: [PATCH v2 1/6] ARM: idmap: populate identity map pgd at init time
 using .init.text
In-Reply-To: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
References: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
Message-ID: <1322504937-24718-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When disabling and re-enabling the MMU, it is necessary to take out an
identity mapping for the code that manipulates the SCTLR in order to
avoid it disappearing from under our feet. This is useful when soft
rebooting and returning from CPU suspend.

This patch allocates a set of page tables during boot and populates them
with an identity mapping for the .idmap.text section. This means that
users of the identity map do not need to manage their own pgd and can
instead annotate their functions with __idmap or, in the case of assembly
code, place them in the correct section.

Acked-by: Dave Martin <dave.martin@linaro.org>
Tested-by: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/idmap.h   |   17 +++++++++++++++++
 arch/arm/include/asm/pgtable.h |    3 ---
 arch/arm/kernel/smp.c          |    1 +
 arch/arm/kernel/vmlinux.lds.S  |    7 +++++++
 arch/arm/mm/idmap.c            |   26 ++++++++++++++++++++++++++
 5 files changed, 51 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/asm/idmap.h

diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
new file mode 100644
index 0000000..62e3d19
--- /dev/null
+++ b/arch/arm/include/asm/idmap.h
@@ -0,0 +1,17 @@
+#ifndef __ASM_IDMAP_H
+#define __ASM_IDMAP_H
+
+#include <linux/compiler.h>
+#include <asm/pgtable.h>
+
+/* Tag a function as requiring to be executed via an identity mapping. */
+#define __idmap __section(.idmap.text) noinline notrace
+
+extern pgd_t *idmap_pgd;
+
+void identity_mapping_add(pgd_t *, unsigned long, unsigned long);
+void identity_mapping_del(pgd_t *, unsigned long, unsigned long);
+
+void setup_mm_for_reboot(void);
+
+#endif	/* __ASM_IDMAP_H */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 9451dce..03893a5 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -346,9 +346,6 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
 #define pgtable_cache_init() do { } while (0)
 
-void identity_mapping_add(pgd_t *, unsigned long, unsigned long);
-void identity_mapping_del(pgd_t *, unsigned long, unsigned long);
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* CONFIG_MMU */
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index ef5640b..8afadda 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -31,6 +31,7 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/exception.h>
+#include <asm/idmap.h>
 #include <asm/topology.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 20b3041..f76e755 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -13,6 +13,12 @@
 	*(.proc.info.init)						\
 	VMLINUX_SYMBOL(__proc_info_end) = .;
 
+#define IDMAP_TEXT							\
+	ALIGN_FUNCTION();						\
+	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
+	*(.idmap.text)							\
+	VMLINUX_SYMBOL(__idmap_text_end) = .;
+
 #ifdef CONFIG_HOTPLUG_CPU
 #define ARM_CPU_DISCARD(x)
 #define ARM_CPU_KEEP(x)		x
@@ -92,6 +98,7 @@ SECTIONS
 			SCHED_TEXT
 			LOCK_TEXT
 			KPROBES_TEXT
+			IDMAP_TEXT
 #ifdef CONFIG_MMU
 			*(.fixup)
 #endif
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 296ad2e..cda5ea3 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -1,8 +1,12 @@
 #include <linux/kernel.h>
 
 #include <asm/cputype.h>
+#include <asm/idmap.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
+#include <asm/sections.h>
+
+pgd_t *idmap_pgd;
 
 static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 	unsigned long prot)
@@ -73,6 +77,28 @@ void identity_mapping_del(pgd_t *pgd, unsigned long addr, unsigned long end)
 }
 #endif
 
+extern char  __idmap_text_start[], __idmap_text_end[];
+
+static int __init init_static_idmap(void)
+{
+	phys_addr_t idmap_start, idmap_end;
+
+	idmap_pgd = pgd_alloc(&init_mm);
+	if (!idmap_pgd)
+		return -ENOMEM;
+
+	/* Add an identity mapping for the physical address of the section. */
+	idmap_start = virt_to_phys((void *)__idmap_text_start);
+	idmap_end = virt_to_phys((void *)__idmap_text_end);
+
+	pr_info("Setting up static identity map for 0x%llx - 0x%llx\n",
+		(long long)idmap_start, (long long)idmap_end);
+	identity_mapping_add(idmap_pgd, idmap_start, idmap_end);
+
+	return 0;
+}
+arch_initcall(init_static_idmap);
+
 /*
  * In order to soft-boot, we need to insert a 1:1 mapping in place of
  * the user-mode pages.  This will then ensure that we have predictable
-- 
1.7.4.1
