From: eric.auger@linaro.org (Eric Auger)
Date: Thu,  9 Jul 2015 10:22:13 +0200
Subject: [PATCH v2 3/7] KVM: irqchip: convey devid to kvm_set_msi
In-Reply-To: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
References: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1436430137-24205-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on ARM, a devid field is populated in kvm_msi struct in case the
flag is set to KVM_MSI_VALID_DEVID. Let's populate the corresponding
kvm_kernel_irq_routing_entry devid field and set the msi type to
KVM_IRQ_ROUTING_EXTENDED_MSI.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 virt/kvm/irqchip.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 21c1424..e678f8a 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -72,9 +72,17 @@ int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi)
 {
 	struct kvm_kernel_irq_routing_entry route;
 
-	if (!irqchip_in_kernel(kvm) || msi->flags != 0)
+	if (!irqchip_in_kernel(kvm))
 		return -EINVAL;
 
+	if (msi->flags & KVM_MSI_VALID_DEVID) {
+		route.devid = msi->devid;
+		route.type = KVM_IRQ_ROUTING_EXTENDED_MSI;
+	} else if (!msi->flags)
+		return -EINVAL;
+
+	/* historically the route.type was not set */
+
 	route.msi.address_lo = msi->address_lo;
 	route.msi.address_hi = msi->address_hi;
 	route.msi.data = msi->data;
-- 
1.9.1
