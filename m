From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 13 Nov 2017 10:17:32 +0100
Subject: [PULL 07/27] KVM: arm/arm64: GICv4: Add property field and per-VM
 predicate
In-Reply-To: <20171113091752.10663-1-christoffer.dall@linaro.org>
References: <20171113091752.10663-1-christoffer.dall@linaro.org>
Message-ID: <20171113091752.10663-8-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Add a new has_gicv4 field in the global VGIC state that indicates
whether the HW is GICv4 capable, as a per-VM predicate indicating
if there is a possibility for a VM to support direct injection
(the above being true and the VM having an ITS).

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/kvm/arm_vgic.h           | 3 +++
 virt/kvm/arm/vgic/vgic-mmio-v3.c | 5 +++++
 virt/kvm/arm/vgic/vgic.h         | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 53f631bdec75..ba9fb450aa1b 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -73,6 +73,9 @@ struct vgic_global {
 	/* Only needed for the legacy KVM_CREATE_IRQCHIP */
 	bool			can_emulate_gicv2;
 
+	/* Hardware has GICv4? */
+	bool			has_gicv4;
+
 	/* GIC system register CPU interface */
 	struct static_key_false gicv3_cpuif;
 
diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index 83786108829e..671fe81f8e1d 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -54,6 +54,11 @@ bool vgic_has_its(struct kvm *kvm)
 	return dist->has_its;
 }
 
+bool vgic_supports_direct_msis(struct kvm *kvm)
+{
+	return kvm_vgic_global_state.has_gicv4 && vgic_has_its(kvm);
+}
+
 static unsigned long vgic_mmio_read_v3_misc(struct kvm_vcpu *vcpu,
 					    gpa_t addr, unsigned int len)
 {
diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
index 0ac85045c0c7..67509b203cf5 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -241,4 +241,6 @@ int vgic_its_resolve_lpi(struct kvm *kvm, struct vgic_its *its,
 			 u32 devid, u32 eventid, struct vgic_irq **irq);
 struct vgic_its *vgic_msi_to_its(struct kvm *kvm, struct kvm_msi *msi);
 
+bool vgic_supports_direct_msis(struct kvm *kvm);
+
 #endif
-- 
2.14.2
