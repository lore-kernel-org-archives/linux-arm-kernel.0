From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:04:00 +0100
Subject: [PATCH v2 41/52] KVM: arm/arm64: GICv4: Unmap VLPI when freeing an LPI
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-42-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When freeing an LPI (on a DISCARD command, for example), we need
to unmap the VLPI down to the physical ITS level.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 255d29837514..ed52b94e8e6d 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -623,8 +623,12 @@ static void its_free_ite(struct kvm *kvm, struct its_ite *ite)
 	list_del(&ite->ite_list);
 
 	/* This put matches the get in vgic_add_lpi. */
-	if (ite->irq)
+	if (ite->irq) {
+		if (ite->irq->hw)
+			its_unmap_vlpi(ite->irq->host_irq);
+
 		vgic_put_irq(kvm, ite->irq);
+	}
 
 	kfree(ite);
 }
-- 
2.11.0
