From: lina.iyer@linaro.org (Lina Iyer)
Date: Mon, 1 Dec 2014 11:50:23 -0700
Subject: [PATCH v13 03/10] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <5476E653.4040007@linaro.org>
References: <1417065854-37745-1-git-send-email-lina.iyer@linaro.org>
 <1417065854-37745-4-git-send-email-lina.iyer@linaro.org>
 <5476E653.4040007@linaro.org>
Message-ID: <20141201185023.GB499@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27 2014 at 01:52 -0700, Daniel Lezcano wrote:
>On 11/27/2014 06:24 AM, Lina Iyer wrote:

>+	static bool cpuidle_drv_init;
>
>        ^^^^^^^^^
>
>As already said in a previous comment, please find a way to remove that.
>
I will look into it. Stephen and I wanted the cpuidle driver to be
probed only after any of the SPMs are ready. And possibly, only for that
cpu, for which the SPM has been probed.

To achieve the SPM -> CPUIDLE Device relation, I havent found a good way
to do that. Without using CPUIDLE_MULTIPLE_DRIVERS, initializing each
cpuidle device, separate from the cpuidle driver, requires that I update 
the cpuidle_driver->cpumask after probing each SPM device, to allow for
only one driver and cpuidle devices only for the probed cpus. Using the
cpuidle_register_driver(), resets the drv->refcnt in
__cpuidle_driver_init.

I may need something like this in the else clause of CPUIDLE_MULTIPLE_DRIVERS -

static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
{
        struct cpuidle_driver *drv = cpuidle_curr_driver;

        if (drv && !cpumask_test_cpu(cpu, drv->cpumask))
                 drv = NULL;

        return drv;
}

void cpuidle_update_cpumask(struct cpumask *mask) {
        struct cpuidle_driver *drv;

        spin_lock(&cpuidle_driver_lock);
        drv = cpuidle_get_driver();
	if (drv)
		drv->cpumask = mask ?: cpu_possible_mask;
        spin_unlock(&cpuidle_driver_lock);
}

With that, I could register cpuidle driver the first time when the mask changes
from empty and consequent updates would just update the cpumask. (I am not
sure, if I missed anything in this change). It just seemed far too invasive at
this time, in lieu of the static bool.

>>+	const struct platform_device_info qcom_cpuidle_info = {
>>+		.name	= "qcom_cpuidle",
>>+		.id	= -1,
>>+		.data = &lpm_ops,
>>+		.size_data = sizeof(lpm_ops),
>>+	};
>>+
>>+	drv = spm_get_drv(pdev, &cpu);
>>+	if (!drv || cpu < 0)
>>+		return -EINVAL;
>
>As already said in a previous comment, it is not possible to have "cpu 
>< 0" with "drv != NULL", so except I am missing something the test 
>should be:
>
>	if (!drv)
>		return -EINVAL;
>
Sorry, done.

>There is something wrong with the init sequence. Don't you find weird 
>you have to backward search for the cpu belonging to the pdev each 
>time the probe function is called ?
>
>
Well, it was that or the SPM device node pointing to the CPU that it
references. It seems more common to have an iterator than the doubly
linked device nodes. I dont have a strong preference either way, just
chose the way that made device nodes easier.

>>+
>>+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>+	drv->reg_base = devm_ioremap_resource(&pdev->dev, res);
>>+	if (IS_ERR(drv->reg_base))
>>+		return PTR_ERR(drv->reg_base);
>>+
>>+	match_id = of_match_node(spm_match_table, pdev->dev.of_node);
>>+	if (!match_id)
>>+		return -ENODEV;
>>+
>>+	drv->reg_data = match_id->data;
>>+
>>+	/* Write the SPM sequences first.. */
>>+	addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
>>+	__iowrite32_copy(addr, drv->reg_data->seq,
>>+			ARRAY_SIZE(drv->reg_data->seq) / 4);
>>+
>>+	/*
>>+	 * ..and then the control registers.
>>+	 * On some SoC's if the control registers are written first and if the
>>+	 * CPU was held in reset, the reset signal could trigger the SPM state
>>+	 * machine, before the sequences are completely written.
>>+	 */
>>+	spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
>>+	spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
>>+	spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly);
>>+
>>+	spm_register_write(drv, SPM_REG_PMIC_DATA_0,
>>+				drv->reg_data->pmic_data[0]);
>>+	spm_register_write(drv, SPM_REG_PMIC_DATA_1,
>>+				drv->reg_data->pmic_data[1]);
>>+
>>+	/*
>>+	 * Ensure all observers see the above register writes before the
>>+	 * cpuidle driver is allowed to use the SPM.
>>+	 */
>>+	wmb();
>>+	per_cpu(cpu_spm_drv, cpu) = drv;
>>+
>>+	if (!cpuidle_drv_init) {
>>+		platform_device_register_full(&qcom_cpuidle_info);
>>+		cpuidle_drv_init = true;
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+static struct platform_driver spm_driver = {
>>+	.probe = spm_dev_probe,
>>+	.driver = {
>>+		.name = "saw",
>>+		.of_match_table = spm_match_table,
>>+	},
>>+};
>>+
>>+module_platform_driver(spm_driver);
>>+
>>+MODULE_LICENSE("GPL v2");
>>+MODULE_DESCRIPTION("SAW power controller driver");
>>+MODULE_ALIAS("platform:saw");
>>diff --git a/include/soc/qcom/pm.h b/include/soc/qcom/pm.h
>>new file mode 100644
>>index 0000000..d9a56d7
>>--- /dev/null
>>+++ b/include/soc/qcom/pm.h
>>@@ -0,0 +1,31 @@
>>+/*
>>+ * Copyright (c) 2009-2014, The Linux Foundation. All rights reserved.
>>+ *
>>+ * This software is licensed under the terms of the GNU General Public
>>+ * License version 2, as published by the Free Software Foundation, and
>>+ * may be copied, distributed, and modified under those terms.
>>+ *
>>+ * This program is distributed in the hope that it will be useful,
>>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>+ * GNU General Public License for more details.
>>+ *
>>+ */
>>+
>>+#ifndef __QCOM_PM_H
>>+#define __QCOM_PM_H
>>+
>>+enum pm_sleep_mode {
>>+	PM_SLEEP_MODE_STBY,
>>+	PM_SLEEP_MODE_RET,
>>+	PM_SLEEP_MODE_SPC,
>>+	PM_SLEEP_MODE_PC,
>>+	PM_SLEEP_MODE_NR,
>>+};
>>+
>>+struct qcom_cpu_pm_ops {
>>+	int (*standby)(void *data);
>>+	int (*spc)(void *data);
>>+};
>>+
>>+#endif  /* __QCOM_PM_H */
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
