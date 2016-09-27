From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:17 +0200
Subject: [PULL 09/50] arm64: KVM: VHE: reset PSTATE.PAN on entry to EL2
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-10-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

SCTLR_EL2.SPAN bit controls what happens with the PSTATE.PAN bit on an
exception. However, this bit has no effect on the PSTATE.PAN when
HCR_EL2.E2H or HCR_EL2.TGE is unset. Thus when VHE is used and
exception taken from a guest PSTATE.PAN bit left unchanged and we
continue with a value guest has set.

To address that always reset PSTATE.PAN on entry from EL1.

Fixes: 1f364c8c48a0 ("arm64: VHE: Add support for running Linux in EL2 mode")

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: <stable@vger.kernel.org> # v4.6+
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 3967c231..b5926ee 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -96,6 +96,8 @@ ENTRY(__guest_exit)
 
 	add	x1, x1, #VCPU_CONTEXT
 
+	ALTERNATIVE(nop, SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)
+
 	// Store the guest regs x2 and x3
 	stp	x2, x3,   [x1, #CPU_XREG_OFFSET(2)]
 
-- 
2.9.0
