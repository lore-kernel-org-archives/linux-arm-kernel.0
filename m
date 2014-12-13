From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 13 Dec 2014 12:17:26 +0100
Subject: [PATCH v2 3/6] arm/arm64: KVM: Add (new) vgic_initialized macro
In-Reply-To: <1418469449-13277-1-git-send-email-christoffer.dall@linaro.org>
References: <1418469449-13277-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418469449-13277-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some code paths will need to check to see if the internal state of the
vgic has been initialized (such as when creating new VCPUs), so
introduce such a macro that checks the nr_cpus field which is set when
the vgic has been initialized.

Also set nr_cpus = 0 in kvm_vgic_destroy, because the error path in
vgic_init() will call this function, and code should never errornously
assume the vgic to be properly initialized after an error.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/kvm/arm_vgic.h | 6 ++++++
 virt/kvm/arm/vgic.c    | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 3e262b9..ac4888d 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -287,6 +287,7 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio);
 
 #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.in_kernel))
+#define vgic_initialized(k)	(!!((k)->arch.vgic.nr_cpus))
 #define vgic_ready(k)		((k)->arch.vgic.ready)
 
 int vgic_v2_probe(struct device_node *vgic_node,
@@ -369,6 +370,11 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
 	return 0;
 }
 
+static inline bool vgic_initialized(struct kvm *kvm)
+{
+	return true;
+}
+
 static inline bool vgic_ready(struct kvm *kvm)
 {
 	return true;
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 22c8304..e1bef68 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1774,6 +1774,7 @@ void kvm_vgic_destroy(struct kvm *kvm)
 	dist->irq_spi_cpu = NULL;
 	dist->irq_spi_target = NULL;
 	dist->irq_pending_on_cpu = NULL;
+	dist->nr_cpus = 0;
 }
 
 /*
@@ -1787,7 +1788,7 @@ static int vgic_init(struct kvm *kvm)
 	int nr_cpus, nr_irqs;
 	int ret, i, vcpu_id;
 
-	if (dist->nr_cpus)	/* Already allocated */
+	if (vgic_initialized(kvm))
 		return 0;
 
 	nr_cpus = dist->nr_cpus = atomic_read(&kvm->online_vcpus);
-- 
2.1.2.330.g565301e.dirty
