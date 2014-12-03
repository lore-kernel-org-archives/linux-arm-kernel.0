From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 3 Dec 2014 07:31:22 -0700
Subject: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <547ED3BD.5090209@linaro.org>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org>
 <1417541958-56907-4-git-send-email-lina.iyer@linaro.org>
 <20141202230544.GG499@linaro.org> <547ED3BD.5090209@linaro.org>
Message-ID: <20141203143122.GH499@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03 2014 at 02:11 -0700, Daniel Lezcano wrote:
>On 12/03/2014 12:05 AM, Lina Iyer wrote:
>>On Tue, Dec 02 2014 at 10:40 -0700, Lina Iyer wrote:
>>+
>>[...]
>
>[ ... ]
>
>>>+static int __init qcom_spm_init(void)
>>>+{
>>>+    int ret;
>>>+
>>>+    /*
>>>+     * cpuidle driver need to registered before the cpuidle device
>>>+     * for any cpu. Register the device for the the cpuidle driver.
>>>+     */
>>>+    ret = platform_device_register(&qcom_cpuidle_drv);
>>>+    if (ret)
>>>+        return ret;
>>Stephen pointed out that we would have the platform device lying around
>>on a non-QCOM device when using multi_v7_defconfig.
>
>Perhaps I am missing the point, but this is not supposed to happen, no ?
>
This would happen, since the file would compile on multi_v7 and we would
initialize and register this device regardless. The cpuidle-qcom.c
driver probe would bail out looking for a matching compatible property.
So we would not register a cpuidle driver but the device would lay
around.

>>So instead of doing this here, we could do this in the probe..
>>
>>if (!cpuidle_get_driver()) {
>>         int ret = platform_device_register(&qcom_cpuidle_drv);
>>         if (ret)
>>                 return ret;
>>}
>>
>>Would that be okay?
>>
>>The successful probe indicates that we are on a QCOM SoC, and we have not
>>registered a cpuidle_driver before this.
>>
>>Thanks,
>>Lina
>>
>>>+
>>>+    return platform_driver_register(&spm_driver);
>>>+}
>>>+module_init(qcom_spm_init);
>>>+
>>>+MODULE_LICENSE("GPL v2");
>>>+MODULE_DESCRIPTION("SAW power controller driver");
>>>+MODULE_ALIAS("platform:saw");
>>>diff --git a/include/soc/qcom/pm.h b/include/soc/qcom/pm.h
>>>new file mode 100644
>>>index 0000000..d9a56d7
>>>--- /dev/null
>>>+++ b/include/soc/qcom/pm.h
>>>@@ -0,0 +1,31 @@
>>>+/*
>>>+ * Copyright (c) 2009-2014, The Linux Foundation. All rights reserved.
>>>+ *
>>>+ * This software is licensed under the terms of the GNU General Public
>>>+ * License version 2, as published by the Free Software Foundation, and
>>>+ * may be copied, distributed, and modified under those terms.
>>>+ *
>>>+ * This program is distributed in the hope that it will be useful,
>>>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>+ * GNU General Public License for more details.
>>>+ *
>>>+ */
>>>+
>>>+#ifndef __QCOM_PM_H
>>>+#define __QCOM_PM_H
>>>+
>>>+enum pm_sleep_mode {
>>>+    PM_SLEEP_MODE_STBY,
>>>+    PM_SLEEP_MODE_RET,
>>>+    PM_SLEEP_MODE_SPC,
>>>+    PM_SLEEP_MODE_PC,
>>>+    PM_SLEEP_MODE_NR,
>>>+};
>>>+
>>>+struct qcom_cpu_pm_ops {
>>>+    int (*standby)(void *data);
>>>+    int (*spc)(void *data);
>>>+};
>>>+
>>>+#endif  /* __QCOM_PM_H */
>>>--
>>>2.1.0
>>>
>
>
>-- 
> <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
>Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
><http://twitter.com/#!/linaroorg> Twitter |
><http://www.linaro.org/linaro-blog/> Blog
>
