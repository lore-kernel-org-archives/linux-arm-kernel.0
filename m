From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 31 Jul 2013 12:44:46 -0400
Subject: [PATCH v2 6/6] ARM: mm: Recreate kernel mappings in
 early_paging_init()
In-Reply-To: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375289086-5315-7-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a step in the init sequence, in order to recreate
the kernel code/data page table mappings prior to full paging
initialization.  This is necessary on LPAE systems that run out of
a physical address space outside the 4G limit.  On these systems,
this implementation provides a machine descriptor hook that allows
the PHYS_OFFSET to be overridden in a machine specific fashion.

Based on Cyril's initial patch. The pv_table needs to be patched
again after switching to higher address space.

Cc: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/mach/arch.h |    1 +
 arch/arm/kernel/setup.c          |    3 ++
 arch/arm/mm/mmu.c                |   82 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 441efc4..8fa734f 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -49,6 +49,7 @@ struct machine_desc {
 	bool			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **,
 					 struct meminfo *);
+	void			(*init_meminfo)(void);
 	void			(*reserve)(void);/* reserve mem blocks	*/
 	void			(*map_io)(void);/* IO mapping function	*/
 	void			(*init_early)(void);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 63af9a7..a554d7e 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -72,6 +72,7 @@ static int __init fpe_setup(char *line)
 __setup("fpe=", fpe_setup);
 #endif
 
+extern void early_paging_init(struct machine_desc *, struct proc_info_list *);
 extern void paging_init(struct machine_desc *desc);
 extern void sanity_check_meminfo(void);
 extern enum reboot_mode reboot_mode;
@@ -876,6 +877,8 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 
 	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
+
+	early_paging_init(mdesc, lookup_processor_type(read_cpuid_id()));
 	sanity_check_meminfo();
 	arm_memblock_init(&meminfo, mdesc);
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4f56617..7910656 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -28,6 +28,7 @@
 #include <asm/highmem.h>
 #include <asm/system_info.h>
 #include <asm/traps.h>
+#include <asm/procinfo.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -1268,6 +1269,87 @@ static void __init map_lowmem(void)
 	}
 }
 
+#ifdef CONFIG_ARM_LPAE
+extern void fixup_pv_table(const void *, unsigned long);
+extern const void *__pv_table_begin, *__pv_table_end;
+
+/*
+ * early_paging_init() recreates boot time page table setup, allowing machines
+ * to switch over to a high (>4G) address space on LPAE systems
+ */
+void __init early_paging_init(struct machine_desc *mdesc,
+			      struct proc_info_list *procinfo)
+{
+	pmdval_t pmdprot = procinfo->__cpu_mm_mmu_flags;
+	unsigned long map_start, map_end;
+	pgd_t *pgd0, *pgdk;
+	pud_t *pud0, *pudk;
+	pmd_t *pmd0, *pmdk;
+	phys_addr_t phys;
+	int i;
+
+	/* remap kernel code and data */
+	map_start = init_mm.start_code;
+	map_end   = init_mm.brk;
+
+	/* get a handle on things... */
+	pgd0 = pgd_offset_k(0);
+	pud0 = pud_offset(pgd0, 0);
+	pmd0 = pmd_offset(pud0, 0);
+
+	pgdk = pgd_offset_k(map_start);
+	pudk = pud_offset(pgdk, map_start);
+	pmdk = pmd_offset(pudk, map_start);
+
+	phys = PHYS_OFFSET;
+
+	if (mdesc->init_meminfo) {
+		mdesc->init_meminfo();
+		/* Run the patch stub to update the constants */
+		fixup_pv_table(&__pv_table_begin,
+			(&__pv_table_end - &__pv_table_begin) << 2);
+
+		/*
+		 * Cache cleaning operations for self-modifying code
+		 * We should clean the entries by MVA but running a
+		 * for loop over every pv_table entry pointer would
+		 * just complicate the code.
+		 */
+		flush_cache_louis();
+		dsb();
+		isb();
+	}
+
+	/* remap level 1 table */
+	for (i = 0; i < PTRS_PER_PGD; i++) {
+		*pud0++ = __pud(__pa(pmd0) | PMD_TYPE_TABLE | L_PGD_SWAPPER);
+		pmd0 += PTRS_PER_PMD;
+	}
+
+	/* remap pmds for kernel mapping */
+	phys = __pa(map_start) & PMD_MASK;
+	do {
+		*pmdk++ = __pmd(phys | pmdprot);
+		phys += PMD_SIZE;
+	} while (phys < map_end);
+
+	flush_cache_all();
+	cpu_set_ttbr(0, __pa(pgd0));
+	cpu_set_ttbr(1, __pa(pgd0) + TTBR1_OFFSET);
+	local_flush_tlb_all();
+}
+
+#else
+
+void __init early_paging_init(struct machine_desc *mdesc,
+			      struct proc_info_list *procinfo)
+{
+	if (mdesc->init_meminfo)
+		mdesc->init_meminfo();
+}
+
+#endif
+
 /*
  * paging_init() sets up the page tables, initialises the zone memory
  * maps, and sets up the zero page, bad page and bad page tables.
-- 
1.7.9.5
