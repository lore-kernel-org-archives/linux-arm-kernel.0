From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue,  9 Nov 2010 11:06:13 +0200
Subject: [PATCH 4/4] ARM: memblock: convert reserve_crashkernel() to use
	memblock
In-Reply-To: <cover.1289292124.git.mika.westerberg@iki.fi>
References: <cover.1289292124.git.mika.westerberg@iki.fi>
Message-ID: <07f23b6e32b1ee64287dc53803890052df6546f3.1289292124.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we now use memblock we can convert reserve_crashkernel() to
take advantage of the memblock API.

While we are at it, fix the typo in the function kerneldoc as well.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/kernel/setup.c |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 336f14e..c477a2e 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -720,16 +720,8 @@ static int __init customize_machine(void)
 arch_initcall(customize_machine);
 
 #ifdef CONFIG_KEXEC
-static inline unsigned long long get_total_mem(void)
-{
-	unsigned long total;
-
-	total = max_low_pfn - min_low_pfn;
-	return total << PAGE_SHIFT;
-}
-
 /**
- * reserve_crashkernel() - reserves memory are for crash kernel
+ * reserve_crashkernel() - reserves memory area for crash kernel
  *
  * This function reserves memory area given in "crashkernel=" kernel command
  * line parameter. The memory reserved is used by a dump capture kernel when
@@ -738,16 +730,17 @@ static inline unsigned long long get_total_mem(void)
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_size, crash_base;
-	unsigned long long total_mem;
 	int ret;
 
-	total_mem = get_total_mem();
-	ret = parse_crashkernel(boot_command_line, total_mem,
+	/* this is necessary because of memblock_phys_mem_size() */
+	memblock_analyze();
+
+	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
 	if (ret)
 		return;
 
-	ret = reserve_bootmem(crash_base, crash_size, BOOTMEM_EXCLUSIVE);
+	ret = memblock_reserve(crash_base, crash_size);
 	if (ret < 0) {
 		printk(KERN_WARNING "crashkernel reservation failed - "
 		       "memory is in use (0x%lx)\n", (unsigned long)crash_base);
@@ -758,7 +751,7 @@ static void __init reserve_crashkernel(void)
 	       "for crashkernel (System RAM: %ldMB)\n",
 	       (unsigned long)(crash_size >> 20),
 	       (unsigned long)(crash_base >> 20),
-	       (unsigned long)(total_mem >> 20));
+	       (unsigned long)(memblock_phys_mem_size() >> 20));
 
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
-- 
1.7.2.3
