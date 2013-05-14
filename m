From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:47 +0100
Subject: [PATCH v4 19/32] arm64: KVM: Plug the arch timer
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-20-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the in-kernel timer emulation.

Reviewed-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp.S      | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 virt/kvm/arm/arch_timer.c |  1 +
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 06a69af4..926dc7e 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -390,6 +390,60 @@ __kvm_hyp_code_start:
 2:
 .endm
 
+.macro save_timer_state
+	// x0: vcpu pointer
+	ldr	x2, [x0, #VCPU_KVM]
+	kern_hyp_va x2
+	ldr	w3, [x2, #KVM_TIMER_ENABLED]
+	cbz	w3, 1f
+
+	mrs	x3, cntv_ctl_el0
+	and	x3, x3, #3
+	str	w3, [x0, #VCPU_TIMER_CNTV_CTL]
+	bic	x3, x3, #1		// Clear Enable
+	msr	cntv_ctl_el0, x3
+
+	isb
+
+	mrs	x3, cntv_cval_el0
+	str	x3, [x0, #VCPU_TIMER_CNTV_CVAL]
+
+1:
+	// Allow physical timer/counter access for the host
+	mrs	x2, cnthctl_el2
+	orr	x2, x2, #3
+	msr	cnthctl_el2, x2
+
+	// Clear cntvoff for the host
+	msr	cntvoff_el2, xzr
+.endm
+
+.macro restore_timer_state
+	// x0: vcpu pointer
+	// Disallow physical timer access for the guest
+	// Physical counter access is allowed
+	mrs	x2, cnthctl_el2
+	orr	x2, x2, #1
+	bic	x2, x2, #2
+	msr	cnthctl_el2, x2
+
+	ldr	x2, [x0, #VCPU_KVM]
+	kern_hyp_va x2
+	ldr	w3, [x2, #KVM_TIMER_ENABLED]
+	cbz	w3, 1f
+
+	ldr	x3, [x2, #KVM_TIMER_CNTVOFF]
+	msr	cntvoff_el2, x3
+	ldr	x2, [x0, #VCPU_TIMER_CNTV_CVAL]
+	msr	cntv_cval_el0, x2
+	isb
+
+	ldr	w2, [x0, #VCPU_TIMER_CNTV_CTL]
+	and	x2, x2, #3
+	msr	cntv_ctl_el0, x2
+1:
+.endm
+
 __save_sysregs:
 	save_sysregs
 	ret
@@ -433,6 +487,7 @@ ENTRY(__kvm_vcpu_run)
 	activate_vm
 
 	restore_vgic_state
+	restore_timer_state
 
 	// Guest context
 	add	x2, x0, #VCPU_CONTEXT
@@ -456,6 +511,7 @@ __kvm_vcpu_return:
 	bl __save_fpsimd
 	bl __save_sysregs
 
+	save_timer_state
 	save_vgic_state
 
 	deactivate_traps
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 2d00b29..6f485ea 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -195,6 +195,7 @@ static struct notifier_block kvm_timer_cpu_nb = {
 
 static const struct of_device_id arch_timer_of_match[] = {
 	{ .compatible	= "arm,armv7-timer",	},
+	{ .compatible	= "arm,armv8-timer",	},
 	{},
 };
 
-- 
1.8.2.3
