From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 20 Mar 2017 11:58:18 +0100
Subject: [PATCH 9/9] KVM: arm/arm64: vgic: Improve sync_hwstate performance
In-Reply-To: <20170320105818.20481-1-cdall@linaro.org>
References: <20170320105818.20481-1-cdall@linaro.org>
Message-ID: <20170320105818.20481-10-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to call any functions to fold LRs when we don't use any
LRs and we don't need to mess with overflow flags, take spinlocks, or
prune the AP list if the AP list is empty.

Note: list_empty is a single atomic read (uses READ_ONCE) and can
therefore check if a list is empty or not without the need to take the
spinlock protecting the list.

Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/vgic/vgic.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 093873e..8ecb009 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -639,15 +639,18 @@ void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 
-	if (unlikely(!vgic_initialized(vcpu->kvm)))
+	/* An empty ap_list_head implies used_lrs == 0 */
+	if (list_empty(&vcpu->arch.vgic_cpu.ap_list_head))
 		return;
 
 	vgic_clear_uie(vcpu);
-	vgic_fold_lr_state(vcpu);
-	vgic_prune_ap_list(vcpu);
 
-	/* Make sure we can fast-path in flush_hwstate */
-	vgic_cpu->used_lrs = 0;
+	if (vgic_cpu->used_lrs) {
+		vgic_fold_lr_state(vcpu);
+		vgic_cpu->used_lrs = 0;
+	}
+
+	vgic_prune_ap_list(vcpu);
 }
 
 /* Flush our emulation state into the GIC hardware before entering the guest. */
-- 
2.9.0
