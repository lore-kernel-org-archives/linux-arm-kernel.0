From: maninder1.s@samsung.com (Maninder Singh)
Date: Tue, 06 Dec 2016 13:59:35 +0530
Subject: [PATCH 1/1] arm/module: maximum utilization of module area.
Message-ID: <1481012975-44478-1-git-send-email-maninder1.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines new macro MODULE_START to ensure kernel text
and module remains within 32 MB of address range.

Tried this patch by inserting 20 MB size module on 4.1 kernel:-

Earlier:-
==========
sh# insmod size.ko
....
insmod: ERROR: could not insert module size.ko: Cannot allocate memory
sh#

With this patch
===============
sh# insmod size.ko
...
sh# lsmod
Module                  Size  Used by
size                20972425  0

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Ajeet Yadav <ajeet.y@samsung.com>
---
 arch/arm/include/asm/memory.h | 4 ++--
 arch/arm/kernel/module.c      | 9 ++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 76cbd9c..1a0a6e5 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -37,7 +37,7 @@
  * TASK_SIZE - the maximum size of a user space task.
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
  */
-#define TASK_SIZE		(UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
+#define TASK_SIZE		(UL(CONFIG_PAGE_OFFSET) - UL(SZ_32M))
 #define TASK_UNMAPPED_BASE	ALIGN(TASK_SIZE / 3, SZ_16M)
 
 /*
@@ -50,7 +50,7 @@
  * and PAGE_OFFSET - it must be within 32MB of the kernel text.
  */
 #ifndef CONFIG_THUMB2_KERNEL
-#define MODULES_VADDR		(PAGE_OFFSET - SZ_16M)
+#define MODULES_VADDR		(PAGE_OFFSET - SZ_32M)
 #else
 /* smaller range for Thumb-2 symbols relocation (2^24)*/
 #define MODULES_VADDR		(PAGE_OFFSET - SZ_8M)
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 4f14b5c..b8e1f9c 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -35,12 +35,19 @@
  */
 #undef MODULES_VADDR
 #define MODULES_VADDR	(((unsigned long)_exiprom + ~PMD_MASK) & PMD_MASK)
+#define MODULES_START MODULES_VADDR
+#else
+#ifndef CONFIG_THUMB2_KERNEL
+#define MODULES_START  ALIGN((unsigned long)_etext - SZ_32M, PAGE_SIZE)
+#else
+#define MODULES_START MODULES_VADDR
+#endif
 #endif
 
 #ifdef CONFIG_MMU
 void *module_alloc(unsigned long size)
 {
-	void *p = __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
+	void *p = __vmalloc_node_range(size, 1, MODULES_START, MODULES_END,
 				GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 	if (!IS_ENABLED(CONFIG_ARM_MODULE_PLTS) || p)
-- 
1.9.1
