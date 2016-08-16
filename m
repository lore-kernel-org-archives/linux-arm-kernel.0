From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 16 Aug 2016 15:03:01 +0100
Subject: [PATCH] arm64: Document workaround for Cortex-A72 erratum #853709
Message-ID: <1471356182-26034-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already have a workaround for Cortex-A57 erratum #852523,
but Cortex-A72 r0p0 to r0p2 do suffer from the same issue
(known as erratum #853709).

Let's document the fact that we already handle this.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/silicon-errata.txt | 1 +
 arch/arm64/kvm/hyp/switch.c            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 4da60b4..ccc6032 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -53,6 +53,7 @@ stable kernels.
 | ARM            | Cortex-A57      | #832075         | ARM64_ERRATUM_832075    |
 | ARM            | Cortex-A57      | #852523         | N/A                     |
 | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220    |
+| ARM            | Cortex-A72      | #853709         | N/A                     |
 | ARM            | MMU-500         | #841119,#826419 | N/A                     |
 |                |                 |                 |                         |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375    |
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index ae7855f..5a84b45 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -256,7 +256,7 @@ static int __hyp_text __guest_run(struct kvm_vcpu *vcpu)
 
 	/*
 	 * We must restore the 32-bit state before the sysregs, thanks
-	 * to Cortex-A57 erratum #852523.
+	 * to erratum #852523 (Cortex-A57) or #853709 (Cortex-A72).
 	 */
 	__sysreg32_restore_state(vcpu);
 	__sysreg_restore_guest_state(guest_ctxt);
-- 
2.1.4
