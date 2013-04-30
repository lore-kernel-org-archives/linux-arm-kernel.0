From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 30 Apr 2013 07:49:23 -0700
Subject: [PATCH 02/15] ARM: KVM: arch_timer: use symbolic constants
In-Reply-To: <1367333376-30983-1-git-send-email-cdall@cs.columbia.edu>
References: <1367333376-30983-1-git-send-email-cdall@cs.columbia.edu>
Message-ID: <1367333376-30983-3-git-send-email-cdall@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

In clocksource/arm_arch_timer.h we define useful symbolic constants.
Let's use them to make the KVM arch_timer code clearer.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@cs.columbia.edu>
Signed-off-by: Christoffer Dall <cdall@cs.columbia.edu>
---
 arch/arm/kvm/arch_timer.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/arch_timer.c b/arch/arm/kvm/arch_timer.c
index 6ac938d..c55b608 100644
--- a/arch/arm/kvm/arch_timer.c
+++ b/arch/arm/kvm/arch_timer.c
@@ -22,6 +22,7 @@
 #include <linux/kvm_host.h>
 #include <linux/interrupt.h>
 
+#include <clocksource/arm_arch_timer.h>
 #include <asm/arch_timer.h>
 
 #include <asm/kvm_vgic.h>
@@ -64,7 +65,7 @@ static void kvm_timer_inject_irq(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 
-	timer->cntv_ctl |= 1 << 1; /* Mask the interrupt in the guest */
+	timer->cntv_ctl |= ARCH_TIMER_CTRL_IT_MASK;
 	kvm_vgic_inject_irq(vcpu->kvm, vcpu->vcpu_id,
 			    vcpu->arch.timer_cpu.irq->irq,
 			    vcpu->arch.timer_cpu.irq->level);
@@ -133,8 +134,8 @@ void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
 	cycle_t cval, now;
 	u64 ns;
 
-	/* Check if the timer is enabled and unmasked first */
-	if ((timer->cntv_ctl & 3) != 1)
+	if ((timer->cntv_ctl & ARCH_TIMER_CTRL_IT_MASK) ||
+		!(timer->cntv_ctl & ARCH_TIMER_CTRL_ENABLE))
 		return;
 
 	cval = timer->cntv_cval;
-- 
1.7.9.5
