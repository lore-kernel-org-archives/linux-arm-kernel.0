From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Oct 2018 13:58:53 +0100
Subject: [PATCH 18/26] kvm: arm64: Allow tuning the physical address size for
 VM
In-Reply-To: <20181019125901.185478-1-marc.zyngier@arm.com>
References: <20181019125901.185478-1-marc.zyngier@arm.com>
Message-ID: <20181019125901.185478-19-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Allow specifying the physical address size limit for a new
VM via the kvm_type argument for the KVM_CREATE_VM ioctl. This
allows us to finalise the stage2 page table as early as possible
and hence perform the right checks on the memory slots
without complication. The size is encoded as Log2(PA_Size) in
bits[7:0] of the type field. For backward compatibility the
value 0 is reserved and implies 40bits. Also, lift the limit
of the IPA to host limit and allow lower IPA sizes (e.g, 32).

The userspace could check the extension KVM_CAP_ARM_VM_IPA_SIZE
for the availability of this feature. The cap check returns the
maximum limit for the physical address shift supported by the host.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Kr?m?? <rkrcmar@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/virtual/kvm/api.txt       | 31 +++++++++++++++++++++++++
 arch/arm64/include/asm/stage2_pgtable.h | 20 ----------------
 arch/arm64/kvm/reset.c                  | 17 ++++++++++----
 include/uapi/linux/kvm.h                | 10 ++++++++
 4 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 647f94128a85..f6b0af55d010 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -123,6 +123,37 @@ memory layout to fit in user mode), check KVM_CAP_MIPS_VZ and use the
 flag KVM_VM_MIPS_VZ.
 
 
+On arm64, the physical address size for a VM (IPA Size limit) is limited
+to 40bits by default. The limit can be configured if the host supports the
+extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
+KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits) to set the size in the machine type
+identifier, where IPA_Bits is the maximum width of any physical
+address used by the VM. The IPA_Bits is encoded in bits[7-0] of the
+machine type identifier.
+
+e.g, to configure a guest to use 48bit physical address size :
+
+    vm_fd = ioctl(dev_fd, KVM_CREATE_VM, KVM_VM_TYPE_ARM_IPA_SIZE(48));
+
+The requested size (IPA_Bits) must be :
+  0 - Implies default size, 40bits (for backward compatibility)
+
+  or
+
+  N - Implies N bits, where N is a positive integer such that,
+      32 <= N <= Host_IPA_Limit
+
+Host_IPA_Limit is the maximum possible value for IPA_Bits on the host and
+is dependent on the CPU capability and the kernel configuration. The limit can
+be retrieved using KVM_CAP_ARM_VM_IPA_SIZE of the KVM_CHECK_EXTENSION
+ioctl()@run-time.
+
+Please note that configuring the IPA size does not affect the capability
+exposed by the guest CPUs in ID_AA64MMFR0_EL1[PARange]. It only affects
+size of the address translated by the stage2 level (guest physical to
+host physical address translations).
+
+
 4.3 KVM_GET_MSR_INDEX_LIST, KVM_GET_MSR_FEATURE_INDEX_LIST
 
 Capability: basic, KVM_CAP_GET_MSR_FEATURES for KVM_GET_MSR_FEATURE_INDEX_LIST
diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
index 2cce769ba4c6..d352f6df8d2c 100644
--- a/arch/arm64/include/asm/stage2_pgtable.h
+++ b/arch/arm64/include/asm/stage2_pgtable.h
@@ -42,28 +42,8 @@
  * the range (IPA_SHIFT, IPA_SHIFT - 4).
  */
 #define stage2_pgtable_levels(ipa)	ARM64_HW_PGTABLE_LEVELS((ipa) - 4)
-#define STAGE2_PGTABLE_LEVELS		stage2_pgtable_levels(KVM_PHYS_SHIFT)
 #define kvm_stage2_levels(kvm)		VTCR_EL2_LVLS(kvm->arch.vtcr)
 
-/*
- * With all the supported VA_BITs and 40bit guest IPA, the following condition
- * is always true:
- *
- *       STAGE2_PGTABLE_LEVELS <= CONFIG_PGTABLE_LEVELS
- *
- * We base our stage-2 page table walker helpers on this assumption and
- * fall back to using the host version of the helper wherever possible.
- * i.e, if a particular level is not folded (e.g, PUD) at stage2, we fall back
- * to using the host version, since it is guaranteed it is not folded@host.
- *
- * If the condition breaks in the future, we can rearrange the host level
- * definitions and reuse them for stage2. Till then...
- */
-#if STAGE2_PGTABLE_LEVELS > CONFIG_PGTABLE_LEVELS
-#error "Unsupported combination of guest IPA and host VA_BITS."
-#endif
-
-
 /* stage2_pgdir_shift() is the size mapped by top-level stage2 entry for the VM */
 #define stage2_pgdir_shift(kvm)		pt_levels_pgdir_shift(kvm_stage2_levels(kvm))
 #define stage2_pgdir_size(kvm)		(1ULL << stage2_pgdir_shift(kvm))
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index f156e45760bc..95f28d5950e0 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -89,6 +89,9 @@ int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_VCPU_EVENTS:
 		r = 1;
 		break;
+	case KVM_CAP_ARM_VM_IPA_SIZE:
+		r = kvm_ipa_limit;
+		break;
 	default:
 		r = 0;
 	}
@@ -192,17 +195,23 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
 	u32 parange, phys_shift;
 	u8 lvls;
 
-	if (type)
+	if (type & ~KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 		return -EINVAL;
 
+	phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(type);
+	if (phys_shift) {
+		if (phys_shift > kvm_ipa_limit ||
+		    phys_shift < 32)
+			return -EINVAL;
+	} else {
+		phys_shift = KVM_PHYS_SHIFT;
+	}
+
 	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 7;
 	if (parange > ID_AA64MMFR0_PARANGE_MAX)
 		parange = ID_AA64MMFR0_PARANGE_MAX;
 	vtcr |= parange << VTCR_EL2_PS_SHIFT;
 
-	phys_shift = id_aa64mmfr0_parange_to_phys_shift(parange);
-	if (phys_shift > KVM_PHYS_SHIFT)
-		phys_shift = KVM_PHYS_SHIFT;
 	vtcr |= VTCR_EL2_T0SZ(phys_shift);
 	/*
 	 * Use a minimum 2 level page table to prevent splitting
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 251be353f950..95aa73ca65dc 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -750,6 +750,15 @@ struct kvm_ppc_resize_hpt {
 
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
+/*
+ * On arm64, machine type can be used to request the physical
+ * address size for the VM. Bits[7-0] are reserved for the guest
+ * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
+ * value 0 implies the default IPA size, 40bits.
+ */
+#define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
+#define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
+	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 /*
  * ioctls for /dev/kvm fds:
  */
@@ -953,6 +962,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_NESTED_STATE 157
 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
 #define KVM_CAP_MSR_PLATFORM_INFO 159
+#define KVM_CAP_ARM_VM_IPA_SIZE 160 /* returns maximum IPA bits for a VM */
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.19.1
