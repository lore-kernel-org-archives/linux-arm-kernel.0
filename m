From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  3 Feb 2016 18:00:10 +0000
Subject: [PATCH v3 17/23] arm64: KVM: VHE: Add fpsimd enabling on guest access
In-Reply-To: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1454522416-6874-18-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Despite the fact that a VHE enabled kernel runs at EL2, it uses
CPACR_EL1 to trap FPSIMD access. Add the required alternative
code to re-enable guest FPSIMD access when it has trapped to
EL2.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/entry.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index fd0fbe9..ce9e5e5 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -130,9 +130,15 @@ ENDPROC(__guest_exit)
 ENTRY(__fpsimd_guest_restore)
 	stp	x4, lr, [sp, #-16]!
 
+alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
 	mrs	x2, cptr_el2
 	bic	x2, x2, #CPTR_EL2_TFP
 	msr	cptr_el2, x2
+alternative_else
+	mrs	x2, cpacr_el1
+	orr	x2, x2, #CPACR_EL1_FPEN
+	msr	cpacr_el1, x2
+alternative_endif
 	isb
 
 	mrs	x3, tpidr_el2
-- 
2.1.4
