From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Nov 2011 16:48:11 +0000
Subject: [PATCH 1/4] ARM: idmap: populate identity map pgd at init time using
 .init.text
In-Reply-To: <1321462094-6647-1-git-send-email-will.deacon@arm.com>
References: <1321462094-6647-1-git-send-email-will.deacon@arm.com>
Message-ID: <1321462094-6647-2-git-send-email-will.deacon@arm.com>
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

Tested-by: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/idmap.h      |   11 +++++++++++
 arch/arm/kernel/vmlinux.lds.S     |    1 +
 arch/arm/mm/idmap.c               |   30 ++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |    6 ++++++
 4 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/idmap.h

diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
new file mode 100644
index 0000000..95a09d7
--- /dev/null
+++ b/arch/arm/include/asm/idmap.h
@@ -0,0 +1,11 @@
+#ifndef __ASM_IDMAP_H
+#define __ASM_IDMAP_H
+
+#include <linux/compiler.h>
+
+/* Tag a function as requiring to be executed via an identity mapping. */
+#define __idmap __section(.idmap.text) noinline notrace
+
+void setup_mm_for_reboot(char mode);
+
+#endif	/* __ASM_IDMAP_H */
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 20b3041..a0205ad 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -92,6 +92,7 @@ SECTIONS
 			SCHED_TEXT
 			LOCK_TEXT
 			KPROBES_TEXT
+			IDMAP_TEXT
 #ifdef CONFIG_MMU
 			*(.fixup)
 #endif
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 2be9139..8c1230a 100644
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
@@ -73,6 +77,32 @@ void identity_mapping_del(pgd_t *pgd, unsigned long addr, unsigned long end)
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
+	/* Align the idmap.text section pointers to PMD_SIZE. */
+	idmap_start = (phys_addr_t)__idmap_text_start & PMD_MASK;
+	idmap_end = PTR_ALIGN((phys_addr_t)__idmap_text_end, PMD_SIZE);
+
+	/* Add an identity mapping for the physical address of the section. */
+	idmap_start = virt_to_phys((void *)idmap_start);
+	idmap_end = virt_to_phys((void *)idmap_end);
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
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b5e2e4c..d555a24 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -425,6 +425,12 @@
 		*(.kprobes.text)					\
 		VMLINUX_SYMBOL(__kprobes_text_end) = .;
 
+#define IDMAP_TEXT							\
+		ALIGN_FUNCTION();					\
+		VMLINUX_SYMBOL(__idmap_text_start) = .;			\
+		*(.idmap.text)						\
+		VMLINUX_SYMBOL(__idmap_text_end) = .;
+
 #define ENTRY_TEXT							\
 		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__entry_text_start) = .;			\
-- 
1.7.4.1
