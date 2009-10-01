From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu,  1 Oct 2009 23:34:13 +0200
Subject: [PATCH] FCSE: Address-space limits.
In-Reply-To: <1254432860-11511-3-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-3-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <1254432860-11511-4-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get the kernel macros to reflect address-space limits imposed by the FCSE.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/include/asm/memory.h    |    5 +++++
 arch/arm/include/asm/processor.h |    5 +++++
 arch/arm/mm/mmap.c               |   22 +++++++++++++++++++---
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index cefedf0..db9781a 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -33,7 +33,12 @@
  */
 #define PAGE_OFFSET		UL(CONFIG_PAGE_OFFSET)
 #define TASK_SIZE		(UL(CONFIG_PAGE_OFFSET) - UL(0x01000000))
+#ifndef CONFIG_ARM_FCSE
 #define TASK_UNMAPPED_BASE	(UL(CONFIG_PAGE_OFFSET) / 3)
+#else /* CONFIG_ARM_FCSE */
+#define TASK_UNMAPPED_BASE	UL(0x01000000)
+#define FCSE_TASK_SIZE		UL(0x02000000)
+#endif /* CONFIG_ARM_FCSE */
 
 /*
  * The maximum size of a 26-bit user space task.
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 6a89567..bc33df1 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -23,9 +23,14 @@
 #include <asm/types.h>
 
 #ifdef __KERNEL__
+#ifndef CONFIG_ARM_FCSE
 #define STACK_TOP	((current->personality & ADDR_LIMIT_32BIT) ? \
 			 TASK_SIZE : TASK_SIZE_26)
 #define STACK_TOP_MAX	TASK_SIZE
+#else /* CONFIG_ARM_FCSE */
+#define STACK_TOP	FCSE_TASK_SIZE
+#define STACK_TOP_MAX	FCSE_TASK_SIZE
+#endif /* CONFIG_ARM_FCSE */
 #endif
 
 union debug_insn {
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index f7457fe..e608bda 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -50,13 +50,16 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 #define aliasing 0
 #endif
 
+#ifdef CONFIG_ARM_FCSE
+	start_addr = addr;
+#endif /* CONFIG_ARM_FCSE */
 	/*
 	 * We enforce the MAP_FIXED case.
 	 */
 	if (flags & MAP_FIXED) {
 		if (aliasing && flags & MAP_SHARED && addr & (SHMLBA - 1))
 			return -EINVAL;
-		return addr;
+		goto found_addr;
 	}
 
 	if (len > TASK_SIZE)
@@ -71,7 +74,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		vma = find_vma(mm, addr);
 		if (TASK_SIZE - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
-			return addr;
+			goto found_addr;
 	}
 	if (len > mm->cached_hole_size) {
 	        start_addr = addr = mm->free_area_cache;
@@ -105,7 +108,7 @@ full_search:
 			 * Remember the place where we stopped the search:
 			 */
 			mm->free_area_cache = addr + len;
-			return addr;
+			goto found_addr;
 		}
 		if (addr + mm->cached_hole_size < vma->vm_start)
 		        mm->cached_hole_size = vma->vm_start - addr;
@@ -113,6 +116,19 @@ full_search:
 		if (do_align)
 			addr = COLOUR_ALIGN(addr, pgoff);
 	}
+
+found_addr:
+#ifdef CONFIG_ARM_FCSE
+	if (addr + len > FCSE_TASK_SIZE) {
+		if (!(flags & MAP_FIXED) && start_addr != TASK_UNMAPPED_BASE) {
+			start_addr = addr = TASK_UNMAPPED_BASE;
+			mm->cached_hole_size = 0;
+			goto full_search;
+		}
+		return -ENOMEM;
+	}
+#endif /* CONFIG_ARM_FCSE */
+	return addr;
 }
 
 
-- 
1.5.6.5
