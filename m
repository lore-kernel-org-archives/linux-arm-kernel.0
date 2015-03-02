From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Mon,  2 Mar 2015 13:29:02 +0000
Subject: [PATCH v2 3/5] arm: KVM: add a common vgic_queue_irq_to_lr fn
In-Reply-To: <1425302944-6276-1-git-send-email-alex.bennee@linaro.org>
References: <1425302944-6276-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1425302944-6276-4-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This helps re-factor away some of the repetitive code and makes the code
flow more nicely.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index bfb6fbb..3b4ded2 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -263,6 +263,13 @@ static int vgic_irq_is_queued(struct kvm_vcpu *vcpu, int irq)
 	return vgic_bitmap_get_irq_val(&dist->irq_queued, vcpu->vcpu_id, irq);
 }
 
+static int vgic_irq_is_active(struct kvm_vcpu *vcpu, int irq)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	return vgic_bitmap_get_irq_val(&dist->irq_active, vcpu->vcpu_id, irq);
+}
+
 static void vgic_irq_set_queued(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
@@ -285,6 +292,13 @@ static void vgic_irq_set_active(struct kvm_vcpu *vcpu, int irq)
 	vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id, irq, 1);
 }
 
+static void vgic_irq_clear_active(struct kvm_vcpu *vcpu, int irq)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id, irq, 0);
+}
+
 static int vgic_dist_irq_get_level(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
@@ -1032,6 +1046,25 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void vgic_queue_irq_to_lr(struct kvm_vcpu *vcpu, int irq,
+				 int lr_nr, struct vgic_lr vlr)
+{
+	if (vgic_irq_is_active(vcpu, irq)) {
+		vlr.state |= LR_STATE_ACTIVE;
+		kvm_debug("Set active, clear distributor: 0x%x\n", vlr.state);
+		vgic_irq_clear_active(vcpu, irq);
+		vgic_update_state(vcpu->kvm);
+	} else if (vgic_dist_irq_is_pending(vcpu, irq)) {
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
@@ -1059,8 +1092,7 @@ bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 		if (vlr.source == sgi_source_id) {
 			kvm_debug("LR%d piggyback for IRQ%d\n", lr, vlr.irq);
 			BUG_ON(!test_bit(lr, vgic_cpu->lr_used));
-			vlr.state |= LR_STATE_PENDING;
-			vgic_set_lr(vcpu, lr, vlr);
+			vgic_queue_irq_to_lr(vcpu, irq, lr, vlr);
 			return true;
 		}
 	}
@@ -1077,11 +1109,8 @@ bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 
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
2.3.0
