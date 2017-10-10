From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 10 Oct 2017 19:38:34 +0100
Subject: [PATCH v3 17/28] arm64/sve: Preserve SVE registers around kernel-mode
 NEON use
In-Reply-To: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1507660725-7986-18-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel-mode NEON will corrupt the SVE vector registers, due to the
way they alias the FPSIMD vector registers in the hardware.

This patch ensures that any live SVE register content for the task
is saved by kernel_neon_begin().  The data will be restored in the
usual way on return to userspace.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
---
 arch/arm64/kernel/fpsimd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5673f50..b1d383a 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -909,8 +909,10 @@ void kernel_neon_begin(void)
 	__this_cpu_write(kernel_neon_busy, true);
 
 	/* Save unsaved task fpsimd state, if any: */
-	if (current->mm && !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
-		fpsimd_save_state(&current->thread.fpsimd_state);
+	if (current->mm) {
+		task_fpsimd_save();
+		set_thread_flag(TIF_FOREIGN_FPSTATE);
+	}
 
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	__this_cpu_write(fpsimd_last_state, NULL);
-- 
2.1.4
