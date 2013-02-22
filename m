From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Feb 2013 18:40:45 +0000
Subject: [PATCH 1/2] ARM: KVM: vgic: force EOIed LRs to the empty state
In-Reply-To: <1361558446-8375-1-git-send-email-marc.zyngier@arm.com>
References: <1361558446-8375-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1361558446-8375-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VGIC doesn't guarantee that an EOIed LR that has been configured
to generate a maintenance interrupt will appear as empty.

While the code recovers from this situation, it is better to clean
the LR and flag it as empty so it can be quickly recycled.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/vgic.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index c9a1731..76ea1aa 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -883,8 +883,7 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 			  lr, irq, vgic_cpu->vgic_lr[lr]);
 		BUG_ON(!test_bit(lr, vgic_cpu->lr_used));
 		vgic_cpu->vgic_lr[lr] |= GICH_LR_PENDING_BIT;
-
-		goto out;
+		return true;
 	}
 
 	/* Try to use another LR for this interrupt */
@@ -898,7 +897,6 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 	vgic_cpu->vgic_irq_lr_map[irq] = lr;
 	set_bit(lr, vgic_cpu->lr_used);
 
-out:
 	if (!vgic_irq_is_edge(vcpu, irq))
 		vgic_cpu->vgic_lr[lr] |= GICH_LR_EOI;
 
@@ -1054,6 +1052,13 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
 			} else {
 				vgic_cpu_irq_clear(vcpu, irq);
 			}
+
+			/*
+			 * Despite being EOIed, the LR may not have
+			 * been marked as empty.
+			 */
+			set_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr);
+			vgic_cpu->vgic_lr[lr] &= ~GICH_LR_ACTIVE_BIT;
 		}
 	}
 
-- 
1.7.12.4
