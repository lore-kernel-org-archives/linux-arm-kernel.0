From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Mar 2013 18:18:05 +0000
Subject: [PATCH 2/3] ARM: cacheflush: don't bother rounding to nearest vma
In-Reply-To: <1364235486-17738-1-git-send-email-will.deacon@arm.com>
References: <1364235486-17738-1-git-send-email-will.deacon@arm.com>
Message-ID: <1364235486-17738-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

do_cache_op finds the lowest VMA contained in the specified address
range and rounds the range to cover only the mapped addresses.

Since commit 4542b6a0fa6b ("ARM: 7365/1: drop unused parameter from
flush_cache_user_range") the VMA is not used for anything else in this
code and seeing as the low-level cache flushing routines return -EFAULT
if the address is not valid, there is no need for this range truncation.

This patch removes the VMA handling code from the cacheflushing syscall.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/traps.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1c08911..da5e268 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -509,25 +509,10 @@ static int bad_syscall(int n, struct pt_regs *regs)
 static inline int
 do_cache_op(unsigned long start, unsigned long end, int flags)
 {
-	struct mm_struct *mm = current->active_mm;
-	struct vm_area_struct *vma;
-
 	if (end < start || flags)
 		return -EINVAL;
 
-	down_read(&mm->mmap_sem);
-	vma = find_vma(mm, start);
-	if (vma && vma->vm_start < end) {
-		if (start < vma->vm_start)
-			start = vma->vm_start;
-		if (end > vma->vm_end)
-			end = vma->vm_end;
-
-		up_read(&mm->mmap_sem);
-		return flush_cache_user_range(start, end);
-	}
-	up_read(&mm->mmap_sem);
-	return -EINVAL;
+	return flush_cache_user_range(start, end);
 }
 
 /*
-- 
1.8.0
