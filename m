From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  4 Aug 2016 13:40:36 +0200
Subject: [PULL 8/8] arm64: KVM: Set cpsr before spsr on fault injection
In-Reply-To: <1470310836-10371-1-git-send-email-christoffer.dall@linaro.org>
References: <1470310836-10371-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1470310836-10371-9-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jones <drjones@redhat.com>

We need to set cpsr before determining the spsr bank, as the bank
depends on the target exception level of the injection, not the
current mode of the vcpu. Normally this is one in the same (EL1),
but not when we manage to trap an EL0 fault. It still doesn't really
matter for the 64-bit EL0 case though, as vcpu_spsr() unconditionally
uses the EL1 bank for that. However the 32-bit EL0 case gets fun, as
that path will lead to the BUG() in vcpu_spsr32().

This patch fixes the assignment order and also modifies some white
space in order to better group pairs of lines that have strict order.

Cc: stable at vger.kernel.org # v4.5
Signed-off-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/inject_fault.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index e9e0e6d..898c0e6 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -132,16 +132,14 @@ static u64 get_except_vector(struct kvm_vcpu *vcpu, enum exception_type type)
 static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
 {
 	unsigned long cpsr = *vcpu_cpsr(vcpu);
-	bool is_aarch32;
+	bool is_aarch32 = vcpu_mode_is_32bit(vcpu);
 	u32 esr = 0;
 
-	is_aarch32 = vcpu_mode_is_32bit(vcpu);
-
-	*vcpu_spsr(vcpu) = cpsr;
 	*vcpu_elr_el1(vcpu) = *vcpu_pc(vcpu);
-
 	*vcpu_pc(vcpu) = get_except_vector(vcpu, except_type_sync);
+
 	*vcpu_cpsr(vcpu) = PSTATE_FAULT_BITS_64;
+	*vcpu_spsr(vcpu) = cpsr;
 
 	vcpu_sys_reg(vcpu, FAR_EL1) = addr;
 
@@ -172,11 +170,11 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
 	unsigned long cpsr = *vcpu_cpsr(vcpu);
 	u32 esr = (ESR_ELx_EC_UNKNOWN << ESR_ELx_EC_SHIFT);
 
-	*vcpu_spsr(vcpu) = cpsr;
 	*vcpu_elr_el1(vcpu) = *vcpu_pc(vcpu);
-
 	*vcpu_pc(vcpu) = get_except_vector(vcpu, except_type_sync);
+
 	*vcpu_cpsr(vcpu) = PSTATE_FAULT_BITS_64;
+	*vcpu_spsr(vcpu) = cpsr;
 
 	/*
 	 * Build an unknown exception, depending on the instruction
-- 
1.9.1
