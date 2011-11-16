From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:34 -0500
Subject: [PATCH 16/23] ARM: sort the meminfo array earlier
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-17-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

The meminfo array has to be sorted before sanity_check_meminfo() in
arch/arm/mm/mmu.c is called for it to work properly.  This also allows
for a simpler find_limits() in arch/arm/mm/init.c.

The sort is moved to arch/arm/kernel/setup.c because that's where the
meminfo array is populated.  Eventually this should be improved upon
to make the memory bank parser a bit more robust against problems
such as overlapping memory ranges.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/kernel/setup.c |    8 ++++++++
 arch/arm/mm/init.c      |   38 ++++++++------------------------------
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 7e7977ab99..44510f8793 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -31,6 +31,7 @@
 #include <linux/memblock.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
+#include <linux/sort.h>
 
 #include <asm/unified.h>
 #include <asm/cpu.h>
@@ -888,6 +889,12 @@ static struct machine_desc * __init setup_machine_tags(unsigned int nr)
 	return mdesc;
 }
 
+static int __init meminfo_cmp(const void *_a, const void *_b)
+{
+	const struct membank *a = _a, *b = _b;
+	long cmp = bank_pfn_start(a) - bank_pfn_start(b);
+	return cmp < 0 ? -1 : cmp > 0 ? 1 : 0;
+}
 
 void __init setup_arch(char **cmdline_p)
 {
@@ -916,6 +923,7 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
 	sanity_check_meminfo();
 	arm_memblock_init(&meminfo, mdesc);
 
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index fbdd12ea3a..d366051e14 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -20,7 +20,6 @@
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
-#include <linux/sort.h>
 
 #include <asm/mach-types.h>
 #include <asm/prom.h>
@@ -134,30 +133,18 @@ void show_mem(unsigned int filter)
 }
 
 static void __init find_limits(unsigned long *min, unsigned long *max_low,
-	unsigned long *max_high)
+			       unsigned long *max_high)
 {
 	struct meminfo *mi = &meminfo;
 	int i;
 
-	*min = -1UL;
-	*max_low = *max_high = 0;
-
-	for_each_bank (i, mi) {
-		struct membank *bank = &mi->bank[i];
-		unsigned long start, end;
-
-		start = bank_pfn_start(bank);
-		end = bank_pfn_end(bank);
-
-		if (*min > start)
-			*min = start;
-		if (*max_high < end)
-			*max_high = end;
-		if (bank->highmem)
-			continue;
-		if (*max_low < end)
-			*max_low = end;
-	}
+	/* This assumes the meminfo array is properly sorted */
+	*min = bank_pfn_start(&mi->bank[0]);
+	for_each_bank (i, mi)
+		if (mi->bank[i].highmem)
+				break;
+	*max_low = bank_pfn_end(&mi->bank[i - 1]);
+	*max_high = bank_pfn_end(&mi->bank[mi->nr_banks - 1]);
 }
 
 static void __init arm_bootmem_init(unsigned long start_pfn,
@@ -319,19 +306,10 @@ static void arm_memory_present(void)
 }
 #endif
 
-static int __init meminfo_cmp(const void *_a, const void *_b)
-{
-	const struct membank *a = _a, *b = _b;
-	long cmp = bank_pfn_start(a) - bank_pfn_start(b);
-	return cmp < 0 ? -1 : cmp > 0 ? 1 : 0;
-}
-
 void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
 {
 	int i;
 
-	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
-
 	memblock_init();
 	for (i = 0; i < mi->nr_banks; i++)
 		memblock_add(mi->bank[i].start, mi->bank[i].size);
-- 
1.7.7.1.431.g10b2a
