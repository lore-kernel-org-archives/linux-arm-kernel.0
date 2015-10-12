From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Oct 2015 15:04:50 +0100
Subject: [PATCH] arm64: kvm: restore EL1N SP for panic
Message-ID: <1444658690-8180-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we panic in hyp mode, we inject a call to panic() into the EL1N host
kernel. If a guest context is active, we first attempt to restore the
minimal amount of state necessary to execute the host kernel with
restore_sysregs.

However, the SP is restored as part of restore_common_regs, and so we
may return to the host's panic() function with the SP of the guest. Any
calculations based on the SP will be bogus, and any attempt to access
the stack will result in recursive data aborts.

When running Linux as a guest, the guest's EL1N SP is like to be some
valid kernel address. In this case, the host kernel may use that region
as a stack for panic(), corrupting it in the process.

Avoid the problem by restoring the host SP prior to returning to the
host. To prevent misleading backtraces in the host, the FP is zeroed at
the same time. We don't need any of the other "common" registers in
order to panic successfully.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: <kvmarm@lists.cs.columbia.edu>
---
 arch/arm64/kvm/hyp.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index e583613..1599701 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -880,6 +880,14 @@ __kvm_hyp_panic:
 
 	bl __restore_sysregs
 
+	/*
+	 * Make sure we have a valid host stack, and don't leave junk in the
+	 * frame pointer that will give us a misleading host stack unwinding.
+	 */
+	ldr	x22, [x2, #CPU_GP_REG_OFFSET(CPU_SP_EL1)]
+	msr	sp_el1, x22
+	mov	x29, xzr
+
 1:	adr	x0, __hyp_panic_str
 	adr	x1, 2f
 	ldp	x2, x3, [x1]
-- 
1.9.1
