From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  4 Apr 2016 14:46:51 +0100
Subject: [PATCH] arm64: KVM: unregister notifiers in hyp mode teardown path
Message-ID: <1459777611-22592-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1e947bad0b63 ("arm64: KVM: Skip HYP setup when already running
in HYP") re-organized the hyp init code and ended up leaving the CPU
hotplug and PM notifier even if hyp mode initialization fails.

Since KVM is not yet supported with ACPI, the above mentioned commit
breaks CPU hotplug in ACPI boot.

This patch fixes teardown_hyp_mode to properly unregister both CPU
hotplug and PM notifiers in the teardown path.

Fixes: 1e947bad0b63 ("arm64: KVM: Skip HYP setup when already running in HYP")
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/kvm/arm.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 6accd66d26f0..42b3a1f83271 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1101,10 +1101,17 @@ static void __init hyp_cpu_pm_init(void)
 {
 	cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
 }
+static void __init hyp_cpu_pm_exit(void)
+{
+	cpu_pm_unregister_notifier(&hyp_init_cpu_pm_nb);
+}
 #else
 static inline void hyp_cpu_pm_init(void)
 {
 }
+static inline void hyp_cpu_pm_exit(void)
+{
+}
 #endif
 
 static void teardown_common_resources(void)
@@ -1166,6 +1173,8 @@ static void teardown_hyp_mode(void)
 	free_hyp_pgds();
 	for_each_possible_cpu(cpu)
 		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+	unregister_cpu_notifier(&hyp_init_cpu_nb);
+	hyp_cpu_pm_exit();
 }
 
 static int init_vhe_mode(void)
@@ -1270,12 +1279,7 @@ static int init_hyp_mode(void)
 	free_boot_hyp_pgd();
 #endif
 
-	cpu_notifier_register_begin();
-
-	err = __register_cpu_notifier(&hyp_init_cpu_nb);
-
-	cpu_notifier_register_done();
-
+	err = register_cpu_notifier(&hyp_init_cpu_nb);
 	if (err) {
 		kvm_err("Cannot register HYP init CPU notifier (%d)\n", err);
 		goto out_err;
-- 
1.9.1
