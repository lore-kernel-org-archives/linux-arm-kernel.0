From: robherring2@gmail.com (Rob Herring)
Date: Tue,  6 May 2014 17:58:06 -0500
Subject: [PATCH 2/3] arm: add early_ioremap support
In-Reply-To: <1399417087-24772-1-git-send-email-robherring2@gmail.com>
References: <1399417087-24772-1-git-send-email-robherring2@gmail.com>
Message-ID: <1399417087-24772-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Salter <msalter@redhat.com>

This patch uses the generic early_ioremap code to implement
early_ioremap for ARM. The ARM-specific bits come mostly from
an earlier patch from Leif Lindholm <leif.lindholm@linaro.org>
here:

  https://lkml.org/lkml/2013/10/3/279

Signed-off-by: Mark Salter <msalter@redhat.com>
Tested-by: Leif Lindholm <leif.lindholm@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
[robh: minor re-work in prep for permanent mappings. Fix bug in page
table allocation size. Rework CONFIG_MMU dependency.]
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/Kconfig              | 11 ++++++
 arch/arm/include/asm/Kbuild   |  1 +
 arch/arm/include/asm/fixmap.h | 21 ++++++++++
 arch/arm/include/asm/io.h     |  1 +
 arch/arm/kernel/setup.c       |  2 +
 arch/arm/mm/Makefile          |  2 +
 arch/arm/mm/early_ioremap.c   | 90 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/mmu.c             |  2 +
 8 files changed, 130 insertions(+)
 create mode 100644 arch/arm/mm/early_ioremap.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db3c541..b33c68b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1891,6 +1891,17 @@ config UACCESS_WITH_MEMCPY
 	  However, if the CPU data cache is using a write-allocate mode,
 	  this option is unlikely to provide any performance gain.
 
+config EARLY_IOREMAP
+	bool "Provide early_ioremap() support for kernel initialization"
+	depends on MMU
+	select GENERIC_EARLY_IOREMAP
+	help
+	  Provide a mechanism for kernel initialisation code to temporarily
+	  map, in a highmem-agnostic way, memory pages in before ioremap()
+	  and friends are available (before paging_init() has run). It uses
+	  the same virtual memory range as kmap so all early mappings must
+	  be unmapped before paging_init() is called.
+
 config SECCOMP
 	bool
 	prompt "Enable seccomp to safely compute untrusted bytecode"
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 23e728e..ec64b55 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += auxvec.h
 generic-y += bitsperlong.h
 generic-y += cputime.h
 generic-y += current.h
+generic-y += early_ioremap.h
 generic-y += emergency-restart.h
 generic-y += errno.h
 generic-y += exec.h
diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index 68ea615..e36020c 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -21,8 +21,29 @@ enum fixed_addresses {
 	FIX_KMAP_BEGIN,
 	FIX_KMAP_END = (FIXADDR_TOP - FIXADDR_START) >> PAGE_SHIFT,
 	__end_of_fixed_addresses
+/*
+ * 224 temporary boot-time mappings, used by early_ioremap(),
+ * before ioremap() is functional.
+ *
+ * (P)re-using the FIXADDR region, which is used for highmem
+ * later on, and statically aligned to 1MB.
+ */
+#define NR_FIX_BTMAPS		32
+#define FIX_BTMAPS_SLOTS	7
+#define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS - FIX_KMAP_BEGIN)
+#define FIX_BTMAP_END		FIX_KMAP_BEGIN
+#define FIX_BTMAP_BEGIN		(FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1)
 };
 
+#define FIXMAP_PAGE_COMMON (L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN)
+
+#define FIXMAP_PAGE_NORMAL (FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
+#define FIXMAP_PAGE_IO	   (FIXMAP_PAGE_COMMON | L_PTE_MT_DEV_SHARED | L_PTE_SHARED | L_PTE_DIRTY)
+#define FIXMAP_PAGE_NOCACHE FIXMAP_PAGE_IO
+
+extern void __early_set_fixmap(enum fixed_addresses idx,
+			       phys_addr_t phys, pgprot_t flags);
+
 #include <asm-generic/fixmap.h>
 
 #endif
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 8aa4cca..637e0cd 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -28,6 +28,7 @@
 #include <asm/byteorder.h>
 #include <asm/memory.h>
 #include <asm-generic/pci_iomap.h>
+#include <asm/early_ioremap.h>
 #include <xen/xen.h>
 
 /*
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 50e198c..7882f04 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -30,6 +30,7 @@
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/sort.h>
+#include <linux/io.h>
 
 #include <asm/unified.h>
 #include <asm/cp15.h>
@@ -883,6 +884,7 @@ void __init setup_arch(char **cmdline_p)
 	const struct machine_desc *mdesc;
 
 	setup_processor();
+	early_ioremap_init();
 	mdesc = setup_machine_fdt(__atags_pointer);
 	if (!mdesc)
 		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 7f39ce2..c6b7b5e 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -12,6 +12,8 @@ ifneq ($(CONFIG_MMU),y)
 obj-y				+= nommu.o
 endif
 
+obj-$(CONFIG_EARLY_IOREMAP)	+= early_ioremap.o
+
 obj-$(CONFIG_ARM_PTDUMP)	+= dump.o
 obj-$(CONFIG_MODULES)		+= proc-syms.o
 
diff --git a/arch/arm/mm/early_ioremap.c b/arch/arm/mm/early_ioremap.c
new file mode 100644
index 0000000..0258a20
--- /dev/null
+++ b/arch/arm/mm/early_ioremap.c
@@ -0,0 +1,90 @@
+/*
+ * early_ioremap() support for ARM
+ *
+ * Based on existing support in arch/x86/mm/ioremap.c
+ *
+ * Restrictions: currently only functional before paging_init()
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <asm/fixmap.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+
+#include <asm/mach/map.h>
+
+static pte_t bm_pte[PTRS_PER_PTE + PTE_HWTABLE_PTRS]
+	__aligned(PTE_HWTABLE_OFF + PTE_HWTABLE_SIZE) __initdata;
+
+static inline pmd_t * __init early_ioremap_pmd(unsigned long addr)
+{
+	unsigned int index = pgd_index(addr);
+	pgd_t *pgd = cpu_get_pgd() + index;
+	pud_t *pud = pud_offset(pgd, addr);
+	pmd_t *pmd = pmd_offset(pud, addr);
+
+	return pmd;
+}
+
+static inline pte_t * __init early_ioremap_pte(unsigned long addr)
+{
+	return &bm_pte[pte_index(addr)];
+}
+
+void __init early_ioremap_init(void)
+{
+	pmd_t *pmd;
+
+	pmd = early_ioremap_pmd(fix_to_virt(FIX_BTMAP_BEGIN));
+
+	pmd_populate_kernel(NULL, pmd, bm_pte);
+
+	/*
+	 * Make sure we don't span multiple pmds.
+	 */
+	BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
+		     != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
+
+	if (pmd != early_ioremap_pmd(fix_to_virt(FIX_BTMAP_END))) {
+		WARN_ON(1);
+		pr_warn("pmd %p != %p\n",
+			pmd, early_ioremap_pmd(fix_to_virt(FIX_BTMAP_END)));
+		pr_warn("fix_to_virt(FIX_BTMAP_BEGIN): %08lx\n",
+			fix_to_virt(FIX_BTMAP_BEGIN));
+		pr_warn("fix_to_virt(FIX_BTMAP_END):   %08lx\n",
+			fix_to_virt(FIX_BTMAP_END));
+		pr_warn("FIX_BTMAP_END:       %d\n", FIX_BTMAP_END);
+		pr_warn("FIX_BTMAP_BEGIN:     %d\n", FIX_BTMAP_BEGIN);
+	}
+
+	early_ioremap_setup();
+}
+
+void __init __early_set_fixmap(enum fixed_addresses idx,
+			       phys_addr_t phys, pgprot_t flags)
+{
+	unsigned long addr = __fix_to_virt(idx);
+	pte_t *pte;
+	u64 desc;
+
+	if (idx > FIX_KMAP_END) {
+		BUG();
+		return;
+	}
+	pte = early_ioremap_pte(addr);
+
+	if (pgprot_val(flags))
+		set_pte_at(NULL, addr, pte, pfn_pte(phys >> PAGE_SHIFT, flags));
+	else
+		pte_clear(NULL, addr, pte);
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	desc = *pte;
+}
+
+void __init early_ioremap_shutdown(void)
+{
+	pmd_clear(early_ioremap_pmd(fix_to_virt(FIX_BTMAP_BEGIN)));
+}
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b68c6b2..9576f87 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -35,6 +35,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/pci.h>
+#include <asm/early_ioremap.h>
 
 #include "mm.h"
 #include "tcm.h"
@@ -1508,6 +1509,7 @@ void __init paging_init(const struct machine_desc *mdesc)
 	prepare_page_table();
 	map_lowmem();
 	dma_contiguous_remap();
+	early_ioremap_reset();
 	devicemaps_init(mdesc);
 	kmap_init();
 	tcm_init();
-- 
1.9.1
