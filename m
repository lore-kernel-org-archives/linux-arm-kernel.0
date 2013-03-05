From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 03:47:39 +0000
Subject: [PATCH 23/29] arm64: KVM: 32bit GP register access
In-Reply-To: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362455265-24165-24-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow access to the 32bit register file through the usual API.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  17 +++-
 arch/arm64/kvm/Makefile              |   2 +-
 arch/arm64/kvm/regmap.c              | 168 +++++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/kvm/regmap.c

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 16a343b..2e72a4f 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -28,6 +28,9 @@
 #include <asm/kvm_mmio.h>
 #include <asm/ptrace.h>
 
+unsigned long *vcpu_reg32(struct kvm_vcpu *vcpu, u8 reg_num);
+unsigned long *vcpu_spsr32(struct kvm_vcpu *vcpu);
+
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
@@ -44,7 +47,7 @@ static inline unsigned long *vcpu_cpsr(struct kvm_vcpu *vcpu)
 
 static inline bool vcpu_mode_is_32bit(struct kvm_vcpu *vcpu)
 {
-	return false;	/* 32bit? Bahhh... */
+	return !!(*vcpu_cpsr(vcpu) & PSR_MODE32_BIT);
 }
 
 static inline bool kvm_condition_valid(struct kvm_vcpu *vcpu)
@@ -59,10 +62,14 @@ static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
 
 static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
 {
+	*vcpu_cpsr(vcpu) |= COMPAT_PSR_T_BIT;
 }
 
 static inline unsigned long *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num)
 {
+	if (vcpu_mode_is_32bit(vcpu))
+		return vcpu_reg32(vcpu, reg_num);
+
 	return (unsigned long *)&vcpu->arch.regs.regs.regs[reg_num];
 
 }
@@ -70,18 +77,24 @@ static inline unsigned long *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num)
 /* Get vcpu SPSR for current mode */
 static inline unsigned long *vcpu_spsr(struct kvm_vcpu *vcpu)
 {
+	if (vcpu_mode_is_32bit(vcpu))
+		return vcpu_spsr32(vcpu);
+
 	return &vcpu->arch.regs.spsr[KVM_SPSR_EL1];
 }
 
 static inline bool kvm_vcpu_reg_is_pc(struct kvm_vcpu *vcpu, int reg)
 {
-	return false;
+	return (vcpu_mode_is_32bit(vcpu)) && reg == 15;
 }
 
 static inline bool vcpu_mode_priv(struct kvm_vcpu *vcpu)
 {
 	u32 mode = *vcpu_cpsr(vcpu) & PSR_MODE_MASK;
 
+	if (vcpu_mode_is_32bit(vcpu))
+		return mode > COMPAT_PSR_MODE_USR;
+
 	return mode != PSR_MODE_EL0t;
 }
 
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 14ba38d..50f9da0 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_KVM_ARM_HOST) += $(addprefix ../../../virt/kvm/, kvm_main.o coalesc
 
 obj-$(CONFIG_KVM_ARM_HOST) += $(addprefix ../../../arch/arm/kvm/, arm.o mmu.o mmio.o psci.o perf.o)
 
-obj-$(CONFIG_KVM_ARM_HOST) += inject_fault.o
+obj-$(CONFIG_KVM_ARM_HOST) += inject_fault.o regmap.o
 obj-$(CONFIG_KVM_ARM_HOST) += hyp.o hyp-init.o handle_exit.o idmap.o
 obj-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_a57.o
 
diff --git a/arch/arm64/kvm/regmap.c b/arch/arm64/kvm/regmap.c
new file mode 100644
index 0000000..f8d4a0c
--- /dev/null
+++ b/arch/arm64/kvm/regmap.c
@@ -0,0 +1,168 @@
+/*
+ * Copyright (C) 2012 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * Derived from arch/arm/kvm/emulate.c:
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
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
+#include <linux/mm.h>
+#include <linux/kvm_host.h>
+#include <asm/kvm_emulate.h>
+#include <asm/ptrace.h>
+
+#define VCPU_NR_MODES 6
+#define REG_OFFSET(_reg) \
+	(offsetof(struct user_pt_regs, _reg) / sizeof(unsigned long))
+
+#define USR_REG_OFFSET(R) REG_OFFSET(compat_usr(R))
+
+static const unsigned long vcpu_reg_offsets[VCPU_NR_MODES][16] = {
+	/* USR Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
+		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
+		USR_REG_OFFSET(12), USR_REG_OFFSET(13),	USR_REG_OFFSET(14),
+		REG_OFFSET(pc)
+	},
+
+	/* FIQ Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7),
+		REG_OFFSET(compat_r8_fiq),  /* r8 */
+		REG_OFFSET(compat_r9_fiq),  /* r9 */
+		REG_OFFSET(compat_r10_fiq), /* r10 */
+		REG_OFFSET(compat_r11_fiq), /* r11 */
+		REG_OFFSET(compat_r12_fiq), /* r12 */
+		REG_OFFSET(compat_sp_fiq),  /* r13 */
+		REG_OFFSET(compat_lr_fiq),  /* r14 */
+		REG_OFFSET(pc)
+	},
+
+	/* IRQ Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
+		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
+		USR_REG_OFFSET(12),
+		REG_OFFSET(compat_sp_irq), /* r13 */
+		REG_OFFSET(compat_lr_irq), /* r14 */
+		REG_OFFSET(pc)
+	},
+
+	/* SVC Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
+		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
+		USR_REG_OFFSET(12),
+		REG_OFFSET(compat_sp_svc), /* r13 */
+		REG_OFFSET(compat_lr_svc), /* r14 */
+		REG_OFFSET(pc)
+	},
+
+	/* ABT Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
+		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
+		USR_REG_OFFSET(12),
+		REG_OFFSET(compat_sp_abt), /* r13 */
+		REG_OFFSET(compat_lr_abt), /* r14 */
+		REG_OFFSET(pc)
+	},
+
+	/* UND Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
+		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
+		USR_REG_OFFSET(12),
+		REG_OFFSET(compat_sp_und), /* r13 */
+		REG_OFFSET(compat_lr_und), /* r14 */
+		REG_OFFSET(pc)
+	},
+};
+
+/*
+ * Return a pointer to the register number valid in the current mode of
+ * the virtual CPU.
+ */
+unsigned long *vcpu_reg32(struct kvm_vcpu *vcpu, u8 reg_num)
+{
+	unsigned long *reg_array = (unsigned long *)&vcpu->arch.regs.regs;
+	unsigned long mode = *vcpu_cpsr(vcpu) & COMPAT_PSR_MODE_MASK;
+
+	switch (mode) {
+	case COMPAT_PSR_MODE_USR...COMPAT_PSR_MODE_SVC:
+		mode &= ~PSR_MODE32_BIT; /* 0 ... 3 */
+		break;
+
+	case COMPAT_PSR_MODE_ABT:
+		mode = 4;
+		break;
+
+	case COMPAT_PSR_MODE_UND:
+		mode = 5;
+		break;
+
+	case COMPAT_PSR_MODE_SYS:
+		mode = 0;	/* SYS maps to USR */
+		break;
+
+	default:
+		BUG();
+	}
+
+	return reg_array + vcpu_reg_offsets[mode][reg_num];
+}
+
+/*
+ * Return the SPSR for the current mode of the virtual CPU.
+ */
+unsigned long *vcpu_spsr32(struct kvm_vcpu *vcpu)
+{
+	unsigned long mode = *vcpu_cpsr(vcpu) & COMPAT_PSR_MODE_MASK;
+	switch (mode) {
+	case COMPAT_PSR_MODE_SVC:
+		mode = KVM_SPSR_SVC;
+		break;
+	case COMPAT_PSR_MODE_ABT:
+		mode = KVM_SPSR_ABT;
+		break;
+	case COMPAT_PSR_MODE_UND:
+		mode = KVM_SPSR_UND;
+		break;
+	case COMPAT_PSR_MODE_IRQ:
+		mode = KVM_SPSR_IRQ;
+		break;
+	case COMPAT_PSR_MODE_FIQ:
+		mode = KVM_SPSR_FIQ;
+		break;
+	default:
+		BUG();
+	}
+
+	return &vcpu->arch.regs.spsr[mode];
+}
-- 
1.7.12.4
