From: john.stultz@linaro.org (John Stultz)
Date: Mon, 13 Dec 2010 20:57:39 -0800
Subject: [PATCH 4/4] Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
Message-ID: <1292302659-1863-5-git-send-email-john.stultz@linaro.org>
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

CC: Nicolas Pitre <nicolas.pitre@linaro.org>
CC: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Dima Zavin <dima@android.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm/include/asm/cacheflush.h |    2 +-
 arch/arm/kernel/traps.c           |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 3acd8fa..f533a6a 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -377,7 +377,7 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr
  * Harvard caches are synchronised for the user space address range.
  * This is used for the ARM private sys_cacheflush system call.
  */
-#define flush_cache_user_range(vma,start,end) \
+#define flush_cache_user_range(start,end) \
 	__cpuc_coherent_user_range((start) & PAGE_MASK, PAGE_ALIGN(end))
 
 /*
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 446aee9..7644a56 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -451,7 +451,9 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
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
1.7.3.2.146.gca209
