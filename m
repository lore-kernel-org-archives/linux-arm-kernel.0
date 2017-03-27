From: eric.auger@redhat.com (Eric Auger)
Date: Mon, 27 Mar 2017 11:31:12 +0200
Subject: [PATCH v4 22/22] KVM: arm64: ITS: Pending table save/restore
In-Reply-To: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1490607072-21610-23-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save and restore the pending tables.

Pending table restore obviously requires the pendbaser to be
already set.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- remove the wrong comment about locking
- pass kvm struct instead of its handle
- add comment about restore method
- remove GITR_PENDABASER.PTZ check
- continue if target_vcpu == NULL
- new locking strategy

v1 -> v2:
- do not care about the 1st KB which should be zeroed according to
  the spec.
---
 virt/kvm/arm/vgic/vgic-its.c | 66 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index a516bbb..e10aa81 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1804,16 +1804,78 @@ static int lookup_table(struct vgic_its *its, gpa_t base, int size, int esz,
  */
 static int vgic_its_flush_pending_tables(struct kvm *kvm)
 {
-	return -ENXIO;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct vgic_irq *irq;
+	int ret;
+
+	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
+		struct kvm_vcpu *vcpu;
+		gpa_t pendbase, ptr;
+		bool stored;
+		u8 val;
+
+		vcpu = irq->target_vcpu;
+		if (!vcpu)
+			continue;
+
+		pendbase = PENDBASER_ADDRESS(vcpu->arch.vgic_cpu.pendbaser);
+
+		ptr = pendbase + (irq->intid / BITS_PER_BYTE);
+
+		ret = kvm_read_guest(kvm, (gpa_t)ptr, &val, 1);
+		if (ret)
+			return ret;
+
+		stored = val & (irq->intid % BITS_PER_BYTE);
+		if (stored == irq->pending_latch)
+			continue;
+
+		if (irq->pending_latch)
+			val |= 1 << (irq->intid % BITS_PER_BYTE);
+		else
+			val &= ~(1 << (irq->intid % BITS_PER_BYTE));
+
+		ret = kvm_write_guest(kvm, (gpa_t)ptr, &val, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 /**
  * vgic_its_restore_pending_tables - Restore the pending tables from guest
  * RAM to internal data structs
+ *
+ * Does not scan the whole pending tables but just loop on all registered
+ * LPIS and scan their associated pending bit. This obviously requires
+ * the ITEs to be restored before.
  */
 static int vgic_its_restore_pending_tables(struct kvm *kvm)
 {
-	return -ENXIO;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct vgic_irq *irq;
+	int ret;
+
+	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
+		struct kvm_vcpu *vcpu;
+		gpa_t pendbase, ptr;
+		u8 val;
+
+		vcpu = irq->target_vcpu;
+		if (!vcpu)
+			continue;
+
+		pendbase = PENDBASER_ADDRESS(vcpu->arch.vgic_cpu.pendbaser);
+
+		ptr = pendbase + (irq->intid / BITS_PER_BYTE);
+
+		ret = kvm_read_guest(kvm, (gpa_t)ptr, &val, 1);
+		if (ret)
+			return ret;
+		irq->pending_latch = val & (1 << (irq->intid % BITS_PER_BYTE));
+	}
+	return 0;
 }
 
 static int vgic_its_flush_ite(struct vgic_its *its, struct its_device *dev,
-- 
2.5.5
