From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 May 2013 12:31:27 +0100
Subject: [PATCH v2 4/4] ARM: cacheflush: don't bother rounding to nearest vma
In-Reply-To: <1369395087-30972-1-git-send-email-will.deacon@arm.com>
References: <1369395087-30972-1-git-send-email-will.deacon@arm.com>
Message-ID: <1369395087-30972-5-git-send-email-will.deacon@arm.com>
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
 arch/arm/kernel/traps.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 47092f2..9af88fd 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -548,24 +548,11 @@ static long do_cache_op_restart(struct restart_block *unused)
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
-	if (!vma || vma->vm_start >= end) {
-		up_read(&mm->mmap_sem);
-		return -EINVAL;
-	}
-
-	if (start < vma->vm_start)
-		start = vma->vm_start;
-	if (end > vma->vm_end)
-		end = vma->vm_end;
-	up_read(&mm->mmap_sem);
+	if (!access_ok(VERIFY_READ, start, end - start))
+		return -EFAULT;
 
 	return __do_cache_op(start, end);
 }
-- 
1.8.2.2
