From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Mar 2013 17:01:07 +0000
Subject: [PATCH v2 12/30] arm64: KVM: virtual CPU reset
In-Reply-To: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
References: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1364317285-20937-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the reset code for a virtual CPU booted in 64bit mode.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/reset.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 arch/arm64/kvm/reset.c

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
new file mode 100644
index 0000000..8cb0244
--- /dev/null
+++ b/arch/arm64/kvm/reset.c
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2012 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * Derived from arch/arm/kvm/reset.c
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
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
+#include <linux/errno.h>
+#include <linux/kvm_host.h>
+#include <linux/kvm.h>
+
+#include <asm/cputype.h>
+#include <asm/ptrace.h>
+#include <asm/kvm_arm.h>
+#include <asm/kvm_coproc.h>
+
+/*
+ * ARMv8 Reset Values
+ */
+static struct kvm_regs default_regs_reset = {
+	.regs.pstate = PSR_MODE_EL1h | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT,
+};
+
+/**
+ * kvm_reset_vcpu - sets core registers and sys_regs to reset value
+ * @vcpu: The VCPU pointer
+ *
+ * This function finds the right table above and sets the registers on
+ * the virtual CPU struct to their architectually defined reset
+ * values.
+ */
+int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_regs *cpu_reset;
+
+	switch (vcpu->arch.target) {
+	default:
+		cpu_reset = &default_regs_reset;
+		break;
+	}
+
+	/* Reset core registers */
+	memcpy(vcpu_gp_regs(vcpu), cpu_reset, sizeof(*cpu_reset));
+
+	/* Reset system registers */
+	kvm_reset_sys_regs(vcpu);
+
+	return 0;
+}
-- 
1.8.1.4
