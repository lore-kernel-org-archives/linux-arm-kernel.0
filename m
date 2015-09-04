From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri,  4 Sep 2015 21:40:47 +0200
Subject: [PATCH v2 5/8] arm/arm64: KVM: Use appropriate define in VGIC reset
 code
In-Reply-To: <1441395650-19663-1-git-send-email-christoffer.dall@linaro.org>
References: <1441395650-19663-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1441395650-19663-6-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently initialize the SGIs to be enabled in the VGIC code, but we
use the VGIC_NR_PPIS define for this purpose, instead of the the more
natural VGIC_NR_SGIS.  Change this slightly confusing use of the
defines.

Note: This should have no functional change, as both names are defined
to the number 16.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index e606f78..9ed8d53 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2109,7 +2109,7 @@ int vgic_init(struct kvm *kvm)
 		}
 
 		for (i = 0; i < dist->nr_irqs; i++) {
-			if (i < VGIC_NR_PPIS)
+			if (i < VGIC_NR_SGIS)
 				vgic_bitmap_set_irq_val(&dist->irq_enabled,
 							vcpu->vcpu_id, i, 1);
 			if (i < VGIC_NR_PRIVATE_IRQS)
-- 
2.1.2.330.g565301e.dirty
