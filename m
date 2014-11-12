From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 12 Nov 2014 10:47:18 +0000
Subject: [PATCH] arm64: compat: align cacheflush syscall with arch/arm
Message-ID: <1415789238-4573-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update handling of cacheflush syscall with changes made in arch/arm
counterpart:
 - return error to userspace when flushing syscall fails
 - split user cache-flushing into interruptible chunks
 - don't bother rounding to nearest vma

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cacheflush.h  |    2 +-
 arch/arm64/include/asm/thread_info.h |   12 ++++++
 arch/arm64/kernel/sys_compat.c       |   77 ++++++++++++++++++++++++----------
 arch/arm64/mm/cache.S                |    6 ++-
 4 files changed, 74 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 689b637..7ae31a2 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -73,7 +73,7 @@ extern void flush_cache_all(void);
 extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void flush_icache_range(unsigned long start, unsigned long end);
 extern void __flush_dcache_area(void *addr, size_t len);
-extern void __flush_cache_user_range(unsigned long start, unsigned long end);
+extern long __flush_cache_user_range(unsigned long start, unsigned long end);
 
 static inline void flush_cache_mm(struct mm_struct *mm)
 {
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 459bf8e..61ea595 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -39,6 +39,15 @@ struct exec_domain;
 
 typedef unsigned long mm_segment_t;
 
+struct compat_restart_block {
+	union {
+		/* For user cache flushing */
+		struct {
+			unsigned long start;
+			unsigned long end;
+		} cache;
+	};
+};
 /*
  * low level task data that entry.S needs immediate access to.
  * __switch_to() assumes cpu_context follows immediately after cpu_domain.
@@ -51,6 +60,9 @@ struct thread_info {
 	struct restart_block	restart_block;
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
 	int			cpu;		/* cpu */
+#ifdef CONFIG_COMPAT
+	struct compat_restart_block     compat_restart_block;
+#endif
 };
 
 #define INIT_THREAD_INFO(tsk)						\
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index dc47e53..7139637 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -28,29 +28,65 @@
 #include <asm/cacheflush.h>
 #include <asm/unistd.h>
 
-static inline void
-do_compat_cache_op(unsigned long start, unsigned long end, int flags)
+static long do_compat_cache_op_restart(struct restart_block *);
+
+static long
+__do_compat_cache_op(unsigned long start, unsigned long end)
 {
-	struct mm_struct *mm = current->active_mm;
-	struct vm_area_struct *vma;
+	long ret;
 
-	if (end < start || flags)
-		return;
-
-	down_read(&mm->mmap_sem);
-	vma = find_vma(mm, start);
-	if (vma && vma->vm_start < end) {
-		if (start < vma->vm_start)
-			start = vma->vm_start;
-		if (end > vma->vm_end)
-			end = vma->vm_end;
-		up_read(&mm->mmap_sem);
-		__flush_cache_user_range(start & PAGE_MASK, PAGE_ALIGN(end));
-		return;
-	}
-	up_read(&mm->mmap_sem);
+	do {
+		unsigned long chunk = min(PAGE_SIZE, end - start);
+
+		if (signal_pending(current)) {
+			struct thread_info *ti = current_thread_info();
+
+			ti->restart_block = (struct restart_block) {
+				.fn     = do_compat_cache_op_restart,
+			};
+
+			ti->compat_restart_block = (struct compat_restart_block) {
+				{
+					.cache = {
+						.start  = start,
+						.end    = end,
+					},
+				},
+			};
+
+			return -ERESTART_RESTARTBLOCK;
+		}
+		ret = __flush_cache_user_range(start, start + chunk);
+		if (ret)
+			return ret;
+
+		cond_resched();
+		start += chunk;
+	} while (start < end);
+
+	return 0;
 }
 
+static long do_compat_cache_op_restart(struct restart_block *unused)
+{
+	struct compat_restart_block *restart_block;
+
+	restart_block = &current_thread_info()->compat_restart_block;
+	return __do_compat_cache_op(restart_block->cache.start,
+				    restart_block->cache.end);
+}
+
+static inline long
+do_compat_cache_op(unsigned long start, unsigned long end, int flags)
+{
+	if (end < start || flags)
+		return -EINVAL;
+
+	if (!access_ok(VERIFY_READ, start, end - start))
+		return -EFAULT;
+
+	return __do_compat_cache_op(start, end);
+}
 /*
  * Handle all unrecognised system calls.
  */
@@ -74,8 +110,7 @@ long compat_arm_syscall(struct pt_regs *regs)
 	 * the specified region).
 	 */
 	case __ARM_NR_compat_cacheflush:
-		do_compat_cache_op(regs->regs[0], regs->regs[1], regs->regs[2]);
-		return 0;
+		return do_compat_cache_op(regs->regs[0], regs->regs[1], regs->regs[2]);
 
 	case __ARM_NR_compat_set_tls:
 		current->thread.tp_value = regs->regs[0];
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 2366383..d41899f 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -17,6 +17,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/errno.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
@@ -138,9 +139,12 @@ USER(9f, ic	ivau, x4	)		// invalidate I line PoU
 	add	x4, x4, x2
 	cmp	x4, x1
 	b.lo	1b
-9:						// ignore any faulting cache operation
 	dsb	ish
 	isb
+	mov	x0, #0
+	ret
+9:
+	mov	x0, #-EFAULT
 	ret
 ENDPROC(flush_icache_range)
 ENDPROC(__flush_cache_user_range)
-- 
1.7.9.5
