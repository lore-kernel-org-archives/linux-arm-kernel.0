From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 03:47:22 +0000
Subject: [PATCH 06/29] arm64: KVM: fault injection into a guest
In-Reply-To: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362455265-24165-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the injection of a fault (undefined, data abort or
prefetch abort) into a 64bit guest.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/inject_fault.c | 117 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 arch/arm64/kvm/inject_fault.c

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
new file mode 100644
index 0000000..80b245f
--- /dev/null
+++ b/arch/arm64/kvm/inject_fault.c
@@ -0,0 +1,117 @@
+/*
+ * Fault injection for 64bit guests.
+ *
+ * Copyright (C) 2012 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * Based on arch/arm/kvm/emulate.c
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
+static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
+{
+	unsigned long cpsr = *vcpu_cpsr(vcpu);
+	int is_aarch32;
+	u32 esr = 0;
+
+	is_aarch32 = vcpu_mode_is_32bit(vcpu);
+
+	*vcpu_spsr(vcpu) = cpsr;
+	vcpu->arch.regs.elr_el1 = *vcpu_pc(vcpu);
+
+	*vcpu_cpsr(vcpu) = PSR_MODE_EL1h | PSR_A_BIT | PSR_F_BIT | PSR_I_BIT;
+	*vcpu_pc(vcpu) = vcpu->arch.sys_regs[VBAR_EL1] + 0x200;
+
+	vcpu->arch.sys_regs[FAR_EL1] = addr;
+
+	/*
+	 * Build an {i,d}abort, depending on the level and the
+	 * instruction set. Report an external synchronous abort.
+	 */
+	if (kvm_vcpu_trap_il_is32bit(vcpu))
+		esr |= (1 << 25);
+
+	if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
+		esr |= (0x20 << 26);
+	else
+		esr |= (0x21 << 26);
+
+	if (!is_iabt)
+		esr |= (1 << 28);
+
+	vcpu->arch.sys_regs[ESR_EL1] = esr | 0x10;
+}
+
+static void inject_undef64(struct kvm_vcpu *vcpu)
+{
+	unsigned long cpsr = *vcpu_cpsr(vcpu);
+	u32 esr = 0;
+
+	*vcpu_spsr(vcpu) = cpsr;
+	vcpu->arch.regs.elr_el1 = *vcpu_pc(vcpu);
+
+	*vcpu_cpsr(vcpu) = PSR_MODE_EL1h | PSR_F_BIT | PSR_I_BIT;
+	*vcpu_pc(vcpu) = vcpu->arch.sys_regs[VBAR_EL1] + 0x200;
+
+	/*
+	 * Build an unknown exception, depending on the instruction
+	 * set.
+	 */
+	if (kvm_vcpu_trap_il_is32bit(vcpu))
+		esr |= (1 << 25);
+
+	vcpu->arch.sys_regs[ESR_EL1] = esr;
+}
+
+/**
+ * kvm_inject_dabt - inject a data abort into the guest
+ * @vcpu: The VCPU to receive the undefined exception
+ * @addr: The address to report in the DFAR
+ *
+ * It is assumed that this code is called from the VCPU thread and that the
+ * VCPU therefore is not currently executing guest code.
+ */
+void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr)
+{
+	inject_abt64(vcpu, false, addr);
+}
+
+/**
+ * kvm_inject_pabt - inject a prefetch abort into the guest
+ * @vcpu: The VCPU to receive the undefined exception
+ * @addr: The address to report in the DFAR
+ *
+ * It is assumed that this code is called from the VCPU thread and that the
+ * VCPU therefore is not currently executing guest code.
+ */
+void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr)
+{
+	inject_abt64(vcpu, true, addr);
+}
+
+/**
+ * kvm_inject_undefined - inject a undefined instruction into the guest
+ *
+ * It is assumed that this code is called from the VCPU thread and that the
+ * VCPU therefore is not currently executing guest code.
+ */
+void kvm_inject_undefined(struct kvm_vcpu *vcpu)
+{
+	inject_undef64(vcpu);
+}
-- 
1.7.12.4
