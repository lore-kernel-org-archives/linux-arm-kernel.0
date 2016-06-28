From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 28 Jun 2016 13:32:27 +0100
Subject: [PATCH v7 14/17] KVM: arm64: allow updates of LPI configuration table
In-Reply-To: <20160628123230.26255-1-andre.przywara@arm.com>
References: <20160628123230.26255-1-andre.przywara@arm.com>
Message-ID: <20160628123230.26255-15-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The (system-wide) LPI configuration table is held in a table in
(guest) memory. To achieve reasonable performance, we cache this data
in our struct vgic_irq. If the guest updates the configuration data
(which consists of the enable bit and the priority value), it issues
an INV or INVALL command to allow us to update our information.
Provide functions that update that information for one LPI or all LPIs
mapped to a specific collection.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 2c88c72..afb5cf9 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -94,6 +94,51 @@ struct its_itte {
 
 #define CBASER_ADDRESS(x)	((x) & GENMASK_ULL(51, 12))
 #define PENDBASER_ADDRESS(x)	((x) & GENMASK_ULL(51, 16))
+#define PROPBASER_ADDRESS(x)	((x) & GENMASK_ULL(51, 12))
+
+#define GIC_LPI_OFFSET 8192
+
+#define LPI_PROP_ENABLE_BIT(p)	((p) & LPI_PROP_ENABLED)
+#define LPI_PROP_PRIORITY(p)	((p) & 0xfc)
+
+/*
+ * Reads the configuration data for a given LPI from guest memory and
+ * updates the fields in struct vgic_irq.
+ * If filter_vcpu is not NULL, applies only if the IRQ is targeting this
+ * VCPU. Unconditionally applies if filter_vcpu is NULL.
+ */
+static int update_lpi_config_filtered(struct kvm *kvm, struct vgic_irq *irq,
+				      struct kvm_vcpu *filter_vcpu)
+{
+	u64 propbase = PROPBASER_ADDRESS(kvm->arch.vgic.propbaser);
+	u8 prop;
+	int ret;
+
+	ret = kvm_read_guest(kvm, propbase + irq->intid - GIC_LPI_OFFSET,
+			     &prop, 1);
+
+	if (ret)
+		return ret;
+
+	spin_lock(&irq->irq_lock);
+
+	if (!filter_vcpu || filter_vcpu == irq->target_vcpu) {
+		irq->priority = LPI_PROP_PRIORITY(prop);
+		irq->enabled = LPI_PROP_ENABLE_BIT(prop);
+
+		vgic_queue_irq_unlock(kvm, irq);
+	} else {
+		spin_unlock(&irq->irq_lock);
+	}
+
+	return 0;
+}
+
+/* Updates the priority and enable bit for a given LPI. */
+int update_lpi_config(struct kvm *kvm, struct vgic_irq *irq)
+{
+	return update_lpi_config_filtered(kvm, irq, NULL);
+}
 
 static int vits_copy_lpi_list(struct kvm *kvm, u32 **intid_ptr)
 {
-- 
2.9.0
