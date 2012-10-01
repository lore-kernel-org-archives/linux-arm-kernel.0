From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:16:21 -0400
Subject: [PATCH v2 4/5] ARM: KVM: arch_timers: Add timer world switch
In-Reply-To: <20121001091528.49694.69990.stgit@ubuntu>
References: <20121001091528.49694.69990.stgit@ubuntu>
Message-ID: <20121001091621.49694.64597.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Do the necessary save/restore dance for the timers in the world
switch code. In the process, allow the guest to read the physical
counter, which is useful for its own clock_event_device.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/kernel/asm-offsets.c  |    8 ++++++++
 arch/arm/kvm/arm.c             |    3 +++
 arch/arm/kvm/interrupts_head.S |   41 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 1f4a894..1c4181e 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -176,6 +176,14 @@ int main(void)
   DEFINE(VGIC_CPU_APR,		offsetof(struct vgic_cpu, vgic_apr));
   DEFINE(VGIC_CPU_LR,		offsetof(struct vgic_cpu, vgic_lr));
   DEFINE(VGIC_CPU_NR_LR,	offsetof(struct vgic_cpu, nr_lr));
+#ifdef CONFIG_KVM_ARM_TIMER
+  DEFINE(VCPU_TIMER_CNTV_CTL,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_ctl));
+  DEFINE(VCPU_TIMER_CNTV_CVALH,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_cval32.high));
+  DEFINE(VCPU_TIMER_CNTV_CVALL,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_cval32.low));
+  DEFINE(KVM_TIMER_CNTVOFF_H,	offsetof(struct kvm, arch.timer.cntvoff32.high));
+  DEFINE(KVM_TIMER_CNTVOFF_L,	offsetof(struct kvm, arch.timer.cntvoff32.low));
+  DEFINE(KVM_TIMER_ENABLED,	offsetof(struct kvm, arch.timer.enabled));
+#endif
   DEFINE(KVM_VGIC_VCTRL,	offsetof(struct kvm, arch.vgic.vctrl_base));
 #endif
   DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index b03e604..c62bf28 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -649,6 +649,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		update_vttbr(vcpu->kvm);
 
 		kvm_vgic_sync_to_cpu(vcpu);
+		kvm_timer_sync_to_cpu(vcpu);
 
 		local_irq_disable();
 
@@ -662,6 +663,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
 			local_irq_enable();
+			kvm_timer_sync_from_cpu(vcpu);
 			kvm_vgic_sync_from_cpu(vcpu);
 			continue;
 		}
@@ -701,6 +703,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * Back from guest
 		 *************************************************************/
 
+		kvm_timer_sync_from_cpu(vcpu);
 		kvm_vgic_sync_from_cpu(vcpu);
 
 		ret = handle_exit(vcpu, run, ret);
diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index 4703035..514a75a 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -306,6 +306,25 @@
 #define CNTHCTL_PL1PCEN		(1 << 1)
 
 .macro save_timer_state	vcpup
+#ifdef CONFIG_KVM_ARM_TIMER
+	ldr	r4, [\vcpup, #VCPU_KVM]
+	ldr	r2, [r4, #KVM_TIMER_ENABLED]
+	cmp	r2, #0
+	beq	1f
+
+	mrc	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
+	and	r2, #3
+	str	r2, [\vcpup, #VCPU_TIMER_CNTV_CTL]
+	bic	r2, #1			@ Clear ENABLE
+	mcr	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
+	isb
+
+	mrrc	p15, 3, r2, r3, c14	@ CNTV_CVAL
+	str	r3, [\vcpup, #VCPU_TIMER_CNTV_CVALH]
+	str	r2, [\vcpup, #VCPU_TIMER_CNTV_CVALL]
+
+1:
+#endif
 	@ Allow physical timer/counter access for the host
 	mrc	p15, 4, r2, c14, c1, 0	@ CNTHCTL
 	orr	r2, r2, #(CNTHCTL_PL1PCEN | CNTHCTL_PL1PCTEN)
@@ -319,6 +338,28 @@
 	orr	r2, r2, #CNTHCTL_PL1PCTEN
 	bic	r2, r2, #CNTHCTL_PL1PCEN
 	mcr	p15, 4, r2, c14, c1, 0	@ CNTHCTL
+
+#ifdef CONFIG_KVM_ARM_TIMER
+	ldr	r4, [\vcpup, #VCPU_KVM]
+	ldr	r2, [r4, #KVM_TIMER_ENABLED]
+	cmp	r2, #0
+	beq	1f
+
+	ldr	r3, [r4, #KVM_TIMER_CNTVOFF_H]
+	ldr	r2, [r4, #KVM_TIMER_CNTVOFF_L]
+	mcrr	p15, 4, r2, r3, c14	@ CNTVOFF
+	isb
+
+	ldr	r3, [\vcpup, #VCPU_TIMER_CNTV_CVALH]
+	ldr	r2, [\vcpup, #VCPU_TIMER_CNTV_CVALL]
+	mcrr	p15, 3, r2, r3, c14	@ CNTV_CVAL
+
+	ldr	r2, [\vcpup, #VCPU_TIMER_CNTV_CTL]
+	and	r2, #3
+	mcr	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
+	isb
+1:
+#endif
 .endm
 
 /* Configures the HSTR (Hyp System Trap Register) on entry/return
