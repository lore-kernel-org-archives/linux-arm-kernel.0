From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Mon, 11 Jul 2016 12:29:02 -0000
Subject: [patch 56/66] arm64: armv8 deprecated: Convert to hotplug state
 machine
References: <20160711122450.923603742@linutronix.de>
Message-ID: <20160711122535.363008443@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Install the callbacks via the state machine.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/arm64/kernel/armv8_deprecated.c |   22 +++++-----------------
 include/linux/cpuhotplug.h           |    1 +
 2 files changed, 6 insertions(+), 17 deletions(-)

--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -121,7 +121,7 @@ static int run_all_cpu_set_hw_mode(struc
  *  0 		- If all the hooks ran successfully.
  * -EINVAL	- At least one hook is not supported by the CPU.
  */
-static int run_all_insn_set_hw_mode(unsigned long cpu)
+static int run_all_insn_set_hw_mode(unsigned int cpu)
 {
 	int rc = 0;
 	unsigned long flags;
@@ -131,7 +131,7 @@ static int run_all_insn_set_hw_mode(unsi
 	list_for_each_entry(insn, &insn_emulation, node) {
 		bool enable = (insn->current_mode == INSN_HW);
 		if (insn->ops->set_hw_mode && insn->ops->set_hw_mode(enable)) {
-			pr_warn("CPU[%ld] cannot support the emulation of %s",
+			pr_warn("CPU[%u] cannot support the emulation of %s",
 				cpu, insn->ops->name);
 			rc = -EINVAL;
 		}
@@ -617,20 +617,6 @@ static struct insn_emulation_ops setend_
 	.set_hw_mode = setend_set_hw_mode,
 };
 
-static int insn_cpu_hotplug_notify(struct notifier_block *b,
-			      unsigned long action, void *hcpu)
-{
-	int rc = 0;
-	if ((action & ~CPU_TASKS_FROZEN) == CPU_STARTING)
-		rc = run_all_insn_set_hw_mode((unsigned long)hcpu);
-
-	return notifier_from_errno(rc);
-}
-
-static struct notifier_block insn_cpu_hotplug_notifier = {
-	.notifier_call = insn_cpu_hotplug_notify,
-};
-
 /*
  * Invoked as late_initcall, since not needed before init spawned.
  */
@@ -649,7 +635,9 @@ static int __init armv8_deprecated_init(
 			pr_info("setend instruction emulation is not supported on the system");
 	}
 
-	register_cpu_notifier(&insn_cpu_hotplug_notifier);
+	cpuhp_setup_state_nocalls(CPUHP_AP_ARM64_ISNDEP_STARTING,
+				  "AP_ARM64_ISNDEP_STARTING",
+				  run_all_insn_set_hw_mode, NULL);
 	register_insn_emulation_sysctl(ctl_abi);
 
 	return 0;
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -56,6 +56,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_XEN_STARTING,
 	CPUHP_AP_ARM_CORESIGHT_STARTING,
 	CPUHP_AP_ARM_CORESIGHT4_STARTING,
+	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_LEDTRIG_STARTING,
 	CPUHP_AP_NOTIFY_STARTING,
 	CPUHP_AP_ONLINE,
