From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 28 Sep 2018 14:39:11 +0100
Subject: [RFC PATCH v2 07/23] arm64/sve: Enable SVE state tracking for
 non-task contexts
In-Reply-To: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1538141967-15375-8-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current FPSIMD/SVE context handling support for non-task (i.e.,
KVM vcpu) contexts does not take SVE into account.  This means that
only task contexts can safely use SVE at present.

In preparation for enabling KVM guests to use SVE, it is necessary
to keep track of SVE state for non-task contexts too.

This patch adds the necessary support, removing assumptions from
the context switch code about the location of the SVE context
storage.

When binding a vcpu context, its vector length is arbitrarily
specified as sve_max_vl for now.  In any case, because TIF_SVE is
presently cleared at vcpu context bind time, the specified vector
length will not be used for anything yet.  In later patches TIF_SVE
will be set here as appropriate, and the appropriate maximum vector
length for the vcpu will be passed when binding.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
---
 arch/arm64/include/asm/fpsimd.h |  3 ++-
 arch/arm64/kernel/fpsimd.c      | 20 +++++++++++++++-----
 arch/arm64/kvm/fpsimd.c         |  4 +++-
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 964adc9..df7a143 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -56,7 +56,8 @@ extern void fpsimd_restore_current_state(void);
 extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
 
 extern void fpsimd_bind_task_to_cpu(void);
-extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state);
+extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
+				     void *sve_state, unsigned int sve_vl);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
 extern void fpsimd_flush_cpu_state(void);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index d28042b..60c5e28 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -121,6 +121,8 @@
  */
 struct fpsimd_last_state_struct {
 	struct user_fpsimd_state *st;
+	void *sve_state;
+	unsigned int sve_vl;
 };
 
 static DEFINE_PER_CPU(struct fpsimd_last_state_struct, fpsimd_last_state);
@@ -241,14 +243,15 @@ static void task_fpsimd_load(void)
  */
 void fpsimd_save(void)
 {
-	struct user_fpsimd_state *st = __this_cpu_read(fpsimd_last_state.st);
+	struct fpsimd_last_state_struct const *last =
+		this_cpu_ptr(&fpsimd_last_state);
 	/* set by fpsimd_bind_task_to_cpu() or fpsimd_bind_state_to_cpu() */
 
 	WARN_ON(!in_softirq() && !irqs_disabled());
 
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
-			if (WARN_ON(sve_get_vl() != current->thread.sve_vl)) {
+			if (WARN_ON(sve_get_vl() != last->sve_vl)) {
 				/*
 				 * Can't save the user regs, so current would
 				 * re-enter user with corrupt state.
@@ -258,9 +261,11 @@ void fpsimd_save(void)
 				return;
 			}
 
-			sve_save_state(sve_pffr(&current->thread), &st->fpsr);
+			sve_save_state((char *)last->sve_state +
+						sve_ffr_offset(last->sve_vl),
+				       &last->st->fpsr);
 		} else
-			fpsimd_save_state(st);
+			fpsimd_save_state(last->st);
 	}
 }
 
@@ -1035,6 +1040,8 @@ void fpsimd_bind_task_to_cpu(void)
 		this_cpu_ptr(&fpsimd_last_state);
 
 	last->st = &current->thread.uw.fpsimd_state;
+	last->sve_state = current->thread.sve_state;
+	last->sve_vl = current->thread.sve_vl;
 	current->thread.fpsimd_cpu = smp_processor_id();
 
 	if (system_supports_sve()) {
@@ -1048,7 +1055,8 @@ void fpsimd_bind_task_to_cpu(void)
 	}
 }
 
-void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st)
+void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
+			      unsigned int sve_vl)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1056,6 +1064,8 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st)
 	WARN_ON(!in_softirq() && !irqs_disabled());
 
 	last->st = st;
+	last->sve_state = sve_state;
+	last->sve_vl = sve_vl;
 }
 
 /*
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index aac7808..55654cb 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -85,7 +85,9 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 	WARN_ON_ONCE(!irqs_disabled());
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
-		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.gp_regs.fp_regs);
+		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.gp_regs.fp_regs,
+					 NULL, sve_max_vl);
+
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
 		clear_thread_flag(TIF_SVE);
 	}
-- 
2.1.4
