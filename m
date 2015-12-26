From: m.smarduch@samsung.com (Mario Smarduch)
Date: Sat, 26 Dec 2015 13:54:56 -0800
Subject: [PATCH v6 2/6] arm: KVM: Introduce host fp/simd context switch
 function
In-Reply-To: <1451166900-3711-1-git-send-email-m.smarduch@samsung.com>
References: <1451166900-3711-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1451166900-3711-3-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add fp/simd context switch function callable from host kernel mode.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/Makefile        |  2 +-
 arch/arm/kvm/fpsimd_switch.S | 47 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/kvm/fpsimd_switch.S

diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index c5eef02c..411b3e4 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -19,7 +19,7 @@ kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o $(KVM)/vf
 
 obj-y += kvm-arm.o init.o interrupts.o
 obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
-obj-y += coproc.o coproc_a15.o coproc_a7.o mmio.o psci.o perf.o
+obj-y += coproc.o coproc_a15.o coproc_a7.o mmio.o psci.o perf.o fpsimd_switch.o
 obj-y += $(KVM)/arm/vgic.o
 obj-y += $(KVM)/arm/vgic-v2.o
 obj-y += $(KVM)/arm/vgic-v2-emul.o
diff --git a/arch/arm/kvm/fpsimd_switch.S b/arch/arm/kvm/fpsimd_switch.S
new file mode 100644
index 0000000..7e48c16
--- /dev/null
+++ b/arch/arm/kvm/fpsimd_switch.S
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2015 - Samsung - Open Source Group
+ * Author: Mario Smarduch <m.smarduch@samsung.com>
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
+ */
+
+#include <linux/linkage.h>
+#include <linux/const.h>
+#include <asm/unified.h>
+#include <asm/page.h>
+#include <asm/ptrace.h>
+#include <asm/asm-offsets.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_arm.h>
+#include <asm/vfpmacros.h>
+#include "interrupts_head.S"
+
+	.text
+/**
+  * void vcpu_restore_host_vfp_state(struct vcpu *vcpu) -
+  * 	This function is called from host to save the guest, and restore host
+  *     fp/simd hardware context.
+  */
+ENTRY(vcpu_restore_host_vfp_state)
+#ifdef CONFIG_VFPv3
+	push	{r4-r7}
+
+	add	r7, r0, #VCPU_VFP_GUEST
+	store_vfp_state r7
+
+	add	r7, r0, #VCPU_VFP_HOST
+	ldr	r7, [r7]
+	restore_vfp_state r7
+
+	pop	{r4-r7}
+#endif
+	bx	lr
+ENDPROC(vcpu_restore_host_vfp_state)
-- 
1.9.1
