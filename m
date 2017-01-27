From: jintack@cs.columbia.edu (Jintack Lim)
Date: Thu, 26 Jan 2017 20:04:56 -0500
Subject: [RFC v2 06/10] KVM: arm/arm64: Update the physical timer interrupt
 level
In-Reply-To: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
References: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1485479100-4966-7-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we maintain the EL1 physical timer register states of VMs,
update the physical timer interrupt level along with the virtual one.

Note that the emulated EL1 physical timer is not mapped to any hardware
timer, so we call a proper vgic function.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 virt/kvm/arm/arch_timer.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 0f6e935..3b6bd50 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -180,6 +180,21 @@ static void kvm_timer_update_mapped_irq(struct kvm_vcpu *vcpu, bool new_level,
 	WARN_ON(ret);
 }
 
+static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level,
+				 struct arch_timer_context *timer)
+{
+	int ret;
+
+	BUG_ON(!vgic_initialized(vcpu->kvm));
+
+	timer->irq.level = new_level;
+	trace_kvm_timer_update_irq(vcpu->vcpu_id, timer->irq.irq,
+				   timer->irq.level);
+	ret = kvm_vgic_inject_irq(vcpu->kvm, vcpu->vcpu_id, timer->irq.irq,
+				  timer->irq.level);
+	WARN_ON(ret);
+}
+
 /*
  * Check if there was a change in the timer state (should we raise or lower
  * the line level to the GIC).
@@ -188,6 +203,7 @@ static int kvm_timer_update_state(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
+	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 
 	/*
 	 * If userspace modified the timer registers via SET_ONE_REG before
@@ -201,6 +217,10 @@ static int kvm_timer_update_state(struct kvm_vcpu *vcpu)
 	if (kvm_timer_should_fire(vcpu, vtimer) != vtimer->irq.level)
 		kvm_timer_update_mapped_irq(vcpu, !vtimer->irq.level, vtimer);
 
+	/* The emulated EL1 physical timer irq is not mapped to hardware */
+	if (kvm_timer_should_fire(vcpu, ptimer) != ptimer->irq.level)
+		kvm_timer_update_irq(vcpu, !ptimer->irq.level, ptimer);
+
 	return 0;
 }
 
-- 
1.9.1
