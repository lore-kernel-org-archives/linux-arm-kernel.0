From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon,  9 Mar 2015 10:27:06 +0000
Subject: [PATCH 2/6] memtest: use phys_addr_t for physical addresses
In-Reply-To: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
References: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1425896830-19705-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since memtest might be used by other architectures pass input parameters
as phys_addr_t instead of long to prevent overflow.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/memblock.h |    4 ++--
 mm/memtest.c             |   16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 6724cb0..9497ec7 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -366,9 +366,9 @@ static inline unsigned long memblock_region_reserved_end_pfn(const struct memblo
 #endif
 
 #ifdef CONFIG_MEMTEST
-extern void early_memtest(unsigned long start, unsigned long end);
+extern void early_memtest(phys_addr_t start, phys_addr_t end);
 #else
-static inline void early_memtest(unsigned long start, unsigned long end)
+static inline void early_memtest(phys_addr_t start, phys_addr_t end)
 {
 }
 #endif
diff --git a/mm/memtest.c b/mm/memtest.c
index 1e9da79..1997d93 100644
--- a/mm/memtest.c
+++ b/mm/memtest.c
@@ -29,7 +29,7 @@ static u64 patterns[] __initdata = {
 	0x7a6c7258554e494cULL, /* yeah ;-) */
 };
 
-static void __init reserve_bad_mem(u64 pattern, u64 start_bad, u64 end_bad)
+static void __init reserve_bad_mem(u64 pattern, phys_addr_t start_bad, phys_addr_t end_bad)
 {
 	printk(KERN_INFO "  %016llx bad mem addr %010llx - %010llx reserved\n",
 	       (unsigned long long) pattern,
@@ -38,11 +38,11 @@ static void __init reserve_bad_mem(u64 pattern, u64 start_bad, u64 end_bad)
 	memblock_reserve(start_bad, end_bad - start_bad);
 }
 
-static void __init memtest(u64 pattern, u64 start_phys, u64 size)
+static void __init memtest(u64 pattern, phys_addr_t start_phys, phys_addr_t size)
 {
 	u64 *p, *start, *end;
-	u64 start_bad, last_bad;
-	u64 start_phys_aligned;
+	phys_addr_t start_bad, last_bad;
+	phys_addr_t start_phys_aligned;
 	const size_t incr = sizeof(pattern);
 
 	start_phys_aligned = ALIGN(start_phys, incr);
@@ -69,14 +69,14 @@ static void __init memtest(u64 pattern, u64 start_phys, u64 size)
 		reserve_bad_mem(pattern, start_bad, last_bad + incr);
 }
 
-static void __init do_one_pass(u64 pattern, u64 start, u64 end)
+static void __init do_one_pass(u64 pattern, phys_addr_t start, phys_addr_t end)
 {
 	u64 i;
 	phys_addr_t this_start, this_end;
 
 	for_each_free_mem_range(i, NUMA_NO_NODE, &this_start, &this_end, NULL) {
-		this_start = clamp_t(phys_addr_t, this_start, start, end);
-		this_end = clamp_t(phys_addr_t, this_end, start, end);
+		this_start = clamp(this_start, start, end);
+		this_end = clamp(this_end, start, end);
 		if (this_start < this_end) {
 			printk(KERN_INFO "  %010llx - %010llx pattern %016llx\n",
 			       (unsigned long long)this_start,
@@ -102,7 +102,7 @@ static int __init parse_memtest(char *arg)
 
 early_param("memtest", parse_memtest);
 
-void __init early_memtest(unsigned long start, unsigned long end)
+void __init early_memtest(phys_addr_t start, phys_addr_t end)
 {
 	unsigned int i;
 	unsigned int idx = 0;
-- 
1.7.9.5
