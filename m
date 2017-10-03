From: jintack.lim@linaro.org (Jintack Lim)
Date: Mon,  2 Oct 2017 22:11:13 -0500
Subject: [RFC PATCH v2 31/31] KVM: arm64: Fixes to toggle_cache for nesting
In-Reply-To: <1507000273-3735-1-git-send-email-jintack.lim@linaro.org>
References: <1507000273-3735-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1507000273-3735-29-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

So far we were flushing almost the entire universe whenever a VM would
load/unload the SCTLR_EL1 and the two versions of that register had
different MMU enabled settings.  This turned out to be so slow that it
prevented forward progress for a nested VM, because a scheduler timer
tick interrupt would always be pending when we reached the nested VM.

To avoid this problem, we consider the SCTLR_EL2 when evaluating if
caches are on or off when entering virtual EL2 (because this is the
value that we end up shadowing onto the hardware EL1 register).

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
---
 arch/arm64/include/asm/kvm_mmu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 601f431..7a1c581 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -240,7 +240,10 @@ static inline bool kvm_page_empty(void *ptr)
 
 static inline bool vcpu_has_cache_enabled(struct kvm_vcpu *vcpu)
 {
-	return (vcpu_sys_reg(vcpu, SCTLR_EL1) & 0b101) == 0b101;
+	if (vcpu_mode_el2(vcpu))
+		return (vcpu_sys_reg(vcpu, SCTLR_EL2) & 0b101) == 0b101;
+	else
+		return (vcpu_sys_reg(vcpu, SCTLR_EL1) & 0b101) == 0b101;
 }
 
 static inline void __coherent_cache_guest_page(struct kvm_vcpu *vcpu,
-- 
1.9.1
