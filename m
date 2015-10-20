From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 20 Oct 2015 16:58:27 +0900
Subject: [PATCH 2/2] fixup! arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
References: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1445327907-23274-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch, kvm cannot start a guest when cpuidle is enabled
if the hardware does not retain cpu state (EL2) in idle state.

This patch re-initailizes EL2 state at CPU_PM_EXIT by calling
kvm_arch_hardware_enable() if and only if kvm has been initialized
before CPU_PM_ENTER, that is, if any vcpus have been created.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm/kvm/arm.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 0871809..fbff638 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -60,6 +60,8 @@ static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u8 kvm_next_vmid;
 static DEFINE_SPINLOCK(kvm_vmid_lock);
 
+static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
+
 static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(preemptible());
@@ -955,12 +957,27 @@ static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
 				    unsigned long cmd,
 				    void *v)
 {
-	if (cmd == CPU_PM_EXIT && kvm_arm_get_running_vcpu()) {
-		kvm_arch_hardware_enable();
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		if (__hyp_get_vectors() != hyp_default_vectors)
+			__this_cpu_write(kvm_arm_hardware_enabled, 1);
+		else
+			__this_cpu_write(kvm_arm_hardware_enabled, 0);
+		/*
+		 * don't call kvm_arch_hardware_disable() in case of
+		 * CPU_PM_ENTER because it does't actually save any state.
+		 */
+
+		return NOTIFY_OK;
+	case CPU_PM_EXIT:
+		if (__this_cpu_read(kvm_arm_hardware_enabled))
+			kvm_arch_hardware_enable();
+
 		return NOTIFY_OK;
-	}
 
-	return NOTIFY_DONE;
+	default:
+		return NOTIFY_DONE;
+	}
 }
 
 static struct notifier_block hyp_init_cpu_pm_nb = {
-- 
1.7.9.5
