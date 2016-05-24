From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 May 2016 11:08:55 +0200
Subject: [PULL 01/59] kvm: arm64: Fix EC field in inject_abt64
In-Reply-To: <1464080993-10884-1-git-send-email-christoffer.dall@linaro.org>
References: <1464080993-10884-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1464080993-10884-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matt Evans <matt.evans@arm.com>

The EC field of the constructed ESR is conditionally modified by ORing in
ESR_ELx_EC_DABT_LOW for a data abort.  However, ESR_ELx_EC_SHIFT is missing
from this condition.

Signed-off-by: Matt Evans <matt.evans@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/inject_fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index 4d1ac81..e9e0e6d 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -162,7 +162,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
 		esr |= (ESR_ELx_EC_IABT_CUR << ESR_ELx_EC_SHIFT);
 
 	if (!is_iabt)
-		esr |= ESR_ELx_EC_DABT_LOW;
+		esr |= ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
 
 	vcpu_sys_reg(vcpu, ESR_EL1) = esr | ESR_ELx_FSC_EXTABT;
 }
-- 
2.1.2.330.g565301e.dirty
