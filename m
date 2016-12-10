From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 10 Dec 2016 21:47:07 +0100
Subject: [RFC PATCH 2/7] KVM: arm/arm64: Move kvm_vgic_flush_hwstate under
 disabled irq
In-Reply-To: <20161210204712.21830-1-christoffer.dall@linaro.org>
References: <20161210204712.21830-1-christoffer.dall@linaro.org>
Message-ID: <20161210204712.21830-3-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are about to play tricks with the timer to be more lazy in saving
and restoring state, we need to move the timer flush function under a
disabled irq section and since we hav to flush the vgic state after the
timer state, move it as well.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 13e54e8..6591af7 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -627,11 +627,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 */
 		preempt_disable();
 		kvm_pmu_flush_hwstate(vcpu);
-		kvm_timer_flush_hwstate(vcpu);
-		kvm_vgic_flush_hwstate(vcpu);
 
 		local_irq_disable();
 
+		kvm_timer_flush_hwstate(vcpu);
+		kvm_vgic_flush_hwstate(vcpu);
+
 		/*
 		 * Re-check atomic conditions
 		 */
-- 
2.9.0
