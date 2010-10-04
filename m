From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Oct 2010 18:09:23 +0100
Subject: [PATCH 02/10] ARM: hotplug cpu: setup 1:1 map for entire kernel image
	for secondary CPUs
Message-ID: <E1P2oXT-00020I-MY@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the entire kernel image available for secondary CPUs rather
than just the first MB of memory.  This allows the startup code
to appear in the cpuinit sections.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c |   63 ++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 40dc74f..1407054 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -33,6 +33,7 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/processor.h>
+#include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/ptrace.h>
 #include <asm/localtimer.h>
@@ -67,12 +68,47 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 };
 
+static inline void identity_mapping_add(pgd_t *pgd, unsigned long start,
+	unsigned long end)
+{
+	unsigned long addr, prot;
+	pmd_t *pmd;
+
+	prot = PMD_TYPE_SECT | PMD_SECT_AP_WRITE;
+	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
+		prot |= PMD_BIT4;
+
+	for (addr = start & PGDIR_MASK; addr < end;) {
+		pmd = pmd_offset(pgd + pgd_index(addr), addr);
+		pmd[0] = __pmd(addr | prot);
+		addr += SECTION_SIZE;
+		pmd[1] = __pmd(addr | prot);
+		addr += SECTION_SIZE;
+		flush_pmd_entry(pmd);
+		outer_clean_range(__pa(pmd), __pa(pmd + 1));
+	}
+}
+
+static inline void identity_mapping_del(pgd_t *pgd, unsigned long start,
+	unsigned long end)
+{
+	unsigned long addr;
+	pmd_t *pmd;
+
+	for (addr = start & PGDIR_MASK; addr < end; addr += PGDIR_SIZE) {
+		pmd = pmd_offset(pgd + pgd_index(addr), addr);
+		pmd[0] = __pmd(0);
+		pmd[1] = __pmd(0);
+		clean_pmd_entry(pmd);
+		outer_clean_range(__pa(pmd), __pa(pmd + 1));
+	}
+}
+
 int __cpuinit __cpu_up(unsigned int cpu)
 {
 	struct cpuinfo_arm *ci = &per_cpu(cpu_data, cpu);
 	struct task_struct *idle = ci->idle;
 	pgd_t *pgd;
-	pmd_t *pmd;
 	int ret;
 
 	/*
@@ -101,11 +137,16 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	 * a 1:1 mapping for the physical address of the kernel.
 	 */
 	pgd = pgd_alloc(&init_mm);
-	pmd = pmd_offset(pgd + pgd_index(PHYS_OFFSET), PHYS_OFFSET);
-	*pmd = __pmd((PHYS_OFFSET & PGDIR_MASK) |
-		     PMD_TYPE_SECT | PMD_SECT_AP_WRITE);
-	flush_pmd_entry(pmd);
-	outer_clean_range(__pa(pmd), __pa(pmd + 1));
+	if (!pgd)
+		return -ENOMEM;
+
+	if (PHYS_OFFSET != PAGE_OFFSET) {
+#ifndef CONFIG_HOTPLUG_CPU
+		identity_mapping_add(pgd, __pa(__init_begin), __pa(__init_end));
+#endif
+		identity_mapping_add(pgd, __pa(_stext), __pa(_etext));
+		identity_mapping_add(pgd, __pa(_sdata), __pa(_edata));
+	}
 
 	/*
 	 * We need to tell the secondary core where to find
@@ -143,8 +184,14 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	secondary_data.stack = NULL;
 	secondary_data.pgdir = 0;
 
-	*pmd = __pmd(0);
-	clean_pmd_entry(pmd);
+	if (PHYS_OFFSET != PAGE_OFFSET) {
+#ifndef CONFIG_HOTPLUG_CPU
+		identity_mapping_del(pgd, __pa(__init_begin), __pa(__init_end));
+#endif
+		identity_mapping_del(pgd, __pa(_stext), __pa(_etext));
+		identity_mapping_del(pgd, __pa(_sdata), __pa(_edata));
+	}
+
 	pgd_free(&init_mm, pgd);
 
 	if (ret) {
-- 
1.6.2.5
