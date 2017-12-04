From: cdall@kernel.org (Christoffer Dall)
Date: Mon,  4 Dec 2017 15:03:43 +0100
Subject: [PULL 14/19] kvm: arm64: handle single-step of hyp emulated mmio
 instructions
In-Reply-To: <20171204135637.21620-1-cdall@kernel.org>
References: <20171204135637.21620-1-cdall@kernel.org>
Message-ID: <20171204140348.21965-12-cdall@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alex Benn?e <alex.bennee@linaro.org>

There is a fast-path of MMIO emulation inside hyp mode. The handling
of single-step is broadly the same as kvm_arm_handle_step_debug()
except we just setup ESR/HSR so handle_exit() does the correct thing
as we exit.

For the case of an emulated illegal access causing an SError we will
exit via the ARM_EXCEPTION_EL1_SERROR path in handle_exit(). We behave
as we would during a real SError and clear the DBG_SPSR_SS bit for the
emulated instruction.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 525c01f48867..f7c651f3a8c0 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -22,6 +22,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 #include <asm/fpsimd.h>
+#include <asm/debug-monitors.h>
 
 static bool __hyp_text __fpsimd_enabled_nvhe(void)
 {
@@ -269,7 +270,11 @@ static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
 	return true;
 }
 
-static void __hyp_text __skip_instr(struct kvm_vcpu *vcpu)
+/* Skip an instruction which has been emulated. Returns true if
+ * execution can continue or false if we need to exit hyp mode because
+ * single-step was in effect.
+ */
+static bool __hyp_text __skip_instr(struct kvm_vcpu *vcpu)
 {
 	*vcpu_pc(vcpu) = read_sysreg_el2(elr);
 
@@ -282,6 +287,14 @@ static void __hyp_text __skip_instr(struct kvm_vcpu *vcpu)
 	}
 
 	write_sysreg_el2(*vcpu_pc(vcpu), elr);
+
+	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
+		vcpu->arch.fault.esr_el2 =
+			(ESR_ELx_EC_SOFTSTP_LOW << ESR_ELx_EC_SHIFT) | 0x22;
+		return false;
+	} else {
+		return true;
+	}
 }
 
 int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
@@ -342,13 +355,21 @@ int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 			int ret = __vgic_v2_perform_cpuif_access(vcpu);
 
 			if (ret == 1) {
-				__skip_instr(vcpu);
-				goto again;
+				if (__skip_instr(vcpu))
+					goto again;
+				else
+					exit_code = ARM_EXCEPTION_TRAP;
 			}
 
 			if (ret == -1) {
-				/* Promote an illegal access to an SError */
-				__skip_instr(vcpu);
+				/* Promote an illegal access to an
+				 * SError. If we would be returning
+				 * due to single-step clear the SS
+				 * bit so handle_exit knows what to
+				 * do after dealing with the error.
+				 */
+				if (!__skip_instr(vcpu))
+					*vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
 				exit_code = ARM_EXCEPTION_EL1_SERROR;
 			}
 
@@ -363,8 +384,10 @@ int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 		int ret = __vgic_v3_perform_cpuif_access(vcpu);
 
 		if (ret == 1) {
-			__skip_instr(vcpu);
-			goto again;
+			if (__skip_instr(vcpu))
+				goto again;
+			else
+				exit_code = ARM_EXCEPTION_TRAP;
 		}
 
 		/* 0 falls through to be handled out of EL2 */
-- 
2.14.2
