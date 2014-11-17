From: lina.iyer@linaro.org (Lina Iyer)
Date: Mon, 17 Nov 2014 11:30:41 -0700
Subject: [PATCH v9 6/9] qcom: cpuidle: Add cpuidle driver for QCOM cpus
In-Reply-To: <5469151A.20205@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
 <1414194024-55547-7-git-send-email-lina.iyer@linaro.org>
 <5469151A.20205@linaro.org>
Message-ID: <20141117183041.GG45276@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16 2014 at 14:20 -0700, Daniel Lezcano wrote:
>On 10/25/2014 01:40 AM, Lina Iyer wrote:
>>Add cpuidle driver interface to allow cpus to go into C-States. Use the
>>cpuidle DT interface, common across ARM architectures, to provide the
>>C-State information to the cpuidle framework.
>>
>>Supported modes at this time are Standby and Standalone Power Collapse.
>>
>>Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>
>A few comments below, otherwise it looks good to me.
>
>
>>---
>
>[ ... ]
>
>>+[1]. Documentation/devicetree/bindings/arm/idle-states.txt
>>diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>>index 8c16ab2..13c7c1f 100644
>>--- a/drivers/cpuidle/Kconfig.arm
>>+++ b/drivers/cpuidle/Kconfig.arm
>>@@ -63,3 +63,10 @@ config ARM_MVEBU_V7_CPUIDLE
>>  	depends on ARCH_MVEBU
>>  	help
>>  	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
>>+
>>+config ARM_QCOM_CPUIDLE
>>+	bool "CPU Idle drivers for Qualcomm processors"
>>+	depends on QCOM_PM
>
>Could you stick to the ARCH dependency as the other drivers ?
>
Sure

[...]
>>+static struct qcom_cpu_pm_ops *lpm_ops;
>>+
>>+static int qcom_cpu_stby(struct cpuidle_device *dev,
>>+				struct cpuidle_driver *drv, int index)
>>+{
>>+	lpm_ops->standby(NULL);
>
>No check ?
>
>>+	return index;
>>+}
>>+
>>+static int qcom_cpu_spc(struct cpuidle_device *dev,
>>+				struct cpuidle_driver *drv, int index)
>>+{
>>+	lpm_ops->spc(NULL);
>
>No check ?
>
Well, we didnt want a check in the line below 
lpm_ops = pdev->dev.platform_data;
The the check was not needed there since we are the ones creating
cpuidle device. Since this function will only be invoked when the probe
is successful and where we assume the lpm_ops to be populated correctly,
I dont see a need to check here..

>>+	return index;
>>+}
>>+
>>+static struct cpuidle_driver qcom_cpuidle_driver = {
>>+	.name	= "qcom_cpuidle",
>>+};
>>+
>>+static const struct of_device_id qcom_idle_state_match[] = {
>>+	{ .compatible = "qcom,idle-state-stby", .data = qcom_cpu_stby},
>>+	{ .compatible = "qcom,idle-state-spc", .data = qcom_cpu_spc },
>>+	{ },
>>+};
>>+
>>+static int qcom_cpuidle_probe(struct platform_device *pdev)
>>+{
>>+	struct cpuidle_driver *drv = &qcom_cpuidle_driver;
>>+	int ret;
>>+
>>+	lpm_ops = pdev->dev.platform_data;
>>+
>>+	/* Probe for other states, including standby */
>>+	ret = dt_init_idle_driver(drv, qcom_idle_state_match, 0);
>>+	if (ret < 0)
>>+		return ret;
>>+
>>+	return cpuidle_register(drv, NULL);
>>+}
>>+
>>+static struct platform_driver qcom_cpuidle_plat_driver = {
>>+	.probe	= qcom_cpuidle_probe,
>>+	.driver = {
>>+		.name = "qcom_cpuidle",
>>+	},
>>+};
>>+
>>+module_platform_driver(qcom_cpuidle_plat_driver);
>>
>
>
>-- 
> <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
>Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
><http://twitter.com/#!/linaroorg> Twitter |
><http://www.linaro.org/linaro-blog/> Blog
>
