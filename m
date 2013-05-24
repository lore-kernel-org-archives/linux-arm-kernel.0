From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 May 2013 12:31:25 +0100
Subject: [PATCH v2 2/4] ARM: cacheflush: split user cache-flushing into
 interruptible chunks
In-Reply-To: <1369395087-30972-1-git-send-email-will.deacon@arm.com>
References: <1369395087-30972-1-git-send-email-will.deacon@arm.com>
Message-ID: <1369395087-30972-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Flushing a large, non-faulting VMA from userspace can potentially result
in a long time spent flushing the cache line-by-line without preemption
occurring (in the case of CONFIG_PREEMPT=n).

Whilst this doesn't affect the stability of the system, it can certainly
affect the responsiveness and CPU availability for other tasks.

This patch splits up the user cacheflush code so that it flushes in
chunks of a page. After each chunk has been flushed, we may reschedule
if appropriate and, before processing the next chunk, we allow any
pending signals to be handled before resuming from where we left off.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/thread_info.h | 11 +++++++
 arch/arm/kernel/traps.c            | 63 +++++++++++++++++++++++++++++++++-----
 2 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 1995d1a..5c3964b 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -43,6 +43,16 @@ struct cpu_context_save {
 	__u32	extra[2];		/* Xscale 'acc' register, etc */
 };
 
+struct arm_restart_block {
+	union {
+		/* For user cache flushing */
+		struct {
+			unsigned long start;
+			unsigned long end;
+		} cache;
+	};
+};
+
 /*
  * low level task data that entry.S needs immediate access to.
  * __switch_to() assumes cpu_context follows immediately after cpu_domain.
@@ -68,6 +78,7 @@ struct thread_info {
 	unsigned long		thumbee_state;	/* ThumbEE Handler Base register */
 #endif
 	struct restart_block	restart_block;
+	struct arm_restart_block	arm_restart_block;
 };
 
 #define INIT_THREAD_INFO(tsk)						\
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 18b32e8..47092f2 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -499,6 +499,52 @@ static int bad_syscall(int n, struct pt_regs *regs)
 	return regs->ARM_r0;
 }
 
+static long do_cache_op_restart(struct restart_block *);
+
+static inline int
+__do_cache_op(unsigned long start, unsigned long end)
+{
+	int ret;
+	unsigned long chunk = PAGE_SIZE;
+
+	do {
+		if (signal_pending(current)) {
+			struct thread_info *ti = current_thread_info();
+
+			ti->restart_block = (struct restart_block) {
+				.fn	= do_cache_op_restart,
+			};
+
+			ti->arm_restart_block = (struct arm_restart_block) {
+				.cache = {
+					.start	= start,
+					.end	= end,
+				},
+			};
+
+			return -ERESTART_RESTARTBLOCK;
+		}
+
+		ret = flush_cache_user_range(start, start + chunk);
+		if (ret)
+			return ret;
+
+		cond_resched();
+		start += chunk;
+	} while (start < end);
+
+	return 0;
+}
+
+static long do_cache_op_restart(struct restart_block *unused)
+{
+	struct arm_restart_block *restart_block;
+
+	restart_block = &current_thread_info()->arm_restart_block;
+	return __do_cache_op(restart_block->cache.start,
+			     restart_block->cache.end);
+}
+
 static inline int
 do_cache_op(unsigned long start, unsigned long end, int flags)
 {
@@ -510,17 +556,18 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
 
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, start);
-	if (vma && vma->vm_start < end) {
-		if (start < vma->vm_start)
-			start = vma->vm_start;
-		if (end > vma->vm_end)
-			end = vma->vm_end;
-
+	if (!vma || vma->vm_start >= end) {
 		up_read(&mm->mmap_sem);
-		return flush_cache_user_range(start, end);
+		return -EINVAL;
 	}
+
+	if (start < vma->vm_start)
+		start = vma->vm_start;
+	if (end > vma->vm_end)
+		end = vma->vm_end;
 	up_read(&mm->mmap_sem);
-	return -EINVAL;
+
+	return __do_cache_op(start, end);
 }
 
 /*
-- 
1.8.2.2
