From: julien.grall@arm.com (Julien Grall)
Date: Thu, 10 May 2018 15:04:41 +0100
Subject: [RFC 13/13] kvmtool: arm/arm64: Add support for creating VM with PA
 size
In-Reply-To: <20180510140441.24573-1-julien.grall@arm.com>
References: <20180510140441.24573-1-julien.grall@arm.com>
Message-ID: <20180510140441.24573-14-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Specify the physical size for the VM encoded in the vm type.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Julien Grall <julien.grall@arm.com>
[julien: Don't specify the type of older kernels | fix max_ipa type]
---
 arm/include/arm-common/kvm-arch.h |  6 +++++-
 arm/kvm.c                         | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arm/include/arm-common/kvm-arch.h b/arm/include/arm-common/kvm-arch.h
index 4be9589..81be262 100644
--- a/arm/include/arm-common/kvm-arch.h
+++ b/arm/include/arm-common/kvm-arch.h
@@ -46,7 +46,11 @@
 
 #define KVM_IRQ_OFFSET		GIC_SPI_IRQ_BASE
 
-#define KVM_VM_TYPE		0
+extern unsigned long		kvm_arm_type;
+extern void kvm__arch_init_hyp(struct kvm *kvm);
+
+#define KVM_VM_TYPE		kvm_arm_type
+#define kvm__arch_init_hyp	kvm__arch_init_hyp
 
 #define VIRTIO_DEFAULT_TRANS(kvm)	\
 	((kvm)->cfg.arch.virtio_trans_pci ? VIRTIO_PCI : VIRTIO_MMIO)
diff --git a/arm/kvm.c b/arm/kvm.c
index 5a2bd28..97c1333 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -13,6 +13,8 @@
 
 #include <stdlib.h>
 
+unsigned long kvm_arm_type;
+
 struct kvm_ext kvm_req_ext[] = {
 	{ DEFINE_KVM_EXT(KVM_CAP_IRQCHIP) },
 	{ DEFINE_KVM_EXT(KVM_CAP_ONE_REG) },
@@ -20,6 +22,31 @@ struct kvm_ext kvm_req_ext[] = {
 	{ 0, 0 },
 };
 
+#ifndef KVM_ARM_GET_MAX_VM_PHYS_SHIFT
+#define KVM_ARM_GET_MAX_VM_PHYS_SHIFT		_IO(KVMIO, 0x0a)
+#endif
+
+void kvm__arch_init_hyp(struct kvm *kvm)
+{
+	int max_ipa;
+
+	max_ipa = ioctl(kvm->sys_fd, KVM_ARM_GET_MAX_VM_PHYS_SHIFT);
+	if (max_ipa < 0)
+		max_ipa = 40;
+	if (!kvm->cfg.arch.phys_shift)
+		kvm->cfg.arch.phys_shift = 40;
+	if (kvm->cfg.arch.phys_shift > max_ipa)
+		die("Requested PA size (%u) is not supported by the host (%ubits)\n",
+		    kvm->cfg.arch.phys_shift, max_ipa);
+
+	/*
+	 * Kernel not implementing the ioctl KVM_ARM_GET_MAX_VM_PHYS_SHIFT
+	 * will request to have kvm_arm_type zeroed and assume 40 bits IPA.
+	 */
+	if (kvm->cfg.arch.phys_shift != 40)
+		kvm_arm_type = kvm->cfg.arch.phys_shift;
+}
+
 bool kvm__arch_cpu_supports_vm(void)
 {
 	/* The KVM capability check is enough. */
-- 
2.11.0
