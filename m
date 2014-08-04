From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  4 Aug 2014 10:46:53 +0200
Subject: [GIT PULL 36/51] ARM64: KVM: store kvm_vcpu_fault_info est_el2 as word
In-Reply-To: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
References: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1407142028-31105-37-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>

esr_el2 field of struct kvm_vcpu_fault_info has u32 type.
It should be stored as word. Current code works in LE case
because existing puts least significant word of x1 into
esr_el2, and it puts most significant work of x1 into next
field, which accidentally is OK because it is updated again
by next instruction. But existing code breaks in BE case.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 5945f3b..7874e02 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -762,7 +762,7 @@ el1_trap:
 	mrs	x2, far_el2
 
 2:	mrs	x0, tpidr_el2
-	str	x1, [x0, #VCPU_ESR_EL2]
+	str	w1, [x0, #VCPU_ESR_EL2]
 	str	x2, [x0, #VCPU_FAR_EL2]
 	str	x3, [x0, #VCPU_HPFAR_EL2]
 
-- 
2.0.0
