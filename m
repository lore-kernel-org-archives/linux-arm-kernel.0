From: anup.patel@linaro.org (Anup Patel)
Date: Tue,  5 Aug 2014 14:54:15 +0530
Subject: [RFC PATCH 6/6] ARM64: KVM: Upgrade to lazy context switch of PMU
 registers
In-Reply-To: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
References: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1407230655-28864-7-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Full context switch of all PMU registers for both host and
guest can make KVM world-switch very expensive.

This patch improves current PMU context switch by implementing
lazy context switch of PMU registers.

To achieve this, we trap all PMU register accesses and use a
per-VCPU dirty flag to keep track whether guest has updated
PMU registers or not. If PMU registers of VCPU are dirty or
PMCR_EL0.E bit is set for VCPU then we do full context switch
for both host and guest.
(This is very similar to lazy world switch for debug registers:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/271040.html)

Also, we always trap-n-emulate PMCR_EL0 to fake number of event
counters available to guest. For this PMCR_EL0 trap-n-emulate to
work correctly, we always save/restore PMCR_EL0 for both host and
guest whereas other PMU registers will be saved/restored based
on PMU dirty flag.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm64/include/asm/kvm_asm.h  |    3 +
 arch/arm64/include/asm/kvm_host.h |    3 +
 arch/arm64/kernel/asm-offsets.c   |    1 +
 arch/arm64/kvm/hyp.S              |   63 ++++++++--
 arch/arm64/kvm/sys_regs.c         |  248 +++++++++++++++++++++++++++++++++++--
 5 files changed, 298 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 93be21f..47b7fcd 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -132,6 +132,9 @@
 #define KVM_ARM64_DEBUG_DIRTY_SHIFT	0
 #define KVM_ARM64_DEBUG_DIRTY		(1 << KVM_ARM64_DEBUG_DIRTY_SHIFT)
 
+#define KVM_ARM64_PMU_DIRTY_SHIFT	0
+#define KVM_ARM64_PMU_DIRTY		(1 << KVM_ARM64_PMU_DIRTY_SHIFT)
+
 #ifndef __ASSEMBLY__
 struct kvm;
 struct kvm_vcpu;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ae4cdb2..4dba2a3 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -117,6 +117,9 @@ struct kvm_vcpu_arch {
 	/* Timer state */
 	struct arch_timer_cpu timer_cpu;
 
+	/* PMU flags */
+	u64 pmu_flags;
+
 	/* PMU state */
 	struct pmu_cpu pmu_cpu;
 
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 053dc3e..4234794 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -140,6 +140,7 @@ int main(void)
   DEFINE(VGIC_CPU_NR_LR,	offsetof(struct vgic_cpu, nr_lr));
   DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
   DEFINE(KVM_VGIC_VCTRL,	offsetof(struct kvm, arch.vgic.vctrl_base));
+  DEFINE(VCPU_PMU_FLAGS,	offsetof(struct kvm_vcpu, arch.pmu_flags));
   DEFINE(VCPU_PMU_IRQ_PENDING,	offsetof(struct kvm_vcpu, arch.pmu_cpu.irq_pending));
 #endif
 #ifdef CONFIG_ARM64_CPU_SUSPEND
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 6b41c01..5f9ccee 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -443,6 +443,9 @@ __kvm_hyp_code_start:
 	and	x5, x4, #~(ARMV8_PMCR_E)// Clear PMCR_EL0.E
 	msr	pmcr_el0, x5		// This will stop all counters
 
+	ldr	x5, [x0, #VCPU_PMU_FLAGS] // Only save if dirty flag set
+	tbz	x5, #KVM_ARM64_PMU_DIRTY_SHIFT, 1f
+
 	mov	x3, #0
 	ubfx	x4, x4, #ARMV8_PMCR_N_SHIFT, #5	// Number of event counters
 	cmp	x4, #0			// Skip if no event counters
@@ -731,7 +734,7 @@ __kvm_hyp_code_start:
 	msr	mdccint_el1, x21
 .endm
 
-.macro restore_pmu
+.macro restore_pmu, is_vcpu_pmu
 	// x2: base address for cpu context
 	// x3: mask of counters allowed in EL0 & EL1
 	// x4: number of event counters allowed in EL0 & EL1
@@ -741,16 +744,19 @@ __kvm_hyp_code_start:
 	cmp	x5, #1			// Must be PMUv3 else skip
 	bne	1f
 
+	ldr	x5, [x0, #VCPU_PMU_FLAGS] // Only restore if dirty flag set
+	tbz	x5, #KVM_ARM64_PMU_DIRTY_SHIFT, 2f
+
 	mov	x3, #0
 	mrs	x4, pmcr_el0
 	ubfx	x4, x4, #ARMV8_PMCR_N_SHIFT, #5	// Number of event counters
 	cmp	x4, #0			// Skip if no event counters
-	beq	2f
+	beq	3f
 	sub	x4, x4, #1		// Last event counter is reserved
 	mov	x3, #1
 	lsl	x3, x3, x4
 	sub	x3, x3, #1
-2:	orr	x3, x3, #(1 << 31)	// Mask of event counters
+3:	orr	x3, x3, #(1 << 31)	// Mask of event counters
 
 	ldr	x5, [x2, #CPU_SYSREG_OFFSET(PMCCFILTR_EL0)]
 	msr	pmccfiltr_el0, x5	// Restore PMCCFILTR_EL0
@@ -772,15 +778,15 @@ __kvm_hyp_code_start:
 	lsl	x5, x4, #4
 	add	x5, x5, #CPU_SYSREG_OFFSET(PMEVCNTR0_EL0)
 	add	x5, x2, x5
-3:	cmp	x4, #0
-	beq	4f
+4:	cmp	x4, #0
+	beq	5f
 	sub	x4, x4, #1
 	ldp	x6, x7, [x5, #-16]!
 	msr	pmselr_el0, x4
 	msr	pmxevcntr_el0, x6	// Restore PMEVCNTR<n>_EL0
 	msr	pmxevtyper_el0, x7	// Restore PMEVTYPER<n>_EL0
-	b	3b
-4:
+	b	4b
+5:
 	ldr	x5, [x2, #CPU_SYSREG_OFFSET(PMSELR_EL0)]
 	msr	pmselr_el0, x5		// Restore PMSELR_EL0
 
@@ -792,6 +798,13 @@ __kvm_hyp_code_start:
 	and	x5, x5, x3
 	msr	pmovsset_el0, x5	// Restore PMOVSSET_EL0
 
+	.if \is_vcpu_pmu == 0
+	// Clear the dirty flag for the next run, as all the state has
+	// already been saved. Note that we nuke the whole 64bit word.
+	// If we ever add more flags, we'll have to be more careful...
+	str	xzr, [x0, #VCPU_PMU_FLAGS]
+	.endif
+2:
 	ldr	x5, [x2, #CPU_SYSREG_OFFSET(PMCR_EL0)]
 	msr	pmcr_el0, x5		// Restore PMCR_EL0
 1:
@@ -838,6 +851,23 @@ __kvm_hyp_code_start:
 9999:
 .endm
 
+.macro compute_pmu_state
+	// Compute pmu state: If PMCR_EL0.E is set then
+	// we do full save/restore cycle and disable trapping
+	add	x25, x0, #VCPU_CONTEXT
+
+	// Check the state of PMCR_EL0.E bit
+	ldr	x26, [x25, #CPU_SYSREG_OFFSET(PMCR_EL0)]
+	and	x26, x26, #ARMV8_PMCR_E
+	cmp	x26, #0
+	b.eq	8887f
+
+	// If any interesting bits was set, we must set the flag
+	mov	x26, #KVM_ARM64_PMU_DIRTY
+	str	x26, [x0, #VCPU_PMU_FLAGS]
+8887:
+.endm
+
 .macro save_guest_32bit_state
 	skip_32bit_state x3, 1f
 
@@ -919,6 +949,12 @@ __kvm_hyp_code_start:
 	orr	x2, x2, #MDCR_EL2_TPMCR
 	orr	x2, x2, #(MDCR_EL2_TDRA | MDCR_EL2_TDOSA)
 
+	// Check for KVM_ARM64_PMU_DIRTY, and set PMU to trap
+	// all PMU registers if PMU not dirty.
+	ldr	x3, [x0, #VCPU_PMU_FLAGS]
+	tbnz	x3, #KVM_ARM64_PMU_DIRTY_SHIFT, 1f
+	orr	x2, x2, #MDCR_EL2_TPM
+1:
 	// Check for KVM_ARM64_DEBUG_DIRTY, and set debug to trap
 	// if not dirty.
 	ldr	x3, [x0, #VCPU_DEBUG_FLAGS]
@@ -1127,8 +1163,12 @@ __save_pmu_guest:
 	save_pmu 1
 	ret
 
-__restore_pmu:
-	restore_pmu
+__restore_pmu_host:
+	restore_pmu 0
+	ret
+
+__restore_pmu_guest:
+	restore_pmu 1
 	ret
 
 __save_fpsimd:
@@ -1160,6 +1200,7 @@ ENTRY(__kvm_vcpu_run)
 
 	save_host_regs
 
+	compute_pmu_state
 	bl __save_pmu_host
 
 	bl __save_fpsimd
@@ -1185,7 +1226,7 @@ ENTRY(__kvm_vcpu_run)
 1:
 	restore_guest_32bit_state
 
-	bl __restore_pmu
+	bl __restore_pmu_guest
 
 	restore_guest_regs
 
@@ -1232,7 +1273,7 @@ __kvm_vcpu_return:
 	str	xzr, [x0, #VCPU_DEBUG_FLAGS]
 	bl	__restore_debug
 1:
-	bl __restore_pmu
+	bl __restore_pmu_host
 
 	restore_host_regs
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 081f95e..cda6774 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -166,6 +166,130 @@ static bool access_sctlr(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+/* PMU reg accessor. Only called as long as MDCR_EL2.TPMCR is set. */
+static bool access_pmu_reg(struct kvm_vcpu *vcpu,
+			   const struct sys_reg_params *p,
+			   const struct sys_reg_desc *r)
+{
+	unsigned long val;
+
+	if (p->is_write) {
+		val = *vcpu_reg(vcpu, p->Rt);
+		if (!p->is_aarch32)
+			vcpu_sys_reg(vcpu, r->reg) = val;
+		else
+			vcpu_cp15(vcpu, r->reg) = val & 0xffffffffUL;
+		vcpu->arch.pmu_flags |= KVM_ARM64_PMU_DIRTY;
+	} else {
+		if (!p->is_aarch32)
+			val = vcpu_sys_reg(vcpu, r->reg);
+		else
+			val = vcpu_cp15(vcpu, r->reg);
+		*vcpu_reg(vcpu, p->Rt) = val;
+	}
+
+	return true;
+}
+
+/* PMU set reg accessor. Only called as long as MDCR_EL2.TPM is set. */
+static bool access_pmu_setreg(struct kvm_vcpu *vcpu,
+			      const struct sys_reg_params *p,
+			      const struct sys_reg_desc *r)
+{
+	unsigned long val;
+
+	if (p->is_write) {
+		val = *vcpu_reg(vcpu, p->Rt);
+		if (!p->is_aarch32)
+			vcpu_sys_reg(vcpu, r->reg) |= val;
+		else
+			vcpu_cp15(vcpu, r->reg) |= val & 0xffffffffUL;
+		vcpu->arch.pmu_flags |= KVM_ARM64_PMU_DIRTY;
+	} else {
+		if (!p->is_aarch32)
+			val = vcpu_sys_reg(vcpu, r->reg);
+		else
+			val = vcpu_cp15(vcpu, r->reg);
+		*vcpu_reg(vcpu, p->Rt) = val;
+	}
+
+	return true;
+}
+
+/* PMU clear reg accessor. Only called as long as MDCR_EL2.TPM is set. */
+static bool access_pmu_clrreg(struct kvm_vcpu *vcpu,
+			      const struct sys_reg_params *p,
+			      const struct sys_reg_desc *r)
+{
+	unsigned long val;
+
+	if (p->is_write) {
+		val = *vcpu_reg(vcpu, p->Rt);
+		if (!p->is_aarch32)
+			vcpu_sys_reg(vcpu, r->reg) &= ~val;
+		else
+			vcpu_cp15(vcpu, r->reg) &= ~(val & 0xffffffffUL);
+		vcpu->arch.pmu_flags |= KVM_ARM64_PMU_DIRTY;
+	} else {
+		if (!p->is_aarch32)
+			val = vcpu_sys_reg(vcpu, r->reg);
+		else
+			val = vcpu_cp15(vcpu, r->reg);
+		*vcpu_reg(vcpu, p->Rt) = val;
+	}
+
+	return true;
+}
+
+/* PMU extended reg accessor. Only called as long as MDCR_EL2.TPM is set. */
+static bool access_pmu_xreg(struct kvm_vcpu *vcpu,
+			    const struct sys_reg_params *p,
+			    const struct sys_reg_desc *r)
+{
+	unsigned long index, reg, val;
+
+	if (!p->is_aarch32)
+		index = vcpu_sys_reg(vcpu, PMSELR_EL0) & ARMV8_PMCR_N_MASK;
+	else
+		index = vcpu_cp15(vcpu, c9_PMSELR) & ARMV8_PMCR_N_MASK;
+
+	if (index != ARMV8_PMCR_N_MASK) {
+		if (!p->is_aarch32) {
+			if (r->reg == PMEVCNTR0_EL0)
+				reg = PMCCNTR_EL0;
+			else
+				reg = PMCCFILTR_EL0;
+		} else {
+			if (r->reg == c14_PMEVCNTR0)
+				reg = c9_PMCCNTR;
+			else
+				reg = c14_PMCCFILTR;
+		}
+	} else {
+		if (!p->is_aarch32)
+			reg = r->reg + 2*index;
+		else
+			reg = r->reg + 4*index;
+	}
+
+	if (p->is_write) {
+		val = *vcpu_reg(vcpu, p->Rt);
+		if (!p->is_aarch32)
+			vcpu_sys_reg(vcpu, reg) = val;
+		else
+			vcpu_cp15(vcpu, reg) = val & 0xffffffffUL;
+		vcpu->arch.pmu_flags |= KVM_ARM64_PMU_DIRTY;
+	} else {
+		if (!p->is_aarch32)
+			val = vcpu_sys_reg(vcpu, reg);
+		else
+			val = vcpu_cp15(vcpu, reg);
+		*vcpu_reg(vcpu, p->Rt) = val;
+	}
+
+	return true;
+}
+
 /* PMCR_EL0 accessor. Only called as long as MDCR_EL2.TPMCR is set. */
 static bool access_pmcr(struct kvm_vcpu *vcpu,
 			const struct sys_reg_params *p,
@@ -185,6 +309,7 @@ static bool access_pmcr(struct kvm_vcpu *vcpu,
 			vcpu_sys_reg(vcpu, r->reg) = val;
 		else
 			vcpu_cp15(vcpu, r->reg) = val;
+		vcpu->arch.pmu_flags |= KVM_ARM64_PMU_DIRTY;
 	} else {
 		/*
 		 * We reserve the last event counter for EL2-mode
@@ -318,14 +443,14 @@ static void reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	/* PMEVCNTRn_EL0 */						\
 	{ Op0(0b11), Op1(0b011), CRn(0b1110),				\
 	  CRm((0b1000 | (((n) >> 3) & 0x3))), Op2(((n) & 0x7)),		\
-	  NULL, reset_val, (PMEVCNTR0_EL0 + (n)*2), 0 }
+	  access_pmu_reg, reset_val, (PMEVCNTR0_EL0 + (n)*2), 0 }
 
 /* Macro to expand the PMEVTYPERn_EL0 register */
 #define PMU_PMEVTYPER_EL0(n)						\
 	/* PMEVTYPERn_EL0 */						\
 	{ Op0(0b11), Op1(0b011), CRn(0b1110),				\
 	  CRm((0b1100 | (((n) >> 3) & 0x3))), Op2(((n) & 0x7)),		\
-	  NULL, reset_val, (PMEVTYPER0_EL0 + (n)*2), 0 }
+	  access_pmu_reg, reset_val, (PMEVTYPER0_EL0 + (n)*2), 0 }
 
 /*
  * Architected system registers.
@@ -463,7 +588,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	/* PMINTENSET_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b001),
-	  NULL, reset_val, PMINTENSET_EL1, 0 },
+	  access_pmu_setreg, reset_val, PMINTENSET_EL1, 0 },
+	/* PMINTENCLR_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b010),
+	  access_pmu_clrreg, reset_val, PMINTENSET_EL1, 0 },
 
 	/* MAIR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0010), Op2(0b000),
@@ -495,19 +623,31 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  access_pmcr, reset_val, PMCR_EL0, 0 },
 	/* PMCNTENSET_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b001),
-	  NULL, reset_val, PMCNTENSET_EL0, 0 },
+	  access_pmu_setreg, reset_val, PMCNTENSET_EL0, 0 },
+	/* PMCNTENCLR_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b010),
+	  access_pmu_clrreg, reset_val, PMCNTENSET_EL0, 0 },
+	/* PMOVSCLR_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b011),
+	  access_pmu_clrreg, reset_val, PMOVSSET_EL0, 0 },
 	/* PMSELR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b101),
-	  NULL, reset_val, PMSELR_EL0 },
+	  access_pmu_reg, reset_val, PMSELR_EL0 },
 	/* PMCCNTR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b000),
-	  NULL, reset_val, PMCCNTR_EL0, 0 },
+	  access_pmu_reg, reset_val, PMCCNTR_EL0, 0 },
+	/* PMXEVTYPER_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b001),
+	  access_pmu_xreg, reset_val, PMEVTYPER0_EL0, 0 },
+	/* PMXEVCNTR_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b010),
+	  access_pmu_xreg, reset_val, PMEVCNTR0_EL0, 0 },
 	/* PMUSERENR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b000),
-	  NULL, reset_val, PMUSERENR_EL0, 0 },
+	  access_pmu_reg, reset_val, PMUSERENR_EL0, 0 },
 	/* PMOVSSET_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b011),
-	  NULL, reset_val, PMOVSSET_EL0, 0 },
+	  access_pmu_setreg, reset_val, PMOVSSET_EL0, 0 },
 
 	/* TPIDR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b010),
@@ -582,7 +722,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	PMU_PMEVTYPER_EL0(30),
 	/* PMCCFILTR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1110), CRm(0b1111), Op2(0b111),
-	  NULL, reset_val, PMCCFILTR_EL0, 0 },
+	  access_pmu_reg, reset_val, PMCCFILTR_EL0, 0 },
 
 	/* DACR32_EL2 */
 	{ Op0(0b11), Op1(0b100), CRn(0b0011), CRm(0b0000), Op2(0b000),
@@ -744,6 +884,20 @@ static const struct sys_reg_desc cp14_64_regs[] = {
 	{ Op1( 0), CRm( 2), .access = trap_raz_wi },
 };
 
+/* Macro to expand the PMEVCNTR<n> register */
+#define PMU_PMEVCNTR(n)							\
+	/* PMEVCNTRn */							\
+	{  Op1( 0), CRn(14), 						\
+	  CRm((0b1000 | (((n) >> 3) & 0x3))), Op2(((n) & 0x7)),		\
+	  access_pmu_reg, reset_val, (c14_PMEVCNTR0 + (n)*4), 0 }
+
+/* Macro to expand the PMEVTYPER<n> register */
+#define PMU_PMEVTYPER(n)						\
+	/* PMEVTYPERn_EL0 */						\
+	{ Op1( 0), CRn(14), 						\
+	  CRm((0b1100 | (((n) >> 3) & 0x3))), Op2(((n) & 0x7)),		\
+	  access_pmu_reg, reset_val, (c14_PMEVTYPR0 + (n)*4), 0 }
+
 /*
  * Trapped cp15 registers. TTBR0/TTBR1 get a double encoding,
  * depending on the way they are accessed (as a 32bit or a 64bit
@@ -771,12 +925,88 @@ static const struct sys_reg_desc cp15_regs[] = {
 
 	/* PMU */
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 0), access_pmcr, NULL, c9_PMCR },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 1), access_pmu_setreg, NULL, c9_PMCNTENSET },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 2), access_pmu_clrreg, NULL, c9_PMCNTENSET },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 3), access_pmu_clrreg, NULL, c9_PMOVSSET },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 5), access_pmu_reg, NULL, c9_PMSELR },
+	{ Op1( 0), CRn( 9), CRm(13), Op2( 0), access_pmu_reg, NULL, c9_PMCCNTR },
+	{ Op1( 0), CRn( 9), CRm(13), Op2( 1), access_pmu_xreg, NULL, c14_PMEVTYPR0 },
+	{ Op1( 0), CRn( 9), CRm(13), Op2( 2), access_pmu_xreg, NULL, c14_PMEVCNTR0 },
+	{ Op1( 0), CRn( 9), CRm(14), Op2( 0), access_pmu_reg, NULL, c9_PMUSERENR },
+	{ Op1( 0), CRn( 9), CRm(14), Op2( 1), access_pmu_setreg, NULL, c9_PMINTENSET },
+	{ Op1( 0), CRn( 9), CRm(14), Op2( 2), access_pmu_clrreg, NULL, c9_PMINTENSET },
+	{ Op1( 0), CRn( 9), CRm(14), Op2( 3), access_pmu_setreg, NULL, c9_PMOVSSET },
 
 	{ Op1( 0), CRn(10), CRm( 2), Op2( 0), access_vm_reg, NULL, c10_PRRR },
 	{ Op1( 0), CRn(10), CRm( 2), Op2( 1), access_vm_reg, NULL, c10_NMRR },
 	{ Op1( 0), CRn(10), CRm( 3), Op2( 0), access_vm_reg, NULL, c10_AMAIR0 },
 	{ Op1( 0), CRn(10), CRm( 3), Op2( 1), access_vm_reg, NULL, c10_AMAIR1 },
 	{ Op1( 0), CRn(13), CRm( 0), Op2( 1), access_vm_reg, NULL, c13_CID },
+
+	/* PMU */
+	PMU_PMEVCNTR(0),
+	PMU_PMEVCNTR(1),
+	PMU_PMEVCNTR(2),
+	PMU_PMEVCNTR(3),
+	PMU_PMEVCNTR(4),
+	PMU_PMEVCNTR(5),
+	PMU_PMEVCNTR(6),
+	PMU_PMEVCNTR(7),
+	PMU_PMEVCNTR(8),
+	PMU_PMEVCNTR(9),
+	PMU_PMEVCNTR(10),
+	PMU_PMEVCNTR(11),
+	PMU_PMEVCNTR(12),
+	PMU_PMEVCNTR(13),
+	PMU_PMEVCNTR(14),
+	PMU_PMEVCNTR(15),
+	PMU_PMEVCNTR(16),
+	PMU_PMEVCNTR(17),
+	PMU_PMEVCNTR(18),
+	PMU_PMEVCNTR(19),
+	PMU_PMEVCNTR(20),
+	PMU_PMEVCNTR(21),
+	PMU_PMEVCNTR(22),
+	PMU_PMEVCNTR(23),
+	PMU_PMEVCNTR(24),
+	PMU_PMEVCNTR(25),
+	PMU_PMEVCNTR(26),
+	PMU_PMEVCNTR(27),
+	PMU_PMEVCNTR(28),
+	PMU_PMEVCNTR(29),
+	PMU_PMEVCNTR(30),
+	PMU_PMEVTYPER(0),
+	PMU_PMEVTYPER(1),
+	PMU_PMEVTYPER(2),
+	PMU_PMEVTYPER(3),
+	PMU_PMEVTYPER(4),
+	PMU_PMEVTYPER(5),
+	PMU_PMEVTYPER(6),
+	PMU_PMEVTYPER(7),
+	PMU_PMEVTYPER(8),
+	PMU_PMEVTYPER(9),
+	PMU_PMEVTYPER(10),
+	PMU_PMEVTYPER(11),
+	PMU_PMEVTYPER(12),
+	PMU_PMEVTYPER(13),
+	PMU_PMEVTYPER(14),
+	PMU_PMEVTYPER(15),
+	PMU_PMEVTYPER(16),
+	PMU_PMEVTYPER(17),
+	PMU_PMEVTYPER(18),
+	PMU_PMEVTYPER(19),
+	PMU_PMEVTYPER(20),
+	PMU_PMEVTYPER(21),
+	PMU_PMEVTYPER(22),
+	PMU_PMEVTYPER(23),
+	PMU_PMEVTYPER(24),
+	PMU_PMEVTYPER(25),
+	PMU_PMEVTYPER(26),
+	PMU_PMEVTYPER(27),
+	PMU_PMEVTYPER(28),
+	PMU_PMEVTYPER(29),
+	PMU_PMEVTYPER(30),
+	{ Op1( 0), CRn(14), CRm(15), Op2( 7), access_pmu_reg, NULL, c14_PMCCFILTR },
 };
 
 static const struct sys_reg_desc cp15_64_regs[] = {
-- 
1.7.9.5
