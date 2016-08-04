From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  4 Aug 2016 13:40:35 +0200
Subject: [PULL 7/8] KVM: arm: vgic-irqfd: Workaround changing
 kvm_set_routing_entry prototype
In-Reply-To: <1470310836-10371-1-git-send-email-christoffer.dall@linaro.org>
References: <1470310836-10371-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1470310836-10371-8-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

kvm_set_routing_entry is changing in -next, and causes things to
explode. Add a temporary workaround that should be dropped when
we hit 4.8-rc1

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-irqfd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-irqfd.c b/virt/kvm/arm/vgic/vgic-irqfd.c
index 683a589..b31a51a 100644
--- a/virt/kvm/arm/vgic/vgic-irqfd.c
+++ b/virt/kvm/arm/vgic/vgic-irqfd.c
@@ -41,12 +41,20 @@ static int vgic_irqfd_set_irq(struct kvm_kernel_irq_routing_entry *e,
  * kvm_set_routing_entry: populate a kvm routing entry
  * from a user routing entry
  *
+ * @kvm: the VM this entry is applied to
  * @e: kvm kernel routing entry handle
  * @ue: user api routing entry handle
  * return 0 on success, -EINVAL on errors.
  */
+#ifdef KVM_CAP_X2APIC_API
+int kvm_set_routing_entry(struct kvm *kvm,
+			  struct kvm_kernel_irq_routing_entry *e,
+			  const struct kvm_irq_routing_entry *ue)
+#else
+/* Remove this version and the ifdefery once merged into 4.8 */
 int kvm_set_routing_entry(struct kvm_kernel_irq_routing_entry *e,
 			  const struct kvm_irq_routing_entry *ue)
+#endif
 {
 	int r = -EINVAL;
 
-- 
1.9.1
