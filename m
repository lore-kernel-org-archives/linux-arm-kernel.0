From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 31 Jan 2018 10:34:44 +0100
Subject: [PULL 05/28] KVM: arm/arm64: Don't cache the timer IRQ level
In-Reply-To: <20180131093507.22219-1-christoffer.dall@linaro.org>
References: <20180131093507.22219-1-christoffer.dall@linaro.org>
Message-ID: <20180131093507.22219-6-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer logic was designed after a strict idea of modeling an
interrupt line level in software, meaning that only transitions in the
level need to be reported to the VGIC.  This works well for the timer,
because the arch timer code is in complete control of the device and can
track the transitions of the line.

However, as we are about to support using the HW bit in the VGIC not
just for the timer, but also for VFIO which cannot track transitions of
the interrupt line, we have to decide on an interface between the GIC
and other subsystems for level triggered mapped interrupts, which both
the timer and VFIO can use.

VFIO only sees an asserting transition of the physical interrupt line,
and tells the VGIC when that happens.  That means that part of the
interrupt flow is offloaded to the hardware.

To use the same interface for VFIO devices and the timer, we therefore
have to change the timer (we cannot change VFIO because it doesn't know
the details of the device it is assigning to a VM).

Luckily, changing the timer is simple, we just need to stop 'caching'
the line level, but instead let the VGIC know the state of the timer
every time there is a potential change in the line level, and when the
line level should be asserted from the timer ISR.  The VGIC can ignore
extra notifications using its validate mechanism.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arch_timer.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index f9555b1e7f15..9376fe03bf2e 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -99,11 +99,9 @@ static irqreturn_t kvm_arch_timer_handler(int irq, void *dev_id)
 	}
 	vtimer = vcpu_vtimer(vcpu);
 
-	if (!vtimer->irq.level) {
-		vtimer->cnt_ctl = read_sysreg_el0(cntv_ctl);
-		if (kvm_timer_irq_can_fire(vtimer))
-			kvm_timer_update_irq(vcpu, true, vtimer);
-	}
+	vtimer->cnt_ctl = read_sysreg_el0(cntv_ctl);
+	if (kvm_timer_irq_can_fire(vtimer))
+		kvm_timer_update_irq(vcpu, true, vtimer);
 
 	if (unlikely(!irqchip_in_kernel(vcpu->kvm)))
 		kvm_vtimer_update_mask_user(vcpu);
@@ -324,12 +322,20 @@ static void kvm_timer_update_state(struct kvm_vcpu *vcpu)
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
+	bool level;
 
 	if (unlikely(!timer->enabled))
 		return;
 
-	if (kvm_timer_should_fire(vtimer) != vtimer->irq.level)
-		kvm_timer_update_irq(vcpu, !vtimer->irq.level, vtimer);
+	/*
+	 * The vtimer virtual interrupt is a 'mapped' interrupt, meaning part
+	 * of its lifecycle is offloaded to the hardware, and we therefore may
+	 * not have lowered the irq.level value before having to signal a new
+	 * interrupt, but have to signal an interrupt every time the level is
+	 * asserted.
+	 */
+	level = kvm_timer_should_fire(vtimer);
+	kvm_timer_update_irq(vcpu, level, vtimer);
 
 	if (kvm_timer_should_fire(ptimer) != ptimer->irq.level)
 		kvm_timer_update_irq(vcpu, !ptimer->irq.level, ptimer);
-- 
2.14.2
