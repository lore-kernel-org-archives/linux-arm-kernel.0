From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 24 Nov 2014 10:41:56 +0100
Subject: [PATCH] arm/arm64: vgic: Remove unreachable irq_clear_pending
Message-ID: <1416822116-9044-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When 'injecting' an edge-triggered interrupt with a falling edge we
shouldn't clear the pending state on the distributor.  In fact, we
don't, because the check in vgic_validate_injection would prevent us
from ever reaching this bit of code.

Remove the unreachable snippet.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 3aaca49..f45cf16 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1643,8 +1643,6 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
 			vgic_dist_irq_clear_level(vcpu, irq_num);
 			if (!vgic_dist_irq_soft_pend(vcpu, irq_num))
 				vgic_dist_irq_clear_pending(vcpu, irq_num);
-		} else {
-			vgic_dist_irq_clear_pending(vcpu, irq_num);
 		}
 	}
 
-- 
2.1.2.330.g565301e.dirty
