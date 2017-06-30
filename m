From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:44:39 +0100
Subject: [PATCH 23/58] KVM: arm/arm64: Introduce an allocator for in-kernel
 irq lines
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-24-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <cdall@linaro.org>

Having multiple devices being able to signal the same interrupt line is
very confusing and almost certainly guarantees a configuration error.

Therefore, introduce a very simple allocator which allows a device to
claim an interrupt line from the vgic for a given VM.

Signed-off-by: Christoffer Dall <cdall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h   |  5 +++++
 virt/kvm/arm/vgic/vgic.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index dde59fbc5f80..5d5b34534ce9 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -121,6 +121,9 @@ struct vgic_irq {
 	u8 source;			/* GICv2 SGIs only */
 	u8 priority;
 	enum vgic_irq_config config;	/* Level or edge */
+
+	void *owner;			/* Opaque pointer to reserve an interrupt
+					   for in-kernel devices. */
 };
 
 struct vgic_register_region;
@@ -340,4 +343,6 @@ int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi);
  */
 int kvm_vgic_setup_default_irq_routing(struct kvm *kvm);
 
+int kvm_vgic_set_owner(struct kvm_vcpu *vcpu, unsigned int intid, void *owner);
+
 #endif /* __KVM_ARM_VGIC_H */
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index c66feaca2a5d..9628945234e4 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -435,6 +435,39 @@ int kvm_vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, unsigned int virt_irq)
 }
 
 /**
+ * kvm_vgic_set_owner - Set the owner of an interrupt for a VM
+ *
+ * @vcpu:   Pointer to the VCPU (used for PPIs)
+ * @intid:  The virtual INTID identifying the interrupt (PPI or SPI)
+ * @owner:  Opaque pointer to the owner
+ *
+ * Returns 0 if intid is not already used by another in-kernel device and the
+ * owner is set, otherwise returns an error code.
+ */
+int kvm_vgic_set_owner(struct kvm_vcpu *vcpu, unsigned int intid, void *owner)
+{
+	struct vgic_irq *irq;
+	int ret = 0;
+
+	if (!vgic_initialized(vcpu->kvm))
+		return -EAGAIN;
+
+	/* SGIs and LPIs cannot be wired up to any device */
+	if (!irq_is_ppi(intid) && !vgic_valid_spi(vcpu->kvm, intid))
+		return -EINVAL;
+
+	irq = vgic_get_irq(vcpu->kvm, vcpu, intid);
+	spin_lock(&irq->irq_lock);
+	if (irq->owner && irq->owner != owner)
+		ret = -EEXIST;
+	else
+		irq->owner = owner;
+	spin_unlock(&irq->irq_lock);
+
+	return ret;
+}
+
+/**
  * vgic_prune_ap_list - Remove non-relevant interrupts from the list
  *
  * @vcpu: The VCPU pointer
-- 
2.11.0
