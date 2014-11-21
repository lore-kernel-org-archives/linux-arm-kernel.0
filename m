From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Nov 2014 17:21:07 +0000
Subject: [PATCH 3/3] arm/arm64: KVM: vgic: Fix error code in kvm_vgic_create()
In-Reply-To: <1416590467-6044-1-git-send-email-marc.zyngier@arm.com>
References: <1416590467-6044-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1416590467-6044-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

If we detect another vCPU is running we just exit and return 0 as if we
succesfully created the VGIC, but the VGIC wouldn't actual be created.

This shouldn't break in-kernel behavior because the kernel will not
observe the failed the attempt to create the VGIC, but userspace could
be rightfully confused.

Cc: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 3aaca49..aacdb59 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1933,7 +1933,7 @@ out:
 
 int kvm_vgic_create(struct kvm *kvm)
 {
-	int i, vcpu_lock_idx = -1, ret = 0;
+	int i, vcpu_lock_idx = -1, ret;
 	struct kvm_vcpu *vcpu;
 
 	mutex_lock(&kvm->lock);
@@ -1948,6 +1948,7 @@ int kvm_vgic_create(struct kvm *kvm)
 	 * vcpu->mutex.  By grabbing the vcpu->mutex of all VCPUs we ensure
 	 * that no other VCPUs are run while we create the vgic.
 	 */
+	ret = -EBUSY;
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (!mutex_trylock(&vcpu->mutex))
 			goto out_unlock;
@@ -1955,11 +1956,10 @@ int kvm_vgic_create(struct kvm *kvm)
 	}
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		if (vcpu->arch.has_run_once) {
-			ret = -EBUSY;
+		if (vcpu->arch.has_run_once)
 			goto out_unlock;
-		}
 	}
+	ret = 0;
 
 	spin_lock_init(&kvm->arch.vgic.lock);
 	kvm->arch.vgic.in_kernel = true;
-- 
2.1.3
