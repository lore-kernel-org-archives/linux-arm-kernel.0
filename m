From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 29 Jun 2015 17:37:15 +0200
Subject: [PATCH 5/7] KVM: arm/arm64: build a default routing table
In-Reply-To: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1435592237-17924-6-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement a default routing table made of flat irqchip routing
entries (gsi = irqchip.pin) covering the VGIC SPI indexes.
This routing table is overwritten by the first user-space call
to KVM_SET_GSI_ROUTING ioctl.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

PATCH: creation
---
 virt/kvm/arm/vgic.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 212a5ff..410fee1 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1783,6 +1783,8 @@ int vgic_init(struct kvm *kvm)
 	ret |= vgic_init_bitmap(&dist->irq_cfg, nr_cpus, nr_irqs);
 	ret |= vgic_init_bytemap(&dist->irq_priority, nr_cpus, nr_irqs);
 
+	ret |= kvm_setup_default_irq_routing(kvm);
+
 	if (ret)
 		goto out;
 
@@ -2264,6 +2266,25 @@ out:
 	return r;
 }
 
+int kvm_setup_default_irq_routing(struct kvm *kvm)
+{
+	struct kvm_irq_routing_entry *entries;
+	u32 nr = kvm->arch.vgic.nr_irqs - VGIC_NR_PRIVATE_IRQS;
+	int i, ret;
+
+	entries = kcalloc(nr, sizeof(struct kvm_kernel_irq_routing_entry),
+			  GFP_KERNEL);
+	for (i = 0; i < nr; i++) {
+		entries[i].gsi = i;
+		entries[i].type = KVM_IRQ_ROUTING_IRQCHIP;
+		entries[i].u.irqchip.irqchip = 0;
+		entries[i].u.irqchip.pin = i;
+	}
+	ret = kvm_set_irq_routing(kvm, entries, nr, 0);
+	kfree(entries);
+	return ret;
+}
+
 int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 		struct kvm *kvm, int irq_source_id,
 		int level, bool line_status)
-- 
1.9.1
