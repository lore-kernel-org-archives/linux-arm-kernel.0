From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed,  5 Aug 2015 10:32:37 -0600
Subject: [PATCH RFC 01/10] drivers: qcom: spm: Support cache SPMs
In-Reply-To: <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
References: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1438792366-2737-2-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recognize cache SPM devices defined in the DT and configure the
corresponding SPM hardware. SPM controllers for L2 controls the cache's
idle low power state and may also be used to turn off the CPU power
rail.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <agross@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/spm.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index b04b05a..9f5edaa27 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -115,6 +115,7 @@ static const struct spm_reg_data spm_reg_8064_cpu = {
 };
 
 static DEFINE_PER_CPU(struct spm_driver_data *, cpu_spm_drv);
+static struct spm_driver_data *domain_spm;
 
 typedef int (*idle_fn)(int);
 static DEFINE_PER_CPU(idle_fn*, qcom_idle_ops);
@@ -283,13 +284,18 @@ CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v1, "qcom,kpss-acc-v1", &qcom_cpuidle_ops);
 CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v2, "qcom,kpss-acc-v2", &qcom_cpuidle_ops);
 
 static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
-		int *spm_cpu)
+		int *index, bool *is_domain_spm)
 {
 	struct spm_driver_data *drv = NULL;
 	struct device_node *cpu_node, *saw_node;
 	int cpu;
 	bool found;
 
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return ERR_PTR(-ENOMEM);
+
+	/* Check for a CPU SPM, if found we are done */
 	for_each_possible_cpu(cpu) {
 		cpu_node = of_cpu_device_node_get(cpu);
 		if (!cpu_node)
@@ -302,11 +308,14 @@ static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
 			break;
 	}
 
-	if (found) {
-		drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
-		if (drv)
-			*spm_cpu = cpu;
-	}
+	/* 
+	 * If found, we have a CPU SPM, if not,
+	 * we have a cache SPM
+	 */
+	if (found)
+		*index = cpu;
+
+	*is_domain_spm = !found;
 
 	return drv;
 }
@@ -327,21 +336,22 @@ static int spm_dev_probe(struct platform_device *pdev)
 	struct resource *res;
 	const struct of_device_id *match_id;
 	void __iomem *addr;
-	int cpu;
+	int index;
+	bool is_domain_spm;
 
-	drv = spm_get_drv(pdev, &cpu);
-	if (!drv)
-		return -EINVAL;
+	match_id = of_match_node(spm_match_table, pdev->dev.of_node);
+	if (!match_id)
+		return -ENODEV;
+
+	drv = spm_get_drv(pdev, &index, &is_domain_spm);
+	if (IS_ERR(drv))
+		return PTR_ERR(drv);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	drv->reg_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(drv->reg_base))
 		return PTR_ERR(drv->reg_base);
 
-	match_id = of_match_node(spm_match_table, pdev->dev.of_node);
-	if (!match_id)
-		return -ENODEV;
-
 	drv->reg_data = match_id->data;
 
 	/* Write the SPM sequences first.. */
@@ -366,8 +376,13 @@ static int spm_dev_probe(struct platform_device *pdev)
 	/* Set up Standby as the default low power mode */
 	spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
 
-	per_cpu(cpu_spm_drv, cpu) = drv;
+	/* We are ready to use the CPU/Cache SPM. */
+	if (is_domain_spm)
+		domain_spm = drv;
+	else
+		per_cpu(cpu_spm_drv, index) = drv;
 
+	dev_dbg(&pdev->dev, "SPM device probed.\n");
 	return 0;
 }
 
-- 
2.1.4
