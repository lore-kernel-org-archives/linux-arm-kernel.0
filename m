From: lina.iyer@linaro.org (Lina Iyer)
Date: Mon, 12 Oct 2015 08:56:40 -0600
Subject: [PATCH v2 1/2] ARM: cpuidle: remove cpu parameter from the
 cpuidle_ops suspend hook
In-Reply-To: <1444648628-24790-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1444648628-24790-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1444648628-24790-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20151012145640.GF921@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12 2015 at 05:16 -0600, Lorenzo Pieralisi wrote:
>The suspend() hook in the cpuidle_ops struct is always called on
>the cpu entering idle, which means that the cpu parameter passed
>to the suspend hook always corresponds to the local cpu, making
>it somewhat redundant.
>
>This patch removes the logical cpu parameter from the ARM
>cpuidle_ops.suspend hook and updates all the existing kernel
>implementations to reflect this change.
>
>Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>Cc: Lina Iyer <lina.iyer@linaro.org>
>Cc: Russell King <linux@arm.linux.org.uk>
>Cc: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Lina Iyer <lina.iyer@linaro.org>

>---
> arch/arm/include/asm/cpuidle.h |  2 +-
> arch/arm/kernel/cpuidle.c      |  2 +-
> drivers/soc/qcom/spm.c         | 10 +++++-----
> 3 files changed, 7 insertions(+), 7 deletions(-)
>
>diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
>index 0f84249..3848259 100644
>--- a/arch/arm/include/asm/cpuidle.h
>+++ b/arch/arm/include/asm/cpuidle.h
>@@ -30,7 +30,7 @@ static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> struct device_node;
>
> struct cpuidle_ops {
>-	int (*suspend)(int cpu, unsigned long arg);
>+	int (*suspend)(unsigned long arg);
> 	int (*init)(struct device_node *, int cpu);
> };
>
>diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
>index 318da33..703926e 100644
>--- a/arch/arm/kernel/cpuidle.c
>+++ b/arch/arm/kernel/cpuidle.c
>@@ -56,7 +56,7 @@ int arm_cpuidle_suspend(int index)
> 	int cpu = smp_processor_id();
>
> 	if (cpuidle_ops[cpu].suspend)
>-		ret = cpuidle_ops[cpu].suspend(cpu, index);
>+		ret = cpuidle_ops[cpu].suspend(index);
>
> 	return ret;
> }
>diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
>index b04b05a..0ad66fa 100644
>--- a/drivers/soc/qcom/spm.c
>+++ b/drivers/soc/qcom/spm.c
>@@ -116,7 +116,7 @@ static const struct spm_reg_data spm_reg_8064_cpu = {
>
> static DEFINE_PER_CPU(struct spm_driver_data *, cpu_spm_drv);
>
>-typedef int (*idle_fn)(int);
>+typedef int (*idle_fn)(void);
> static DEFINE_PER_CPU(idle_fn*, qcom_idle_ops);
>
> static inline void spm_register_write(struct spm_driver_data *drv,
>@@ -179,10 +179,10 @@ static int qcom_pm_collapse(unsigned long int unused)
> 	return -1;
> }
>
>-static int qcom_cpu_spc(int cpu)
>+static int qcom_cpu_spc(void)
> {
> 	int ret;
>-	struct spm_driver_data *drv = per_cpu(cpu_spm_drv, cpu);
>+	struct spm_driver_data *drv = __this_cpu_read(cpu_spm_drv);
>
> 	spm_set_low_power_mode(drv, PM_SLEEP_MODE_SPC);
> 	ret = cpu_suspend(0, qcom_pm_collapse);
>@@ -197,9 +197,9 @@ static int qcom_cpu_spc(int cpu)
> 	return ret;
> }
>
>-static int qcom_idle_enter(int cpu, unsigned long index)
>+static int qcom_idle_enter(unsigned long index)
> {
>-	return per_cpu(qcom_idle_ops, cpu)[index](cpu);
>+	return __this_cpu_read(qcom_idle_ops)[index]();
> }
>
> static const struct of_device_id qcom_idle_state_match[] __initconst = {
>-- 
>2.5.1
>
