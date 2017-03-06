From: eric.auger@redhat.com (Eric Auger)
Date: Mon,  6 Mar 2017 12:34:34 +0100
Subject: [PATCH v3 19/19] KVM: arm64: ITS: Pending table save/restore
In-Reply-To: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1488800074-21991-20-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save and restore the pending tables.

Pending table restore obviously requires the pendbaser to be
already set.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- do not care about the 1st KB which should be zeroed according to
  the spec.
---
 virt/kvm/arm/vgic/vgic-its.c | 71 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 27ebabd..24824be 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1736,7 +1736,48 @@ static int lookup_table(struct vgic_its *its, gpa_t base, int size, int esz,
  */
 static int vgic_its_flush_pending_tables(struct vgic_its *its)
 {
-	return -ENXIO;
+	struct kvm *kvm = its->dev->kvm;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct vgic_irq *irq;
+	int ret;
+
+	/**
+	 * we do not take the dist->lpi_list_lock since we have a garantee
+	 * the LPI list is not touched while the its lock is held
+	 */
+	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
+		struct kvm_vcpu *vcpu;
+		gpa_t pendbase, ptr;
+		bool stored;
+		u8 val;
+
+		vcpu = irq->target_vcpu;
+		if (!vcpu)
+			return -EINVAL;
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
@@ -1745,7 +1786,33 @@ static int vgic_its_flush_pending_tables(struct vgic_its *its)
  */
 static int vgic_its_restore_pending_tables(struct vgic_its *its)
 {
-	return -ENXIO;
+	struct vgic_irq *irq;
+	struct kvm *kvm = its->dev->kvm;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	int ret;
+
+	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
+		struct kvm_vcpu *vcpu;
+		gpa_t pendbase, ptr;
+		u8 val;
+
+		vcpu = irq->target_vcpu;
+		if (!vcpu)
+			return -EINVAL;
+
+		if (!(vcpu->arch.vgic_cpu.pendbaser & GICR_PENDBASER_PTZ))
+			return 0;
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
