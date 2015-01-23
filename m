From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:51 +0100
Subject: [GIT PULL 22/36] arm/arm64: KVM: make the maximum number of vCPUs a
 per-VM value
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-23-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

Currently the maximum number of vCPUs supported is a global value
limited by the used GIC model. GICv3 will lift this limit, but we
still need to observe it for guests using GICv2.
So the maximum number of vCPUs is per-VM value, depending on the
GIC model the guest uses.
Store and check the value in struct kvm_arch, but keep it down to
8 for now.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_host.h   |  1 +
 arch/arm/kvm/arm.c                |  8 ++++++++
 arch/arm64/include/asm/kvm_host.h |  3 +++
 include/kvm/arm_vgic.h            |  8 ++++++++
 virt/kvm/arm/vgic-v2.c            |  1 +
 virt/kvm/arm/vgic-v3.c            |  1 +
 virt/kvm/arm/vgic.c               | 16 ++++++++++++++++
 7 files changed, 38 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 2fa5174..bde4946 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -68,6 +68,7 @@ struct kvm_arch {
 
 	/* Interrupt controller */
 	struct vgic_dist	vgic;
+	int max_vcpus;
 };
 
 #define KVM_NR_MEM_OBJS     40
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 3a51ffca..6fbfa5f 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -132,6 +132,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	/* Mark the initial VMID generation invalid */
 	kvm->arch.vmid_gen = 0;
 
+	/* The maximum number of VCPUs is limited by the host's GIC model */
+	kvm->arch.max_vcpus = kvm_vgic_get_max_vcpus();
+
 	return ret;
 out_free_stage2_pgd:
 	kvm_free_stage2_pgd(kvm);
@@ -218,6 +221,11 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 		goto out;
 	}
 
+	if (id >= kvm->arch.max_vcpus) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
 	if (!vcpu) {
 		err = -ENOMEM;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ff8ee3e..2c49aa4 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -59,6 +59,9 @@ struct kvm_arch {
 	/* VTTBR value associated with above pgd and vmid */
 	u64    vttbr;
 
+	/* The maximum number of vCPUs depends on the used GIC model */
+	int max_vcpus;
+
 	/* Interrupt controller */
 	struct vgic_dist	vgic;
 
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index dd24396..1c0e9db 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -33,6 +33,7 @@
 #define VGIC_V2_MAX_LRS		(1 << 6)
 #define VGIC_V3_MAX_LRS		16
 #define VGIC_MAX_IRQS		1024
+#define VGIC_V2_MAX_CPUS	8
 
 /* Sanity checks... */
 #if (KVM_MAX_VCPUS > 8)
@@ -132,6 +133,7 @@ struct vgic_params {
 	unsigned int	maint_irq;
 	/* Virtual control interface base address */
 	void __iomem	*vctrl_base;
+	int		max_gic_vcpus;
 };
 
 struct vgic_vm_ops {
@@ -289,6 +291,7 @@ struct kvm_exit_mmio;
 int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write);
 int kvm_vgic_hyp_init(void);
 int kvm_vgic_map_resources(struct kvm *kvm);
+int kvm_vgic_get_max_vcpus(void);
 int kvm_vgic_create(struct kvm *kvm, u32 type);
 void kvm_vgic_destroy(struct kvm *kvm);
 void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu);
@@ -393,6 +396,11 @@ static inline bool vgic_ready(struct kvm *kvm)
 {
 	return true;
 }
+
+static inline int kvm_vgic_get_max_vcpus(void)
+{
+	return KVM_MAX_VCPUS;
+}
 #endif
 
 #endif
diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
index e1cd3cb..e8b82b2 100644
--- a/virt/kvm/arm/vgic-v2.c
+++ b/virt/kvm/arm/vgic-v2.c
@@ -237,6 +237,7 @@ int vgic_v2_probe(struct device_node *vgic_node,
 		 vctrl_res.start, vgic->maint_irq);
 
 	vgic->type = VGIC_V2;
+	vgic->max_gic_vcpus = VGIC_V2_MAX_CPUS;
 	*ops = &vgic_v2_ops;
 	*params = vgic;
 	goto out;
diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
index d14c75f..ea39bad 100644
--- a/virt/kvm/arm/vgic-v3.c
+++ b/virt/kvm/arm/vgic-v3.c
@@ -235,6 +235,7 @@ int vgic_v3_probe(struct device_node *vgic_node,
 	vgic->vcpu_base = vcpu_res.start;
 	vgic->vctrl_base = NULL;
 	vgic->type = VGIC_V3;
+	vgic->max_gic_vcpus = KVM_MAX_VCPUS;
 
 	kvm_info("%s@%llx IRQ%d\n", vgic_node->name,
 		 vcpu_res.start, vgic->maint_irq);
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 1c3b75e..2126bf5 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1878,6 +1878,17 @@ static int vgic_vcpu_init_maps(struct kvm_vcpu *vcpu, int nr_irqs)
 	return 0;
 }
 
+/**
+ * kvm_vgic_get_max_vcpus - Get the maximum number of VCPUs allowed by HW
+ *
+ * The host's GIC naturally limits the maximum amount of VCPUs a guest
+ * can use.
+ */
+int kvm_vgic_get_max_vcpus(void)
+{
+	return vgic->max_gic_vcpus;
+}
+
 void kvm_vgic_destroy(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
@@ -2072,6 +2083,8 @@ static void vgic_v2_init_emulation(struct kvm *kvm)
 	dist->vm_ops.add_sgi_source = vgic_v2_add_sgi_source;
 	dist->vm_ops.init_model = vgic_v2_init_model;
 	dist->vm_ops.map_resources = vgic_v2_map_resources;
+
+	kvm->arch.max_vcpus = VGIC_V2_MAX_CPUS;
 }
 
 static int init_vgic_model(struct kvm *kvm, int type)
@@ -2084,6 +2097,9 @@ static int init_vgic_model(struct kvm *kvm, int type)
 		return -ENODEV;
 	}
 
+	if (atomic_read(&kvm->online_vcpus) > kvm->arch.max_vcpus)
+		return -E2BIG;
+
 	return 0;
 }
 
-- 
2.1.2.330.g565301e.dirty
