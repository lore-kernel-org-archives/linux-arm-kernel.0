From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 15 Dec 2014 12:41:55 +0100
Subject: [GIT PULL 08/12] arm/arm64: KVM: Rename vgic_initialized to vgic_ready
In-Reply-To: <1418643719-25966-1-git-send-email-christoffer.dall@linaro.org>
References: <1418643719-25966-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418643719-25966-9-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vgic_initialized() macro currently returns the state of the
vgic->ready flag, which indicates if the vgic is ready to be used when
running a VM, not specifically if its internal state has been
initialized.

Rename the macro accordingly in preparation for a more nuanced
initialization flow.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c     | 2 +-
 include/kvm/arm_vgic.h | 4 ++--
 virt/kvm/arm/vgic.c    | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index fa4b97c..c5a05f2 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -431,7 +431,7 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	 * Map the VGIC hardware resources before running a vcpu the first
 	 * time on this VM.
 	 */
-	if (unlikely(!vgic_initialized(vcpu->kvm))) {
+	if (unlikely(!vgic_ready(vcpu->kvm))) {
 		ret = kvm_vgic_map_resources(vcpu->kvm);
 		if (ret)
 			return ret;
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index fe9783b..3e262b9 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -287,7 +287,7 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio);
 
 #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.in_kernel))
-#define vgic_initialized(k)	((k)->arch.vgic.ready)
+#define vgic_ready(k)		((k)->arch.vgic.ready)
 
 int vgic_v2_probe(struct device_node *vgic_node,
 		  const struct vgic_ops **ops,
@@ -369,7 +369,7 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
 	return 0;
 }
 
-static inline bool vgic_initialized(struct kvm *kvm)
+static inline bool vgic_ready(struct kvm *kvm)
 {
 	return true;
 }
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 1ce4e36..4edb257 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1696,7 +1696,7 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 {
 	int vcpu_id;
 
-	if (likely(vgic_initialized(kvm))) {
+	if (likely(vgic_ready(kvm))) {
 		vcpu_id = vgic_update_irq_pending(kvm, cpuid, irq_num, level);
 		if (vcpu_id >= 0)
 			/* kick the specified vcpu */
@@ -1888,7 +1888,7 @@ int kvm_vgic_map_resources(struct kvm *kvm)
 
 	mutex_lock(&kvm->lock);
 
-	if (vgic_initialized(kvm))
+	if (vgic_ready(kvm))
 		goto out;
 
 	if (IS_VGIC_ADDR_UNDEF(kvm->arch.vgic.vgic_dist_base) ||
@@ -2282,7 +2282,7 @@ static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 
 		mutex_lock(&dev->kvm->lock);
 
-		if (vgic_initialized(dev->kvm) || dev->kvm->arch.vgic.nr_irqs)
+		if (vgic_ready(dev->kvm) || dev->kvm->arch.vgic.nr_irqs)
 			ret = -EBUSY;
 		else
 			dev->kvm->arch.vgic.nr_irqs = val;
-- 
2.1.2.330.g565301e.dirty
