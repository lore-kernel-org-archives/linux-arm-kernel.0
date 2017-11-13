From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 13 Nov 2017 10:17:36 +0100
Subject: [PULL 11/27] KVM: arm/arm64: GICv4: Unmap VLPI when freeing an LPI
In-Reply-To: <20171113091752.10663-1-christoffer.dall@linaro.org>
References: <20171113091752.10663-1-christoffer.dall@linaro.org>
Message-ID: <20171113091752.10663-12-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When freeing an LPI (on a DISCARD command, for example), we need
to unmap the VLPI down to the physical ITS level.

Acked-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-its.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 590f794b7330..ad14af8a4412 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -631,8 +631,12 @@ static void its_free_ite(struct kvm *kvm, struct its_ite *ite)
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
2.14.2
