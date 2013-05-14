From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:43 +0100
Subject: [PATCH v4 15/32] arm64: KVM: hypervisor initialization code
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide EL2 with page tables and stack, and set the vectors
to point to the full blown world-switch code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  13 +++++
 arch/arm64/kvm/hyp-init.S         | 112 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 arch/arm64/kvm/hyp-init.S

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4a2622f..2500eb6 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -183,4 +183,17 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 int kvm_perf_init(void);
 int kvm_perf_teardown(void);
 
+static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
+				       phys_addr_t pgd_ptr,
+				       unsigned long hyp_stack_ptr,
+				       unsigned long vector_ptr)
+{
+	/*
+	 * Call initialization code, and switch to the full blown
+	 * HYP code.
+	 */
+	kvm_call_hyp((void *)boot_pgd_ptr, pgd_ptr,
+		     hyp_stack_ptr, vector_ptr);
+}
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
new file mode 100644
index 0000000..4a9cfd2
--- /dev/null
+++ b/arch/arm64/kvm/hyp-init.S
@@ -0,0 +1,112 @@
+/*
+ * Copyright (C) 2012,2013 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
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
+#include <linux/linkage.h>
+
+#include <asm/assembler.h>
+#include <asm/kvm_arm.h>
+#include <asm/kvm_mmu.h>
+
+	.text
+	.pushsection	.hyp.idmap.text, "ax"
+
+	.align	11
+
+__kvm_hyp_init:
+	.global	__kvm_hyp_init
+
+ENTRY(__kvm_hyp_init_vector)
+	ventry	__invalid		// Synchronous EL2t
+	ventry	__invalid		// IRQ EL2t
+	ventry	__invalid		// FIQ EL2t
+	ventry	__invalid		// Error EL2t
+
+	ventry	__invalid		// Synchronous EL2h
+	ventry	__invalid		// IRQ EL2h
+	ventry	__invalid		// FIQ EL2h
+	ventry	__invalid		// Error EL2h
+
+	ventry	__do_hyp_init		// Synchronous 64-bit EL1
+	ventry	__invalid		// IRQ 64-bit EL1
+	ventry	__invalid		// FIQ 64-bit EL1
+	ventry	__invalid		// Error 64-bit EL1
+
+	ventry	__invalid		// Synchronous 32-bit EL1
+	ventry	__invalid		// IRQ 32-bit EL1
+	ventry	__invalid		// FIQ 32-bit EL1
+	ventry	__invalid		// Error 32-bit EL1
+ENDPROC(__kvm_hyp_init_vector)
+
+__invalid:
+	b	.
+
+	/*
+	 * x0: HYP boot pgd
+	 * x1: HYP pgd
+	 * x2: HYP stack
+	 * x3: HYP vectors
+	 */
+__do_hyp_init:
+
+	msr	ttbr0_el2, x0
+
+	mrs	x4, tcr_el1
+	ldr	x5, =TCR_EL2_MASK
+	and	x4, x4, x5
+	ldr	x5, =TCR_EL2_FLAGS
+	orr	x4, x4, x5
+	msr	tcr_el2, x4
+
+	ldr	x4, =VTCR_EL2_FLAGS
+	msr	vtcr_el2, x4
+
+	mrs	x4, mair_el1
+	msr	mair_el2, x4
+	isb
+
+	mov	x4, #SCTLR_EL2_FLAGS
+	msr	sctlr_el2, x4
+	isb
+
+	/* MMU is now enabled. Get ready for the trampoline dance */
+	ldr	x4, =TRAMPOLINE_VA
+	adr	x5, target
+	bfi	x4, x5, #0, #PAGE_SHIFT
+	br	x4
+
+	nop
+
+target: /* We're now in the trampoline code, switch page tables */
+	msr	ttbr0_el2, x1
+	isb
+
+	/* Invalidate the old TLBs */
+	tlbi	alle2
+	dsb	sy
+
+	/* Set the stack and new vectors */
+	kern_hyp_va	x2
+	mov	sp, x2
+	kern_hyp_va	x3
+	msr	vbar_el2, x3
+
+	/* Hello, World! */
+	eret
+
+	.ltorg
+
+	.popsection
-- 
1.8.2.3
