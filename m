From: julien.thierry@arm.com (Julien Thierry)
Date: Tue,  3 Oct 2017 18:05:52 +0100
Subject: [PATCH REPOST 3/3] arm64: kvm: Fix single step for guest skipped
 instructions
In-Reply-To: <1507050352-15909-1-git-send-email-julien.thierry@arm.com>
References: <1507050352-15909-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1507050352-15909-4-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Software Step exception is missing after trapping instruction from the guest.

We need to set the PSR.SS to 0 for the guest vcpu before resuming guest
execution.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Alex Benn?e <alex.bennee@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>

---
 arch/arm64/include/asm/kvm_asm.h     |  2 ++
 arch/arm64/include/asm/kvm_emulate.h |  2 ++
 arch/arm64/kvm/debug.c               | 17 ++++++++++++++++-
 arch/arm64/kvm/hyp/switch.c          | 10 ++++++++++
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 26a64d0..398bbaa 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -32,6 +32,8 @@

 #define KVM_ARM64_DEBUG_DIRTY_SHIFT	0
 #define KVM_ARM64_DEBUG_DIRTY		(1 << KVM_ARM64_DEBUG_DIRTY_SHIFT)
+#define KVM_ARM64_DEBUG_INST_SKIP_SHIFT	1
+#define KVM_ARM64_DEBUG_INST_SKIP	(1 << KVM_ARM64_DEBUG_INST_SKIP_SHIFT)

 #define kvm_ksym_ref(sym)						\
 	({								\
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index e5df3fc..ee02dd2ee 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -95,6 +95,8 @@ static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
 		kvm_skip_instr32(vcpu, is_wide_instr);
 	else
 		*vcpu_pc(vcpu) += 4;
+	/* Let debug engine know we skipped an instruction */
+	vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_INST_SKIP;
 }

 static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index dbadfaf..b5fcb96 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -151,12 +151,27 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
 		 * debugging the system.
 		 */
 		if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
-			*vcpu_cpsr(vcpu) |=  DBG_SPSR_SS;
+			/*
+			 * Taking a Software step exception, context being
+			 * stepped has PSTATE.SS == 0. In order to step the next
+			 * instruction, we need to reset this bit.
+			 * If we skipped an instruction while single stepping,
+			 * we want to get a software step exception for the
+			 * skipped instruction (i.e. as soon as we return to the
+			 * guest). This is obtained by returning to the guest
+			 * with PSTATE.SS cleared.
+			 */
+			if (!(vcpu->arch.debug_flags & KVM_ARM64_DEBUG_INST_SKIP))
+				*vcpu_cpsr(vcpu) |=  DBG_SPSR_SS;
+			else
+				*vcpu_cpsr(vcpu) &=  ~DBG_SPSR_SS;
 			vcpu_sys_reg(vcpu, MDSCR_EL1) |= DBG_MDSCR_SS;
 		} else {
 			vcpu_sys_reg(vcpu, MDSCR_EL1) &= ~DBG_MDSCR_SS;
 		}

+		vcpu->arch.debug_flags &= ~KVM_ARM64_DEBUG_INST_SKIP;
+
 		trace_kvm_arm_set_dreg32("SPSR_EL2", *vcpu_cpsr(vcpu));

 		/*
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 945e79c..34fe215 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -22,6 +22,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 #include <asm/fpsimd.h>
+#include <asm/debug-monitors.h>

 static bool __hyp_text __fpsimd_enabled_nvhe(void)
 {
@@ -276,6 +277,8 @@ static void __hyp_text __skip_instr(struct kvm_vcpu *vcpu)
 	}

 	write_sysreg_el2(*vcpu_pc(vcpu), elr);
+
+	write_sysreg_el2(read_sysreg_el2(spsr) & ~DBG_SPSR_SS, spsr);
 }

 int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
@@ -343,6 +346,13 @@ int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 			if (ret == -1) {
 				/* Promote an illegal access to an SError */
 				__skip_instr(vcpu);
+
+				/*
+				 * We're not jumping back, let debug setup know
+				 * we skipped an instruction.
+				 */
+				vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_INST_SKIP;
+
 				exit_code = ARM_EXCEPTION_EL1_SERROR;
 			}

--
1.9.1
