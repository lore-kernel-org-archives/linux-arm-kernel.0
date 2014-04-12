From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Apr 2014 21:16:40 -0400
Subject: commit b3a977b224 {ARM: Better virt_to_page() handling} breaks
 Keystone boot
In-Reply-To: <alpine.LFD.2.11.1404112036470.980@knanqh.ubzr>
References: <53487A9E.70805@ti.com>
 <alpine.LFD.2.11.1404112011320.980@knanqh.ubzr>
 <20140412002401.GS16119@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1404112036470.980@knanqh.ubzr>
Message-ID: <534893F8.30309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 April 2014 08:38 PM, Nicolas Pitre wrote:
> On Sat, 12 Apr 2014, Russell King - ARM Linux wrote:
> 
>> On Fri, Apr 11, 2014 at 08:13:23PM -0400, Nicolas Pitre wrote:
>>> On Fri, 11 Apr 2014, Santosh Shilimkar wrote:
>>>
>>>> Russell,
>>>>
>>>> The subject commit breaks Keystone boot with higher address space enabled.
>>>> I haven't debugged it further but reverting that patch makes it boot again.
>>>>
>>>> I will further look at it on Monday, but thought of letting you know.
>>>
>>> See my comment at the bottom of this email which might be the cause:
>>>
>>> http://article.gmane.org/gmane.linux.ports.arm.kernel/312721
>>
>> I still don't see the relevance.  Nothing touches __pv_phys_offset
>> after we've booted.  From what I can see, this stuff remains incomplete
>> for Keystone.
> 
> It certainly looks incomplete, and some out-of-tree might need adjusting 
> as mentioned before.
> 
Sure. Here is the link[1] for the address switch patch. also attached.
I should have merged this already but was waiting to sort out dma-ranges
thinking to solve that one remainder issue before merging.

In subject I mentioned a wrong commit id of your patch. It should have
been 'e26a9e00a'

Regards,
Santosh
[1] https://git.kernel.org/cgit/linux/kernel/git/ssantosh/linux-keystone.git/commit/?h=for_3.15/dma-ranges_v4-04&id=b9ae04710e2a9685ce2c0f5ec9676b86e5308a67

-------------- next part --------------
>From b9ae04710e2a9685ce2c0f5ec9676b86e5308a67 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 13 Jun 2013 19:24:39 -0400
Subject: ARM: keystone: Switch over to coherent memory address space

With late code patching updates for LPAE machines has merged now and
memblock conversion from bootmem is on its way, Keystone can switch to
the coherent memory address space which starts beyond 4GB boundary.
The idmap alias needs are managed via virt_to_idmap() for boot purpose.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 6e6bb7d..1b43a27 100644
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
+	__pv_phys_offset = offset;
+	__pv_offset = (offset - PAGE_OFFSET);
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
cgit v0.10.1
