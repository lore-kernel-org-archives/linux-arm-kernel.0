From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:28 +0200
Subject: [PULL 18/79] KVM: arm/arm64: vgic: Avoid flushing vgic state when
 there's no pending IRQ
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-19-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shih-Wei Li <shihwei@cs.columbia.edu>

We do not need to flush vgic states in each world switch unless
there is pending IRQ queued to the vgic's ap list. We can thus reduce
the overhead by not grabbing the spinlock and not making the extra
function call to vgic_flush_lr_state.

Note: list_empty is a single atomic read (uses READ_ONCE) and can
therefore check if a list is empty or not without the need to take the
spinlock protecting the list.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Shih-Wei Li <shihwei@cs.columbia.edu>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/vgic/vgic.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 2ac0def..1043291 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -637,12 +637,17 @@ static void vgic_flush_lr_state(struct kvm_vcpu *vcpu)
 /* Sync back the hardware VGIC state into our emulation after a guest's run. */
 void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 {
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+
 	if (unlikely(!vgic_initialized(vcpu->kvm)))
 		return;
 
 	vgic_process_maintenance_interrupt(vcpu);
 	vgic_fold_lr_state(vcpu);
 	vgic_prune_ap_list(vcpu);
+
+	/* Make sure we can fast-path in flush_hwstate */
+	vgic_cpu->used_lrs = 0;
 }
 
 /* Flush our emulation state into the GIC hardware before entering the guest. */
@@ -651,6 +656,18 @@ void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 	if (unlikely(!vgic_initialized(vcpu->kvm)))
 		return;
 
+	/*
+	 * If there are no virtual interrupts active or pending for this
+	 * VCPU, then there is no work to do and we can bail out without
+	 * taking any lock.  There is a potential race with someone injecting
+	 * interrupts to the VCPU, but it is a benign race as the VCPU will
+	 * either observe the new interrupt before or after doing this check,
+	 * and introducing additional synchronization mechanism doesn't change
+	 * this.
+	 */
+	if (list_empty(&vcpu->arch.vgic_cpu.ap_list_head))
+		return;
+
 	spin_lock(&vcpu->arch.vgic_cpu.ap_list_lock);
 	vgic_flush_lr_state(vcpu);
 	spin_unlock(&vcpu->arch.vgic_cpu.ap_list_lock);
-- 
2.9.0
