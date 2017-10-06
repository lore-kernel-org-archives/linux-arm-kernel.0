From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Oct 2017 16:33:47 +0100
Subject: [PATCH v4 12/26] KVM: arm/arm64: GICv4: Propagate affinity changes to
 the physical ITS
In-Reply-To: <20171006153401.5481-1-marc.zyngier@arm.com>
References: <20171006153401.5481-1-marc.zyngier@arm.com>
Message-ID: <20171006153401.5481-13-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the guest issues an affinity change, we need to tell the physical
ITS that we're now targetting a new vcpu.  This is done by extracting
the current mapping, updating the target, and reapplying the mapping.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index c9b1c0967426..42ffb9084bb7 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -337,11 +337,25 @@ static int vgic_copy_lpi_list(struct kvm_vcpu *vcpu, u32 **intid_ptr)
 
 static int update_affinity(struct vgic_irq *irq, struct kvm_vcpu *vcpu)
 {
+	int ret = 0;
+
 	spin_lock(&irq->irq_lock);
 	irq->target_vcpu = vcpu;
 	spin_unlock(&irq->irq_lock);
 
-	return 0;
+	if (irq->hw) {
+		struct its_vlpi_map map;
+
+		ret = its_get_vlpi(irq->host_irq, &map);
+		if (ret)
+			return ret;
+
+		map.vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
+
+		ret = its_map_vlpi(irq->host_irq, &map);
+	}
+
+	return ret;
 }
 
 /*
-- 
2.14.1
