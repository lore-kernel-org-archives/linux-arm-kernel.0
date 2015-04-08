From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 08 Apr 2015 10:45:35 +0100
Subject: [PATCH 6/6] ARM: cleanup early_paging_init() calling
In-Reply-To: <20150408094438.GM12732@n2100.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
Message-ID: <E1YfmYB-0006X7-4U@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eliminate the needless nommu version of this function, and get rid of
the proc_info_list structure argument - we no longer need this in order
to fix up the page table entries.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/setup.c | 7 ++++---
 arch/arm/mm/mmu.c       | 6 ++----
 arch/arm/mm/nommu.c     | 9 ---------
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 6c777e908a24..979c1c5fe96a 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -75,8 +75,7 @@ __setup("fpe=", fpe_setup);
 
 extern void init_default_cache_policy(unsigned long);
 extern void paging_init(const struct machine_desc *desc);
-extern void early_paging_init(const struct machine_desc *,
-			      struct proc_info_list *);
+extern void early_paging_init(const struct machine_desc *);
 extern void sanity_check_meminfo(void);
 extern enum reboot_mode reboot_mode;
 extern void setup_dma_zone(const struct machine_desc *desc);
@@ -936,7 +935,9 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
-	early_paging_init(mdesc, lookup_processor_type(read_cpuid_id()));
+#ifdef CONFIG_MMU
+	early_paging_init(mdesc);
+#endif
 	setup_dma_zone(mdesc);
 	sanity_check_meminfo();
 	arm_memblock_init(mdesc);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index addb7987c714..b2e96bc9d74a 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1396,8 +1396,7 @@ pgtables_remap lpae_pgtables_remap_asm;
  * early_paging_init() recreates boot time page table setup, allowing machines
  * to switch over to a high (>4G) address space on LPAE systems
  */
-void __init early_paging_init(const struct machine_desc *mdesc,
-			      struct proc_info_list *procinfo)
+void __init early_paging_init(const struct machine_desc *mdesc)
 {
 	pgtables_remap *lpae_pgtables_remap;
 	unsigned long pa_pgd;
@@ -1460,8 +1459,7 @@ void __init early_paging_init(const struct machine_desc *mdesc,
 
 #else
 
-void __init early_paging_init(const struct machine_desc *mdesc,
-			      struct proc_info_list *procinfo)
+void __init early_paging_init(const struct machine_desc *mdesc)
 {
 	long long offset;
 
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index a014dfacd5ca..afd7e05d95f1 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -304,15 +304,6 @@ void __init sanity_check_meminfo(void)
 }
 
 /*
- * early_paging_init() recreates boot time page table setup, allowing machines
- * to switch over to a high (>4G) address space on LPAE systems
- */
-void __init early_paging_init(const struct machine_desc *mdesc,
-			      struct proc_info_list *procinfo)
-{
-}
-
-/*
  * paging_init() sets up the page tables, initialises the zone memory
  * maps, and sets up the zero page, bad page and bad page tables.
  */
-- 
1.8.3.1
