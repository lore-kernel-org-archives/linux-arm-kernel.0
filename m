From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 08 Apr 2015 10:45:14 +0100
Subject: [PATCH 2/6] ARM: keystone2: move update of the phys-to-virt constants
 into generic code
In-Reply-To: <20150408094438.GM12732@n2100.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
Message-ID: <E1YfmXq-0006Wr-M7@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the init_meminfo function return the offset to be applied to the
phys-to-virt translation constants.  This allows us to move the update
into generic code, along with the requirements for this update.

This avoids platforms having to know the details of the phys-to-virt
translation support.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/arch.h  |  2 +-
 arch/arm/mach-keystone/keystone.c | 27 ++++++++++-----------------
 arch/arm/mm/mmu.c                 | 26 ++++++++++++++++++++++----
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 0406cb3f1af7..e881913f7c3e 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -51,7 +51,7 @@ struct machine_desc {
 	bool			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **);
 	void			(*dt_fixup)(void);
-	void			(*init_meminfo)(void);
+	long long		(*init_meminfo)(void);
 	void			(*reserve)(void);/* reserve mem blocks	*/
 	void			(*map_io)(void);/* IO mapping function	*/
 	void			(*init_early)(void);
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 3d58a8f4dc7e..baa0fbc9803a 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -68,11 +68,9 @@ static phys_addr_t keystone_virt_to_idmap(unsigned long x)
 	return (phys_addr_t)(x) - CONFIG_PAGE_OFFSET + KEYSTONE_LOW_PHYS_START;
 }
 
-static void __init keystone_init_meminfo(void)
+static long long __init keystone_init_meminfo(void)
 {
-	bool lpae = IS_ENABLED(CONFIG_ARM_LPAE);
-	bool pvpatch = IS_ENABLED(CONFIG_ARM_PATCH_PHYS_VIRT);
-	phys_addr_t offset = PHYS_OFFSET - KEYSTONE_LOW_PHYS_START;
+	long long offset;
 	phys_addr_t mem_start, mem_end;
 
 	mem_start = memblock_start_of_DRAM();
@@ -81,29 +79,24 @@ static void __init keystone_init_meminfo(void)
 	/* nothing to do if we are running out of the <32-bit space */
 	if (mem_start >= KEYSTONE_LOW_PHYS_START &&
 	    mem_end   <= KEYSTONE_LOW_PHYS_END)
-		return;
-
-	if (!lpae || !pvpatch) {
-		pr_crit("Enable %s%s%s to run outside 32-bit space\n",
-		      !lpae ? __stringify(CONFIG_ARM_LPAE) : "",
-		      (!lpae && !pvpatch) ? " and " : "",
-		      !pvpatch ? __stringify(CONFIG_ARM_PATCH_PHYS_VIRT) : "");
-	}
+		return 0;
 
 	if (mem_start < KEYSTONE_HIGH_PHYS_START ||
 	    mem_end   > KEYSTONE_HIGH_PHYS_END) {
 		pr_crit("Invalid address space for memory (%08llx-%08llx)\n",
-		      (u64)mem_start, (u64)mem_end);
+		        (u64)mem_start, (u64)mem_end);
+		return 0;
 	}
 
-	offset += KEYSTONE_HIGH_PHYS_START;
-	__pv_phys_pfn_offset = PFN_DOWN(offset);
-	__pv_offset = (offset - PAGE_OFFSET);
+	offset = KEYSTONE_HIGH_PHYS_START - KEYSTONE_LOW_PHYS_START;
 
 	/* Populate the arch idmap hook */
 	arch_virt_to_idmap = keystone_virt_to_idmap;
 
-	pr_info("Switching to high address space at 0x%llx\n", (u64)offset);
+	pr_info("Switching to high address space at 0x%llx\n",
+	        (u64)PHYS_OFFSET + (u64)offset);
+
+	return offset;
 }
 
 static const char *const keystone_match[] __initconst = {
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4e6ef896c619..71563fdf298c 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1387,7 +1387,7 @@ static void __init map_lowmem(void)
 	}
 }
 
-#ifdef CONFIG_ARM_LPAE
+#if defined(CONFIG_ARM_LPAE) && defined(CONFIG_ARM_PATCH_PHYS_VIRT)
 /*
  * early_paging_init() recreates boot time page table setup, allowing machines
  * to switch over to a high (>4G) address space on LPAE systems
@@ -1397,6 +1397,7 @@ void __init early_paging_init(const struct machine_desc *mdesc,
 {
 	pmdval_t pmdprot = procinfo->__cpu_mm_mmu_flags;
 	unsigned long map_start, map_end;
+	long long offset;
 	pgd_t *pgd0, *pgdk;
 	pud_t *pud0, *pudk, *pud_start;
 	pmd_t *pmd0, *pmdk;
@@ -1419,7 +1420,13 @@ void __init early_paging_init(const struct machine_desc *mdesc,
 	pudk = pud_offset(pgdk, map_start);
 	pmdk = pmd_offset(pudk, map_start);
 
-	mdesc->init_meminfo();
+	offset = mdesc->init_meminfo();
+	if (offset == 0)
+		return;
+
+	/* Re-set the phys pfn offset, and the pv offset */
+	__pv_offset = PHYS_OFFSET + offset - PAGE_OFFSET;
+	__pv_phys_pfn_offset = PFN_DOWN(PHYS_OFFSET + offset);
 
 	/* Run the patch stub to update the constants */
 	fixup_pv_table(&__pv_table_begin,
@@ -1502,8 +1509,19 @@ void __init early_paging_init(const struct machine_desc *mdesc,
 void __init early_paging_init(const struct machine_desc *mdesc,
 			      struct proc_info_list *procinfo)
 {
-	if (mdesc->init_meminfo)
-		mdesc->init_meminfo();
+	long long offset;
+
+	if (!mdesc->init_meminfo)
+		return;
+
+	offset = mdesc->init_meminfo();
+	if (offset == 0)
+		return;
+
+	pr_crit("Physical address space modification is only to support Keystone2.\n");
+	pr_crit("Please enable ARM_LPAE and ARM_PATCH_PHYS_VIRT support to use this\n");
+	pr_crit("feature. Your kernel may crash now, have a good day.\n");
+	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 }
 
 #endif
-- 
1.8.3.1
