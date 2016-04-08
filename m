From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri,  8 Apr 2016 11:52:15 +0200
Subject: [PULL 4/4] arm64: KVM: unregister notifiers in hyp mode teardown path
In-Reply-To: <1460109135-6612-1-git-send-email-christoffer.dall@linaro.org>
References: <1460109135-6612-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1460109135-6612-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <sudeep.holla@arm.com>

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
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index b538431..dded1b7 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1112,10 +1112,17 @@ static void __init hyp_cpu_pm_init(void)
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
@@ -1141,9 +1148,7 @@ static int init_subsystems(void)
 	/*
 	 * Register CPU Hotplug notifier
 	 */
-	cpu_notifier_register_begin();
-	err = __register_cpu_notifier(&hyp_init_cpu_nb);
-	cpu_notifier_register_done();
+	err = register_cpu_notifier(&hyp_init_cpu_nb);
 	if (err) {
 		kvm_err("Cannot register KVM init CPU notifier (%d)\n", err);
 		return err;
@@ -1193,6 +1198,8 @@ static void teardown_hyp_mode(void)
 	free_hyp_pgds();
 	for_each_possible_cpu(cpu)
 		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+	unregister_cpu_notifier(&hyp_init_cpu_nb);
+	hyp_cpu_pm_exit();
 }
 
 static int init_vhe_mode(void)
-- 
2.1.2.330.g565301e.dirty
