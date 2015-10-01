From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  1 Oct 2015 09:58:52 +0100
Subject: [PATCH 1/2] ARM: cpuidle: make cpuidle_ops interfaces ARM64 compliant
In-Reply-To: <1443689933-28882-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1443689933-28882-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1443689933-28882-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for sharing PSCI idle operations on ARM and ARM64,
this patch refines the ARM cpuidle_ops interfaces so that the
two arches can use the same interfaces seamlessly.

Based-on-patch-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Lina Iyer <lina.iyer@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/include/asm/cpuidle.h | 4 ++--
 arch/arm/kernel/cpuidle.c      | 4 ++--
 drivers/soc/qcom/spm.c         | 9 +++++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 0f84249..ee36dd4 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -30,8 +30,8 @@ static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
 struct device_node;
 
 struct cpuidle_ops {
-	int (*suspend)(int cpu, unsigned long arg);
-	int (*init)(struct device_node *, int cpu);
+	int (*suspend)(unsigned long arg);
+	int (*init)(unsigned int cpu);
 };
 
 struct of_cpuidle_method {
diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index 318da33..a75b7ae 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -56,7 +56,7 @@ int arm_cpuidle_suspend(int index)
 	int cpu = smp_processor_id();
 
 	if (cpuidle_ops[cpu].suspend)
-		ret = cpuidle_ops[cpu].suspend(cpu, index);
+		ret = cpuidle_ops[cpu].suspend(index);
 
 	return ret;
 }
@@ -144,7 +144,7 @@ int __init arm_cpuidle_init(int cpu)
 
 	ret = arm_cpuidle_read_ops(cpu_node, cpu);
 	if (!ret && cpuidle_ops[cpu].init)
-		ret = cpuidle_ops[cpu].init(cpu_node, cpu);
+		ret = cpuidle_ops[cpu].init(cpu);
 
 	of_node_put(cpu_node);
 
diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index b04b05a..8deaea0 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -197,8 +197,9 @@ static int qcom_cpu_spc(int cpu)
 	return ret;
 }
 
-static int qcom_idle_enter(int cpu, unsigned long index)
+static int qcom_idle_enter(unsigned long index)
 {
+	int cpu = smp_processor_id();
 	return per_cpu(qcom_idle_ops, cpu)[index](cpu);
 }
 
@@ -207,7 +208,7 @@ static const struct of_device_id qcom_idle_state_match[] __initconst = {
 	{ },
 };
 
-static int __init qcom_cpuidle_init(struct device_node *cpu_node, int cpu)
+static int __init qcom_cpuidle_init(unsigned int cpu)
 {
 	const struct of_device_id *match_id;
 	struct device_node *state_node;
@@ -217,6 +218,10 @@ static int __init qcom_cpuidle_init(struct device_node *cpu_node, int cpu)
 	idle_fn *fns;
 	cpumask_t mask;
 	bool use_scm_power_down = false;
+	struct device_node *cpu_node = of_get_cpu_node(cpu, NULL);
+
+	if (!cpu_node)
+		return -ENODEV;
 
 	for (i = 0; ; i++) {
 		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
-- 
2.5.1
