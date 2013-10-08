From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Oct 2013 13:45:33 -0400
Subject: [PATCH v3 5/6] ARM: mm: Recreate kernel mappings in
 early_paging_init()
In-Reply-To: <20131008102642.GC17148@mudshark.cambridge.arm.com>
References: <1380835081-12129-1-git-send-email-santosh.shilimkar@ti.com>
 <1380835081-12129-6-git-send-email-santosh.shilimkar@ti.com>
 <20131004155958.GU24303@mudshark.cambridge.arm.com> <524EE8F4.4060407@ti.com>
 <52530CD1.5010309@ti.com> <20131008102642.GC17148@mudshark.cambridge.arm.com>
Message-ID: <525444BD.80304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tuesday 08 October 2013 06:26 AM, Will Deacon wrote:
> On Mon, Oct 07, 2013 at 08:34:41PM +0100, Santosh Shilimkar wrote:
>> Will,
> 
> Hi Santosh,
> 

[..]

>> +void __init early_paging_init(const struct machine_desc *mdesc,
>> +			      struct proc_info_list *procinfo)
>> +{
>> +	pmdval_t pmdprot = procinfo->__cpu_mm_mmu_flags;
>> +	unsigned long map_start, map_end;
>> +	pgd_t *pgd0, *pgdk;
>> +	pud_t *pud0, *pudk, *pud_start;
>> +	pmd_t *pmd0, *pmdk, *pmd_start;
>> +	phys_addr_t phys;
>> +	int i;
>> +
>> +	/* remap kernel code and data */
>> +	map_start = init_mm.start_code;
>> +	map_end   = init_mm.brk;
>> +
>> +	/* get a handle on things... */
>> +	pgd0 = pgd_offset_k(0);
>> +	pud_start = pud0 = pud_offset(pgd0, 0);
>> +	pmd0 = pmd_offset(pud0, 0);
>> +
>> +	pgdk = pgd_offset_k(map_start);
>> +	pudk = pud_offset(pgdk, map_start);
>> +	pmd_start = pmdk = pmd_offset(pudk, map_start);
>> +
>> +	phys = PHYS_OFFSET;
>> +
>> +	if (mdesc->init_meminfo) {
>> +		mdesc->init_meminfo();
>> +		/* Run the patch stub to update the constants */
>> +		fixup_pv_table(&__pv_table_begin,
>> +			(&__pv_table_end - &__pv_table_begin) << 2);
>> +
>> +		/*
>> +		 * Cache cleaning operations for self-modifying code
>> +		 * We should clean the entries by MVA but running a
>> +		 * for loop over every pv_table entry pointer would
>> +		 * just complicate the code. isb() is added to commit
>> +		 * all the prior cp15 operations.
>> +		 */
>> +		flush_cache_louis();
>> +		isb();
> 
> I see, you need the new __pv_tables to be visible for your page table
> population below, right? In which case, I'm afraid I have to go back on my
> original statement; you *do* need that dsb() prior to the isb() if you want
> to ensure that the icache maintenance is complete and synchronised.
> 
Need of dsb and isb is what ARM ARM says but then I got bit biased after
your reply. 

> However, this really looks like an issue with the v7 cache flushing
> routines. Why on Earth do they only guarantee completion on the D-side?
> 
Indeed.

>> +	}
>> +
>> +	/* remap level 1 table */
>> +	for (i = 0; i < PTRS_PER_PGD; i++) {
>> +		*pud0++ = __pud(__pa(pmd0) | PMD_TYPE_TABLE | L_PGD_SWAPPER);
>> +		pmd0 += PTRS_PER_PMD;
>> +	}
>> +
>> +	__cpuc_flush_dcache_area(pud_start, sizeof(pud_start) * PTRS_PER_PGD);
>> +	outer_clean_range(virt_to_phys(pud_start), sizeof(pud_start) * PTRS_PER_PGD);
> 
> You don't need to flush these page tables if you're SMP. If you use
> clean_dcache_area instead, it will do the right thing. The again, why can't
> you use pud_populate and pmd_populate for these two loops? Is there an
> interaction with coherency here? (if so, why don't you need to flush the
> entire cache hierarchy anyway?)
> 
You mean AMRMv7 SMP PT walkers can read from L1 cache and hence doesn't need 
flushing L1. While this could be true, for some reason we don't the same
behavior and seeing that without flush we are seeing the issue.

Initially we were doing entire cache flush but moved to the mva based
routines on your suggestion.

Regarding the pud_populate(), since we needed L_PGD_SWAPPER, we couldn't
use that version but updated patch uses the set_pud() which takes the flag.
And pmd_populate() can't be used either because it creates pte based
tables which is not what we want.

So the current working patch as it stands is end of the email. Do let
us know if we are missing anything for the PTW L1 allocation behavior.

Regards,
Santosh


>From 832ea2ba84ad8a012ec7d4dad4d8085cca2cd598 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Wed, 31 Jul 2013 12:44:46 -0400
Subject: [PATCH v3 5/8] ARM: mm: Recreate kernel mappings in
 early_paging_init()

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

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/mach/arch.h |    1 +
 arch/arm/kernel/setup.c          |    4 ++
 arch/arm/mm/mmu.c                |   91 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 402a2bc..17a3fa2 100644
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
index 0e1e2b3..af7b7db 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -73,6 +73,8 @@ __setup("fpe=", fpe_setup);
 #endif
 
 extern void paging_init(const struct machine_desc *desc);
+extern void early_paging_init(const struct machine_desc *,
+			      struct proc_info_list *);
 extern void sanity_check_meminfo(void);
 extern enum reboot_mode reboot_mode;
 extern void setup_dma_zone(const struct machine_desc *desc);
@@ -878,6 +880,8 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 
 	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
+
+	early_paging_init(mdesc, lookup_processor_type(read_cpuid_id()));
 	sanity_check_meminfo();
 	arm_memblock_init(&meminfo, mdesc);
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b1d17ee..e9e5276 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -28,6 +28,7 @@
 #include <asm/highmem.h>
 #include <asm/system_info.h>
 #include <asm/traps.h>
+#include <asm/procinfo.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -1315,6 +1316,96 @@ static void __init map_lowmem(void)
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
+void __init early_paging_init(const struct machine_desc *mdesc,
+			      struct proc_info_list *procinfo)
+{
+	pmdval_t pmdprot = procinfo->__cpu_mm_mmu_flags;
+	unsigned long map_start, map_end;
+	pgd_t *pgd0, *pgdk;
+	pud_t *pud0, *pudk, *pud_start;
+	pmd_t *pmd0, *pmdk, *pmd_start;
+	phys_addr_t phys;
+	int i;
+
+	/* remap kernel code and data */
+	map_start = init_mm.start_code;
+	map_end   = init_mm.brk;
+
+	/* get a handle on things... */
+	pgd0 = pgd_offset_k(0);
+	pud_start = pud0 = pud_offset(pgd0, 0);
+	pmd0 = pmd_offset(pud0, 0);
+
+	pgdk = pgd_offset_k(map_start);
+	pudk = pud_offset(pgdk, map_start);
+	pmd_start = pmdk = pmd_offset(pudk, map_start);
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
+	for (i = 0; i < PTRS_PER_PGD; pud0++, i++) {
+		set_pud(pud0,
+			__pud(__pa(pmd0) | PMD_TYPE_TABLE | L_PGD_SWAPPER));
+		pmd0 += PTRS_PER_PMD;
+	}
+
+	__cpuc_flush_dcache_area(pud_start, sizeof(pud_start) * PTRS_PER_PGD);
+	outer_clean_range(virt_to_phys(pud_start),
+			  sizeof(pud_start) * PTRS_PER_PGD);
+
+	/* remap pmds for kernel mapping */
+	phys = __pa(map_start) & PMD_MASK;
+	i = 0;
+	do {
+		*pmdk++ = __pmd(phys | pmdprot);
+		phys += PMD_SIZE;
+		i++;
+	} while (phys < map_end);
+
+	__cpuc_flush_dcache_area(pmd_start, sizeof(pmd_start) * i);
+	outer_clean_range(virt_to_phys(pmd_start),
+			  sizeof(pmd_start) * i);
+
+	cpu_switch_mm(pgd0, &init_mm);
+	cpu_set_ttbr(1, __pa(pgd0) + TTBR1_OFFSET);
+	local_flush_bp_all();
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
