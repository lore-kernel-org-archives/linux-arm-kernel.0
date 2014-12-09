From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue,  9 Dec 2014 12:26:07 +0100
Subject: [GIT PULL 8/9] arm/arm64: vgic: Remove unreachable irq_clear_pending
In-Reply-To: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
References: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418124368-28418-9-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When 'injecting' an edge-triggered interrupt with a falling edge we
shouldn't clear the pending state on the distributor.  In fact, we
don't, because the check in vgic_validate_injection would prevent us
from ever reaching this bit of code.

Remove the unreachable snippet.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 5acf2c9..631a472 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1643,8 +1643,6 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
 			vgic_dist_irq_clear_level(vcpu, irq_num);
 			if (!vgic_dist_irq_soft_pend(vcpu, irq_num))
 				vgic_dist_irq_clear_pending(vcpu, irq_num);
-		} else {
-			vgic_dist_irq_clear_pending(vcpu, irq_num);
 		}
 
 		ret = false;
-- 
2.1.2.330.g565301e.dirty
