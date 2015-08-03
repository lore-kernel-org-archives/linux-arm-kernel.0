From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  3 Aug 2015 17:31:27 +0200
Subject: [PATCH v3 5/7] KVM: arm/arm64: build a default routing table
In-Reply-To: <1438615889-10892-1-git-send-email-eric.auger@linaro.org>
References: <1438615889-10892-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1438615889-10892-6-git-send-email-eric.auger@linaro.org>
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
index 8114235..1b092e3 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1785,6 +1785,8 @@ int vgic_init(struct kvm *kvm)
 	ret |= vgic_init_bitmap(&dist->irq_cfg, nr_cpus, nr_irqs);
 	ret |= vgic_init_bytemap(&dist->irq_priority, nr_cpus, nr_irqs);
 
+	ret |= kvm_setup_default_irq_routing(kvm);
+
 	if (ret)
 		goto out;
 
@@ -2266,6 +2268,25 @@ out:
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
 /**
  * kvm_set_msi: inject the MSI corresponding to the
  * MSI routing entry
-- 
1.9.1
