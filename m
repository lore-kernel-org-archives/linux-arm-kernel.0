From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:03:57 +0100
Subject: [PATCH v2 38/52] KVM: arm/arm64: GICv4: Wire init/teardown of per-VM
 support
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-39-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Should the HW support GICv4 and an ITS being associated with this
VM, let's init the its_vm and its_vpe structures.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-init.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 3a0b8999f011..0de1f0d986d4 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -285,8 +285,14 @@ int vgic_init(struct kvm *kvm)
 	if (ret)
 		goto out;
 
-	if (vgic_has_its(kvm))
+	if (vgic_has_its(kvm)) {
 		dist->msis_require_devid = true;
+		if (kvm_vgic_global_state.has_gicv4) {
+			ret = vgic_v4_init(kvm);
+			if (ret)
+				goto out;
+		}
+	}
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		kvm_vgic_vcpu_enable(vcpu);
@@ -323,6 +329,9 @@ static void kvm_vgic_dist_destroy(struct kvm *kvm)
 
 	kfree(dist->spis);
 	dist->nr_spis = 0;
+
+	if (kvm_vgic_global_state.has_gicv4 && vgic_has_its(kvm))
+		vgic_v4_teardown(kvm);
 }
 
 void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
-- 
2.11.0
