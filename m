From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 13:03:30 -0500
Subject: [PATCH v6 3/4] ARM: KVM: arch_timers: Add timer world switch
In-Reply-To: <20130116180307.29693.84098.stgit@ubuntu>
References: <20130116180307.29693.84098.stgit@ubuntu>
Message-ID: <20130116180330.29693.23684.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Do the necessary save/restore dance for the timers in the world
switch code. In the process, allow the guest to read the physical
counter, which is useful for its own clock_event_device.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_asm.h |    3 +-
 arch/arm/kernel/asm-offsets.c  |    6 ++++
 arch/arm/kvm/arm.c             |    3 ++
 arch/arm/kvm/coproc.c          |    4 +++
 arch/arm/kvm/interrupts_head.S |   59 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 58d787b..8a60ed8 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -45,7 +45,8 @@
 #define c13_TID_URW	23	/* Thread ID, User R/W */
 #define c13_TID_URO	24	/* Thread ID, User R/O */
 #define c13_TID_PRIV	25	/* Thread ID, Privileged */
-#define NR_CP15_REGS	26	/* Number of regs (incl. invalid) */
+#define c14_CNTKCTL	26	/* Timer Control Register (PL1) */
+#define NR_CP15_REGS	27	/* Number of regs (incl. invalid) */
 
 #define ARM_EXCEPTION_RESET	  0
 #define ARM_EXCEPTION_UNDEFINED   1
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 17cea2e..5ce738b 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -179,6 +179,12 @@ int main(void)
   DEFINE(VGIC_CPU_APR,		offsetof(struct vgic_cpu, vgic_apr));
   DEFINE(VGIC_CPU_LR,		offsetof(struct vgic_cpu, vgic_lr));
   DEFINE(VGIC_CPU_NR_LR,	offsetof(struct vgic_cpu, nr_lr));
+#ifdef CONFIG_KVM_ARM_TIMER
+  DEFINE(VCPU_TIMER_CNTV_CTL,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_ctl));
+  DEFINE(VCPU_TIMER_CNTV_CVAL,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_cval));
+  DEFINE(KVM_TIMER_CNTVOFF,	offsetof(struct kvm, arch.timer.cntvoff));
+  DEFINE(KVM_TIMER_ENABLED,	offsetof(struct kvm, arch.timer.enabled));
+#endif
   DEFINE(KVM_VGIC_VCTRL,	offsetof(struct kvm, arch.vgic.vctrl_base));
 #endif
   DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 68cb2b550..1a98b5c 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -707,6 +707,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		update_vttbr(vcpu->kvm);
 
 		kvm_vgic_flush_hwstate(vcpu);
+		kvm_timer_flush_hwstate(vcpu);
 
 		local_irq_disable();
 
@@ -720,6 +721,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
 			local_irq_enable();
+			kvm_timer_sync_hwstate(vcpu);
 			kvm_vgic_sync_hwstate(vcpu);
 			continue;
 		}
@@ -759,6 +761,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * Back from guest
 		 *************************************************************/
 
+		kvm_timer_sync_hwstate(vcpu);
 		kvm_vgic_sync_hwstate(vcpu);
 
 		ret = handle_exit(vcpu, run, ret);
diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index d782638..4ea9a98 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -222,6 +222,10 @@ static const struct coproc_reg cp15_regs[] = {
 			NULL, reset_unknown, c13_TID_URO },
 	{ CRn(13), CRm( 0), Op1( 0), Op2( 4), is32,
 			NULL, reset_unknown, c13_TID_PRIV },
+
+	/* CNTKCTL: swapped by interrupt.S. */
+	{ CRn(14), CRm( 1), Op1( 0), Op2( 0), is32,
+			NULL, reset_val, c14_CNTKCTL, 0x00000000 },
 };
 
 /* Target specific emulation tables */
diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index dea987e..d2442f9 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -300,6 +300,14 @@ vcpu	.req	r0		@ vcpu pointer always in r0
 	str	r11, [vcpu, #CP15_OFFSET(c6_IFAR)]
 	str	r12, [vcpu, #CP15_OFFSET(c12_VBAR)]
 	.endif
+
+	mrc	p15, 0, r2, c14, c1, 0	@ CNTKCTL
+
+	.if \store_to_vcpu == 0
+	push	{r2}
+	.else
+	str	r2, [vcpu, #CP15_OFFSET(c14_CNTKCTL)]
+	.endif
 .endm
 
 /*
@@ -311,6 +319,14 @@ vcpu	.req	r0		@ vcpu pointer always in r0
  */
 .macro write_cp15_state read_from_vcpu
 	.if \read_from_vcpu == 0
+	pop	{r2}
+	.else
+	ldr	r2, [vcpu, #CP15_OFFSET(c14_CNTKCTL)]
+	.endif
+
+	mcr	p15, 0, r2, c14, c1, 0	@ CNTKCTL
+
+	.if \read_from_vcpu == 0
 	pop	{r2-r12}
 	.else
 	ldr	r2, [vcpu, #CP15_OFFSET(c13_CID)]
@@ -461,8 +477,28 @@ vcpu	.req	r0		@ vcpu pointer always in r0
  * for the host.
  *
  * Assumes vcpu pointer in vcpu reg
+ * Clobbers r2-r5
  */
 .macro save_timer_state
+#ifdef CONFIG_KVM_ARM_TIMER
+	ldr	r4, [vcpu, #VCPU_KVM]
+	ldr	r2, [r4, #KVM_TIMER_ENABLED]
+	cmp	r2, #0
+	beq	1f
+
+	mrc	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
+	str	r2, [vcpu, #VCPU_TIMER_CNTV_CTL]
+	bic	r2, #1			@ Clear ENABLE
+	mcr	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
+	isb
+
+	mrrc	p15, 3, r2, r3, c14	@ CNTV_CVAL
+	ldr	r4, =VCPU_TIMER_CNTV_CVAL
+	add	r5, vcpu, r4
+	strd	r2, r3, [r5]
+
+1:
+#endif
 	@ Allow physical timer/counter access for the host
 	mrc	p15, 4, r2, c14, c1, 0	@ CNTHCTL
 	orr	r2, r2, #(CNTHCTL_PL1PCEN | CNTHCTL_PL1PCTEN)
@@ -474,6 +510,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
  * for the host.
  *
  * Assumes vcpu pointer in vcpu reg
+ * Clobbers r2-r5
  */
 .macro restore_timer_state
 	@ Disallow physical timer access for the guest
@@ -482,6 +519,28 @@ vcpu	.req	r0		@ vcpu pointer always in r0
 	orr	r2, r2, #CNTHCTL_PL1PCTEN
 	bic	r2, r2, #CNTHCTL_PL1PCEN
 	mcr	p15, 4, r2, c14, c1, 0	@ CNTHCTL
+
+#ifdef CONFIG_KVM_ARM_TIMER
+	ldr	r4, [vcpu, #VCPU_KVM]
+	ldr	r2, [r4, #KVM_TIMER_ENABLED]
+	cmp	r2, #0
+	beq	1f
+
+	ldr	r2, [r4, #KVM_TIMER_CNTVOFF]
+	ldr	r3, [r4, #(KVM_TIMER_CNTVOFF + 4)]
+	mcrr	p15, 4, r2, r3, c14	@ CNTVOFF
+
+	ldr	r4, =VCPU_TIMER_CNTV_CVAL
+	add	r5, vcpu, r4
+	ldrd	r2, r3, [r5]
+	mcrr	p15, 3, r2, r3, c14	@ CNTV_CVAL
+	isb
+
+	ldr	r2, [vcpu, #VCPU_TIMER_CNTV_CTL]
+	and	r2, r2, #3
+	mcr	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
+1:
+#endif
 .endm
 
 .equ vmentry,	0
