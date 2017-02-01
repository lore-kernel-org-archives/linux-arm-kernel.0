From: jintack@cs.columbia.edu (Jintack Lim)
Date: Wed,  1 Feb 2017 12:43:08 -0500
Subject: [RFC v3 08/10] KVM: arm/arm64: Set up a background timer for the
 physical timer emulation
In-Reply-To: <1485970990-13775-1-git-send-email-jintack@cs.columbia.edu>
References: <1485970990-13775-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1485970990-13775-9-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set a background timer for the EL1 physical timer emulation while VMs
are running, so that VMs get the physical timer interrupts in a timely
manner.

Schedule the background timer on entry to the VM and cancel it on exit.
This would not have any performance impact to the guest OSes that
currently use the virtual timer since the physical timer is always not
enabled.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 virt/kvm/arm/arch_timer.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 89bdb79..1806e5e 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -229,6 +229,22 @@ static int kvm_timer_update_state(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+/* Schedule the background timer for the emulated timer. */
+static void kvm_timer_emulate(struct kvm_vcpu *vcpu,
+			      struct arch_timer_context *timer_ctx)
+{
+	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+
+	if (kvm_timer_should_fire(timer_ctx))
+		return;
+
+	if (!kvm_timer_irq_can_fire(timer_ctx))
+		return;
+
+	/*  The timer has not yet expired, schedule a background timer */
+	timer_arm(timer, kvm_timer_compute_delta(timer_ctx));
+}
+
 /*
  * Schedule the background timer before calling kvm_vcpu_block, so that this
  * thread is removed from its waitqueue and made runnable when there's a timer
@@ -286,6 +302,9 @@ void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu)
 	if (kvm_timer_update_state(vcpu))
 		return;
 
+	/* Set the background timer for the physical timer emulation. */
+	kvm_timer_emulate(vcpu, vcpu_ptimer(vcpu));
+
 	/*
 	* If we enter the guest with the virtual input level to the VGIC
 	* asserted, then we have already told the VGIC what we need to, and
@@ -348,7 +367,11 @@ void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 
-	BUG_ON(timer_is_armed(timer));
+	/*
+	 * This is to cancel the background timer for the physical timer
+	 * emulation if it is set.
+	 */
+	timer_disarm(timer);
 
 	/*
 	 * The guest could have modified the timer registers or the timer
-- 
1.9.1
