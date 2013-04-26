From: anup.patel@linaro.org (Anup Patel)
Date: Fri, 26 Apr 2013 19:02:16 +0530
Subject: [PATCH] arm64: KVM: Add kvm_target_timer_irq() for arch_timer
Message-ID: <1366983136-11147-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds kvm_target_timer_irq() for KVM ARM64 which determines guest virtual timer ppi number based on vcpu target type.

The patch also updates kvm_vcpu_reset() so that arch_timer is resetted on every vcpu reset.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h |    1 +
 arch/arm64/kvm/guest.c            |   17 +++++++++++++++++
 arch/arm64/kvm/reset.c            |   13 +++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 77eec44..23e185d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -43,6 +43,7 @@
 
 struct kvm_vcpu;
 int kvm_target_cpu(void);
+struct kvm_irq_level *kvm_target_timer_irq(struct kvm_vcpu *vcpu);
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
 int kvm_arch_dev_ioctl_check_extension(long ext);
 
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 8dc349b..ac9ec08 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -36,6 +36,11 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ NULL }
 };
 
+static struct kvm_irq_level target_cortex_a57_timer_irq = {
+	.irq = 27,
+	.level = 1,
+};
+
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
@@ -224,6 +229,18 @@ int __attribute_const__ kvm_target_cpu(void)
 	}
 }
 
+struct kvm_irq_level *kvm_target_timer_irq(struct kvm_vcpu *vcpu)
+{
+	switch (vcpu->arch.target) {
+	case KVM_ARM_TARGET_AEM_V8:
+	case KVM_ARM_TARGET_FOUNDATION_V8:
+	case KVM_ARM_TARGET_CORTEX_A57:
+		return &target_cortex_a57_timer_irq;
+	default:
+		return NULL;
+	};
+}
+
 int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 			const struct kvm_vcpu_init *init)
 {
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 64e0740..45f1f10 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -28,6 +28,14 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_coproc.h>
 
+#ifdef CONFIG_KVM_ARM_TIMER
+/*
+ * We cannont directly include arm/include/asm/kvm_arch_timer.h here so,
+ * forward declaring required functions
+ */
+extern int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu);
+#endif
+
 /*
  * ARMv8 Reset Values
  */
@@ -95,5 +103,10 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset system registers */
 	kvm_reset_sys_regs(vcpu);
 
+#ifdef CONFIG_KVM_ARM_TIMER
+	/* Reset arch_timer context */
+	return kvm_timer_vcpu_reset(vcpu);
+#else
 	return 0;
+#endif
 }
-- 
1.7.9.5
