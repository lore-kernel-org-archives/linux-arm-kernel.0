From: jintack@cs.columbia.edu (Jintack Lim)
Date: Fri,  3 Feb 2017 10:20:04 -0500
Subject: [RFC v4 06/10] KVM: arm/arm64: Update the physical timer interrupt
 level
In-Reply-To: <1486135208-13415-1-git-send-email-jintack@cs.columbia.edu>
References: <1486135208-13415-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1486135208-13415-7-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we maintain the EL1 physical timer register states of VMs,
update the physical timer interrupt level along with the virtual one.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arch_timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index dbd0af1..7f9a664 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -186,6 +186,7 @@ static int kvm_timer_update_state(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
+	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 
 	/*
 	 * If userspace modified the timer registers via SET_ONE_REG before
@@ -199,6 +200,9 @@ static int kvm_timer_update_state(struct kvm_vcpu *vcpu)
 	if (kvm_timer_should_fire(vtimer) != vtimer->irq.level)
 		kvm_timer_update_irq(vcpu, !vtimer->irq.level, vtimer);
 
+	if (kvm_timer_should_fire(ptimer) != ptimer->irq.level)
+		kvm_timer_update_irq(vcpu, !ptimer->irq.level, ptimer);
+
 	return 0;
 }
 
-- 
1.9.1
