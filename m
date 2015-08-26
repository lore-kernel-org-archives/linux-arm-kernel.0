From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Wed, 26 Aug 2015 10:40:41 +0800
Subject: [PATCH] arm64: fix bug for reloading FPSIMD state after execve on cpu
 0.
Message-ID: <1440556841-17219-1-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Janet Liu <janet.liu@spreadtrum.com>

If process A is running on CPU 0 and do execve syscall and after sched_exec,
dest_cpu is 0, fpsimd_state.cpu is 0. If at the time Process A get scheduled
out and after some kernel threads running on CPU 0, process A is back in CPU 0,
A's fpsimd_state.cpu is current cpu id "0", and per_cpu(fpsimd_last_state)
points A's fpsimd_state, TIF_FOREIGN_FPSTATE will be clear, kernel will not
reload the context during it return to userspace. so set the cpu's
fpsimd_last_state to NULL to avoid this.

Signed-off-by: Janet Liu <janet.liu@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 arch/arm64/kernel/fpsimd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 44d6f75..ec58d94 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -159,6 +159,7 @@ void fpsimd_flush_thread(void)
 {
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
+	this_cpu_write(fpsimd_last_state, NULL);
 }
 
 /*
-- 
1.7.9.5
