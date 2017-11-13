From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 13 Nov 2017 10:17:52 +0100
Subject: [PULL 27/27] KVM: arm/arm64: Don't queue VLPIs on INV/INVALL
In-Reply-To: <20171113091752.10663-1-christoffer.dall@linaro.org>
References: <20171113091752.10663-1-christoffer.dall@linaro.org>
Message-ID: <20171113091752.10663-28-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since VLPIs are injected directly by the hardware there's no need to
mark these as pending in software and queue them on the AP list.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-its.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index c93ecd4a903b..a3754ec719c4 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -292,11 +292,14 @@ static int update_lpi_config(struct kvm *kvm, struct vgic_irq *irq,
 		irq->priority = LPI_PROP_PRIORITY(prop);
 		irq->enabled = LPI_PROP_ENABLE_BIT(prop);
 
-		vgic_queue_irq_unlock(kvm, irq, flags);
-	} else {
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		if (!irq->hw) {
+			vgic_queue_irq_unlock(kvm, irq, flags);
+			return 0;
+		}
 	}
 
+	spin_unlock_irqrestore(&irq->irq_lock, flags);
+
 	if (irq->hw)
 		return its_prop_update_vlpi(irq->host_irq, prop, needs_inv);
 
-- 
2.14.2
