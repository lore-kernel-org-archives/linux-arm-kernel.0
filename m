From: gang.chen.5i5j@gmail.com (Chen Gang)
Date: Wed, 12 Nov 2014 23:04:23 +0800
Subject: [PATCH] virt: kvm: arm: vgic: Return failure code '-EBUSY' when
 mutex_trylock() fails
Message-ID: <546376F7.90502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When mutex_trylock() fails, kvm_vgic_create() will not create 'vgic', so
it need return failure code '-EBUSY' instead of '0' to let outside know
about it.

Also simplify the code within kvm_vgic_create():

 - kvm_for_each_vcpu() scanning once is enough for current case.

 - Remove redundant variable 'vcpu_lock_idx'.


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 virt/kvm/arm/vgic.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 3aaca49..5846725 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1933,7 +1933,7 @@ out:
 
 int kvm_vgic_create(struct kvm *kvm)
 {
-	int i, vcpu_lock_idx = -1, ret = 0;
+	int i, ret = 0;
 	struct kvm_vcpu *vcpu;
 
 	mutex_lock(&kvm->lock);
@@ -1949,13 +1949,12 @@ int kvm_vgic_create(struct kvm *kvm)
 	 * that no other VCPUs are run while we create the vgic.
 	 */
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		if (!mutex_trylock(&vcpu->mutex))
+		if (!mutex_trylock(&vcpu->mutex)) {
+			ret = -EBUSY;
 			goto out_unlock;
-		vcpu_lock_idx = i;
-	}
-
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+		}
 		if (vcpu->arch.has_run_once) {
+			mutex_unlock(&vcpu->mutex);
 			ret = -EBUSY;
 			goto out_unlock;
 		}
@@ -1968,8 +1967,8 @@ int kvm_vgic_create(struct kvm *kvm)
 	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
 
 out_unlock:
-	for (; vcpu_lock_idx >= 0; vcpu_lock_idx--) {
-		vcpu = kvm_get_vcpu(kvm, vcpu_lock_idx);
+	while (i-- > 0) {
+		vcpu = kvm_get_vcpu(kvm, i);
 		mutex_unlock(&vcpu->mutex);
 	}
 
-- 
1.9.3
