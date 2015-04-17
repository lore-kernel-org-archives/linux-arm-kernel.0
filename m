From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 17 Apr 2015 17:49:03 -0600
Subject: [PATCH RFC 1/7] arm: Modify cpuidle_ops structures to match ARM64
In-Reply-To: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
References: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1429314549-6730-2-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SoC's tend to reuse the same hardware block for both ARM and ARM64 based
cpus. As such the idle setup and enter functions are generally common.
Using the same arguments as cpu_operations for cpuidle callbacks, allow
reuse of the same driver for many SoCs.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/include/asm/cpuidle.h | 4 ++--
 arch/arm/kernel/cpuidle.c      | 2 +-
 drivers/soc/qcom/spm.c         | 5 +++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 0f84249..08768da 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -30,8 +30,8 @@ static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
 struct device_node;
 
 struct cpuidle_ops {
-	int (*suspend)(int cpu, unsigned long arg);
-	int (*init)(struct device_node *, int cpu);
+	int (*suspend)(unsigned long arg);
+	int (*init)(struct device_node *, unsigned int cpu);
 };
 
 struct of_cpuidle_method {
diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index 318da33..703926e 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -56,7 +56,7 @@ int arm_cpuidle_suspend(int index)
 	int cpu = smp_processor_id();
 
 	if (cpuidle_ops[cpu].suspend)
-		ret = cpuidle_ops[cpu].suspend(cpu, index);
+		ret = cpuidle_ops[cpu].suspend(index);
 
 	return ret;
 }
diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index b562af8..5d0dd8c 100644
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
+static int __init qcom_cpuidle_init(struct device_node *cpu_node, u32 cpu)
 {
 	const struct of_device_id *match_id;
 	struct device_node *state_node;
-- 
2.1.0
