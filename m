From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed,  3 Aug 2016 18:13:25 +0200
Subject: [PATCH 3/3] KVM: arm64: vgic-its: Make updates to propbaser/pendbaser
 atomic
In-Reply-To: <20160803161325.14933-1-christoffer.dall@linaro.org>
References: <20160803161325.14933-1-christoffer.dall@linaro.org>
Message-ID: <20160803161325.14933-4-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two problems with the current implementation of the MMIO
handlers for the propbaser and pendbaser:

First, the write to the value itself is not guaranteed to be an atomic
64-bit write so two concurrent writes to the structure field could be
intermixed.

Second, because we do a read-modify-update operation without any
synchronization, if we have two 32-bit accesses to separate parts of the
register, we can loose one of them.

We can take the KVM mutex to synchronize accesses to these registers.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-mmio-v3.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index ff668e0..e38b7a0 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -306,16 +306,19 @@ static void vgic_mmio_write_propbase(struct kvm_vcpu *vcpu,
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
-	u64 propbaser = dist->propbaser;
+	u64 propbaser;
 
 	/* Storing a value with LPIs already enabled is undefined */
 	if (vgic_cpu->lpis_enabled)
 		return;
 
+	mutex_lock(&vcpu->kvm->lock);
+	propbaser = dist->propbaser;
 	propbaser = update_64bit_reg(propbaser, addr & 4, len, val);
 	propbaser = vgic_sanitise_propbaser(propbaser);
 
 	dist->propbaser = propbaser;
+	mutex_unlock(&vcpu->kvm->lock);
 }
 
 static unsigned long vgic_mmio_read_pendbase(struct kvm_vcpu *vcpu,
@@ -331,16 +334,19 @@ static void vgic_mmio_write_pendbase(struct kvm_vcpu *vcpu,
 				     unsigned long val)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
-	u64 pendbaser = vgic_cpu->pendbaser;
+	u64 pendbaser;
 
 	/* Storing a value with LPIs already enabled is undefined */
 	if (vgic_cpu->lpis_enabled)
 		return;
 
+	mutex_lock(&vcpu->kvm->lock);
+	pendbaser = vgic_cpu->pendbaser;
 	pendbaser = update_64bit_reg(pendbaser, addr & 4, len, val);
 	pendbaser = vgic_sanitise_pendbaser(pendbaser);
 
 	vgic_cpu->pendbaser = pendbaser;
+	mutex_unlock(&vcpu->kvm->lock);
 }
 
 /*
-- 
2.9.0
