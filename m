From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Jun 2014 10:19:38 +0100
Subject: [PATCH v5 15/20] KVM: ARM: vgic: revisit implementation of
 irqchip_in_kernel
In-Reply-To: <1403169583-13668-1-git-send-email-marc.zyngier@arm.com>
References: <1403169583-13668-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403169583-13668-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, irqchip_in_kernel() was implemented by testing the value of
vctrl_base, which worked fine with GICv2.

With GICv3, this field is useless, as we're using system registers
instead of a emmory mapped interface. To solve this, add a boolean
flag indicating if the we're using a vgic or not.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h | 3 ++-
 virt/kvm/arm/vgic.c    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index d8d52a9..f6b9fec 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -117,6 +117,7 @@ struct vgic_params {
 struct vgic_dist {
 #ifdef CONFIG_KVM_ARM_VGIC
 	spinlock_t		lock;
+	bool			in_kernel;
 	bool			ready;
 
 	/* Virtual control interface mapping */
@@ -212,7 +213,7 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio);
 
-#define irqchip_in_kernel(k)	(!!((k)->arch.vgic.vctrl_base))
+#define irqchip_in_kernel(k)	(!!((k)->arch.vgic.in_kernel))
 #define vgic_initialized(k)	((k)->arch.vgic.ready)
 
 int vgic_v2_probe(struct device_node *vgic_node,
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index e4b9cbb..1348e74 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1650,6 +1650,7 @@ int kvm_vgic_create(struct kvm *kvm)
 	}
 
 	spin_lock_init(&kvm->arch.vgic.lock);
+	kvm->arch.vgic.in_kernel = true;
 	kvm->arch.vgic.vctrl_base = vgic->vctrl_base;
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
 	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
-- 
1.8.3.4
