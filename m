From: cdall@kernel.org (Christoffer Dall)
Date: Mon,  4 Dec 2017 15:03:44 +0100
Subject: [PULL 15/19] KVM: arm/arm64: Avoid attempting to load timer vgic
 state without a vgic
In-Reply-To: <20171204135637.21620-1-cdall@kernel.org>
References: <20171204135637.21620-1-cdall@kernel.org>
Message-ID: <20171204140348.21965-13-cdall@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

The timer optimization patches inadvertendly changed the logic to always
load the timer state as if we have a vgic, even if we don't have a vgic.

Fix this by doing the usual irqchip_in_kernel() check and call the
appropriate load function.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arch_timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 190c99ed1b73..f9555b1e7f15 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -835,7 +835,10 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
 no_vgic:
 	preempt_disable();
 	timer->enabled = 1;
-	kvm_timer_vcpu_load_vgic(vcpu);
+	if (!irqchip_in_kernel(vcpu->kvm))
+		kvm_timer_vcpu_load_user(vcpu);
+	else
+		kvm_timer_vcpu_load_vgic(vcpu);
 	preempt_enable();
 
 	return 0;
-- 
2.14.2
