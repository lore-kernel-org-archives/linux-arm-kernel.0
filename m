From: anup.patel@linaro.org (Anup Patel)
Date: Mon, 30 Sep 2013 14:20:05 +0530
Subject: [PATCH v5 1/4] ARM: KVM: Implement kvm_vcpu_preferred_target()
 function
In-Reply-To: <1380531008-15901-1-git-send-email-anup.patel@linaro.org>
References: <1380531008-15901-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1380531008-15901-2-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements kvm_vcpu_preferred_target() function for
KVM ARM which will help us implement KVM_ARM_PREFERRED_TARGET ioctl
for user space.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/include/asm/kvm_host.h |    1 +
 arch/arm/kvm/guest.c            |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 7d22517..76f3c19 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -154,6 +154,7 @@ struct kvm_vcpu_stat {
 struct kvm_vcpu_init;
 int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 			const struct kvm_vcpu_init *init);
+int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init);
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
 struct kvm_one_reg;
diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index 152d036..21beea0 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -222,6 +222,26 @@ int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
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
1.7.9.5
