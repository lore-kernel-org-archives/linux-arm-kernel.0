From: anup.patel@linaro.org (Anup Patel)
Date: Tue, 21 Jan 2014 18:31:40 +0530
Subject: [RFC PATCH 2/3] ARM/ARM64: KVM: Add support for PSCI v0.2 emulation
In-Reply-To: <1390309301-28424-1-git-send-email-anup.patel@linaro.org>
References: <1390309301-28424-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1390309301-28424-3-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the in-kernel PSCI emulation provides PSCI v0.1 interface to
VCPUs. This patch extends current in-kernel PSCI emulation to provide
PSCI v0.2 interface to VCPUs.

By default, ARM/ARM64 KVM will always provide PSCI v0.1 interface for
keeping the ABI backward-compatible.

To select PSCI v0.2 interface for VCPUs, the user space (i.e. QEMU or
KVMTOOL) will have to set KVM_ARM_VCPU_PSCI_0_2 feature when doing VCPU
init using KVM_ARM_VCPU_INIT ioctl.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/include/asm/kvm_host.h   |    2 +-
 arch/arm/include/uapi/asm/kvm.h   |   39 ++++++++++++++++--
 arch/arm/kvm/arm.c                |    6 ++-
 arch/arm/kvm/psci.c               |   79 ++++++++++++++++++++++++++++++-------
 arch/arm64/include/asm/kvm_host.h |    2 +-
 arch/arm64/include/uapi/asm/kvm.h |   39 ++++++++++++++++--
 6 files changed, 143 insertions(+), 24 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 8a6f6db..0239ac5 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -36,7 +36,7 @@
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #define KVM_HAVE_ONE_REG
 
-#define KVM_VCPU_MAX_FEATURES 1
+#define KVM_VCPU_MAX_FEATURES 2
 
 #include <kvm/arm_vgic.h>
 
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index c498b60..d9eb74c 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -83,6 +83,7 @@ struct kvm_regs {
 #define KVM_VGIC_V2_CPU_SIZE		0x2000
 
 #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
+#define KVM_ARM_VCPU_PSCI_0_2		1 /* CPU uses PSCI v0.2 */
 
 struct kvm_vcpu_init {
 	__u32 target;
@@ -164,7 +165,7 @@ struct kvm_arch_memory_slot {
 /* Highest supported SPI, from VGIC_NR_IRQS */
 #define KVM_ARM_IRQ_GIC_MAX		127
 
-/* PSCI interface */
+/* PSCI v0.1 interface */
 #define KVM_PSCI_FN_BASE		0x95c1ba5e
 #define KVM_PSCI_FN(n)			(KVM_PSCI_FN_BASE + (n))
 
@@ -173,9 +174,41 @@ struct kvm_arch_memory_slot {
 #define KVM_PSCI_FN_CPU_ON		KVM_PSCI_FN(2)
 #define KVM_PSCI_FN_MIGRATE		KVM_PSCI_FN(3)
 
+/* PSCI v0.2 interface */
+#define KVM_PSCI_0_2_FN_BASE		0x84000000
+#define KVM_PSCI_0_2_FN(n)		(KVM_PSCI_0_2_FN_BASE + (n))
+#define KVM_PSCI_0_2_FN64_BASE		0xC4000000
+#define KVM_PSCI_0_2_FN64(n)		(KVM_PSCI_0_2_FN64_BASE + (n))
+
+#define KVM_PSCI_0_2_FN_PSCI_VERSION	KVM_PSCI_0_2_FN(0)
+#define KVM_PSCI_0_2_FN_CPU_SUSPEND	KVM_PSCI_0_2_FN(1)
+#define KVM_PSCI_0_2_FN_CPU_OFF		KVM_PSCI_0_2_FN(2)
+#define KVM_PSCI_0_2_FN_CPU_ON		KVM_PSCI_0_2_FN(3)
+#define KVM_PSCI_0_2_FN_AFFINITY_INFO	KVM_PSCI_0_2_FN(4)
+#define KVM_PSCI_0_2_FN_MIGRATE		KVM_PSCI_0_2_FN(5)
+#define KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE \
+					KVM_PSCI_0_2_FN(6)
+#define KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU \
+					KVM_PSCI_0_2_FN(7)
+#define KVM_PSCI_0_2_FN_SYSTEM_OFF	KVM_PSCI_0_2_FN(8)
+#define KVM_PSCI_0_2_FN_SYSTEM_RESET	KVM_PSCI_0_2_FN(9)
+
+#define KVM_PSCI_0_2_FN64_CPU_SUSPEND	KVM_PSCI_0_2_FN64(1)
+#define KVM_PSCI_0_2_FN64_CPU_ON	KVM_PSCI_0_2_FN64(3)
+#define KVM_PSCI_0_2_FN64_AFFINITY_INFO	KVM_PSCI_0_2_FN64(4)
+#define KVM_PSCI_0_2_FN64_MIGRATE	KVM_PSCI_0_2_FN64(5)
+#define KVM_PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU \
+					KVM_PSCI_0_2_FN64(7)
+
+/* PSCI return values */
 #define KVM_PSCI_RET_SUCCESS		0
-#define KVM_PSCI_RET_NI			((unsigned long)-1)
-#define KVM_PSCI_RET_INVAL		((unsigned long)-2)
+#define KVM_PSCI_RET_NOT_SUPPORTED	((unsigned long)-1)
+#define KVM_PSCI_RET_INVALID_PARAMS	((unsigned long)-2)
 #define KVM_PSCI_RET_DENIED		((unsigned long)-3)
+#define KVM_PSCI_RET_ALREADY_ON		((unsigned long)-4)
+#define KVM_PSCI_RET_ON_PENDING		((unsigned long)-5)
+#define KVM_PSCI_RET_INTERNAL_FAILURE	((unsigned long)-6)
+#define KVM_PSCI_RET_NOT_PRESENT	((unsigned long)-7)
+#define KVM_PSCI_RET_DISABLED		((unsigned long)-8)
 
 #endif /* __ARM_KVM_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 2a700e0..0b7817a 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -193,6 +193,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
 	case KVM_CAP_ONE_REG:
 	case KVM_CAP_ARM_PSCI:
+	case KVM_CAP_ARM_PSCI_0_2:
 		r = 1;
 		break;
 	case KVM_CAP_COALESCED_MMIO:
@@ -483,7 +484,10 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	 * PSCI code.
 	 */
 	if (test_and_clear_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features)) {
-		*vcpu_reg(vcpu, 0) = KVM_PSCI_FN_CPU_OFF;
+		if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
+			*vcpu_reg(vcpu, 0) = KVM_PSCI_0_2_FN_CPU_OFF;
+		else
+			*vcpu_reg(vcpu, 0) = KVM_PSCI_FN_CPU_OFF;
 		kvm_psci_call(vcpu);
 	}
 
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 0881bf1..ee044a3 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -55,13 +55,13 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	}
 
 	if (!vcpu)
-		return KVM_PSCI_RET_INVAL;
+		return KVM_PSCI_RET_INVALID_PARAMS;
 
 	target_pc = *vcpu_reg(source_vcpu, 2);
 
 	wq = kvm_arch_vcpu_wq(vcpu);
 	if (!waitqueue_active(wq))
-		return KVM_PSCI_RET_INVAL;
+		return KVM_PSCI_RET_INVALID_PARAMS;
 
 	kvm_reset_vcpu(vcpu);
 
@@ -84,17 +84,49 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	return KVM_PSCI_RET_SUCCESS;
 }
 
-/**
- * kvm_psci_call - handle PSCI call if r0 value is in range
- * @vcpu: Pointer to the VCPU struct
- *
- * Handle PSCI calls from guests through traps from HVC instructions.
- * The calling convention is similar to SMC calls to the secure world where
- * the function number is placed in r0 and this function returns true if the
- * function number specified in r0 is withing the PSCI range, and false
- * otherwise.
- */
-bool kvm_psci_call(struct kvm_vcpu *vcpu)
+static bool kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
+{
+	unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
+	unsigned long val;
+
+	switch (psci_fn) {
+	case KVM_PSCI_0_2_FN_PSCI_VERSION:
+		/*
+		 * Bits[31:16] = Major Version = 0
+		 * Bits[15:0] = Minor Version = 2
+		 */
+		val = 2;
+		break;
+	case KVM_PSCI_0_2_FN_CPU_OFF:
+		kvm_psci_vcpu_off(vcpu);
+		val = KVM_PSCI_RET_SUCCESS;
+		break;
+	case KVM_PSCI_0_2_FN_CPU_ON:
+	case KVM_PSCI_0_2_FN64_CPU_ON:
+		val = kvm_psci_vcpu_on(vcpu);
+		break;
+	case KVM_PSCI_0_2_FN_CPU_SUSPEND:
+	case KVM_PSCI_0_2_FN_AFFINITY_INFO:
+	case KVM_PSCI_0_2_FN_MIGRATE:
+	case KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
+	case KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU:
+	case KVM_PSCI_0_2_FN_SYSTEM_OFF:
+	case KVM_PSCI_0_2_FN_SYSTEM_RESET:
+	case KVM_PSCI_0_2_FN64_CPU_SUSPEND:
+	case KVM_PSCI_0_2_FN64_AFFINITY_INFO:
+	case KVM_PSCI_0_2_FN64_MIGRATE:
+	case KVM_PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
+		val = KVM_PSCI_RET_NOT_SUPPORTED;
+		break;
+	default:
+		return false;
+	}
+
+	*vcpu_reg(vcpu, 0) = val;
+	return true;
+}
+
+static bool kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
 {
 	unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
 	unsigned long val;
@@ -109,9 +141,8 @@ bool kvm_psci_call(struct kvm_vcpu *vcpu)
 		break;
 	case KVM_PSCI_FN_CPU_SUSPEND:
 	case KVM_PSCI_FN_MIGRATE:
-		val = KVM_PSCI_RET_NI;
+		val = KVM_PSCI_RET_NOT_SUPPORTED;
 		break;
-
 	default:
 		return false;
 	}
@@ -119,3 +150,21 @@ bool kvm_psci_call(struct kvm_vcpu *vcpu)
 	*vcpu_reg(vcpu, 0) = val;
 	return true;
 }
+
+/**
+ * kvm_psci_call - handle PSCI call if r0 value is in range
+ * @vcpu: Pointer to the VCPU struct
+ *
+ * Handle PSCI calls from guests through traps from HVC instructions.
+ * The calling convention is similar to SMC calls to the secure world where
+ * the function number is placed in r0 and this function returns true if the
+ * function number specified in r0 is withing the PSCI range, and false
+ * otherwise.
+ */
+bool kvm_psci_call(struct kvm_vcpu *vcpu)
+{
+	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
+		return kvm_psci_0_2_call(vcpu);
+
+	return kvm_psci_0_1_call(vcpu);
+}
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 0a1d697..92242ce 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -39,7 +39,7 @@
 #include <kvm/arm_vgic.h>
 #include <kvm/arm_arch_timer.h>
 
-#define KVM_VCPU_MAX_FEATURES 2
+#define KVM_VCPU_MAX_FEATURES 3
 
 struct kvm_vcpu;
 int kvm_target_cpu(void);
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index d9f026b..0eb254d 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -77,6 +77,7 @@ struct kvm_regs {
 
 #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
 #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
+#define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
 
 struct kvm_vcpu_init {
 	__u32 target;
@@ -150,7 +151,7 @@ struct kvm_arch_memory_slot {
 /* Highest supported SPI, from VGIC_NR_IRQS */
 #define KVM_ARM_IRQ_GIC_MAX		127
 
-/* PSCI interface */
+/* PSCI v0.1 interface */
 #define KVM_PSCI_FN_BASE		0x95c1ba5e
 #define KVM_PSCI_FN(n)			(KVM_PSCI_FN_BASE + (n))
 
@@ -159,10 +160,42 @@ struct kvm_arch_memory_slot {
 #define KVM_PSCI_FN_CPU_ON		KVM_PSCI_FN(2)
 #define KVM_PSCI_FN_MIGRATE		KVM_PSCI_FN(3)
 
+/* PSCI v0.2 interface */
+#define KVM_PSCI_0_2_FN_BASE		0x84000000
+#define KVM_PSCI_0_2_FN(n)		(KVM_PSCI_0_2_FN_BASE + (n))
+#define KVM_PSCI_0_2_FN64_BASE		0xC4000000
+#define KVM_PSCI_0_2_FN64(n)		(KVM_PSCI_0_2_FN64_BASE + (n))
+
+#define KVM_PSCI_0_2_FN_PSCI_VERSION	KVM_PSCI_0_2_FN(0)
+#define KVM_PSCI_0_2_FN_CPU_SUSPEND	KVM_PSCI_0_2_FN(1)
+#define KVM_PSCI_0_2_FN_CPU_OFF		KVM_PSCI_0_2_FN(2)
+#define KVM_PSCI_0_2_FN_CPU_ON		KVM_PSCI_0_2_FN(3)
+#define KVM_PSCI_0_2_FN_AFFINITY_INFO	KVM_PSCI_0_2_FN(4)
+#define KVM_PSCI_0_2_FN_MIGRATE		KVM_PSCI_0_2_FN(5)
+#define KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE \
+					KVM_PSCI_0_2_FN(6)
+#define KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU \
+					KVM_PSCI_0_2_FN(7)
+#define KVM_PSCI_0_2_FN_SYSTEM_OFF	KVM_PSCI_0_2_FN(8)
+#define KVM_PSCI_0_2_FN_SYSTEM_RESET	KVM_PSCI_0_2_FN(9)
+
+#define KVM_PSCI_0_2_FN64_CPU_SUSPEND	KVM_PSCI_0_2_FN64(1)
+#define KVM_PSCI_0_2_FN64_CPU_ON	KVM_PSCI_0_2_FN64(3)
+#define KVM_PSCI_0_2_FN64_AFFINITY_INFO	KVM_PSCI_0_2_FN64(4)
+#define KVM_PSCI_0_2_FN64_MIGRATE	KVM_PSCI_0_2_FN64(5)
+#define KVM_PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU \
+					KVM_PSCI_0_2_FN64(7)
+
+/* PSCI return values */
 #define KVM_PSCI_RET_SUCCESS		0
-#define KVM_PSCI_RET_NI			((unsigned long)-1)
-#define KVM_PSCI_RET_INVAL		((unsigned long)-2)
+#define KVM_PSCI_RET_NOT_SUPPORTED	((unsigned long)-1)
+#define KVM_PSCI_RET_INVALID_PARAMS	((unsigned long)-2)
 #define KVM_PSCI_RET_DENIED		((unsigned long)-3)
+#define KVM_PSCI_RET_ALREADY_ON		((unsigned long)-4)
+#define KVM_PSCI_RET_ON_PENDING		((unsigned long)-5)
+#define KVM_PSCI_RET_INTERNAL_FAILURE	((unsigned long)-6)
+#define KVM_PSCI_RET_NOT_PRESENT	((unsigned long)-7)
+#define KVM_PSCI_RET_DISABLED		((unsigned long)-8)
 
 #endif
 
-- 
1.7.9.5
