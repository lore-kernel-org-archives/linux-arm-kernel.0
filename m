From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Oct 2017 16:33:46 +0100
Subject: [PATCH v4 11/26] KVM: arm/arm64: GICv4: Unmap VLPI when freeing an LPI
In-Reply-To: <20171006153401.5481-1-marc.zyngier@arm.com>
References: <20171006153401.5481-1-marc.zyngier@arm.com>
Message-ID: <20171006153401.5481-12-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When freeing an LPI (on a DISCARD command, for example), we need
to unmap the VLPI down to the physical ITS level.

Acked-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index b2a678d131d0..c9b1c0967426 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -628,8 +628,12 @@ static void its_free_ite(struct kvm *kvm, struct its_ite *ite)
 	list_del(&ite->ite_list);
 
 	/* This put matches the get in vgic_add_lpi. */
-	if (ite->irq)
+	if (ite->irq) {
+		if (ite->irq->hw)
+			WARN_ON(its_unmap_vlpi(ite->irq->host_irq));
+
 		vgic_put_irq(kvm, ite->irq);
+	}
 
 	kfree(ite);
 }
-- 
2.14.1
