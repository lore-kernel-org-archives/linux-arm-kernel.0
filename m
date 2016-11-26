From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Sun, 27 Nov 2016 00:13:44 +0100
Subject: [PATCH 16/22] arm64/cpuinfo: Convert to hotplug state machine
In-Reply-To: <20161126231350.10321-1-bigeasy@linutronix.de>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
Message-ID: <20161126231350.10321-17-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/kernel/cpuinfo.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 19aad7041e14..7b7be71e87bf 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -227,7 +227,7 @@ static struct attribute_group cpuregs_attr_group = {
 	.name = "identification"
 };
 
-static int cpuid_add_regs(int cpu)
+static int cpuid_cpu_online(unsigned int cpu)
 {
 	int rc;
 	struct device *dev;
@@ -248,7 +248,7 @@ static int cpuid_add_regs(int cpu)
 	return rc;
 }
 
-static int cpuid_remove_regs(int cpu)
+static int cpuid_cpu_offline(unsigned int cpu)
 {
 	struct device *dev;
 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
@@ -264,41 +264,22 @@ static int cpuid_remove_regs(int cpu)
 	return 0;
 }
 
-static int cpuid_callback(struct notifier_block *nb,
-			 unsigned long action, void *hcpu)
-{
-	int rc = 0;
-	unsigned long cpu = (unsigned long)hcpu;
-
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_ONLINE:
-	case CPU_DOWN_FAILED:
-		rc = cpuid_add_regs(cpu);
-		break;
-	case CPU_DOWN_PREPARE:
-		rc = cpuid_remove_regs(cpu);
-		break;
-	}
-
-	return notifier_from_errno(rc);
-}
-
 static int __init cpuinfo_regs_init(void)
 {
-	int cpu;
-
-	cpu_notifier_register_begin();
+	int cpu, ret;
 
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
 
 		kobject_init(&info->kobj, &cpuregs_kobj_type);
-		if (cpu_online(cpu))
-			cpuid_add_regs(cpu);
 	}
-	__hotcpu_notifier(cpuid_callback, 0);
 
-	cpu_notifier_register_done();
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/cpuinfo:online",
+				cpuid_cpu_online, cpuid_cpu_offline);
+	if (ret < 0) {
+		pr_err("cpuinfo: failed to register hotplug callbacks.\n");
+		return ret;
+	}
 	return 0;
 }
 static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
-- 
2.10.2
