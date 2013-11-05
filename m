From: tom.leiming@gmail.com (Ming Lei)
Date: Wed,  6 Nov 2013 00:22:10 +0800
Subject: [PATCH] ARM: mm: Ensure get_unmapped_area() returns higher address
 than mmap_min_addr
Message-ID: <1383668531-24648-1-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ming Lei <ming.lei@canonical.com>

This patch is the arm version of below patch, which is already in
-mm tree:

	http://marc.info/?t=138251444500006&r=1&w=2

Without this patch, the below syscall may return failure when
'/proc/sys/vm/mmap_min_addr' is set 32768:

	mmap(0, size, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);

but actually there is surely enough VM space for current task, for
example arch_get_unmapped_area() may return 0x7000, but which can't
pass security check, so finally -EPERM is returned to the caller, and
cause bug from user space's view.

Cc: <stable@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Akira Takeuchi <takeuchi.akr@jp.panasonic.com>
Cc: Kiyoshi Owada <owada.kiyoshi@jp.panasonic.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/mm/mmap.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index d27158c..c2fbb91 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/personality.h>
 #include <linux/random.h>
+#include <linux/security.h>
 #include <asm/cachetype.h>
 
 #define COLOUR_ALIGN(addr,pgoff)		\
@@ -78,7 +79,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		return addr;
 	}
 
-	if (len > TASK_SIZE)
+	if (len > TASK_SIZE - mmap_min_addr)
 		return -ENOMEM;
 
 	if (addr) {
@@ -88,14 +89,14 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 			addr = PAGE_ALIGN(addr);
 
 		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
+		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
 
 	info.flags = 0;
 	info.length = len;
-	info.low_limit = mm->mmap_base;
+	info.low_limit = max(mm->mmap_base, mmap_min_addr);
 	info.high_limit = TASK_SIZE;
 	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
@@ -122,7 +123,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		do_align = filp || (flags & MAP_SHARED);
 
 	/* requested length too big for entire address space */
-	if (len > TASK_SIZE)
+	if (len > TASK_SIZE - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED) {
@@ -139,14 +140,14 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		else
 			addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
+		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
 				(!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = PAGE_SIZE;
+	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
 	info.high_limit = mm->mmap_base;
 	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
@@ -161,7 +162,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	if (addr & ~PAGE_MASK) {
 		VM_BUG_ON(addr != -ENOMEM);
 		info.flags = 0;
-		info.low_limit = mm->mmap_base;
+		info.low_limit = max(mm->mmap_base, mmap_min_addr);
 		info.high_limit = TASK_SIZE;
 		addr = vm_unmapped_area(&info);
 	}
-- 
1.7.9.5
