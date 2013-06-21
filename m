From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 21 Jun 2013 19:48:22 -0400
Subject: [PATCH 8/8] ARM: keystone: Switch over to high physical address range
In-Reply-To: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
References: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1371858502-10083-9-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone platforms have their physical memory mapped at an address outside the
32-bit physical range.  A Keystone machine with 16G of RAM would find its
memory at 0x0800000000 - 0x0bffffffff.

For boot purposes, the interconnect supports a limited alias of some of this
memory within the 32-bit addressable space (0x80000000 - 0xffffffff).  This
aliasing is implemented in hardware, and is not intended to be used much
beyond boot.  For instance, DMA coherence does not work when running out of
this aliased address space.

Therefore, a two pahsed boot approach is implemented.
1) Boot out of the low physical address range
2) Switch over to the high range once we're safely inside machine
 initialization.

This patch implements this switch over mechanism, which involves rewiring
the TTBRs and page tables to point to the new physical address space.
Based on earlier patch version from Cyril.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/keystone.c |   49 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-keystone/memory.h   |   24 ++++++++++++++++++
 arch/arm/mach-keystone/platsmp.c  |   16 +++++++++++-
 3 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-keystone/memory.h

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index fe4d9ff..90442bb 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -20,6 +20,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/smp_plat.h>
+#include <asm/memory.h>
+
+#include "memory.h"
 
 #include "keystone.h"
 
@@ -44,6 +47,51 @@ static void __init keystone_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
+static phys_addr_t keystone_virt_to_idmap(unsigned long x)
+{
+	return (phys_addr_t)(x) - CONFIG_PAGE_OFFSET + KEYSTONE_LOW_PHYS_START;
+}
+
+static void __init keystone_init_meminfo(void)
+{
+	bool lpae = IS_ENABLED(CONFIG_ARM_LPAE);
+	bool pvpatch = IS_ENABLED(CONFIG_ARM_PATCH_PHYS_VIRT);
+	phys_addr_t offset = PHYS_OFFSET - KEYSTONE_LOW_PHYS_START;
+	phys_addr_t mem_start, mem_end;
+
+	BUG_ON(meminfo.nr_banks < 1);
+	mem_start = meminfo.bank[0].start;
+	mem_end = mem_start + meminfo.bank[0].size - 1;
+
+	/* nothing to do if we are running out of the <32-bit space */
+	if (mem_start >= KEYSTONE_LOW_PHYS_START &&
+	    mem_end   <= KEYSTONE_LOW_PHYS_END)
+		return;
+
+	if (!lpae || !pvpatch) {
+		pr_crit("Enable %s%s%s to run outside 32-bit space\n",
+		      !lpae ? __stringify(CONFIG_ARM_LPAE) : "",
+		      (!lpae && !pvpatch) ? " and " : "",
+		      !pvpatch ? __stringify(CONFIG_ARM_PATCH_PHYS_VIRT) : "");
+	}
+
+	if (mem_start < KEYSTONE_HIGH_PHYS_START ||
+	    mem_end   > KEYSTONE_HIGH_PHYS_END) {
+		pr_crit("Invalid address space for memory (%08llx-%08llx)\n",
+		      (u64)mem_start, (u64)mem_end);
+	}
+
+	offset += KEYSTONE_HIGH_PHYS_START;
+	__pv_phys_offset = offset;
+	__pv_offset = (offset - PAGE_OFFSET);
+	__pv_offset >>= PV_LOW_SHIFT;
+
+	/* Populate the arch idmap hook */
+	arch_virt_to_idmap = keystone_virt_to_idmap;
+
+	pr_info("Switching to high address space at 0x%llx\n", (u64)offset);
+}
+
 static const char *keystone_match[] __initconst = {
 	"ti,keystone-evm",
 	NULL,
@@ -72,4 +120,5 @@ DT_MACHINE_START(KEYSTONE, "Keystone")
 	.init_machine	= keystone_init,
 	.dt_compat	= keystone_match,
 	.restart	= keystone_restart,
+	.init_meminfo   = keystone_init_meminfo,
 MACHINE_END
diff --git a/arch/arm/mach-keystone/memory.h b/arch/arm/mach-keystone/memory.h
new file mode 100644
index 0000000..83fc5a9
--- /dev/null
+++ b/arch/arm/mach-keystone/memory.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright 2013 Texas Instruments, Inc.
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+#ifndef __MACH_MEMORY_H
+#define __MACH_MEMORY_H
+
+#define MAX_PHYSMEM_BITS	36
+#define SECTION_SIZE_BITS	34
+
+#define KEYSTONE_LOW_PHYS_START		0x80000000ULL
+#define KEYSTONE_LOW_PHYS_SIZE		0x80000000ULL /* 2G */
+#define KEYSTONE_LOW_PHYS_END		(KEYSTONE_LOW_PHYS_START + \
+					 KEYSTONE_LOW_PHYS_SIZE - 1)
+
+#define KEYSTONE_HIGH_PHYS_START	0x800000000ULL
+#define KEYSTONE_HIGH_PHYS_SIZE		0x400000000ULL	/* 16G */
+#define KEYSTONE_HIGH_PHYS_END		(KEYSTONE_HIGH_PHYS_START + \
+					 KEYSTONE_HIGH_PHYS_SIZE - 1)
+#endif /* _MACH_MEMORY_H */
diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
index 1d4181e..4be8ea2 100644
--- a/arch/arm/mach-keystone/platsmp.c
+++ b/arch/arm/mach-keystone/platsmp.c
@@ -18,13 +18,15 @@
 
 #include <asm/smp_plat.h>
 #include <asm/prom.h>
+#include <asm/tlbflush.h>
+#include <asm/pgtable.h>
 
 #include "keystone.h"
 
 static int __cpuinit keystone_smp_boot_secondary(unsigned int cpu,
 						struct task_struct *idle)
 {
-	unsigned long start = virt_to_phys(&secondary_startup);
+	unsigned long start = virt_to_idmap(&secondary_startup);
 	int error;
 
 	pr_debug("keystone-smp: booting cpu %d, vector %08lx\n",
@@ -37,7 +39,19 @@ static int __cpuinit keystone_smp_boot_secondary(unsigned int cpu,
 	return error;
 }
 
+static void __cpuinit keystone_smp_secondary_initmem(unsigned int cpu)
+{
+	bool lpae = IS_ENABLED(CONFIG_ARM_LPAE);
+
+	if (lpae) {
+		pgd_t *pgd0 = pgd_offset_k(0);
+		cpu_set_ttbr(1, __pa(pgd0) + TTBR1_OFFSET);
+		local_flush_tlb_all();
+	}
+}
+
 struct smp_operations keystone_smp_ops __initdata = {
 	.smp_init_cpus		= arm_dt_init_cpu_maps,
 	.smp_boot_secondary	= keystone_smp_boot_secondary,
+	.smp_secondary_init     = keystone_smp_secondary_initmem,
 };
-- 
1.7.9.5
