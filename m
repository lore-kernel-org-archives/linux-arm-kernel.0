From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 03:47:44 +0000
Subject: [PATCH 28/29] arm64: KVM: 32bit guest fault injection
In-Reply-To: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362455265-24165-29-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add fault injection capability for 32bit guests.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/inject_fault.c | 79 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index 80b245f..85a4548 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -1,5 +1,5 @@
 /*
- * Fault injection for 64bit guests.
+ * Fault injection for both 32 and 64bit guests.
  *
  * Copyright (C) 2012 - ARM Ltd
  * Author: Marc Zyngier <marc.zyngier@arm.com>
@@ -24,6 +24,74 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_emulate.h>
 
+static void prepare_fault32(struct kvm_vcpu *vcpu, u32 mode, u32 vect_offset)
+{
+	unsigned long cpsr;
+	unsigned long new_spsr_value = *vcpu_cpsr(vcpu);
+	bool is_thumb = (new_spsr_value & COMPAT_PSR_T_BIT);
+	u32 return_offset = (is_thumb) ? 4 : 0;
+	u32 sctlr = vcpu->arch.cp15[c1_SCTLR];
+
+	cpsr = mode | COMPAT_PSR_I_BIT;
+
+	if (sctlr & (1 << 30))
+		cpsr |= COMPAT_PSR_T_BIT;
+	if (sctlr & (1 << 25))
+		cpsr |= COMPAT_PSR_E_BIT;
+
+	*vcpu_cpsr(vcpu) = cpsr;
+
+	/* Note: These now point to the banked copies */
+	*vcpu_spsr(vcpu) = new_spsr_value;
+	*vcpu_reg(vcpu, 14) = *vcpu_pc(vcpu) + return_offset;
+
+	/* Branch to exception vector */
+	if (sctlr & (1 << 13))
+		vect_offset += 0xffff0000;
+	else /* always have security exceptions */
+		vect_offset += vcpu->arch.cp15[c12_VBAR];
+
+	*vcpu_pc(vcpu) = vect_offset;
+}
+
+static void inject_undef32(struct kvm_vcpu *vcpu)
+{
+	prepare_fault32(vcpu, COMPAT_PSR_MODE_UND, 4);
+}
+
+/*
+ * Modelled after TakeDataAbortException() and TakePrefetchAbortException
+ * pseudocode.
+ */
+static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt,
+			 unsigned long addr)
+{
+	u32 vect_offset;
+	u32 *far, *fsr;
+	bool is_lpae;
+
+	if (is_pabt) {
+		vect_offset = 12;
+		far = &vcpu->arch.cp15[c6_IFAR];
+		fsr = &vcpu->arch.cp15[c5_IFSR];
+	} else { /* !iabt */
+		vect_offset = 16;
+		far = &vcpu->arch.cp15[c6_DFAR];
+		fsr = &vcpu->arch.cp15[c5_DFSR];
+	}
+
+	prepare_fault32(vcpu, COMPAT_PSR_MODE_ABT | COMPAT_PSR_A_BIT, vect_offset);
+
+	*far = addr;
+
+	/* Always give debug fault for now - should give guest a clue */
+	is_lpae = (vcpu->arch.cp15[c2_TTBCR] >> 31);
+	if (is_lpae)
+		*fsr = 1 << 9 | 0x22;
+	else
+		*fsr = 2;
+}
+
 static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
 {
 	unsigned long cpsr = *vcpu_cpsr(vcpu);
@@ -89,6 +157,9 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
  */
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr)
 {
+	if (!(vcpu->arch.hcr_el2 & HCR_RW))
+		inject_abt32(vcpu, false, addr);
+
 	inject_abt64(vcpu, false, addr);
 }
 
@@ -102,6 +173,9 @@ void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr)
  */
 void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr)
 {
+	if (!(vcpu->arch.hcr_el2 & HCR_RW))
+		inject_abt32(vcpu, true, addr);
+
 	inject_abt64(vcpu, true, addr);
 }
 
@@ -113,5 +187,8 @@ void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr)
  */
 void kvm_inject_undefined(struct kvm_vcpu *vcpu)
 {
+	if (!(vcpu->arch.hcr_el2 & HCR_RW))
+		inject_undef32(vcpu);
+
 	inject_undef64(vcpu);
 }
-- 
1.7.12.4
