From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:36 +0200
Subject: [PULL 26/79] KVM: arm/arm64: vgic: Improve sync_hwstate performance
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-27-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to call any functions to fold LRs when we don't use any
LRs and we don't need to mess with overflow flags, take spinlocks, or
prune the AP list if the AP list is empty.

Note: list_empty is a single atomic read (uses READ_ONCE) and can
therefore check if a list is empty or not without the need to take the
spinlock protecting the list.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-v2.c |  7 +++++--
 virt/kvm/arm/vgic/vgic-v3.c |  7 +++++--
 virt/kvm/arm/vgic/vgic.c    | 10 ++++++----
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
index b58b086..025b57d 100644
--- a/virt/kvm/arm/vgic/vgic-v2.c
+++ b/virt/kvm/arm/vgic/vgic-v2.c
@@ -44,12 +44,13 @@ static bool lr_signals_eoi_mi(u32 lr_val)
  */
 void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
 {
-	struct vgic_v2_cpu_if *cpuif = &vcpu->arch.vgic_cpu.vgic_v2;
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_v2_cpu_if *cpuif = &vgic_cpu->vgic_v2;
 	int lr;
 
 	cpuif->vgic_hcr &= ~GICH_HCR_UIE;
 
-	for (lr = 0; lr < vcpu->arch.vgic_cpu.used_lrs; lr++) {
+	for (lr = 0; lr < vgic_cpu->used_lrs; lr++) {
 		u32 val = cpuif->vgic_lr[lr];
 		u32 intid = val & GICH_LR_VIRTUALID;
 		struct vgic_irq *irq;
@@ -91,6 +92,8 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
 		spin_unlock(&irq->irq_lock);
 		vgic_put_irq(vcpu->kvm, irq);
 	}
+
+	vgic_cpu->used_lrs = 0;
 }
 
 /*
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 4f2dce6..bc7010d 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -36,13 +36,14 @@ static bool lr_signals_eoi_mi(u64 lr_val)
 
 void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
 {
-	struct vgic_v3_cpu_if *cpuif = &vcpu->arch.vgic_cpu.vgic_v3;
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_v3_cpu_if *cpuif = &vgic_cpu->vgic_v3;
 	u32 model = vcpu->kvm->arch.vgic.vgic_model;
 	int lr;
 
 	cpuif->vgic_hcr &= ~ICH_HCR_UIE;
 
-	for (lr = 0; lr < vcpu->arch.vgic_cpu.used_lrs; lr++) {
+	for (lr = 0; lr < vgic_cpu->used_lrs; lr++) {
 		u64 val = cpuif->vgic_lr[lr];
 		u32 intid;
 		struct vgic_irq *irq;
@@ -92,6 +93,8 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
 		spin_unlock(&irq->irq_lock);
 		vgic_put_irq(vcpu->kvm, irq);
 	}
+
+	vgic_cpu->used_lrs = 0;
 }
 
 /* Requires the irq to be locked already */
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 04a405a..3d0979c 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -633,11 +633,13 @@ void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 
-	vgic_fold_lr_state(vcpu);
-	vgic_prune_ap_list(vcpu);
+	/* An empty ap_list_head implies used_lrs == 0 */
+	if (list_empty(&vcpu->arch.vgic_cpu.ap_list_head))
+		return;
 
-	/* Make sure we can fast-path in flush_hwstate */
-	vgic_cpu->used_lrs = 0;
+	if (vgic_cpu->used_lrs)
+		vgic_fold_lr_state(vcpu);
+	vgic_prune_ap_list(vcpu);
 }
 
 /* Flush our emulation state into the GIC hardware before entering the guest. */
-- 
2.9.0
