From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 12 Jan 2018 13:07:34 +0100
Subject: [PATCH v3 28/41] KVM: arm64: Prepare to handle deferred save/restore
 of ELR_EL1
In-Reply-To: <20180112120747.27999-1-christoffer.dall@linaro.org>
References: <20180112120747.27999-1-christoffer.dall@linaro.org>
Message-ID: <20180112120747.27999-29-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ELR_EL1 is not used by a VHE host kernel and can be deferred, but we
need to rework the accesses to this register to access the latest value
depending on whether or not guest system registers are loaded on the CPU
or only reside in memory.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 18 +++++++++++++++++-
 arch/arm64/kvm/inject_fault.c        |  4 ++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index f0bc7c096fdc..c9ca2dc579c7 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -78,11 +78,27 @@ static inline unsigned long *vcpu_pc(const struct kvm_vcpu *vcpu)
 	return (unsigned long *)&vcpu_gp_regs(vcpu)->regs.pc;
 }
 
-static inline unsigned long *vcpu_elr_el1(const struct kvm_vcpu *vcpu)
+static inline unsigned long *__vcpu_elr_el1(const struct kvm_vcpu *vcpu)
 {
 	return (unsigned long *)&vcpu_gp_regs(vcpu)->elr_el1;
 }
 
+static inline unsigned long vcpu_read_elr_el1(const struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.sysregs_loaded_on_cpu)
+		return read_sysreg_el1(elr);
+	else
+		return *__vcpu_elr_el1(vcpu);
+}
+
+static inline void vcpu_write_elr_el1(const struct kvm_vcpu *vcpu, unsigned long v)
+{
+	if (vcpu->arch.sysregs_loaded_on_cpu)
+		write_sysreg_el1(v, elr);
+	else
+		*__vcpu_elr_el1(vcpu) = v;
+}
+
 static inline unsigned long *vcpu_cpsr(const struct kvm_vcpu *vcpu)
 {
 	return (unsigned long *)&vcpu_gp_regs(vcpu)->regs.pstate;
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index c638593d305d..8425e20f1cc9 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -67,7 +67,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
 	bool is_aarch32 = vcpu_mode_is_32bit(vcpu);
 	u32 esr = 0;
 
-	*vcpu_elr_el1(vcpu) = *vcpu_pc(vcpu);
+	vcpu_write_elr_el1(vcpu, *vcpu_pc(vcpu));
 	*vcpu_pc(vcpu) = get_except_vector(vcpu, except_type_sync);
 
 	*vcpu_cpsr(vcpu) = PSTATE_FAULT_BITS_64;
@@ -102,7 +102,7 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
 	unsigned long cpsr = *vcpu_cpsr(vcpu);
 	u32 esr = (ESR_ELx_EC_UNKNOWN << ESR_ELx_EC_SHIFT);
 
-	*vcpu_elr_el1(vcpu) = *vcpu_pc(vcpu);
+	vcpu_write_elr_el1(vcpu, *vcpu_pc(vcpu));
 	*vcpu_pc(vcpu) = get_except_vector(vcpu, except_type_sync);
 
 	*vcpu_cpsr(vcpu) = PSTATE_FAULT_BITS_64;
-- 
2.14.2
