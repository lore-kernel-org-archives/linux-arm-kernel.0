From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:13 +0200
Subject: [PULL 05/50] KVM: arm: vgic: Drop build compatibility hack for older
 kernel versions
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-6-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

As kvm_set_routing_entry() was changing prototype between 4.7 and 4.8,
an ugly hack was put in place in order to survive both building in
-next and the merge window.

Now that everything has been merged, let's dump the compatibility
hack for good.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-irqfd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-irqfd.c b/virt/kvm/arm/vgic/vgic-irqfd.c
index b31a51a..d918dcf 100644
--- a/virt/kvm/arm/vgic/vgic-irqfd.c
+++ b/virt/kvm/arm/vgic/vgic-irqfd.c
@@ -46,15 +46,9 @@ static int vgic_irqfd_set_irq(struct kvm_kernel_irq_routing_entry *e,
  * @ue: user api routing entry handle
  * return 0 on success, -EINVAL on errors.
  */
-#ifdef KVM_CAP_X2APIC_API
 int kvm_set_routing_entry(struct kvm *kvm,
 			  struct kvm_kernel_irq_routing_entry *e,
 			  const struct kvm_irq_routing_entry *ue)
-#else
-/* Remove this version and the ifdefery once merged into 4.8 */
-int kvm_set_routing_entry(struct kvm_kernel_irq_routing_entry *e,
-			  const struct kvm_irq_routing_entry *ue)
-#endif
 {
 	int r = -EINVAL;
 
-- 
2.9.0
