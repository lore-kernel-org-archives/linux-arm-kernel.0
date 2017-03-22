From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:51:01 +0000
Subject: [RFC PATCH v2 31/41] arm64/sve: Set CPU vector length to match
 current task
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-32-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the necessary code to configure the CPU for the
task's vector length, whenever SVE state is loaded for a task.

No special action is needed on sched-out: only user tasks with SVE
state care what the CPU's VL is set to.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/fpsimd.h       |  3 ++-
 arch/arm64/include/asm/fpsimdmacros.h |  7 ++++++-
 arch/arm64/kernel/entry-fpsimd.S      |  2 +-
 arch/arm64/kernel/fpsimd.c            | 10 +++++++---
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 7dba890..557e755 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -97,7 +97,8 @@ extern void fpsimd_save_partial_state(struct fpsimd_partial_state *state,
 extern void fpsimd_load_partial_state(struct fpsimd_partial_state *state);
 
 extern void sve_save_state(void *state, u32 *pfpsr);
-extern void sve_load_state(void const *state, u32 const *pfpsr);
+extern void sve_load_state(void const *state, u32 const *pfpsr,
+			   unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
 extern void __init fpsimd_init_task_struct_size(void);
 extern void *__sve_state(struct task_struct *task);
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index e2bb032..4586468 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -254,7 +254,12 @@
 	.purgem savep
 .endm
 
-.macro sve_load nb, xpfpsr, ntmp
+.macro sve_load nb, xpfpsr, xvqminus1 ntmp
+	mrs_s	x\ntmp, SYS_ZCR_EL1
+	bic	x\ntmp, x\ntmp, ZCR_EL1_LEN_MASK
+	orr	x\ntmp, x\ntmp, \xvqminus1
+	msr_s	SYS_ZCR_EL1, x\ntmp	// self-synchronising
+
 	.macro loadz n
 		_zldrv	\n, \nb, (\n) - 34
 	.endm
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 5dcec55..0a3fdcb 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -73,7 +73,7 @@ ENTRY(sve_save_state)
 ENDPROC(sve_save_state)
 
 ENTRY(sve_load_state)
-	sve_load 0, x1, 2
+	sve_load 0, x1, x2, 3
 	ret
 ENDPROC(sve_load_state)
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index d3f89ac6..09d3d23 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -272,10 +272,14 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 static void task_fpsimd_load(struct task_struct *task)
 {
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
-	    test_tsk_thread_flag(task, TIF_SVE))
+	    test_tsk_thread_flag(task, TIF_SVE)) {
+		unsigned int vl = task->thread.sve_vl;
+
+		BUG_ON(!sve_vl_valid(vl));
 		sve_load_state(sve_pffr(task),
-			       &task->thread.fpsimd_state.fpsr);
-	else
+			       &task->thread.fpsimd_state.fpsr,
+			       sve_vq_from_vl(vl) - 1);
+	} else
 		fpsimd_load_state(&task->thread.fpsimd_state);
 
 	/*
-- 
2.1.4
