From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Fri, 13 Mar 2015 17:02:53 +0000
Subject: [PATCH v3 2/5] arm/arm64: KVM: add a common vgic_queue_irq_to_lr fn
In-Reply-To: <1426266176-14933-1-git-send-email-alex.bennee@linaro.org>
References: <1426266176-14933-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1426266176-14933-3-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This helps re-factor away some of the repetitive code and makes the code
flow more nicely.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---
v3
  - Move to before the un-queue active patch

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 0cc6ab6..6682d58 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -949,6 +949,20 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void vgic_queue_irq_to_lr(struct kvm_vcpu *vcpu, int irq,
+				 int lr_nr, struct vgic_lr vlr)
+{
+	if (vgic_dist_irq_is_pending(vcpu, irq)) {
+		vlr.state |= LR_STATE_PENDING;
+		kvm_debug("Set pending: 0x%x\n", vlr.state);
+	}
+
+	if (!vgic_irq_is_edge(vcpu, irq))
+		vlr.state |= LR_EOI_INT;
+
+	vgic_set_lr(vcpu, lr_nr, vlr);
+}
+
 /*
  * Queue an interrupt to a CPU virtual interface. Return true on success,
  * or false if it wasn't possible to queue it.
@@ -976,8 +990,7 @@ bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 		if (vlr.source == sgi_source_id) {
 			kvm_debug("LR%d piggyback for IRQ%d\n", lr, vlr.irq);
 			BUG_ON(!test_bit(lr, vgic_cpu->lr_used));
-			vlr.state |= LR_STATE_PENDING;
-			vgic_set_lr(vcpu, lr, vlr);
+			vgic_queue_irq_to_lr(vcpu, irq, lr, vlr);
 			return true;
 		}
 	}
@@ -994,11 +1007,8 @@ bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 
 	vlr.irq = irq;
 	vlr.source = sgi_source_id;
-	vlr.state = LR_STATE_PENDING;
-	if (!vgic_irq_is_edge(vcpu, irq))
-		vlr.state |= LR_EOI_INT;
-
-	vgic_set_lr(vcpu, lr, vlr);
+	vlr.state = 0;
+	vgic_queue_irq_to_lr(vcpu, irq, lr, vlr);
 
 	return true;
 }
-- 
2.3.2
