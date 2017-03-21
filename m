From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 21 Mar 2017 22:10:58 +0100
Subject: [PATCH v2 09/10] KVM: arm/arm64: vgic: Don't check vgic_initialized
 in sync/flush
In-Reply-To: <20170321211059.8719-1-cdall@linaro.org>
References: <20170321211059.8719-1-cdall@linaro.org>
Message-ID: <20170321211059.8719-10-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now when we do an early init of the static parts of the VGIC data
structures, we can do things like checking if the AP lists are empty
directly without having to explicitly check if the vgic is initialized
and reduce a bit of work in our critical path.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
Changes since v1:
 - Moved note about checking list_empty to other patch commit message
 - Removed check in both sync/flush in this patch

 virt/kvm/arm/vgic/vgic.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index b64b143..04a405a 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -633,9 +633,6 @@ void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 
-	if (unlikely(!vgic_initialized(vcpu->kvm)))
-		return;
-
 	vgic_fold_lr_state(vcpu);
 	vgic_prune_ap_list(vcpu);
 
@@ -646,9 +643,6 @@ void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 /* Flush our emulation state into the GIC hardware before entering the guest. */
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 {
-	if (unlikely(!vgic_initialized(vcpu->kvm)))
-		return;
-
 	/*
 	 * If there are no virtual interrupts active or pending for this
 	 * VCPU, then there is no work to do and we can bail out without
-- 
2.9.0
