From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 25 Aug 2014 15:27:36 +0200
Subject: [RFC 1/9] KVM: ARM: VGIC: fix multiple injection of level sensitive
 forwarded IRQ
In-Reply-To: <1408973264-30384-1-git-send-email-eric.auger@linaro.org>
References: <1408973264-30384-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1408973264-30384-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix multiple injection of level sensitive forwarded IRQs.
With current code, the second injection fails since the state bitmaps
are not reset (process_maintenance is not called anymore).
New implementation consists in fully bypassing the vgic state
management for forwarded IRQ (checks are ignored in
vgic_update_irq_pending). This obviously assumes the forwarded IRQ is
injected from kernel side.

---
  It was attempted to reset the states in __kvm_vgic_sync_hwstate, checking
  the emptied LR of forwarded IRQ. However surprisingly this solution does
  not seem to work. Some times, a new forwarded IRQ injection is observed
  while the LR of the previous instance was not observed as empty.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 include/kvm/arm_vgic.h | 1 +
 virt/kvm/arm/vgic.c    | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 743020f..3da244f 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -177,6 +177,7 @@ struct vgic_dist {
 	unsigned long		irq_pending_on_cpu;
 
 	struct rb_root		irq_phys_map;
+	spinlock_t			rb_tree_lock;
 #endif
 };
 
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 0007300..195c10c 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1517,14 +1517,18 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
 	int edge_triggered, level_triggered;
 	int enabled;
 	bool ret = true;
+	bool is_forwarded;
 
 	spin_lock(&dist->lock);
 
 	vcpu = kvm_get_vcpu(kvm, cpuid);
+	is_forwarded = (vgic_get_phys_irq(vcpu, irq_num) >0);
+		
 	edge_triggered = vgic_irq_is_edge(vcpu, irq_num);
 	level_triggered = !edge_triggered;
 
-	if (!vgic_validate_injection(vcpu, irq_num, level)) {
+	if (!is_forwarded &&
+		!vgic_validate_injection(vcpu, irq_num, level)) {
 		ret = false;
 		goto out;
 	}
@@ -1557,7 +1561,8 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
 		goto out;
 	}
 
-	if (level_triggered && vgic_irq_is_queued(vcpu, irq_num)) {
+	if (!is_forwarded &&
+		level_triggered && vgic_irq_is_queued(vcpu, irq_num)) {
 		/*
 		 * Level interrupt in progress, will be picked up
 		 * when EOId.
-- 
1.9.1
