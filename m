From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 26 Jan 2018 12:14:41 +0100
Subject: [RFC 2/2] arm64: compat: cacheflush syscall: process only pages
 that are in the memory
In-Reply-To: <20180126111441.29353-1-m.szyprowski@samsung.com>
References: <20180126111441.29353-1-m.szyprowski@samsung.com>
 <CGME20180126111453eucas1p178663ac7b17d0c92cc889a42b3f5bcec@eucas1p1.samsung.com>
Message-ID: <20180126111441.29353-2-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

glibc in ARM 32bit mode calls cacheflush syscall on the whole textrels
section of the relocated binaries. However, relocation usually doesn't
touch all pages of that section, so not all of them are read to memory
when calling this syscall. However flush_cache_user_range() function will
unconditionally touch all pages from the provided range, resulting
additional overhead related to reading all clean pages. Optimize this by
calling flush_cache_user_range() only on the pages that are already in the
memory.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/kernel/sys_compat.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index 8b8bbd3eaa52..4a047db3fdd4 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/mm.h>
 
 #include <asm/cacheflush.h>
 #include <asm/unistd.h>
@@ -32,23 +33,36 @@
 static long
 __do_compat_cache_op(unsigned long start, unsigned long end)
 {
-	long ret;
+	struct vm_area_struct *vma = NULL;
+	long ret = 0;
 
+	down_read(&current->mm->mmap_sem);
 	do {
 		unsigned long chunk = min(PAGE_SIZE, end - start);
 
+		if (!vma || vma->vm_end <= start) {
+			vma = find_vma(current->mm, start);
+			if (!vma) {
+				ret = -EFAULT;
+				goto done;
+			}
+		}
+
 		if (fatal_signal_pending(current))
-			return 0;
+			goto done;
 
-		ret = __flush_cache_user_range(start, start + chunk);
-		if (ret)
-			return ret;
+		if (follow_page(vma, start, 0)) {
+			ret = __flush_cache_user_range(start, start + chunk);
+			if (ret)
+				goto done;
+		}
 
 		cond_resched();
 		start += chunk;
 	} while (start < end);
-
-	return 0;
+done:
+	up_read(&current->mm->mmap_sem);
+	return ret;
 }
 
 static inline long
-- 
2.15.0
