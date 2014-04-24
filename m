From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 24 Apr 2014 11:42:19 -0400
Subject: [PATCH 1/4] ARM: keystone: Switch over to coherent memory address
 space
In-Reply-To: <1398354142-2767-1-git-send-email-santosh.shilimkar@ti.com>
References: <1398354142-2767-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1398354142-2767-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With late code patching updates for LPAE machines has merged now and
memblock conversion from bootmem is on its way, Keystone can switch to
the coherent memory address space which starts beyond 4GB boundary.
The idmap alias needs are managed via virt_to_idmap() for boot purpose.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/keystone.c |   48 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-keystone/memory.h   |   24 +++++++++++++++++++
 arch/arm/mach-keystone/platsmp.c  |   18 +++++++++++++-
 3 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-keystone/memory.h

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index e0b9e1b..155eb06 100644
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
 
@@ -45,6 +48,50 @@ static void __init keystone_init(void)
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
+	__pv_phys_pfn_offset = PFN_DOWN(offset);
+	__pv_offset = (offset - PAGE_OFFSET);
+
+	/* Populate the arch idmap hook */
+	arch_virt_to_idmap = keystone_virt_to_idmap;
+
+	pr_info("Switching to high address space at 0x%llx\n", (u64)offset);
+}
+
 static const char *keystone_match[] __initconst = {
 	"ti,keystone",
 	NULL,
@@ -76,4 +123,5 @@ DT_MACHINE_START(KEYSTONE, "Keystone")
 	.init_machine	= keystone_init,
 	.dt_compat	= keystone_match,
 	.restart	= keystone_restart,
+	.init_meminfo   = keystone_init_meminfo,
 MACHINE_END
diff --git a/arch/arm/mach-keystone/memory.h b/arch/arm/mach-keystone/memory.h
new file mode 100644
index 0000000..b854fb1
--- /dev/null
+++ b/arch/arm/mach-keystone/memory.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright 2014 Texas Instruments, Inc.
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+#ifndef __MEMORY_H
+#define __MEMORY_H
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
+#endif /* __MEMORY_H */
diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
index 5cf0683..5f46a7c 100644
--- a/arch/arm/mach-keystone/platsmp.c
+++ b/arch/arm/mach-keystone/platsmp.c
@@ -17,13 +17,16 @@
 #include <linux/io.h>
 
 #include <asm/smp_plat.h>
+#include <asm/prom.h>
+#include <asm/tlbflush.h>
+#include <asm/pgtable.h>
 
 #include "keystone.h"
 
 static int keystone_smp_boot_secondary(unsigned int cpu,
 						struct task_struct *idle)
 {
-	unsigned long start = virt_to_phys(&secondary_startup);
+	unsigned long start = virt_to_idmap(&secondary_startup);
 	int error;
 
 	pr_debug("keystone-smp: booting cpu %d, vector %08lx\n",
@@ -36,6 +39,19 @@ static int keystone_smp_boot_secondary(unsigned int cpu,
 	return error;
 }
 
+#ifdef CONFIG_ARM_LPAE
+static void __cpuinit keystone_smp_secondary_initmem(unsigned int cpu)
+{
+	pgd_t *pgd0 = pgd_offset_k(0);
+	cpu_set_ttbr(1, __pa(pgd0) + TTBR1_OFFSET);
+	local_flush_tlb_all();
+}
+#else
+static inline void __cpuinit keystone_smp_secondary_initmem(unsigned int cpu)
+{}
+#endif
+
 struct smp_operations keystone_smp_ops __initdata = {
 	.smp_boot_secondary	= keystone_smp_boot_secondary,
+	.smp_secondary_init     = keystone_smp_secondary_initmem,
 };
-- 
1.7.9.5
