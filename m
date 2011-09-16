From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Sep 2011 03:07:12 -0400
Subject: [PATCH 01/19] ARM: sort the meminfo array earlier
In-Reply-To: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
Message-ID: <1316156850-31013-2-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

The meminfo array has to be sorted before sanity_check_meminfo() can work
properly.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/kernel/setup.c |    8 ++++++++
 arch/arm/mm/init.c      |   10 ----------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 70bca649e9..56cd8c351c 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -29,6 +29,7 @@
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/memblock.h>
+#include <linux/sort.h>
 
 #include <asm/unified.h>
 #include <asm/cpu.h>
@@ -875,6 +876,12 @@ static struct machine_desc * __init setup_machine_tags(unsigned int nr)
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
@@ -903,6 +910,7 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
 	sanity_check_meminfo();
 	arm_memblock_init(&meminfo, mdesc);
 
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 91bca355cd..7080f10cc2 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -19,7 +19,6 @@
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
-#include <linux/sort.h>
 
 #include <asm/mach-types.h>
 #include <asm/prom.h>
@@ -318,19 +317,10 @@ static void arm_memory_present(void)
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
1.7.7-rc0
