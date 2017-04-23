From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:30 +0200
Subject: [PULL 20/79] KVM: arm/arm64: vgic: Only set underflow when actually
 out of LRs
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-21-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently assume that all the interrupts in our AP list will be
queued to LRs, but that's not necessarily the case, because some of them
could have been migrated away to different VCPUs and only the VCPU
thread itself can remove interrupts from its AP list.

Therefore, slightly change the logic to only setting the underflow
interrupt when we actually run out of LRs.

As it turns out, this allows us to further simplify the handling in
vgic_sync_hwstate in later patches.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/vgic/vgic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 1043291..442f7df 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -601,10 +601,8 @@ static void vgic_flush_lr_state(struct kvm_vcpu *vcpu)
 
 	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
 
-	if (compute_ap_list_depth(vcpu) > kvm_vgic_global_state.nr_lr) {
-		vgic_set_underflow(vcpu);
+	if (compute_ap_list_depth(vcpu) > kvm_vgic_global_state.nr_lr)
 		vgic_sort_ap_list(vcpu);
-	}
 
 	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
 		spin_lock(&irq->irq_lock);
@@ -623,8 +621,12 @@ static void vgic_flush_lr_state(struct kvm_vcpu *vcpu)
 next:
 		spin_unlock(&irq->irq_lock);
 
-		if (count == kvm_vgic_global_state.nr_lr)
+		if (count == kvm_vgic_global_state.nr_lr) {
+			if (!list_is_last(&irq->ap_list,
+					  &vgic_cpu->ap_list_head))
+				vgic_set_underflow(vcpu);
 			break;
+		}
 	}
 
 	vcpu->arch.vgic_cpu.used_lrs = count;
-- 
2.9.0
