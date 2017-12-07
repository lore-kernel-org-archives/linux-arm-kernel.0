From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  7 Dec 2017 18:06:19 +0100
Subject: [PATCH v2 25/36] KVM: arm64: Prepare to handle traps on deferred
 AArch32 sysregs
In-Reply-To: <20171207170630.592-1-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
Message-ID: <20171207170630.592-26-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handle accesses to any AArch32 EL1 system registers where we can defer
saving and restoring them to vcpu_load and vcpu_put, and which are
stored in special EL2 registers only used support 32-bit guests.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 3f765b9de94d..e7234f823cba 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -91,9 +91,16 @@ static inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
 /* Set the SPSR for the current mode */
 static inline void vcpu_set_spsr(struct kvm_vcpu *vcpu, u64 val)
 {
-	if (vcpu_mode_is_32bit(vcpu))
+	if (vcpu_mode_is_32bit(vcpu)) {
+		if (vcpu->arch.sysregs_loaded_on_cpu)
+			__sysreg32_save_state(vcpu);
+
 		*vcpu_spsr32(vcpu) = val;
 
+		if (vcpu->arch.sysregs_loaded_on_cpu)
+			__sysreg32_restore_state(vcpu);
+	}
+
 	if (vcpu->arch.sysregs_loaded_on_cpu)
 		write_sysreg_el1(val, spsr);
 	else
-- 
2.14.2
