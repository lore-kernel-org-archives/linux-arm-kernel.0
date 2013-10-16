From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 15 Oct 2013 17:49:31 -0700
Subject: [PATCH 3/9] ARM64: KVM: Implement kvm_vcpu_preferred_target() function
In-Reply-To: <1381884577-24747-1-git-send-email-christoffer.dall@linaro.org>
References: <1381884577-24747-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1381884577-24747-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anup Patel <anup.patel@linaro.org>

This patch implements kvm_vcpu_preferred_target() function for
KVM ARM64 which will help us implement KVM_ARM_PREFERRED_TARGET
ioctl for user space.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h |    1 +
 arch/arm64/kvm/guest.c            |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 0859a4d..4cc8c70 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -151,6 +151,7 @@ struct kvm_vcpu_stat {
 struct kvm_vcpu_init;
 int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 			const struct kvm_vcpu_init *init);
+int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init);
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
 struct kvm_one_reg;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 2c3ff67..3f0731e 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -248,6 +248,26 @@ int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 	return kvm_reset_vcpu(vcpu);
 }
 
+int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
+{
+	int target = kvm_target_cpu();
+
+	if (target < 0)
+		return -ENODEV;
+
+	memset(init, 0, sizeof(*init));
+
+	/*
+	 * For now, we don't return any features.
+	 * In future, we might use features to return target
+	 * specific features available for the preferred
+	 * target type.
+	 */
+	init->target = (__u32)target;
+
+	return 0;
+}
+
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
 	return -EINVAL;
-- 
1.7.10.4
