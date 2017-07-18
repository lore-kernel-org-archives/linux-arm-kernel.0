From: jintack.lim@linaro.org (Jintack Lim)
Date: Tue, 18 Jul 2017 11:58:32 -0500
Subject: [RFC PATCH v2 06/38] KVM: arm64: Add vcpu_mode_el2 primitive to
 support nesting
In-Reply-To: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
References: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1500397144-16232-7-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

When running a nested hypervisor we occasionally have to figure out if
the mode we are switching into is the virtual EL2 mode or a regular
EL0/1 mode.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_emulate.h   |  6 ++++++
 arch/arm64/include/asm/kvm_emulate.h | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 9a8a45a..399cd75e 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -77,6 +77,12 @@ static inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+/* We don't support nesting on arm */
+static inline bool vcpu_mode_el2(const struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
 static inline unsigned long *vcpu_pc(struct kvm_vcpu *vcpu)
 {
 	return &vcpu->arch.ctxt.gp_regs.usr_regs.ARM_pc;
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index fe39e68..5d6f3d0 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -143,6 +143,18 @@ static inline bool vcpu_mode_priv(const struct kvm_vcpu *vcpu)
 	return mode != PSR_MODE_EL0t;
 }
 
+static inline bool vcpu_mode_el2(const struct kvm_vcpu *vcpu)
+{
+	u32 mode;
+
+	if (vcpu_mode_is_32bit(vcpu))
+		return false;
+
+	mode = *vcpu_cpsr(vcpu) & PSR_MODE_MASK;
+
+	return mode == PSR_MODE_EL2h || mode == PSR_MODE_EL2t;
+}
+
 static inline u32 kvm_vcpu_get_hsr(const struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.fault.esr_el2;
-- 
1.9.1
