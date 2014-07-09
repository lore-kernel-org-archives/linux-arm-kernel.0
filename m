From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed,  9 Jul 2014 10:39:52 +0100
Subject: [PATCH 2/2] arm: add early_ioremap support
In-Reply-To: <1404898792-4201-1-git-send-email-leif.lindholm@linaro.org>
References: <1404898792-4201-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1404898792-4201-3-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Salter <msalter@redhat.com>

This patch uses the generic early_ioremap code to implement
early_ioremap for ARM. The ARM-specific bits come mostly from
an earlier patch from Leif Lindholm <leif.lindholm@linaro.org>
here:

  https://lkml.org/lkml/2013/10/3/279

Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Tested-by: Leif Lindholm <leif.lindholm@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
CC: linux-arm-kernel at lists.infradead.org
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig            |   11 ++++++
 arch/arm/include/asm/Kbuild |    1 +
 arch/arm/include/asm/io.h   |    1 +
 arch/arm/kernel/setup.c     |    3 ++
 arch/arm/mm/Makefile        |    1 +
 arch/arm/mm/early_ioremap.c |   86 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/mmu.c           |    2 +
 7 files changed, 105 insertions(+)
 create mode 100644 arch/arm/mm/early_ioremap.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 245058b..04b8f8a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1800,6 +1800,17 @@ config UACCESS_WITH_MEMCPY
 	  However, if the CPU data cache is using a write-allocate mode,
 	  this option is unlikely to provide any performance gain.
 
+config EARLY_IOREMAP
+	depends on MMU
+	bool "Provide early_ioremap() support for kernel initialization."
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
index f5a3576..0bc5a02 100644
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
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 3d23418..7b8a981 100644
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
index 8a16ee5..aa2621a 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -36,6 +36,7 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/elf.h>
+#include <asm/io.h>
 #include <asm/procinfo.h>
 #include <asm/psci.h>
 #include <asm/sections.h>
@@ -894,6 +895,8 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	early_ioremap_init();
+
 	early_paging_init(mdesc, lookup_processor_type(read_cpuid_id()));
 	setup_dma_zone(mdesc);
 	sanity_check_meminfo();
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 91da64d..1c8ce752 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_ARM_PTDUMP)	+= dump.o
 obj-$(CONFIG_MODULES)		+= proc-syms.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
+obj-$(CONFIG_EARLY_IOREMAP)	+= early_ioremap.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 
diff --git a/arch/arm/mm/early_ioremap.c b/arch/arm/mm/early_ioremap.c
new file mode 100644
index 0000000..1013109
--- /dev/null
+++ b/arch/arm/mm/early_ioremap.c
@@ -0,0 +1,86 @@
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
+static pte_t bm_pte[PTRS_PER_PTE] __aligned(PTE_HWTABLE_SIZE) __initdata;
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
+	pmd_populate_kernel(NULL, pmd, bm_pte);
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
+		set_pte_at(NULL, addr, pte,
+			   pfn_pte(phys >> PAGE_SHIFT, flags));
+	else
+		pte_clear(NULL, addr, pte);
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	desc = *pte;
+}
+
+void __init
+early_ioremap_shutdown(void)
+{
+	pmd_t *pmd = early_ioremap_pmd(fix_to_virt(FIX_BTMAP_BEGIN));
+
+	pmd_clear(pmd);
+}
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ab14b79..608dc36 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -36,6 +36,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/pci.h>
 #include <asm/fixmap.h>
+#include <asm/early_ioremap.h>
 
 #include "mm.h"
 #include "tcm.h"
@@ -1474,6 +1475,7 @@ void __init paging_init(const struct machine_desc *mdesc)
 {
 	void *zero_page;
 
+	early_ioremap_reset();
 	build_mem_type_table();
 	prepare_page_table();
 	map_lowmem();
-- 
1.7.10.4
