From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jul 2017 18:26:17 +0100
Subject: [PATCH v3 39/59] KVM: arm/arm64: GICv4: Add property field and per-VM
 predicate
In-Reply-To: <20170731172637.29355-1-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
Message-ID: <20170731172637.29355-40-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new has_gicv4 field in the global VGIC state that indicates
whether the HW is GICv4 capable, as a per-VM predicate indicating
if there is a possibility for a VM to support direct injection
(the above being true and the VM having an ITS).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h           | 3 +++
 virt/kvm/arm/vgic/vgic-mmio-v3.c | 5 +++++
 virt/kvm/arm/vgic/vgic.h         | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index ee8587c8c715..84694b42373a 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -73,6 +73,9 @@ struct vgic_global {
 	/* Only needed for the legacy KVM_CREATE_IRQCHIP */
 	bool			can_emulate_gicv2;
 
+	/* Does have GICv4? */
+	bool			has_gicv4;
+
 	/* GIC system register CPU interface */
 	struct static_key_false gicv3_cpuif;
 
diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index 714fa3933546..74109ca75cc0 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -54,6 +54,11 @@ bool vgic_has_its(struct kvm *kvm)
 	return dist->has_its;
 }
 
+bool vgic_is_v4_capable(struct kvm *kvm)
+{
+	return kvm_vgic_global_state.has_gicv4 && vgic_has_its(kvm);
+}
+
 static unsigned long vgic_mmio_read_v3_misc(struct kvm_vcpu *vcpu,
 					    gpa_t addr, unsigned int len)
 {
diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
index 3002b72d938b..90f6436a11aa 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -229,4 +229,6 @@ int vgic_its_resolve_lpi(struct kvm *kvm, struct vgic_its *its,
 			 u32 devid, u32 eventid, struct vgic_irq **irq);
 struct vgic_its *vgic_msi_to_its(struct kvm *kvm, struct kvm_msi *msi);
 
+bool vgic_is_v4_capable(struct kvm *kvm);
+
 #endif
-- 
2.11.0
