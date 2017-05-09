From: cdall@linaro.org (Christoffer Dall)
Date: Tue,  9 May 2017 12:44:30 +0200
Subject: [PULL 01/37] arm64: KVM: Fix decoding of Rt/Rt2 when trapping AArch32
 CP accesses
In-Reply-To: <20170509104506.30929-1-cdall@linaro.org>
References: <20170509104506.30929-1-cdall@linaro.org>
Message-ID: <20170509104506.30929-2-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Our 32bit CP14/15 handling inherited some of the ARMv7 code for handling
the trapped system registers, completely missing the fact that the
fields for Rt and Rt2 are now 5 bit wide, and not 4...

Let's fix it, and provide an accessor for the most common Rt case.

Cc: stable at vger.kernel.org
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 6 ++++++
 arch/arm64/kvm/sys_regs.c            | 8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index f5ea0ba..fe39e68 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -240,6 +240,12 @@ static inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_FSC_TYPE;
 }
 
+static inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
+{
+	u32 esr = kvm_vcpu_get_hsr(vcpu);
+	return (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
+}
+
 static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
 {
 	return vcpu_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 8ddcee6..ea9fbb5 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1529,8 +1529,8 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
 {
 	struct sys_reg_params params;
 	u32 hsr = kvm_vcpu_get_hsr(vcpu);
-	int Rt = (hsr >> 5) & 0xf;
-	int Rt2 = (hsr >> 10) & 0xf;
+	int Rt = kvm_vcpu_sys_get_rt(vcpu);
+	int Rt2 = (hsr >> 10) & 0x1f;
 
 	params.is_aarch32 = true;
 	params.is_32bit = false;
@@ -1586,7 +1586,7 @@ static int kvm_handle_cp_32(struct kvm_vcpu *vcpu,
 {
 	struct sys_reg_params params;
 	u32 hsr = kvm_vcpu_get_hsr(vcpu);
-	int Rt  = (hsr >> 5) & 0xf;
+	int Rt  = kvm_vcpu_sys_get_rt(vcpu);
 
 	params.is_aarch32 = true;
 	params.is_32bit = true;
@@ -1688,7 +1688,7 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	struct sys_reg_params params;
 	unsigned long esr = kvm_vcpu_get_hsr(vcpu);
-	int Rt = (esr >> 5) & 0x1f;
+	int Rt = kvm_vcpu_sys_get_rt(vcpu);
 	int ret;
 
 	trace_kvm_handle_sys_reg(esr);
-- 
2.9.0
