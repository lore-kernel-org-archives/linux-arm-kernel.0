From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 24 May 2018 17:56:36 +0100
Subject: [PATCH v11 07/19] arm64: fpsimd: Avoid FPSIMD context leakage for the
 init task
In-Reply-To: <1527181008-13549-1-git-send-email-Dave.Martin@arm.com>
References: <1527181008-13549-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1527181008-13549-8-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init task is started with thread_flags equal to 0, which means
that TIF_FOREIGN_FPSTATE is initially clear.

It is theoretically possible (if unlikely) that the init task could
reach userspace without ever being scheduled out.  If this occurs,
data left in the FPSIMD registers by the kernel could be exposed.

This patch fixes this anomaly by ensuring that the init task's
initial TIF_FOREIGN_FPSTATE is set.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Fixes: 005f78cd8849 ("arm64: defer reloading a task's FPSIMD state to userland resume")
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

---

Changes since v10:

 * New patch.
---
 arch/arm64/include/asm/thread_info.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 740aa03c..af271f9 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -45,12 +45,6 @@ struct thread_info {
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
 };
 
-#define INIT_THREAD_INFO(tsk)						\
-{									\
-	.preempt_count	= INIT_PREEMPT_COUNT,				\
-	.addr_limit	= KERNEL_DS,					\
-}
-
 #define thread_saved_pc(tsk)	\
 	((unsigned long)(tsk->thread.cpu_context.pc))
 #define thread_saved_sp(tsk)	\
@@ -117,5 +111,12 @@ void arch_release_task_struct(struct task_struct *tsk);
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
 				 _TIF_NOHZ)
 
+#define INIT_THREAD_INFO(tsk)						\
+{									\
+	.flags		= _TIF_FOREIGN_FPSTATE,				\
+	.preempt_count	= INIT_PREEMPT_COUNT,				\
+	.addr_limit	= KERNEL_DS,					\
+}
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_THREAD_INFO_H */
-- 
2.1.4
