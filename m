From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 21 May 2018 12:45:18 +0100
Subject: [PATCH 11/14] ARM: KVM: invalidate icache on guest exit for Cortex-A15
In-Reply-To: <20180521114238.GN17671@n2100.armlinux.org.uk>
References: <20180521114238.GN17671@n2100.armlinux.org.uk>
Message-ID: <E1fKjFe-00064U-38@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

In order to avoid aliasing attacks against the branch predictor
on Cortex-A15, let's invalidate the BTB on guest exit, which can
only be done by invalidating the icache (with ACTLR[0] being set).

We use the same hack as for A12/A17 to perform the vector decoding.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/kvm_mmu.h |  5 +++++
 arch/arm/kvm/hyp/hyp-entry.S   | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index d08ce9c41df4..48edb1f4ced4 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -306,6 +306,11 @@ static inline void *kvm_get_hyp_vector(void)
 		return kvm_ksym_ref(__kvm_hyp_vector_bp_inv);
 	}
 
+	case ARM_CPU_PART_CORTEX_A15:
+	{
+		extern char __kvm_hyp_vector_ic_inv[];
+		return kvm_ksym_ref(__kvm_hyp_vector_ic_inv);
+	}
 #endif
 	default:
 	{
diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
index e789f52a5129..918a05dd2d63 100644
--- a/arch/arm/kvm/hyp/hyp-entry.S
+++ b/arch/arm/kvm/hyp/hyp-entry.S
@@ -73,6 +73,28 @@
 
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 	.align 5
+__kvm_hyp_vector_ic_inv:
+	.global __kvm_hyp_vector_ic_inv
+
+	/*
+	 * We encode the exception entry in the bottom 3 bits of
+	 * SP, and we have to guarantee to be 8 bytes aligned.
+	 */
+	W(add)	sp, sp, #1	/* Reset 	  7 */
+	W(add)	sp, sp, #1	/* Undef	  6 */
+	W(add)	sp, sp, #1	/* Syscall	  5 */
+	W(add)	sp, sp, #1	/* Prefetch abort 4 */
+	W(add)	sp, sp, #1	/* Data abort	  3 */
+	W(add)	sp, sp, #1	/* HVC		  2 */
+	W(add)	sp, sp, #1	/* IRQ		  1 */
+	W(nop)			/* FIQ		  0 */
+
+	mcr	p15, 0, r0, c7, c5, 0	/* ICIALLU */
+	isb
+
+	b	decode_vectors
+
+	.align 5
 __kvm_hyp_vector_bp_inv:
 	.global __kvm_hyp_vector_bp_inv
 
@@ -92,6 +114,8 @@
 	mcr	p15, 0, r0, c7, c5, 6	/* BPIALL */
 	isb
 
+decode_vectors:
+
 #ifdef CONFIG_THUMB2_KERNEL
 	/*
 	 * Yet another silly hack: Use VPIDR as a temp register.
-- 
2.7.4
