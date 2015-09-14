From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Sep 2015 16:06:03 +0100
Subject: [PATCH] KVM: arm64: add workaround for Cortex-A57 erratum #852523
Message-ID: <1442243163-2675-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When restoring the system register state for an AArch32 guest at EL2,
writes to DACR32_EL2 may not be correctly synchronised by Cortex-A57,
which can lead to the guest effectively running with junk in the DACR
and running into unexpected domain faults.

This patch works around the issue by re-ordering our restoration of the
AArch32 register aliases so that they happen before the AArch64 system
registers. Ensuring that the registers are restored in this order
guarantees that they will be correctly synchronised by the core.

Cc: <stable@vger.kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kvm/hyp.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 3c4f641451bb..c4016d411f4a 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -739,6 +739,9 @@ ENTRY(__kvm_vcpu_run)
 	// Guest context
 	add	x2, x0, #VCPU_CONTEXT
 
+	// We must restore the 32-bit state before the sysregs, thanks
+	// to Cortex-A57 erratum #852523.
+	restore_guest_32bit_state
 	bl __restore_sysregs
 
 	skip_debug_state x3, 1f
@@ -746,7 +749,6 @@ ENTRY(__kvm_vcpu_run)
 	kern_hyp_va x3
 	bl	__restore_debug
 1:
-	restore_guest_32bit_state
 	restore_guest_regs
 
 	// That's it, no more messing around.
-- 
2.1.4
