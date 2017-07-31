From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jul 2017 18:26:22 +0100
Subject: [PATCH v3 44/59] KVM: arm/arm64: GICv4: Handle MOVI applied to a VLPI
In-Reply-To: <20170731172637.29355-1-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
Message-ID: <20170731172637.29355-45-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the guest issues a MOVI, we need to tell the physical ITS
that we're now targetting a new vcpu. This is done by extracting
the current mapping, updating the target, and reapplying the
mapping. The core ITS code should do the right thing.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 79bac93d3e7d..aaad577ce328 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -706,6 +706,19 @@ static int vgic_its_cmd_handle_movi(struct kvm *kvm, struct vgic_its *its,
 	ite->irq->target_vcpu = vcpu;
 	spin_unlock(&ite->irq->irq_lock);
 
+	if (ite->irq->hw) {
+		struct its_vlpi_map map;
+		int ret;
+
+		ret = its_get_vlpi(ite->irq->host_irq, &map);
+		if (ret)
+			return ret;
+
+		map.vpe_idx = vcpu->vcpu_id;
+
+		return its_map_vlpi(ite->irq->host_irq, &map);
+	}
+
 	return 0;
 }
 
-- 
2.11.0
