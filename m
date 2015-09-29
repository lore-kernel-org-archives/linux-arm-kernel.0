From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 29 Sep 2015 16:49:05 +0200
Subject: [PATCH v3 8/8] arm/arm64: KVM: Support edge-triggered forwarded
 interrupts
In-Reply-To: <1443538145-11990-1-git-send-email-christoffer.dall@linaro.org>
References: <1443538145-11990-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1443538145-11990-9-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We mark edge-triggered interrupts with the HW bit set as queued to
prevent the VGIC code from injecting LRs with both the Active and
Pending bits set at the same time while also setting the HW bit,
because the hardware does not support this.

However, this means that we must also clear the queued flag when we sync
back a LR where the state on the physical distributor went from active
to inactive because the guest deactivated the interrupt.  At this point
we must also check if the interrupt is pending on the distributor, and
tell the VGIC to queue it again if it is.

Since these actions on the sync path are extremely close to those for
level-triggered interrupts, rename process_level_irq to
process_queued_irq, allowing it to cater for both cases.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 53548f1..f3e76e5 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1322,13 +1322,10 @@ epilog:
 	}
 }
 
-static int process_level_irq(struct kvm_vcpu *vcpu, int lr, struct vgic_lr vlr)
+static int process_queued_irq(struct kvm_vcpu *vcpu,
+				   int lr, struct vgic_lr vlr)
 {
-	int level_pending = 0;
-
-	vlr.state = 0;
-	vlr.hwirq = 0;
-	vgic_set_lr(vcpu, lr, vlr);
+	int pending = 0;
 
 	/*
 	 * If the IRQ was EOIed (called from vgic_process_maintenance) or it
@@ -1344,26 +1341,35 @@ static int process_level_irq(struct kvm_vcpu *vcpu, int lr, struct vgic_lr vlr)
 	vgic_dist_irq_clear_soft_pend(vcpu, vlr.irq);
 
 	/*
-	 * Tell the gic to start sampling the line of this interrupt again.
+	 * Tell the gic to start sampling this interrupt again.
 	 */
 	vgic_irq_clear_queued(vcpu, vlr.irq);
 
 	/* Any additional pending interrupt? */
-	if (vgic_dist_irq_get_level(vcpu, vlr.irq)) {
-		vgic_cpu_irq_set(vcpu, vlr.irq);
-		level_pending = 1;
+	if (vgic_irq_is_edge(vcpu, vlr.irq)) {
+		BUG_ON(!(vlr.state & LR_HW));
+		pending = vgic_dist_irq_is_pending(vcpu, vlr.irq);
 	} else {
-		vgic_dist_irq_clear_pending(vcpu, vlr.irq);
-		vgic_cpu_irq_clear(vcpu, vlr.irq);
+		if (vgic_dist_irq_get_level(vcpu, vlr.irq)) {
+			vgic_cpu_irq_set(vcpu, vlr.irq);
+			pending = 1;
+		} else {
+			vgic_dist_irq_clear_pending(vcpu, vlr.irq);
+			vgic_cpu_irq_clear(vcpu, vlr.irq);
+		}
 	}
 
 	/*
 	 * Despite being EOIed, the LR may not have
 	 * been marked as empty.
 	 */
+	vlr.state = 0;
+	vlr.hwirq = 0;
+	vgic_set_lr(vcpu, lr, vlr);
+
 	vgic_sync_lr_elrsr(vcpu, lr, vlr);
 
-	return level_pending;
+	return pending;
 }
 
 static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
@@ -1400,7 +1406,7 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
 					     vlr.irq - VGIC_NR_PRIVATE_IRQS);
 
 			spin_lock(&dist->lock);
-			level_pending |= process_level_irq(vcpu, lr, vlr);
+			level_pending |= process_queued_irq(vcpu, lr, vlr);
 			spin_unlock(&dist->lock);
 		}
 	}
@@ -1422,7 +1428,7 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
 /*
  * Save the physical active state, and reset it to inactive.
  *
- * Return true if there's a pending level triggered interrupt line to queue.
+ * Return true if there's a pending forwarded interrupt to queue.
  */
 static bool vgic_sync_hwirq(struct kvm_vcpu *vcpu, int lr, struct vgic_lr vlr)
 {
@@ -1458,10 +1464,8 @@ static bool vgic_sync_hwirq(struct kvm_vcpu *vcpu, int lr, struct vgic_lr vlr)
 		return false;
 	}
 
-	/* Mapped edge-triggered interrupts not yet supported. */
-	WARN_ON(vgic_irq_is_edge(vcpu, vlr.irq));
 	spin_lock(&dist->lock);
-	level_pending = process_level_irq(vcpu, lr, vlr);
+	level_pending = process_queued_irq(vcpu, lr, vlr);
 	spin_unlock(&dist->lock);
 	return level_pending;
 }
-- 
2.1.2.330.g565301e.dirty
