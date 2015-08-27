From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 27 Aug 2015 08:12:33 +0200
Subject: [PATCH] arm64: flush FP/SIMD state correctly after execve()
Message-ID: <1440655953-31431-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a task calls execve(), its FP/SIMD state is flushed so that
none of the original program state is observeable by the incoming
program.

However, since this flushing consists of setting the in-memory copy
of the FP/SIMD state to all zeroes, the CPU field is set to CPU 0 as
well, which indicates to the lazy FP/SIMD preserve/restore code that
the FP/SIMD state does not need to be reread from memory if the task
is scheduled again on CPU 0 without any other tasks having entered
userland (or used the FP/SIMD in kernel mode) on the same CPU in the
mean time. If this happens, the FP/SIMD state of the old program will
still be present in the registers when the new program starts.

So set the CPU field to the invalid value of NR_CPUS when performing
the flush, by calling fpsimd_flush_task_state().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/fpsimd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 44d6f7545505..c56956a16d3f 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -158,6 +158,7 @@ void fpsimd_thread_switch(struct task_struct *next)
 void fpsimd_flush_thread(void)
 {
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
+	fpsimd_flush_task_state(current);
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 }
 
-- 
1.9.1
