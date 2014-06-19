From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 19 Jun 2014 10:45:44 +0100
Subject: [PATCH 06/14] arm/arm64: KVM: make the maximum number of vCPUs a
 per-VM value
In-Reply-To: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
References: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1403171152-24067-7-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the maximum number of vCPUs supported is a global value
limited by the used GIC model. GICv3 will lift this limit, but we
still need to observe it for guests using GICv2.
So the maximum number of vCPUs is per-VM value, depending on the
GIC model the guest uses.
Store and check the value in struct kvm_arch, but keep it down to
8 for now.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/kvm_host.h   |    1 +
 arch/arm/kvm/arm.c                |    6 ++++++
 arch/arm64/include/asm/kvm_host.h |    3 +++
 virt/kvm/arm/vgic-v2.c            |    5 +++++
 virt/kvm/arm/vgic-v3.c            |    6 ++++++
 5 files changed, 21 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 8d30f05..49c07ea 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -67,6 +67,7 @@ struct kvm_arch {
 
 	/* Interrupt controller */
 	struct vgic_dist	vgic;
+	int max_vcpus;
 };
 
 #define KVM_NR_MEM_OBJS     40
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index fa37fa1..a291e63 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -142,6 +142,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	/* Mark the initial VMID generation invalid */
 	kvm->arch.vmid_gen = 0;
+	kvm->arch.max_vcpus = CONFIG_KVM_ARM_MAX_VCPUS;
 
 	return ret;
 out_free_stage2_pgd:
@@ -260,6 +261,11 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	int err;
 	struct kvm_vcpu *vcpu;
 
+	if (id >= kvm->arch.max_vcpus) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
 	if (!vcpu) {
 		err = -ENOMEM;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4c84250..eef63b1 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -58,6 +58,9 @@ struct kvm_arch {
 	/* VTTBR value associated with above pgd and vmid */
 	u64    vttbr;
 
+	/* The maximum number of vCPUs depends on the used GIC model */
+	int max_vcpus;
+
 	/* Interrupt controller */
 	struct vgic_dist	vgic;
 
diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
index f2c214a..4091078 100644
--- a/virt/kvm/arm/vgic-v2.c
+++ b/virt/kvm/arm/vgic-v2.c
@@ -164,11 +164,16 @@ static struct vgic_params vgic_v2_params;
 static bool vgic_v2_init_emul(struct kvm *kvm, int type)
 {
 	struct vgic_vm_ops *vm_ops = &kvm->arch.vgic.vm_ops;
+	int nr_vcpus;
 
 	switch (type) {
 	case KVM_DEV_TYPE_ARM_VGIC_V2:
+		nr_vcpus = atomic_read(&kvm->online_vcpus);
+		if (nr_vcpus > 8)
+			return false;
 		vm_ops->get_lr = vgic_v2_get_lr;
 		vm_ops->set_lr = vgic_v2_set_lr;
+		kvm->arch.max_vcpus = 8;
 		return true;
 	}
 
diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
index f42961c..40d6817 100644
--- a/virt/kvm/arm/vgic-v3.c
+++ b/virt/kvm/arm/vgic-v3.c
@@ -171,11 +171,17 @@ static const struct vgic_ops vgic_v3_ops = {
 static bool vgic_v3_init_emul_compat(struct kvm *kvm, int type)
 {
 	struct vgic_vm_ops *vm_ops = &kvm->arch.vgic.vm_ops;
+	int nr_vcpus;
 
 	switch (type) {
 	case KVM_DEV_TYPE_ARM_VGIC_V2:
+		nr_vcpus = atomic_read(&kvm->online_vcpus);
+		if (nr_vcpus > 8)
+			return false;
+
 		vm_ops->get_lr = vgic_v3_get_lr;
 		vm_ops->set_lr = vgic_v3_set_lr;
+		kvm->arch.max_vcpus = 8;
 		return true;
 	}
 	return false;
-- 
1.7.9.5
