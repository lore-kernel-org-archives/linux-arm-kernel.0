From: anup.patel@linaro.org (Anup Patel)
Date: Tue,  5 Aug 2014 14:54:14 +0530
Subject: [RFC PATCH 5/6] ARM64: KVM: Implement full context switch of PMU
 registers
In-Reply-To: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
References: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1407230655-28864-6-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements following stuff:
1. Save/restore all PMU registers for both Guest and Host in
KVM world switch.
2. Reserve last PMU event counter for performance analysis in
EL2-mode. To achieve we fake the number of event counters available
to the Guest by trapping PMCR_EL0 register accesses and program
MDCR_EL2.HPMN with number of PMU event counters minus one.
3. Clear and mask overflowed interrupts when saving PMU context
for Guest. The Guest will re-enable overflowed interrupts when
processing virtual PMU interrupt.

With this patch we have direct access of all PMU registers from
Guest and we only trap-n-emulate PMCR_EL0 accesses to fake number
of PMU event counters to Guest.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm64/include/asm/kvm_asm.h |   36 ++++++--
 arch/arm64/kernel/asm-offsets.c  |    1 +
 arch/arm64/kvm/hyp-init.S        |   15 ++++
 arch/arm64/kvm/hyp.S             |  168 +++++++++++++++++++++++++++++++++++-
 arch/arm64/kvm/sys_regs.c        |  175 ++++++++++++++++++++++++++++----------
 5 files changed, 343 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 993a7db..93be21f 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -53,15 +53,27 @@
 #define DBGWVR0_EL1	71	/* Debug Watchpoint Value Registers (0-15) */
 #define DBGWVR15_EL1	86
 #define MDCCINT_EL1	87	/* Monitor Debug Comms Channel Interrupt Enable Reg */
+#define PMCR_EL0	88	/* Performance Monitors Control Register */
+#define PMOVSSET_EL0	89	/* Performance Monitors Overflow Flag Status Set Register */
+#define PMCCNTR_EL0	90	/* Cycle Counter Register */
+#define PMSELR_EL0	91	/* Performance Monitors Event Counter Selection Register */
+#define PMEVCNTR0_EL0	92	/* Performance Monitors Event Counter Register (0-30) */
+#define PMEVTYPER0_EL0	93	/* Performance Monitors Event Type Register (0-30) */
+#define PMEVCNTR30_EL0	152
+#define PMEVTYPER30_EL0	153
+#define PMCNTENSET_EL0	154	/* Performance Monitors Count Enable Set Register */
+#define PMINTENSET_EL1	155	/* Performance Monitors Interrupt Enable Set Register */
+#define PMUSERENR_EL0	156	/* Performance Monitors User Enable Register */
+#define PMCCFILTR_EL0	157	/* Cycle Count Filter Register */
 
 /* 32bit specific registers. Keep them at the end of the range */
-#define	DACR32_EL2	88	/* Domain Access Control Register */
-#define	IFSR32_EL2	89	/* Instruction Fault Status Register */
-#define	FPEXC32_EL2	90	/* Floating-Point Exception Control Register */
-#define	DBGVCR32_EL2	91	/* Debug Vector Catch Register */
-#define	TEECR32_EL1	92	/* ThumbEE Configuration Register */
-#define	TEEHBR32_EL1	93	/* ThumbEE Handler Base Register */
-#define	NR_SYS_REGS	94
+#define	DACR32_EL2	158	/* Domain Access Control Register */
+#define	IFSR32_EL2	159	/* Instruction Fault Status Register */
+#define	FPEXC32_EL2	160	/* Floating-Point Exception Control Register */
+#define	DBGVCR32_EL2	161	/* Debug Vector Catch Register */
+#define	TEECR32_EL1	162	/* ThumbEE Configuration Register */
+#define	TEEHBR32_EL1	163	/* ThumbEE Handler Base Register */
+#define	NR_SYS_REGS	164
 
 /* 32bit mapping */
 #define c0_MPIDR	(MPIDR_EL1 * 2)	/* MultiProcessor ID Register */
@@ -83,6 +95,13 @@
 #define c6_IFAR		(c6_DFAR + 1)	/* Instruction Fault Address Register */
 #define c7_PAR		(PAR_EL1 * 2)	/* Physical Address Register */
 #define c7_PAR_high	(c7_PAR + 1)	/* PAR top 32 bits */
+#define c9_PMCR		(PMCR_EL0 * 2)	/* Performance Monitors Control Register */
+#define c9_PMOVSSET	(PMOVSSET_EL0 * 2)
+#define c9_PMCCNTR	(PMCCNTR_EL0 * 2)
+#define c9_PMSELR	(PMSELR_EL0 * 2)
+#define c9_PMCNTENSET	(PMCNTENSET_EL0 * 2)
+#define c9_PMINTENSET	(PMINTENSET_EL1 * 2)
+#define c9_PMUSERENR	(PMUSERENR_EL0 * 2)
 #define c10_PRRR	(MAIR_EL1 * 2)	/* Primary Region Remap Register */
 #define c10_NMRR	(c10_PRRR + 1)	/* Normal Memory Remap Register */
 #define c12_VBAR	(VBAR_EL1 * 2)	/* Vector Base Address Register */
@@ -93,6 +112,9 @@
 #define c10_AMAIR0	(AMAIR_EL1 * 2)	/* Aux Memory Attr Indirection Reg */
 #define c10_AMAIR1	(c10_AMAIR0 + 1)/* Aux Memory Attr Indirection Reg */
 #define c14_CNTKCTL	(CNTKCTL_EL1 * 2) /* Timer Control Register (PL1) */
+#define c14_PMEVCNTR0	(PMEVCNTR0_EL0 * 2)
+#define c14_PMEVTYPR0	(PMEVTYPER0_EL0 * 2)
+#define c14_PMCCFILTR	(PMCCFILTR_EL0 * 2)
 
 #define cp14_DBGDSCRext	(MDSCR_EL1 * 2)
 #define cp14_DBGBCR0	(DBGBCR0_EL1 * 2)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index ae73a83..053dc3e 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -140,6 +140,7 @@ int main(void)
   DEFINE(VGIC_CPU_NR_LR,	offsetof(struct vgic_cpu, nr_lr));
   DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
   DEFINE(KVM_VGIC_VCTRL,	offsetof(struct kvm, arch.vgic.vctrl_base));
+  DEFINE(VCPU_PMU_IRQ_PENDING,	offsetof(struct kvm_vcpu, arch.pmu_cpu.irq_pending));
 #endif
 #ifdef CONFIG_ARM64_CPU_SUSPEND
   DEFINE(CPU_SUSPEND_SZ,	sizeof(struct cpu_suspend_ctx));
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index d968796..b45556e 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -20,6 +20,7 @@
 #include <asm/assembler.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
+#include <asm/pmu.h>
 
 	.text
 	.pushsection	.hyp.idmap.text, "ax"
@@ -107,6 +108,20 @@ target: /* We're now in the trampoline code, switch page tables */
 	kern_hyp_va	x3
 	msr	vbar_el2, x3
 
+	/* Reserve last PMU event counter for EL2 */
+	mov	x4, #0
+	mrs	x5, id_aa64dfr0_el1
+	ubfx	x5, x5, #8, #4		// Extract PMUver
+	cmp	x5, #1			// Must be PMUv3 else skip
+	bne	1f
+	mrs	x5, pmcr_el0
+	ubfx	x5, x5, #ARMV8_PMCR_N_SHIFT, #5	// Number of event counters
+	cmp	x5, #0			// Skip if no event counters
+	beq	1f
+	sub	x4, x5, #1
+1:
+	msr	mdcr_el2, x4
+
 	/* Hello, World! */
 	eret
 ENDPROC(__kvm_hyp_init)
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index d032132..6b41c01 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -23,6 +23,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/debug-monitors.h>
 #include <asm/fpsimdmacros.h>
+#include <asm/pmu.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_arm.h>
@@ -426,6 +427,77 @@ __kvm_hyp_code_start:
 	str	x21, [x2, #CPU_SYSREG_OFFSET(MDCCINT_EL1)]
 .endm
 
+.macro save_pmu, is_vcpu_pmu
+	// x2: base address for cpu context
+	// x3: mask of counters allowed in EL0 & EL1
+	// x4: number of event counters allowed in EL0 & EL1
+
+	mrs	x6, id_aa64dfr0_el1
+	ubfx	x5, x6, #8, #4		// Extract PMUver
+	cmp	x5, #1			// Must be PMUv3 else skip
+	bne	1f
+
+	mrs	x4, pmcr_el0		// Save PMCR_EL0
+	str	x4, [x2, #CPU_SYSREG_OFFSET(PMCR_EL0)]
+
+	and	x5, x4, #~(ARMV8_PMCR_E)// Clear PMCR_EL0.E
+	msr	pmcr_el0, x5		// This will stop all counters
+
+	mov	x3, #0
+	ubfx	x4, x4, #ARMV8_PMCR_N_SHIFT, #5	// Number of event counters
+	cmp	x4, #0			// Skip if no event counters
+	beq	2f
+	sub	x4, x4, #1		// Last event counter is reserved
+	mov	x3, #1
+	lsl	x3, x3, x4
+	sub	x3, x3, #1
+2:	orr	x3, x3, #(1 << 31)	// Mask of event counters
+
+	mrs	x5, pmovsset_el0	// Save PMOVSSET_EL0
+	and	x5, x5, x3
+	str	x5, [x2, #CPU_SYSREG_OFFSET(PMOVSSET_EL0)]
+
+	.if \is_vcpu_pmu == 1
+	msr	pmovsclr_el0, x5	// Clear HW interrupt line
+	msr	pmintenclr_el1, x5	// Mask irq for overflowed counters
+	str	w5, [x0, #VCPU_PMU_IRQ_PENDING] // Update irq pending flag
+	.endif
+
+	mrs	x5, pmccntr_el0		// Save PMCCNTR_EL0
+	str	x5, [x2, #CPU_SYSREG_OFFSET(PMCCNTR_EL0)]
+
+	mrs	x5, pmselr_el0		// Save PMSELR_EL0
+	str	x5, [x2, #CPU_SYSREG_OFFSET(PMSELR_EL0)]
+
+	lsl	x5, x4, #4
+	add	x5, x5, #CPU_SYSREG_OFFSET(PMEVCNTR0_EL0)
+	add	x5, x2, x5
+3:	cmp	x4, #0
+	beq	4f
+	sub	x4, x4, #1
+	msr	pmselr_el0, x4
+	mrs	x6, pmxevcntr_el0	// Save PMEVCNTR<n>_EL0
+	mrs	x7, pmxevtyper_el0	// Save PMEVTYPER<n>_EL0
+	stp	x6, x7, [x5, #-16]!
+	b	3b
+4:
+	mrs	x5, pmcntenset_el0	// Save PMCNTENSET_EL0
+	and	x5, x5, x3
+	str	x5, [x2, #CPU_SYSREG_OFFSET(PMCNTENSET_EL0)]
+
+	mrs	x5, pmintenset_el1	// Save PMINTENSET_EL1
+	and	x5, x5, x3
+	str	x5, [x2, #CPU_SYSREG_OFFSET(PMINTENSET_EL1)]
+
+	mrs	x5, pmuserenr_el0	// Save PMUSERENR_EL0
+	and	x5, x5, x3
+	str	x5, [x2, #CPU_SYSREG_OFFSET(PMUSERENR_EL0)]
+
+	mrs	x5, pmccfiltr_el0	// Save PMCCFILTR_EL0
+	str	x5, [x2, #CPU_SYSREG_OFFSET(PMCCFILTR_EL0)]
+1:
+.endm
+
 .macro restore_sysregs
 	// x2: base address for cpu context
 	// x3: tmp register
@@ -659,6 +731,72 @@ __kvm_hyp_code_start:
 	msr	mdccint_el1, x21
 .endm
 
+.macro restore_pmu
+	// x2: base address for cpu context
+	// x3: mask of counters allowed in EL0 & EL1
+	// x4: number of event counters allowed in EL0 & EL1
+
+	mrs	x6, id_aa64dfr0_el1
+	ubfx	x5, x6, #8, #4		// Extract PMUver
+	cmp	x5, #1			// Must be PMUv3 else skip
+	bne	1f
+
+	mov	x3, #0
+	mrs	x4, pmcr_el0
+	ubfx	x4, x4, #ARMV8_PMCR_N_SHIFT, #5	// Number of event counters
+	cmp	x4, #0			// Skip if no event counters
+	beq	2f
+	sub	x4, x4, #1		// Last event counter is reserved
+	mov	x3, #1
+	lsl	x3, x3, x4
+	sub	x3, x3, #1
+2:	orr	x3, x3, #(1 << 31)	// Mask of event counters
+
+	ldr	x5, [x2, #CPU_SYSREG_OFFSET(PMCCFILTR_EL0)]
+	msr	pmccfiltr_el0, x5	// Restore PMCCFILTR_EL0
+
+	ldr	x5, [x2, #CPU_SYSREG_OFFSET(PMUSERENR_EL0)]
+	and	x5, x5, x3
+	msr	pmuserenr_el0, x5	// Restore PMUSERENR_EL0
+
+	msr	pmintenclr_el1, x3
+	ldr	x5, [x2, #CPU_SYSREG_OFFSET(PMINTENSET_EL1)]
+	and	x5, x5, x3
+	msr	pmintenset_el1, x5	// Restore PMINTENSET_EL1
+
+	msr	pmcntenclr_el0, x3
+	ldr	x5, [x2, #CPU_SYSREG_OFFSET(PMCNTENSET_EL0)]
+	and	x5, x5, x3
+	msr	pmcntenset_el0, x5	// Restore PMCNTENSET_EL0
+
+	lsl	x5, x4, #4
+	add	x5, x5, #CPU_SYSREG_OFFSET(PMEVCNTR0_EL0)
+	add	x5, x2, x5
+3:	cmp	x4, #0
+	beq	4f
+	sub	x4, x4, #1
+	ldp	x6, x7, [x5, #-16]!
+	msr	pmselr_el0, x4
+	msr	pmxevcntr_el0, x6	// Restore PMEVCNTR<n>_EL0
+	msr	pmxevtyper_el0, x7	// Restore PMEVTYPER<n>_EL0
+	b	3b
+4:
+	ldr	x5, [x2, #CPU_SYSREG_OFFSET(PMSELR_EL0)]
+	msr	pmselr_el0, x5		// Restore PMSELR_EL0
+
+	ldr	x5, [x2, #CPU_SYSREG_OFFSET(PMCCNTR_EL0)]
+	msr	pmccntr_el0, x5		// Restore PMCCNTR_EL0
+
+	msr	pmovsclr_el0, x3
+	ldr	x5, [x2, #CPU_SYSREG_OFFSET(PMOVSSET_EL0)]
+	and	x5, x5, x3
+	msr	pmovsset_el0, x5	// Restore PMOVSSET_EL0
+
+	ldr	x5, [x2, #CPU_SYSREG_OFFSET(PMCR_EL0)]
+	msr	pmcr_el0, x5		// Restore PMCR_EL0
+1:
+.endm
+
 .macro skip_32bit_state tmp, target
 	// Skip 32bit state if not needed
 	mrs	\tmp, hcr_el2
@@ -775,8 +913,10 @@ __kvm_hyp_code_start:
 	msr	hstr_el2, x2
 
 	mrs	x2, mdcr_el2
+	and	x3, x2, #MDCR_EL2_HPME
 	and	x2, x2, #MDCR_EL2_HPMN_MASK
-	orr	x2, x2, #(MDCR_EL2_TPM | MDCR_EL2_TPMCR)
+	orr	x2, x2, x3
+	orr	x2, x2, #MDCR_EL2_TPMCR
 	orr	x2, x2, #(MDCR_EL2_TDRA | MDCR_EL2_TDOSA)
 
 	// Check for KVM_ARM64_DEBUG_DIRTY, and set debug to trap
@@ -795,7 +935,9 @@ __kvm_hyp_code_start:
 	msr	hstr_el2, xzr
 
 	mrs	x2, mdcr_el2
+	and	x3, x2, #MDCR_EL2_HPME
 	and	x2, x2, #MDCR_EL2_HPMN_MASK
+	orr	x2, x2, x3
 	msr	mdcr_el2, x2
 .endm
 
@@ -977,6 +1119,18 @@ __restore_debug:
 	restore_debug
 	ret
 
+__save_pmu_host:
+	save_pmu 0
+	ret
+
+__save_pmu_guest:
+	save_pmu 1
+	ret
+
+__restore_pmu:
+	restore_pmu
+	ret
+
 __save_fpsimd:
 	save_fpsimd
 	ret
@@ -1005,6 +1159,9 @@ ENTRY(__kvm_vcpu_run)
 	kern_hyp_va x2
 
 	save_host_regs
+
+	bl __save_pmu_host
+
 	bl __save_fpsimd
 	bl __save_sysregs
 
@@ -1027,6 +1184,9 @@ ENTRY(__kvm_vcpu_run)
 	bl	__restore_debug
 1:
 	restore_guest_32bit_state
+
+	bl __restore_pmu
+
 	restore_guest_regs
 
 	// That's it, no more messing around.
@@ -1040,12 +1200,16 @@ __kvm_vcpu_return:
 	add	x2, x0, #VCPU_CONTEXT
 
 	save_guest_regs
+
+	bl __save_pmu_guest
+
 	bl __save_fpsimd
 	bl __save_sysregs
 
 	skip_debug_state x3, 1f
 	bl	__save_debug
 1:
+
 	save_guest_32bit_state
 
 	save_timer_state
@@ -1068,6 +1232,8 @@ __kvm_vcpu_return:
 	str	xzr, [x0, #VCPU_DEBUG_FLAGS]
 	bl	__restore_debug
 1:
+	bl __restore_pmu
+
 	restore_host_regs
 
 	mov	x0, x1
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4a89ca2..081f95e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -23,6 +23,7 @@
 #include <linux/mm.h>
 #include <linux/kvm_host.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_host.h>
 #include <asm/kvm_emulate.h>
@@ -31,6 +32,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <asm/debug-monitors.h>
+#include <asm/pmu.h>
 #include <trace/events/kvm.h>
 
 #include "sys_regs.h"
@@ -164,6 +166,45 @@ static bool access_sctlr(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+/* PMCR_EL0 accessor. Only called as long as MDCR_EL2.TPMCR is set. */
+static bool access_pmcr(struct kvm_vcpu *vcpu,
+			const struct sys_reg_params *p,
+			const struct sys_reg_desc *r)
+{
+	unsigned long val, n;
+
+	if (p->is_write) {
+		/* Only update writeable bits of PMCR */
+		if (!p->is_aarch32)
+			val = vcpu_sys_reg(vcpu, r->reg);
+		else
+			val = vcpu_cp15(vcpu, r->reg);
+		val &= ~ARMV8_PMCR_MASK;
+		val |= *vcpu_reg(vcpu, p->Rt) & ARMV8_PMCR_MASK;
+		if (!p->is_aarch32)
+			vcpu_sys_reg(vcpu, r->reg) = val;
+		else
+			vcpu_cp15(vcpu, r->reg) = val;
+	} else {
+		/*
+		 * We reserve the last event counter for EL2-mode
+		 * performance analysis hence we show one less
+		 * event counter to the guest.
+		 */
+		if (!p->is_aarch32)
+			val = vcpu_sys_reg(vcpu, r->reg);
+		else
+			val = vcpu_cp15(vcpu, r->reg);
+		n = (val >> ARMV8_PMCR_N_SHIFT) & ARMV8_PMCR_N_MASK;
+		n = (n) ? n - 1 : 0;
+		val &= ~(ARMV8_PMCR_N_MASK << ARMV8_PMCR_N_SHIFT);
+		val |= (n & ARMV8_PMCR_N_MASK) << ARMV8_PMCR_N_SHIFT;
+		*vcpu_reg(vcpu, p->Rt) = val;
+	}
+
+	return true;
+}
+
 static bool trap_raz_wi(struct kvm_vcpu *vcpu,
 			const struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
@@ -272,6 +313,20 @@ static void reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	{ Op0(0b10), Op1(0b000), CRn(0b0000), CRm((n)), Op2(0b111),	\
 	  trap_debug_regs, reset_val, (DBGWCR0_EL1 + (n)), 0 }
 
+/* Macro to expand the PMEVCNTRn_EL0 register */
+#define PMU_PMEVCNTR_EL0(n)						\
+	/* PMEVCNTRn_EL0 */						\
+	{ Op0(0b11), Op1(0b011), CRn(0b1110),				\
+	  CRm((0b1000 | (((n) >> 3) & 0x3))), Op2(((n) & 0x7)),		\
+	  NULL, reset_val, (PMEVCNTR0_EL0 + (n)*2), 0 }
+
+/* Macro to expand the PMEVTYPERn_EL0 register */
+#define PMU_PMEVTYPER_EL0(n)						\
+	/* PMEVTYPERn_EL0 */						\
+	{ Op0(0b11), Op1(0b011), CRn(0b1110),				\
+	  CRm((0b1100 | (((n) >> 3) & 0x3))), Op2(((n) & 0x7)),		\
+	  NULL, reset_val, (PMEVTYPER0_EL0 + (n)*2), 0 }
+
 /*
  * Architected system registers.
  * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
@@ -408,10 +463,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	/* PMINTENSET_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b001),
-	  trap_raz_wi },
-	/* PMINTENCLR_EL1 */
-	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b010),
-	  trap_raz_wi },
+	  NULL, reset_val, PMINTENSET_EL1, 0 },
 
 	/* MAIR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0010), Op2(0b000),
@@ -440,43 +492,22 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	/* PMCR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b000),
-	  trap_raz_wi },
+	  access_pmcr, reset_val, PMCR_EL0, 0 },
 	/* PMCNTENSET_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b001),
-	  trap_raz_wi },
-	/* PMCNTENCLR_EL0 */
-	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b010),
-	  trap_raz_wi },
-	/* PMOVSCLR_EL0 */
-	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b011),
-	  trap_raz_wi },
-	/* PMSWINC_EL0 */
-	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b100),
-	  trap_raz_wi },
+	  NULL, reset_val, PMCNTENSET_EL0, 0 },
 	/* PMSELR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b101),
-	  trap_raz_wi },
-	/* PMCEID0_EL0 */
-	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b110),
-	  trap_raz_wi },
-	/* PMCEID1_EL0 */
-	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b111),
-	  trap_raz_wi },
+	  NULL, reset_val, PMSELR_EL0 },
 	/* PMCCNTR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b000),
-	  trap_raz_wi },
-	/* PMXEVTYPER_EL0 */
-	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b001),
-	  trap_raz_wi },
-	/* PMXEVCNTR_EL0 */
-	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b010),
-	  trap_raz_wi },
+	  NULL, reset_val, PMCCNTR_EL0, 0 },
 	/* PMUSERENR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b000),
-	  trap_raz_wi },
+	  NULL, reset_val, PMUSERENR_EL0, 0 },
 	/* PMOVSSET_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b011),
-	  trap_raz_wi },
+	  NULL, reset_val, PMOVSSET_EL0, 0 },
 
 	/* TPIDR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b010),
@@ -485,6 +516,74 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b011),
 	  NULL, reset_unknown, TPIDRRO_EL0 },
 
+	/* PMEVCNTRn_EL0 */
+	PMU_PMEVCNTR_EL0(0),
+	PMU_PMEVCNTR_EL0(1),
+	PMU_PMEVCNTR_EL0(2),
+	PMU_PMEVCNTR_EL0(3),
+	PMU_PMEVCNTR_EL0(4),
+	PMU_PMEVCNTR_EL0(5),
+	PMU_PMEVCNTR_EL0(6),
+	PMU_PMEVCNTR_EL0(7),
+	PMU_PMEVCNTR_EL0(8),
+	PMU_PMEVCNTR_EL0(9),
+	PMU_PMEVCNTR_EL0(10),
+	PMU_PMEVCNTR_EL0(11),
+	PMU_PMEVCNTR_EL0(12),
+	PMU_PMEVCNTR_EL0(13),
+	PMU_PMEVCNTR_EL0(14),
+	PMU_PMEVCNTR_EL0(15),
+	PMU_PMEVCNTR_EL0(16),
+	PMU_PMEVCNTR_EL0(17),
+	PMU_PMEVCNTR_EL0(18),
+	PMU_PMEVCNTR_EL0(19),
+	PMU_PMEVCNTR_EL0(20),
+	PMU_PMEVCNTR_EL0(21),
+	PMU_PMEVCNTR_EL0(22),
+	PMU_PMEVCNTR_EL0(23),
+	PMU_PMEVCNTR_EL0(24),
+	PMU_PMEVCNTR_EL0(25),
+	PMU_PMEVCNTR_EL0(26),
+	PMU_PMEVCNTR_EL0(27),
+	PMU_PMEVCNTR_EL0(28),
+	PMU_PMEVCNTR_EL0(29),
+	PMU_PMEVCNTR_EL0(30),
+	/* PMEVTYPERn_EL0 */
+	PMU_PMEVTYPER_EL0(0),
+	PMU_PMEVTYPER_EL0(1),
+	PMU_PMEVTYPER_EL0(2),
+	PMU_PMEVTYPER_EL0(3),
+	PMU_PMEVTYPER_EL0(4),
+	PMU_PMEVTYPER_EL0(5),
+	PMU_PMEVTYPER_EL0(6),
+	PMU_PMEVTYPER_EL0(7),
+	PMU_PMEVTYPER_EL0(8),
+	PMU_PMEVTYPER_EL0(9),
+	PMU_PMEVTYPER_EL0(10),
+	PMU_PMEVTYPER_EL0(11),
+	PMU_PMEVTYPER_EL0(12),
+	PMU_PMEVTYPER_EL0(13),
+	PMU_PMEVTYPER_EL0(14),
+	PMU_PMEVTYPER_EL0(15),
+	PMU_PMEVTYPER_EL0(16),
+	PMU_PMEVTYPER_EL0(17),
+	PMU_PMEVTYPER_EL0(18),
+	PMU_PMEVTYPER_EL0(19),
+	PMU_PMEVTYPER_EL0(20),
+	PMU_PMEVTYPER_EL0(21),
+	PMU_PMEVTYPER_EL0(22),
+	PMU_PMEVTYPER_EL0(23),
+	PMU_PMEVTYPER_EL0(24),
+	PMU_PMEVTYPER_EL0(25),
+	PMU_PMEVTYPER_EL0(26),
+	PMU_PMEVTYPER_EL0(27),
+	PMU_PMEVTYPER_EL0(28),
+	PMU_PMEVTYPER_EL0(29),
+	PMU_PMEVTYPER_EL0(30),
+	/* PMCCFILTR_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1110), CRm(0b1111), Op2(0b111),
+	  NULL, reset_val, PMCCFILTR_EL0, 0 },
+
 	/* DACR32_EL2 */
 	{ Op0(0b11), Op1(0b100), CRn(0b0011), CRm(0b0000), Op2(0b000),
 	  NULL, reset_unknown, DACR32_EL2 },
@@ -671,19 +770,7 @@ static const struct sys_reg_desc cp15_regs[] = {
 	{ Op1( 0), CRn( 7), CRm(14), Op2( 2), access_dcsw },
 
 	/* PMU */
-	{ Op1( 0), CRn( 9), CRm(12), Op2( 0), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(12), Op2( 1), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(12), Op2( 2), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(12), Op2( 3), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(12), Op2( 5), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(12), Op2( 6), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(12), Op2( 7), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(13), Op2( 0), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(13), Op2( 1), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(13), Op2( 2), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(14), Op2( 0), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(14), Op2( 1), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(14), Op2( 2), trap_raz_wi },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 0), access_pmcr, NULL, c9_PMCR },
 
 	{ Op1( 0), CRn(10), CRm( 2), Op2( 0), access_vm_reg, NULL, c10_PRRR },
 	{ Op1( 0), CRn(10), CRm( 2), Op2( 1), access_vm_reg, NULL, c10_NMRR },
-- 
1.7.9.5
