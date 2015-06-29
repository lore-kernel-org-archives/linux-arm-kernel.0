From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 29 Jun 2015 17:37:13 +0200
Subject: [PATCH 3/7] KVM: irqchip: convey devid to kvm_set_msi
In-Reply-To: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1435592237-17924-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on ARM, a devid field is conveyed in kvm_msi struct. Let's choose the
routing type and struct according to its availability and fill the
corresponding struct. Also remove the flag check now this latter can
be non null.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 virt/kvm/irqchip.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 1d56a90..e76c7d2 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -73,12 +73,22 @@ int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi)
 {
 	struct kvm_kernel_irq_routing_entry route;
 
-	if (!irqchip_in_kernel(kvm) || msi->flags != 0)
+	if (!irqchip_in_kernel(kvm))
 		return -EINVAL;
 
-	route.msi.address_lo = msi->address_lo;
-	route.msi.address_hi = msi->address_hi;
-	route.msi.data = msi->data;
+	if (msi->flags & KVM_MSI_VALID_DEVID) {
+		route.type = KVM_IRQ_ROUTING_EXTENDED_MSI;
+		route.ext_msi.address_lo = msi->address_lo;
+		route.ext_msi.address_hi = msi->address_hi;
+		route.ext_msi.data = msi->data;
+		route.ext_msi.devid= msi->devid;
+	}
+	else {
+		route.type = KVM_IRQ_ROUTING_MSI;
+		route.msi.address_lo = msi->address_lo;
+		route.msi.address_hi = msi->address_hi;
+		route.msi.data = msi->data;
+	}
 
 	return kvm_set_msi(&route, kvm, KVM_USERSPACE_IRQ_SOURCE_ID, 1, false);
 }
-- 
1.9.1
