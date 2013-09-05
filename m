From: anup.patel@linaro.org (Anup Patel)
Date: Thu,  5 Sep 2013 20:16:01 +0530
Subject: [RFC PATCH 2/3] ARM64: KVM: Implement target CPU=Host
In-Reply-To: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
References: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1378392362-6773-3-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements KVM_ARM_TARGET_HOST for KVM ARM64.

If user space provides KVM_ARM_TARGET_HOST as target type in
KVM_ARM_VCPU_INIT ioctl then we find out appropriate target
type based on underlying host and return that to user space
via struct kvm_vcpu_init.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h |    2 +-
 arch/arm64/include/uapi/asm/kvm.h |    2 +-
 arch/arm64/kvm/guest.c            |   10 ++++++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 0859a4d..9ee431c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -150,7 +150,7 @@ struct kvm_vcpu_stat {
 
 struct kvm_vcpu_init;
 int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
-			const struct kvm_vcpu_init *init);
+			struct kvm_vcpu_init *init);
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
 struct kvm_one_reg;
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index d9f026b..eeb5726 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -56,7 +56,7 @@ struct kvm_regs {
 #define KVM_ARM_TARGET_FOUNDATION_V8	1
 #define KVM_ARM_TARGET_CORTEX_A57	2
 #define KVM_ARM_TARGET_XGENE_POTENZA	3
-
+#define KVM_ARM_TARGET_HOST		0x0FFFFFFF
 #define KVM_ARM_NUM_TARGETS		4
 
 /* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index d7bf7d6..261e836 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -230,12 +230,18 @@ int __attribute_const__ kvm_target_cpu(void)
 }
 
 int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
-			const struct kvm_vcpu_init *init)
+			struct kvm_vcpu_init *init)
 {
 	unsigned int i;
 	int phys_target = kvm_target_cpu();
 
-	if (init->target != phys_target)
+	if (phys_target < 0) {
+		return phys_target;
+	}
+
+	if (init->target == KVM_ARM_TARGET_HOST)
+		init->target = phys_target;
+	else if (init->target != phys_target)
 		return -EINVAL;
 
 	vcpu->arch.target = phys_target;
-- 
1.7.9.5
