From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Oct 2018 13:58:54 +0100
Subject: [PATCH 19/26] KVM: arm/arm64: Rename kvm_arm_config_vm to
 kvm_arm_setup_stage2
In-Reply-To: <20181019125901.185478-1-marc.zyngier@arm.com>
References: <20181019125901.185478-1-marc.zyngier@arm.com>
Message-ID: <20181019125901.185478-20-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VM tends to be a very overloaded term in KVM, so let's keep it
to describe the virtual machine. For the virtual memory setup,
let's use the "stage2" suffix.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 6 +++++-
 arch/arm64/include/asm/kvm_arm.h  | 2 +-
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/kvm/reset.c            | 2 +-
 virt/kvm/arm/arm.c                | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 72d46418e1ef..b45af481ccf7 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -354,8 +354,12 @@ static inline void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu) {}
 struct kvm *kvm_arch_alloc_vm(void);
 void kvm_arch_free_vm(struct kvm *kvm);
 
-static inline int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
+static inline int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 {
+	/*
+	 * On 32bit ARM, VMs get a static 40bit IPA stage2 setup,
+	 * so any non-zero value used as type is illegal.
+	 */
 	if (type)
 		return -EINVAL;
 	return 0;
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index f1330284720d..6e324d1f1231 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -133,7 +133,7 @@
  * 40 bits wide (T0SZ = 24).  Systems with a PARange smaller than 40 bits are
  * not known to exist and will break with this configuration.
  *
- * The VTCR_EL2 is configured per VM and is initialised in kvm_arm_config_vm().
+ * The VTCR_EL2 is configured per VM and is initialised in kvm_arm_setup_stage2().
  *
  * Note that when using 4K pages, we concatenate two first level page tables
  * together. With 16K pages, we concatenate 16 first level page tables.
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f008f8866b2a..376a5b695467 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -511,6 +511,6 @@ void kvm_set_ipa_limit(void);
 struct kvm *kvm_arch_alloc_vm(void);
 void kvm_arch_free_vm(struct kvm *kvm);
 
-int kvm_arm_config_vm(struct kvm *kvm, unsigned long type);
+int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type);
 
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 95f28d5950e0..aa806d582552 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -189,7 +189,7 @@ void kvm_set_ipa_limit(void)
  * all CPUs, as it is safe to run with or without the feature and
  * the bit is RES0 on CPUs that don't support it.
  */
-int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
+int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 {
 	u64 vtcr = VTCR_EL2_FLAGS;
 	u32 parange, phys_shift;
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 631f9a3ad99a..91c464c9cd21 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -120,7 +120,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	int ret, cpu;
 
-	ret = kvm_arm_config_vm(kvm, type);
+	ret = kvm_arm_setup_stage2(kvm, type);
 	if (ret)
 		return ret;
 
-- 
2.19.1
