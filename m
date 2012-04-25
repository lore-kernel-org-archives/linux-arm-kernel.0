From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Apr 2012 16:54:19 +0100
Subject: [PATCH 1/2] ARM: Do not call flush_cache_user_range with mmap_sem held
Message-ID: <1335369260-9761-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dima Zavin <dima@android.com>

We can't be holding the mmap_sem while calling flush_cache_user_range
because the flush can fault. If we fault on a user address, the
page fault handler will try to take mmap_sem again. Since both places
acquire the read lock, most of the time it succeeds. However, if another
thread tries to acquire the write lock on the mmap_sem (e.g. mmap) in
between the call to flush_cache_user_range and the fault, the down_read
in do_page_fault will deadlock.

Also, since we really can't be holding the mmap_sem while calling
flush_cache_user_range AND vma is actually unused by the flush itself,
get rid of vma as an argument.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Dima Zavin <dima@android.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Note: I'm including this as a prerequisite to the following patch but if
      there are still objections to this then I can rebase without it.

 arch/arm/include/asm/cacheflush.h |    2 +-
 arch/arm/kernel/traps.c           |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index d5d8d5c..1252a26 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -249,7 +249,7 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr
  * Harvard caches are synchronised for the user space address range.
  * This is used for the ARM private sys_cacheflush system call.
  */
-#define flush_cache_user_range(vma,start,end) \
+#define flush_cache_user_range(start,end) \
 	__cpuc_coherent_user_range((start) & PAGE_MASK, PAGE_ALIGN(end))
 
 /*
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 7784547..63d402f 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -496,7 +496,9 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
 		if (end > vma->vm_end)
 			end = vma->vm_end;
 
-		flush_cache_user_range(vma, start, end);
+		up_read(&mm->mmap_sem);
+		flush_cache_user_range(start, end);
+		return;
 	}
 	up_read(&mm->mmap_sem);
 }
-- 
1.7.4.1
