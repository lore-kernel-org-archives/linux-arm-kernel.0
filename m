From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 08 Oct 2014 18:17:57 -0700
Subject: [PATCH v8 4/7] qcom: pm: Add cpu low power mode functions
In-Reply-To: <1412718106-17049-5-git-send-email-lina.iyer@linaro.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-5-git-send-email-lina.iyer@linaro.org>
Message-ID: <5435E245.1090507@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2014 02:41 PM, Lina Iyer wrote:

> +
> +static struct platform_device qcom_cpuidle_device = {
> +	.name              = "qcom_cpuidle",
> +	.id                = -1,
> +	.dev.platform_data = qcom_cpu_pm_enter_sleep,
> +};
> +

Same comment as last time, doesn't need to be static.

> +static int __init qcom_pm_device_init(void)
> +{
> +	platform_device_register(&qcom_cpuidle_device);
> +

This is wrong. We're going to register a platform device whenever this 
file is included in a kernel. This is then going to try and probe the 
qcom_cpuidle device which is going to fail and print an error message if 
we're not running on a qcom device. This is one reason why I've been 
arguing to get rid of this file and just put it inside the spm driver. 
That way we don't ever add the cpuidle device and:

  a) We know the SPM hardware is configured and ready to be used
  b) We don't get this annoying warning and have some weird device in 
sysfs on non-qcom devices


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
