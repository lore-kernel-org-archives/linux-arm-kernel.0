From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 23 Oct 2014 10:58:08 -0600
Subject: [PATCH v8 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
In-Reply-To: <5448E103.9070505@linaro.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-6-git-send-email-lina.iyer@linaro.org>
 <5448E103.9070505@linaro.org>
Message-ID: <20141023165808.GC30210@ilina-mac.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23 2014 at 05:05 -0600, Daniel Lezcano wrote:
>On 10/07/2014 11:41 PM, Lina Iyer wrote:
>>Add cpuidle driver interface to allow cpus to go into C-States. Use the
>>cpuidle DT interface, common across ARM architectures, to provide the
>>C-State information to the cpuidle framework.
>>
>>Supported modes at this time are Standby and Standalone Power Collapse.
>
>Why not the retention mode which is in between the standby and the 
>retention ?
>
Retention would appear 'hacky' in comparision to these code, and has
dependencies on clocks. So at some point, yes, I will submit a patch to
address this deficiency. 

>diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>>index 38cff69..6a9ee12 100644
>>--- a/drivers/cpuidle/Kconfig.arm
>>+++ b/drivers/cpuidle/Kconfig.arm
>>@@ -62,3 +62,10 @@ config ARM_MVEBU_V7_CPUIDLE
>>  	depends on ARCH_MVEBU
>>  	help
>>  	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
>>+
>>+config ARM_QCOM_CPUIDLE
>>+	bool "CPU Idle drivers for Qualcomm processors"
>>+	depends on QCOM_PM
>
>+ depends on ARCH_QCOM
>
I may have removed it, which I will check, QCOM_PM used to depend on
ARCH_QCOM

>+
>>+static void (*qcom_idle_enter)(enum pm_sleep_mode);
>>+
>>+static int qcom_lpm_enter_stby(struct cpuidle_device *dev,
>>+				struct cpuidle_driver *drv, int index)
>>+{
>>+	qcom_idle_enter(PM_SLEEP_MODE_STBY);
>
>Could you replace this function by a generic one ?
>
>It would be nice to have qcom_cpu_standby(void) and 
>qcom_cpu_powerdown(void) and let behind the mysterious words 'Single 
>Power Collapse' in the low level code which is qcom specific :)
>
>I guess you had to create a single "qcom_idle_enter" because of a 
>single pointer in the platform data. I am working on a common 
>structure to be shared across the drivers as a common way to pass the 
>different callbacks without including a soc specific header.
>
>struct cpuidle_ops {
>	int (*standby)(void *data);
>	int (*retention)(void *data);
>	int (*poweroff)(void *data);
>};
>
>So maybe you can either:
>
>1. wait I post this structure and provide the driver with this one
>2. create a similar structure and I will take care to upgrade when I 
>post the patchset with the common structure.
>
>The issue I see with this common structure is the initialization of 
>the qcom_idle_state_match array.
>
>>+	local_irq_enable();
>
>local_irq_enable() is handled by the cpuidle framework.
>Please remove all occurrences of this function in the driver otherwise 
>time measurement will include irq time processing and will no longer 
>be valid.
OK. Thanks for pointing that out.

>
>>+	return index;
>>+}
>>+
>>+static int qcom_lpm_enter_spc(struct cpuidle_device *dev,
>>+				struct cpuidle_driver *drv, int index)
>>+{
>>+	cpu_pm_enter();
>>+	qcom_idle_enter(PM_SLEEP_MODE_SPC);
>
>Where is cpu_suspend ?
>
Inside that function qcom_idle_enter() in the SoC layer (pm.c)

>>+	cpu_pm_exit();
>>+	local_irq_enable();
>>+
>>+	return index;
>>+}
>>+
>>+static struct cpuidle_driver qcom_cpuidle_driver = {
>>+	.name	= "qcom_cpuidle",
>>+};
>>+
>>+static const struct of_device_id qcom_idle_state_match[] = {
>>+	{ .compatible = "qcom,idle-state-stby", .data = qcom_lpm_enter_stby},
>>+	{ .compatible = "qcom,idle-state-spc", .data = qcom_lpm_enter_spc },
>>+	{ },
>>+};
>>+
>>+static int qcom_cpuidle_probe(struct platform_device *pdev)
>>+{
>>+	struct cpuidle_driver *drv = &qcom_cpuidle_driver;
>>+	int ret;
>>+
>>+	qcom_idle_enter = pdev->dev.platform_data;
>>+	if (!qcom_idle_enter)
>>+		return -EFAULT;
>
>It shouldn't fail because if the probe is called then the cpuidle 
>device was registered with its callback which is hardcoded.
>
Yeah, I see the paradigm shift. Even though I know how the caller is, I
am always backing up the expectation with an error check. Will remove
that.

>>+	 /* Probe for other states, including standby */
>>+	ret = dt_init_idle_driver(drv, qcom_idle_state_match, 0);
>
>Are you sure it is not worth to add the simple WFI state ? It may have 
>less latency than the standby mode, no ?
>
May be. But it would split the bucket between wfi and the cpu plus
allowing the L2 and the power hierarachy to enter their standby states.
This could very well be useful and possible, when there is a QoS request
that disallows power down and high latency states.
IMO, the benefit of the possible heirarchical standby seems to outweigh the
latency gain we may get by just doing a core's clock gating.

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
>
>
>-- 
> <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
>Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
><http://twitter.com/#!/linaroorg> Twitter |
><http://www.linaro.org/linaro-blog/> Blog
>
