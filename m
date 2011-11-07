From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Nov 2011 17:33:44 +0000
Subject: [PATCH] ARM: Do not call flush_cache_user_range with mmap_sem held
Message-ID: <20111107172836.5615.64219.stgit@e102109-lin.cambridge.arm.com>
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

Signed-off-by: Dima Zavin <dima@android.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Russell, this patch has been around for a while but still no decision
made, so I'm reposting it. It solves a real bug in the ARM kernels and
I'd like to be considered for upstream.

If you think there is some cache flushing race that this semaphore is
protecting against, the ARMv8 allows (some) user-space cache maintenance
and that's no different from running the cache flush outside the
mmap_sem.

Thanks.


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
index e8fd69e..d9b59d0 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -466,7 +466,9 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
 		if (end > vma->vm_end)
 			end = vma->vm_end;
 
-		flush_cache_user_range(vma, start, end);
+		up_read(&mm->mmap_sem);
+		flush_cache_user_range(start, end);
+		return;
 	}
 	up_read(&mm->mmap_sem);
 }
