From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:04:11 +0100
Subject: [PATCH v2 52/52] KVM: arm/arm64: GICv4: Enable VLPI support
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-53-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All it takes is for the has_v4 flag to be set in gic_kvm_info, and
we'll enable it...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-v3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 96ea597db0e7..fb7bc3b93482 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -478,6 +478,12 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
 	kvm_vgic_global_state.can_emulate_gicv2 = false;
 	kvm_vgic_global_state.ich_vtr_el2 = ich_vtr_el2;
 
+	/* GICv4 support? */
+	if (info->has_v4) {
+		kvm_vgic_global_state.has_gicv4 = true;
+		kvm_info("GICv4 support enabled\n");
+	}
+
 	if (!info->vcpu.start) {
 		kvm_info("GICv3: no GICV resource entry\n");
 		kvm_vgic_global_state.vcpu_base = 0;
-- 
2.11.0
