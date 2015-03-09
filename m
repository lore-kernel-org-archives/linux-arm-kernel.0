From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon,  9 Mar 2015 10:27:05 +0000
Subject: [PATCH 1/6] mm: move memtest under /mm
In-Reply-To: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
References: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1425896830-19705-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is nothing platform dependent in the core memtest code, so other platform
might benefit of this feature too.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/x86/Kconfig            |   11 ----
 arch/x86/include/asm/e820.h |    8 ---
 arch/x86/mm/Makefile        |    2 -
 arch/x86/mm/memtest.c       |  118 -------------------------------------------
 include/linux/memblock.h    |    8 +++
 lib/Kconfig.debug           |   11 ++++
 mm/Makefile                 |    1 +
 mm/memtest.c                |  118 +++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 138 insertions(+), 139 deletions(-)
 delete mode 100644 arch/x86/mm/memtest.c
 create mode 100644 mm/memtest.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b7d31ca..d16e510 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -716,17 +716,6 @@ endif #HYPERVISOR_GUEST
 config NO_BOOTMEM
 	def_bool y
 
-config MEMTEST
-	bool "Memtest"
-	---help---
-	  This option adds a kernel parameter 'memtest', which allows memtest
-	  to be set.
-	        memtest=0, mean disabled; -- default
-	        memtest=1, mean do 1 test pattern;
-	        ...
-	        memtest=4, mean do 4 test patterns.
-	  If you are unsure how to answer this question, answer N.
-
 source "arch/x86/Kconfig.cpu"
 
 config HPET_TIMER
diff --git a/arch/x86/include/asm/e820.h b/arch/x86/include/asm/e820.h
index 779c2ef..3ab0537 100644
--- a/arch/x86/include/asm/e820.h
+++ b/arch/x86/include/asm/e820.h
@@ -40,14 +40,6 @@ static inline void e820_mark_nosave_regions(unsigned long limit_pfn)
 }
 #endif
 
-#ifdef CONFIG_MEMTEST
-extern void early_memtest(unsigned long start, unsigned long end);
-#else
-static inline void early_memtest(unsigned long start, unsigned long end)
-{
-}
-#endif
-
 extern unsigned long e820_end_of_ram_pfn(void);
 extern unsigned long e820_end_of_low_ram_pfn(void);
 extern u64 early_reserve_e820(u64 sizet, u64 align);
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c4cc740..a482d10 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -32,6 +32,4 @@ obj-$(CONFIG_AMD_NUMA)		+= amdtopology.o
 obj-$(CONFIG_ACPI_NUMA)		+= srat.o
 obj-$(CONFIG_NUMA_EMU)		+= numa_emulation.o
 
-obj-$(CONFIG_MEMTEST)		+= memtest.o
-
 obj-$(CONFIG_X86_INTEL_MPX)	+= mpx.o
diff --git a/arch/x86/mm/memtest.c b/arch/x86/mm/memtest.c
deleted file mode 100644
index 1e9da79..0000000
--- a/arch/x86/mm/memtest.c
+++ /dev/null
@@ -1,118 +0,0 @@
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/init.h>
-#include <linux/pfn.h>
-#include <linux/memblock.h>
-
-static u64 patterns[] __initdata = {
-	/* The first entry has to be 0 to leave memtest with zeroed memory */
-	0,
-	0xffffffffffffffffULL,
-	0x5555555555555555ULL,
-	0xaaaaaaaaaaaaaaaaULL,
-	0x1111111111111111ULL,
-	0x2222222222222222ULL,
-	0x4444444444444444ULL,
-	0x8888888888888888ULL,
-	0x3333333333333333ULL,
-	0x6666666666666666ULL,
-	0x9999999999999999ULL,
-	0xccccccccccccccccULL,
-	0x7777777777777777ULL,
-	0xbbbbbbbbbbbbbbbbULL,
-	0xddddddddddddddddULL,
-	0xeeeeeeeeeeeeeeeeULL,
-	0x7a6c7258554e494cULL, /* yeah ;-) */
-};
-
-static void __init reserve_bad_mem(u64 pattern, u64 start_bad, u64 end_bad)
-{
-	printk(KERN_INFO "  %016llx bad mem addr %010llx - %010llx reserved\n",
-	       (unsigned long long) pattern,
-	       (unsigned long long) start_bad,
-	       (unsigned long long) end_bad);
-	memblock_reserve(start_bad, end_bad - start_bad);
-}
-
-static void __init memtest(u64 pattern, u64 start_phys, u64 size)
-{
-	u64 *p, *start, *end;
-	u64 start_bad, last_bad;
-	u64 start_phys_aligned;
-	const size_t incr = sizeof(pattern);
-
-	start_phys_aligned = ALIGN(start_phys, incr);
-	start = __va(start_phys_aligned);
-	end = start + (size - (start_phys_aligned - start_phys)) / incr;
-	start_bad = 0;
-	last_bad = 0;
-
-	for (p = start; p < end; p++)
-		*p = pattern;
-
-	for (p = start; p < end; p++, start_phys_aligned += incr) {
-		if (*p == pattern)
-			continue;
-		if (start_phys_aligned == last_bad + incr) {
-			last_bad += incr;
-			continue;
-		}
-		if (start_bad)
-			reserve_bad_mem(pattern, start_bad, last_bad + incr);
-		start_bad = last_bad = start_phys_aligned;
-	}
-	if (start_bad)
-		reserve_bad_mem(pattern, start_bad, last_bad + incr);
-}
-
-static void __init do_one_pass(u64 pattern, u64 start, u64 end)
-{
-	u64 i;
-	phys_addr_t this_start, this_end;
-
-	for_each_free_mem_range(i, NUMA_NO_NODE, &this_start, &this_end, NULL) {
-		this_start = clamp_t(phys_addr_t, this_start, start, end);
-		this_end = clamp_t(phys_addr_t, this_end, start, end);
-		if (this_start < this_end) {
-			printk(KERN_INFO "  %010llx - %010llx pattern %016llx\n",
-			       (unsigned long long)this_start,
-			       (unsigned long long)this_end,
-			       (unsigned long long)cpu_to_be64(pattern));
-			memtest(pattern, this_start, this_end - this_start);
-		}
-	}
-}
-
-/* default is disabled */
-static int memtest_pattern __initdata;
-
-static int __init parse_memtest(char *arg)
-{
-	if (arg)
-		memtest_pattern = simple_strtoul(arg, NULL, 0);
-	else
-		memtest_pattern = ARRAY_SIZE(patterns);
-
-	return 0;
-}
-
-early_param("memtest", parse_memtest);
-
-void __init early_memtest(unsigned long start, unsigned long end)
-{
-	unsigned int i;
-	unsigned int idx = 0;
-
-	if (!memtest_pattern)
-		return;
-
-	printk(KERN_INFO "early_memtest: # of tests: %d\n", memtest_pattern);
-	for (i = memtest_pattern-1; i < UINT_MAX; --i) {
-		idx = i % ARRAY_SIZE(patterns);
-		do_one_pass(patterns[idx], start, end);
-	}
-}
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index e8cc453..6724cb0 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -365,6 +365,14 @@ static inline unsigned long memblock_region_reserved_end_pfn(const struct memblo
 #define __initdata_memblock
 #endif
 
+#ifdef CONFIG_MEMTEST
+extern void early_memtest(unsigned long start, unsigned long end);
+#else
+static inline void early_memtest(unsigned long start, unsigned long end)
+{
+}
+#endif
+
 #else
 static inline phys_addr_t memblock_alloc(phys_addr_t size, phys_addr_t align)
 {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c5cefb3..8eb064fd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1732,6 +1732,17 @@ config TEST_UDELAY
 
 	  If unsure, say N.
 
+config MEMTEST
+	bool "Memtest"
+	---help---
+	  This option adds a kernel parameter 'memtest', which allows memtest
+	  to be set.
+	        memtest=0, mean disabled; -- default
+	        memtest=1, mean do 1 test pattern;
+	        ...
+	        memtest=4, mean do 4 test patterns.
+	  If you are unsure how to answer this question, answer N.
+
 source "samples/Kconfig"
 
 source "lib/Kconfig.kgdb"
diff --git a/mm/Makefile b/mm/Makefile
index 3c1caa2..e925708 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -76,3 +76,4 @@ obj-$(CONFIG_GENERIC_EARLY_IOREMAP) += early_ioremap.o
 obj-$(CONFIG_CMA)	+= cma.o
 obj-$(CONFIG_MEMORY_BALLOON) += balloon_compaction.o
 obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
+obj-$(CONFIG_MEMTEST)		+= memtest.o
diff --git a/mm/memtest.c b/mm/memtest.c
new file mode 100644
index 0000000..1e9da79
--- /dev/null
+++ b/mm/memtest.c
@@ -0,0 +1,118 @@
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/pfn.h>
+#include <linux/memblock.h>
+
+static u64 patterns[] __initdata = {
+	/* The first entry has to be 0 to leave memtest with zeroed memory */
+	0,
+	0xffffffffffffffffULL,
+	0x5555555555555555ULL,
+	0xaaaaaaaaaaaaaaaaULL,
+	0x1111111111111111ULL,
+	0x2222222222222222ULL,
+	0x4444444444444444ULL,
+	0x8888888888888888ULL,
+	0x3333333333333333ULL,
+	0x6666666666666666ULL,
+	0x9999999999999999ULL,
+	0xccccccccccccccccULL,
+	0x7777777777777777ULL,
+	0xbbbbbbbbbbbbbbbbULL,
+	0xddddddddddddddddULL,
+	0xeeeeeeeeeeeeeeeeULL,
+	0x7a6c7258554e494cULL, /* yeah ;-) */
+};
+
+static void __init reserve_bad_mem(u64 pattern, u64 start_bad, u64 end_bad)
+{
+	printk(KERN_INFO "  %016llx bad mem addr %010llx - %010llx reserved\n",
+	       (unsigned long long) pattern,
+	       (unsigned long long) start_bad,
+	       (unsigned long long) end_bad);
+	memblock_reserve(start_bad, end_bad - start_bad);
+}
+
+static void __init memtest(u64 pattern, u64 start_phys, u64 size)
+{
+	u64 *p, *start, *end;
+	u64 start_bad, last_bad;
+	u64 start_phys_aligned;
+	const size_t incr = sizeof(pattern);
+
+	start_phys_aligned = ALIGN(start_phys, incr);
+	start = __va(start_phys_aligned);
+	end = start + (size - (start_phys_aligned - start_phys)) / incr;
+	start_bad = 0;
+	last_bad = 0;
+
+	for (p = start; p < end; p++)
+		*p = pattern;
+
+	for (p = start; p < end; p++, start_phys_aligned += incr) {
+		if (*p == pattern)
+			continue;
+		if (start_phys_aligned == last_bad + incr) {
+			last_bad += incr;
+			continue;
+		}
+		if (start_bad)
+			reserve_bad_mem(pattern, start_bad, last_bad + incr);
+		start_bad = last_bad = start_phys_aligned;
+	}
+	if (start_bad)
+		reserve_bad_mem(pattern, start_bad, last_bad + incr);
+}
+
+static void __init do_one_pass(u64 pattern, u64 start, u64 end)
+{
+	u64 i;
+	phys_addr_t this_start, this_end;
+
+	for_each_free_mem_range(i, NUMA_NO_NODE, &this_start, &this_end, NULL) {
+		this_start = clamp_t(phys_addr_t, this_start, start, end);
+		this_end = clamp_t(phys_addr_t, this_end, start, end);
+		if (this_start < this_end) {
+			printk(KERN_INFO "  %010llx - %010llx pattern %016llx\n",
+			       (unsigned long long)this_start,
+			       (unsigned long long)this_end,
+			       (unsigned long long)cpu_to_be64(pattern));
+			memtest(pattern, this_start, this_end - this_start);
+		}
+	}
+}
+
+/* default is disabled */
+static int memtest_pattern __initdata;
+
+static int __init parse_memtest(char *arg)
+{
+	if (arg)
+		memtest_pattern = simple_strtoul(arg, NULL, 0);
+	else
+		memtest_pattern = ARRAY_SIZE(patterns);
+
+	return 0;
+}
+
+early_param("memtest", parse_memtest);
+
+void __init early_memtest(unsigned long start, unsigned long end)
+{
+	unsigned int i;
+	unsigned int idx = 0;
+
+	if (!memtest_pattern)
+		return;
+
+	printk(KERN_INFO "early_memtest: # of tests: %d\n", memtest_pattern);
+	for (i = memtest_pattern-1; i < UINT_MAX; --i) {
+		idx = i % ARRAY_SIZE(patterns);
+		do_one_pass(patterns[idx], start, end);
+	}
+}
-- 
1.7.9.5
