From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:04:04 +0100
Subject: [PATCH v2 45/52] KVM: arm/arm64: GICv4: Propagate property updates to
 VLPIs
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-46-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Upon updating a property, we propagate it all the way to the physical
ITS, and ask for an INV command to be executed there.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index b40f46e5a79d..2015246ab9f9 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -297,6 +297,9 @@ static int update_lpi_config(struct kvm *kvm, struct vgic_irq *irq,
 		spin_unlock(&irq->irq_lock);
 	}
 
+	if (irq->hw)
+		return its_prop_update_vlpi(irq->host_irq, prop, true);
+
 	return 0;
 }
 
-- 
2.11.0
