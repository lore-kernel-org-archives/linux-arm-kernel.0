From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed,  5 Aug 2015 10:32:39 -0600
Subject: [PATCH RFC 03/10] drivers: qcom: spm: Enable runtime suspend/resume
 of CPU PM domain
In-Reply-To: <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
References: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1438792366-2737-4-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On APQ8084 QCOM SoC's, the CPUs are powered by a single rail controlled
by the L2 cache power controller (L2 SPM). The L2 power domain supplies
power to all the CPUs and L2. It is safe to power down the domain when
all the CPUs and the L2 are powered down.

Powering down of the domain is done through the finite state machine on
the L2 SAW. The L2 SPM can be configured to enter an idle state, when
all CPUs enter their idle state. The L2 SPM state machine would turn off
the cache and possibly power off the power domain as well. The SPM also
guarantees that the h/w is ready for the CPU to resume, when woken up by
an interrupt.

Define a cluster that holds the SPM and possibly other common cluster
elements. The L2 SAW is also the genpd domain provider and the CPUs are
the devices attached to the domain. When CPUIdle powers down each CPU,
the ARM domain framework would callback to notify that the domain may be
powered off. Configure the L2 SPM at that time to flush the L2 cache and
turn off the CPU power rail.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/spm.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index efbf5e5..b6d75db 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -24,8 +24,11 @@
 #include <linux/platform_device.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
+#include <linux/pm_domain.h>
 #include <linux/qcom_scm.h>
 
+#include <asm/arm-pd.h>
+#include <asm/cacheflush.h>
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
@@ -132,6 +135,7 @@ static const struct spm_reg_data spm_reg_8064_cpu = {
 
 static DEFINE_PER_CPU(struct spm_driver_data *, cpu_spm_drv);
 static struct spm_driver_data *domain_spm;
+static int l2_flush_flag;
 
 typedef int (*idle_fn)(int);
 static DEFINE_PER_CPU(idle_fn*, qcom_idle_ops);
@@ -187,7 +191,14 @@ static void spm_set_low_power_mode(struct spm_driver_data *drv,
 
 static int qcom_pm_collapse(unsigned long int unused)
 {
-	qcom_scm_cpu_power_down(QCOM_SCM_CPU_PWR_DOWN_L2_ON);
+	/*
+	 * Flush the non-secure cache for Krait processors.
+	 * SCM will flush the secure cache.
+	 */
+	if (l2_flush_flag == QCOM_SCM_CPU_PWR_DOWN_L2_OFF)
+		flush_cache_all();
+
+	qcom_scm_cpu_power_down(l2_flush_flag);
 
 	/*
 	 * Returns here only if there was a pending interrupt and we did not
@@ -300,6 +311,33 @@ static struct cpuidle_ops qcom_cpuidle_ops __initdata = {
 CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v1, "qcom,kpss-acc-v1", &qcom_cpuidle_ops);
 CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v2, "qcom,kpss-acc-v2", &qcom_cpuidle_ops);
 
+static int pd_init(struct device_node *dn, struct generic_pm_domain *domain)
+{
+	return 0;
+}
+
+static int pd_power_on(struct generic_pm_domain *domain)
+{
+	l2_flush_flag = QCOM_SCM_CPU_PWR_DOWN_L2_ON;
+	spm_set_low_power_mode(domain_spm, PM_SLEEP_MODE_STBY);
+	return 0;
+}
+
+static int pd_power_off(struct generic_pm_domain *domain)
+{
+	l2_flush_flag = QCOM_SCM_CPU_PWR_DOWN_L2_OFF;
+	spm_set_low_power_mode(domain_spm, PM_SLEEP_MODE_SPC);
+	return 0;
+}
+
+static struct of_arm_pd_ops pd_ops __initdata = {
+	.init = pd_init,
+	.power_on = pd_power_on,
+	.power_off = pd_power_off,
+};
+
+ARM_PD_METHOD_OF_DECLARE(qcom_cpu_pd, "qcom,apq8084-saw2-v2.1-l2", &pd_ops);
+
 static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
 		int *index, bool *is_domain_spm)
 {
-- 
2.1.4
