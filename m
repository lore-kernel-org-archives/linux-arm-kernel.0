From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 26 Jan 2018 12:14:40 +0100
Subject: [RFC 1/2] arm: cacheflush syscall: process only pages that are in
 the memory
References: <CGME20180126111453eucas1p1330d8561386c3cf2bb457bc22c0d99a8@eucas1p1.samsung.com>
Message-ID: <20180126111441.29353-1-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

glibc in calls cacheflush syscall on the whole textrels section of the
relocated binaries. However, relocation usually doesn't touch all pages
of that section, so not all of them are read to memory when calling this
syscall. However flush_cache_user_range() function will unconditionally
touch all pages from the provided range, resulting additional overhead
related to reading all clean pages. Optimize this by calling
flush_cache_user_range() only on the pages that are already in the
memory.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/kernel/traps.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 5e3633c24e63..a5ec262ab30e 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -564,23 +564,36 @@ static int bad_syscall(int n, struct pt_regs *regs)
 static inline int
 __do_cache_op(unsigned long start, unsigned long end)
 {
-	int ret;
+	struct vm_area_struct *vma = NULL;
+	int ret = 0;
 
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
 			return 0;
 
-		ret = flush_cache_user_range(start, start + chunk);
-		if (ret)
-			return ret;
+		if (follow_page(vma, start, 0)) {
+			ret = flush_cache_user_range(start, start + chunk);
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
 
 static inline int
-- 
2.15.0
