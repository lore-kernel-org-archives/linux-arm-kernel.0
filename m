From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Mon, 11 Jul 2016 12:28:29 -0000
Subject: [patch 07/66] ARM: mvebu: Convert to hotplug state machine
References: <20160711122450.923603742@linutronix.de>
Message-ID: <20160711122531.171995355@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Install the callbacks via the state machine.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/arm/mach-mvebu/coherency.c |   19 ++++++-------------
 include/linux/cpuhotplug.h      |    1 +
 2 files changed, 7 insertions(+), 13 deletions(-)

--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -111,20 +111,12 @@ static struct notifier_block mvebu_hwcc_
 	.notifier_call = mvebu_hwcc_notifier,
 };
 
-static int armada_xp_clear_shared_l2_notifier_func(struct notifier_block *nfb,
-					unsigned long action, void *hcpu)
+static int armada_xp_clear_l2_starting(unsigned int cpu)
 {
-	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
-		armada_xp_clear_shared_l2();
-
-	return NOTIFY_OK;
+	armada_xp_clear_shared_l2();
+	return 0;
 }
 
-static struct notifier_block armada_xp_clear_shared_l2_notifier = {
-	.notifier_call = armada_xp_clear_shared_l2_notifier_func,
-	.priority = 100,
-};
-
 static void __init armada_370_coherency_init(struct device_node *np)
 {
 	struct resource res;
@@ -155,8 +147,9 @@ static void __init armada_370_coherency_
 
 	of_node_put(cpu_config_np);
 
-	register_cpu_notifier(&armada_xp_clear_shared_l2_notifier);
-
+	cpuhp_setup_state_nocalls(CPUHP_AP_ARM_MVEBU_COHERENCY,
+				  "AP_ARM_MVEBU_COHERENCY",
+				  armada_xp_clear_l2_starting, NULL);
 exit:
 	set_cpu_coherent();
 }
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -15,6 +15,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_ARMADA_CASC_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
+	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_NOTIFY_STARTING,
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
