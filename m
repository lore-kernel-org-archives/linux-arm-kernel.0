From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu, 16 Nov 2017 15:39:20 +0000
Subject: [PATCH v3 2/3] kvm: arm64: handle single-stepping trapped instructions
In-Reply-To: <20171116153921.21991-1-alex.bennee@linaro.org>
References: <20171116153921.21991-1-alex.bennee@linaro.org>
Message-ID: <20171116153921.21991-3-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we are using guest debug to single-step the guest we need to ensure
we exit after emulating the instruction. This only affects
instructions completely emulated by the kernel. For userspace emulated
instructions we need to exit and return to complete the emulation.

The kvm_arm_handle_step_debug() helper sets up the necessary exit
state if needed.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
---
v2
  - use helper from patch 1
  - if (handled > 0) instead of if (handled) so errors propagate
---
 arch/arm64/kvm/handle_exit.c | 47 +++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 7debb74843a0..af1c804742f6 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -178,6 +178,38 @@ static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
 	return arm_exit_handlers[hsr_ec];
 }
 
+/*
+ * We may be single-stepping an emulated instruction. If the emulation
+ * has been completed in-kernel we can return to userspace with a
+ * KVM_EXIT_DEBUG, otherwise the userspace needs to complete its
+ * emulation first.
+ */
+
+static int handle_trap_exceptions(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	int handled;
+
+	/*
+	 * See ARM ARM B1.14.1: "Hyp traps on instructions
+	 * that fail their condition code check"
+	 */
+	if (!kvm_condition_valid(vcpu)) {
+		kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+		handled = 1;
+	} else {
+		exit_handle_fn exit_handler;
+
+		exit_handler = kvm_get_exit_handler(vcpu);
+		handled = exit_handler(vcpu, run);
+	}
+
+	/* helper sets exit_reason if we need to return to userspace */
+	if (handled > 0 && kvm_arm_handle_step_debug(vcpu, run))
+		handled = 0;
+
+	return handled;
+}
+
 /*
  * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
  * proper exit to userspace.
@@ -185,8 +217,6 @@ static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
 int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		       int exception_index)
 {
-	exit_handle_fn exit_handler;
-
 	if (ARM_SERROR_PENDING(exception_index)) {
 		u8 hsr_ec = ESR_ELx_EC(kvm_vcpu_get_hsr(vcpu));
 
@@ -214,18 +244,7 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		kvm_inject_vabt(vcpu);
 		return 1;
 	case ARM_EXCEPTION_TRAP:
-		/*
-		 * See ARM ARM B1.14.1: "Hyp traps on instructions
-		 * that fail their condition code check"
-		 */
-		if (!kvm_condition_valid(vcpu)) {
-			kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
-			return 1;
-		}
-
-		exit_handler = kvm_get_exit_handler(vcpu);
-
-		return exit_handler(vcpu, run);
+		return handle_trap_exceptions(vcpu, run);
 	case ARM_EXCEPTION_HYP_GONE:
 		/*
 		 * EL2 has been reset to the hyp-stub. This happens when a guest
-- 
2.15.0
