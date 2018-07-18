From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 18 Jul 2018 10:19:03 +0100
Subject: [PATCH v4 20/20] kvm: arm64: Allow tuning the physical address size
 for VM
In-Reply-To: <1531905547-25478-1-git-send-email-suzuki.poulose@arm.com>
References: <1531905547-25478-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1531905547-25478-21-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow specifying the physical address size limit for a new
VM via the kvm_type argument for the KVM_CREATE_VM ioctl. This
allows us to finalise the stage2 page table as early as possible
and hence perform the right checks on the memory slots
without complication. The size is ecnoded as Log2(PA_Size) in
bits[7:0] of the type field. For backward compatibility the
value 0 is reserved and implies 40bits. Also, lift the limit
of the IPA to host limit and allow lower IPA sizes (e.g, 32).

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Cc: Peter Maydel <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Kr?m?? <rkrcmar@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
All,

This is not the final API. We are still evaluating the possible
options to create a VM and then configure the VM before any
resources can be allocated (e.g, devices, vCPUs or memory).
See [0] for discussion:

[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/587839.html
---
 Documentation/virtual/kvm/api.txt       |  4 ++++
 arch/arm64/include/asm/stage2_pgtable.h | 20 --------------------
 arch/arm64/kvm/guest.c                  |  3 ---
 include/uapi/linux/kvm.h                |  9 +++++++++
 virt/kvm/arm/arm.c                      | 16 ++++++++++++----
 5 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index d10944e..4e76e81 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -122,6 +122,10 @@ the default trap & emulate implementation (which changes the virtual
 memory layout to fit in user mode), check KVM_CAP_MIPS_VZ and use the
 flag KVM_VM_MIPS_VZ.
 
+On arm64, bits[7-0] of the machine type has been reserved for specifying
+the maximum physical address size for the VM. For backward compatibility,
+value 0 implies the default limit of 40bits.
+
 
 4.3 KVM_GET_MSR_INDEX_LIST, KVM_GET_MSR_FEATURE_INDEX_LIST
 
diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
index 6743b76..fbdfed7 100644
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
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 142e610..66fb20c 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -475,9 +475,6 @@ int kvm_arm_config_vm(struct kvm *kvm, u32 ipa_shift)
 	u64 parange;
 	u8 lvls = stage2_pgtable_levels(ipa_shift);
 
-	if (ipa_shift != KVM_PHYS_SHIFT)
-		return -EINVAL;
-
 	/*
 	 * Use a minimum 2 level page table to prevent splitting
 	 * host PMD huge pages@stage2.
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9a40d82..625a11e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -751,6 +751,15 @@ struct kvm_ppc_resize_hpt {
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
 /*
+ * On arm/arm64, machine type cane be used to request the physical
+ * address size for the VM. Bits[7-0] has been reserved for the PA
+ * size shift (i.e, log2(PA_Size)). For backward compatibility,
+ * value 0 implies the default IPA size, 40bits.
+ */
+#define KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK	0xff
+#define KVM_VM_TYPE_ARM_PHYS_SHIFT(x)		\
+	((x) & KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK)
+/*
  * ioctls for /dev/kvm fds:
  */
 #define KVM_GET_API_VERSION       _IO(KVMIO,   0x00)
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 220d886..a96205e 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -111,6 +111,17 @@ void kvm_arch_check_processor_compat(void *rtn)
 	*(int *)rtn = 0;
 }
 
+static int kvm_arch_config_vm(struct kvm *kvm, unsigned long type)
+{
+	u32 ipa_shift = KVM_VM_TYPE_ARM_PHYS_SHIFT(type);
+
+	if (!ipa_shift)
+		ipa_shift = KVM_PHYS_SHIFT;
+	if (ipa_shift > kvm_ipa_limit)
+		return -E2BIG;
+	return kvm_arm_config_vm(kvm, ipa_shift);
+}
+
 /**
  * kvm_arch_init_vm - initializes a VM data structure
  * @kvm:	pointer to the KVM struct
@@ -119,10 +130,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	int ret, cpu;
 
-	if (type)
-		return -EINVAL;
-
-	ret = kvm_arm_config_vm(kvm, KVM_PHYS_SHIFT);
+	ret = kvm_arch_config_vm(kvm, type);
 	if (ret)
 		return ret;
 
-- 
2.7.4
