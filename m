From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:52 +0100
Subject: [PATCH v4 24/32] arm64: KVM: 32bit conditional execution emulation
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-25-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As conditional instructions can trap on AArch32, add the thinest
possible emulation layer to keep 32bit guests happy.

Reviewed-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  13 ++-
 arch/arm64/kvm/Makefile              |   2 +-
 arch/arm64/kvm/emulate.c             | 158 +++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/kvm/emulate.c

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 20a1a39..eec0738 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -31,6 +31,9 @@
 unsigned long *vcpu_reg32(const struct kvm_vcpu *vcpu, u8 reg_num);
 unsigned long *vcpu_spsr32(const struct kvm_vcpu *vcpu);
 
+bool kvm_condition_valid32(const struct kvm_vcpu *vcpu);
+void kvm_skip_instr32(struct kvm_vcpu *vcpu, bool is_wide_instr);
+
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
@@ -57,12 +60,18 @@ static inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
 
 static inline bool kvm_condition_valid(const struct kvm_vcpu *vcpu)
 {
-	return true;	/* No conditionals on arm64 */
+	if (vcpu_mode_is_32bit(vcpu))
+		return kvm_condition_valid32(vcpu);
+
+	return true;
 }
 
 static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
 {
-	*vcpu_pc(vcpu) += 4;
+	if (vcpu_mode_is_32bit(vcpu))
+		kvm_skip_instr32(vcpu, is_wide_instr);
+	else
+		*vcpu_pc(vcpu) += 4;
 }
 
 static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index b0f82da..fa78b7d 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -15,7 +15,7 @@ kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/arm.o $(ARM)/mmu.o $(ARM)/mmio.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/psci.o $(ARM)/perf.o
 
-kvm-$(CONFIG_KVM_ARM_HOST) += inject_fault.o regmap.o
+kvm-$(CONFIG_KVM_ARM_HOST) += emulate.o inject_fault.o regmap.o
 kvm-$(CONFIG_KVM_ARM_HOST) += hyp.o hyp-init.o handle_exit.o
 kvm-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_generic_v8.o
 
diff --git a/arch/arm64/kvm/emulate.c b/arch/arm64/kvm/emulate.c
new file mode 100644
index 0000000..124418d
--- /dev/null
+++ b/arch/arm64/kvm/emulate.c
@@ -0,0 +1,158 @@
+/*
+ * (not much of an) Emulation layer for 32bit guests.
+ *
+ * Copyright (C) 2012,2013 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * based on arch/arm/kvm/emulate.c
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_emulate.h>
+
+/*
+ * stolen from arch/arm/kernel/opcodes.c
+ *
+ * condition code lookup table
+ * index into the table is test code: EQ, NE, ... LT, GT, AL, NV
+ *
+ * bit position in short is condition code: NZCV
+ */
+static const unsigned short cc_map[16] = {
+	0xF0F0,			/* EQ == Z set            */
+	0x0F0F,			/* NE                     */
+	0xCCCC,			/* CS == C set            */
+	0x3333,			/* CC                     */
+	0xFF00,			/* MI == N set            */
+	0x00FF,			/* PL                     */
+	0xAAAA,			/* VS == V set            */
+	0x5555,			/* VC                     */
+	0x0C0C,			/* HI == C set && Z clear */
+	0xF3F3,			/* LS == C clear || Z set */
+	0xAA55,			/* GE == (N==V)           */
+	0x55AA,			/* LT == (N!=V)           */
+	0x0A05,			/* GT == (!Z && (N==V))   */
+	0xF5FA,			/* LE == (Z || (N!=V))    */
+	0xFFFF,			/* AL always              */
+	0			/* NV                     */
+};
+
+static int kvm_vcpu_get_condition(const struct kvm_vcpu *vcpu)
+{
+	u32 esr = kvm_vcpu_get_hsr(vcpu);
+
+	if (esr & ESR_EL2_CV)
+		return (esr & ESR_EL2_COND) >> ESR_EL2_COND_SHIFT;
+
+	return -1;
+}
+
+/*
+ * Check if a trapped instruction should have been executed or not.
+ */
+bool kvm_condition_valid32(const struct kvm_vcpu *vcpu)
+{
+	unsigned long cpsr;
+	u32 cpsr_cond;
+	int cond;
+
+	/* Top two bits non-zero?  Unconditional. */
+	if (kvm_vcpu_get_hsr(vcpu) >> 30)
+		return true;
+
+	/* Is condition field valid? */
+	cond = kvm_vcpu_get_condition(vcpu);
+	if (cond == 0xE)
+		return true;
+
+	cpsr = *vcpu_cpsr(vcpu);
+
+	if (cond < 0) {
+		/* This can happen in Thumb mode: examine IT state. */
+		unsigned long it;
+
+		it = ((cpsr >> 8) & 0xFC) | ((cpsr >> 25) & 0x3);
+
+		/* it == 0 => unconditional. */
+		if (it == 0)
+			return true;
+
+		/* The cond for this insn works out as the top 4 bits. */
+		cond = (it >> 4);
+	}
+
+	cpsr_cond = cpsr >> 28;
+
+	if (!((cc_map[cond] >> cpsr_cond) & 1))
+		return false;
+
+	return true;
+}
+
+/**
+ * adjust_itstate - adjust ITSTATE when emulating instructions in IT-block
+ * @vcpu:	The VCPU pointer
+ *
+ * When exceptions occur while instructions are executed in Thumb IF-THEN
+ * blocks, the ITSTATE field of the CPSR is not advanced (updated), so we have
+ * to do this little bit of work manually. The fields map like this:
+ *
+ * IT[7:0] -> CPSR[26:25],CPSR[15:10]
+ */
+static void kvm_adjust_itstate(struct kvm_vcpu *vcpu)
+{
+	unsigned long itbits, cond;
+	unsigned long cpsr = *vcpu_cpsr(vcpu);
+	bool is_arm = !(cpsr & COMPAT_PSR_T_BIT);
+
+	BUG_ON(is_arm && (cpsr & COMPAT_PSR_IT_MASK));
+
+	if (!(cpsr & COMPAT_PSR_IT_MASK))
+		return;
+
+	cond = (cpsr & 0xe000) >> 13;
+	itbits = (cpsr & 0x1c00) >> (10 - 2);
+	itbits |= (cpsr & (0x3 << 25)) >> 25;
+
+	/* Perform ITAdvance (see page A2-52 in ARM DDI 0406C) */
+	if ((itbits & 0x7) == 0)
+		itbits = cond = 0;
+	else
+		itbits = (itbits << 1) & 0x1f;
+
+	cpsr &= ~COMPAT_PSR_IT_MASK;
+	cpsr |= cond << 13;
+	cpsr |= (itbits & 0x1c) << (10 - 2);
+	cpsr |= (itbits & 0x3) << 25;
+	*vcpu_cpsr(vcpu) = cpsr;
+}
+
+/**
+ * kvm_skip_instr - skip a trapped instruction and proceed to the next
+ * @vcpu: The vcpu pointer
+ */
+void kvm_skip_instr32(struct kvm_vcpu *vcpu, bool is_wide_instr)
+{
+	bool is_thumb;
+
+	is_thumb = !!(*vcpu_cpsr(vcpu) & COMPAT_PSR_T_BIT);
+	if (is_thumb && !is_wide_instr)
+		*vcpu_pc(vcpu) += 2;
+	else
+		*vcpu_pc(vcpu) += 4;
+	kvm_adjust_itstate(vcpu);
+}
-- 
1.8.2.3
