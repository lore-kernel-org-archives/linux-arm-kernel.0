From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 May 2012 15:38:04 +0100
Subject: [STABLE PATCH] ARM: 7409/1: Do not call flush_cache_user_range with
 mmap_sem held
Message-ID: <1337956684-23569-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dima Zavin <dima@android.com>

commit 435a7ef52db7d86e67a009b36cac1457f8972391 upstream

We can't be holding the mmap_sem while calling flush_cache_user_range
because the flush can fault. If we fault on a user address, the
page fault handler will try to take mmap_sem again. Since both places
acquire the read lock, most of the time it succeeds. However, if another
thread tries to acquire the write lock on the mmap_sem (e.g. mmap) in
between the call to flush_cache_user_range and the fault, the down_read
in do_page_fault will deadlock.

[will: removed drop of vma parameter as already queued by rmk (7365/1)]

Cc: <stable@vger.kernel.org> # 2.6.32+: 4542b6a0: ARM: 7365/1
Cc: <stable@vger.kernel.org> # 2.6.32+
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Dima Zavin <dima@android.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---

Greg: This patch is a candidate for -stable, but its dependency (listed
      above) wasn't marked as such, hence this retrospective submission.

 arch/arm/kernel/traps.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 55b2f3d..63d402f 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -496,7 +496,9 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
 		if (end > vma->vm_end)
 			end = vma->vm_end;
 
+		up_read(&mm->mmap_sem);
 		flush_cache_user_range(start, end);
+		return;
 	}
 	up_read(&mm->mmap_sem);
 }
-- 
1.7.4.1
