From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 24 May 2018 17:56:46 +0100
Subject: [PATCH v11 17/19] KVM: arm64: Remove redundant *exit_code changes in
 fpsimd_guest_exit()
In-Reply-To: <1527181008-13549-1-git-send-email-Dave.Martin@arm.com>
References: <1527181008-13549-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1527181008-13549-18-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In fixup_guest_exit(), there are a couple of cases where after
checking what the exit code was, we assign it explicitly with the
value it already had.

Assuming this is not indicative of a bug, these assignments are not
needed.

This patch removes the redundant assignments, and simplifies some
if-nesting that becomes trivial as a result.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
---
 arch/arm64/kvm/hyp/switch.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index a6a8c7d..18d0faa 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -403,12 +403,8 @@ static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 		if (valid) {
 			int ret = __vgic_v2_perform_cpuif_access(vcpu);
 
-			if (ret == 1) {
-				if (__skip_instr(vcpu))
-					return true;
-				else
-					*exit_code = ARM_EXCEPTION_TRAP;
-			}
+			if (ret ==  1 && __skip_instr(vcpu))
+				return true;
 
 			if (ret == -1) {
 				/* Promote an illegal access to an
@@ -430,12 +426,8 @@ static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_CP15_32)) {
 		int ret = __vgic_v3_perform_cpuif_access(vcpu);
 
-		if (ret == 1) {
-			if (__skip_instr(vcpu))
-				return true;
-			else
-				*exit_code = ARM_EXCEPTION_TRAP;
-		}
+		if (ret == 1 && __skip_instr(vcpu))
+			return true;
 	}
 
 	/* Return to the host kernel and handle the exit */
-- 
2.1.4
