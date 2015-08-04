From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue,  4 Aug 2015 17:35:38 -0600
Subject: [PATCH 8/9] ARM64: smp: Add runtime PM support for CPU hotplug
In-Reply-To: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1438731339-58317-9-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable runtime PM for CPU devices. Do a runtime get of the CPU device
when the CPU is hotplugged in and runtime put of the CPU device when the
CPU is hotplugged off. When all the CPUs in a domain are hotplugged off,
the domain may also be powered off and cluster_pm_enter/exit()
notifications are be sent out.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/kernel/smp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index dbdaacd..fbeeffa 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -135,6 +135,7 @@ asmlinkage void secondary_start_kernel(void)
 {
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu = smp_processor_id();
+	struct device *cpu_dev;
 
 	/*
 	 * All kernel threads share the same mm context; grab a
@@ -185,6 +186,11 @@ asmlinkage void secondary_start_kernel(void)
 	local_irq_enable();
 	local_async_enable();
 
+	/* We are running, enable runtime PM for the CPU. */
+	cpu_dev = get_cpu_device(cpu);
+	if (cpu_dev)
+		pm_runtime_get_sync(cpu_dev);
+
 	/*
 	 * OK, it's off to the idle thread for us
 	 */
@@ -219,6 +225,9 @@ int __cpu_disable(void)
 	unsigned int cpu = smp_processor_id();
 	int ret;
 
+	/* We dont need the CPU device anymore. */
+	pm_runtime_put_sync(get_cpu_device(cpu));
+
 	ret = op_cpu_disable(cpu);
 	if (ret)
 		return ret;
@@ -293,6 +302,13 @@ void cpu_die(void)
 {
 	unsigned int cpu = smp_processor_id();
 
+	/*
+	 * We dont need the CPU device anymore.
+	 * Lets do this before IRQs are disabled to allow
+	 * runtime PM to suspend the domain as well.
+	 */
+	pm_runtime_put_sync(get_cpu_device(cpu));
+
 	idle_task_exit();
 
 	local_irq_disable();
-- 
2.1.4
