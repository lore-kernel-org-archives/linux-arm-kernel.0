From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:41 +0100
Subject: [PATCH v4 13/32] arm64: KVM: MMIO access backend
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the necessary structures to perform an MMIO access.

Reviewed-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_mmio.h | 59 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 arch/arm64/include/asm/kvm_mmio.h

diff --git a/arch/arm64/include/asm/kvm_mmio.h b/arch/arm64/include/asm/kvm_mmio.h
new file mode 100644
index 0000000..fc2f689
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_mmio.h
@@ -0,0 +1,59 @@
+/*
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
+#ifndef __ARM64_KVM_MMIO_H__
+#define __ARM64_KVM_MMIO_H__
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_arm.h>
+
+/*
+ * This is annoying. The mmio code requires this, even if we don't
+ * need any decoding. To be fixed.
+ */
+struct kvm_decode {
+	unsigned long rt;
+	bool sign_extend;
+};
+
+/*
+ * The in-kernel MMIO emulation code wants to use a copy of run->mmio,
+ * which is an anonymous type. Use our own type instead.
+ */
+struct kvm_exit_mmio {
+	phys_addr_t	phys_addr;
+	u8		data[8];
+	u32		len;
+	bool		is_write;
+};
+
+static inline void kvm_prepare_mmio(struct kvm_run *run,
+				    struct kvm_exit_mmio *mmio)
+{
+	run->mmio.phys_addr	= mmio->phys_addr;
+	run->mmio.len		= mmio->len;
+	run->mmio.is_write	= mmio->is_write;
+	memcpy(run->mmio.data, mmio->data, mmio->len);
+	run->exit_reason	= KVM_EXIT_MMIO;
+}
+
+int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
+		 phys_addr_t fault_ipa);
+
+#endif	/* __ARM64_KVM_MMIO_H__ */
-- 
1.8.2.3
