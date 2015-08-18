From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 18 Aug 2015 12:09:54 +0200
Subject: [RESEND PATCH 2/3 v6] cpufreq: mediatek: Add MT8173 cpufreq driver
In-Reply-To: <1439803465-19683-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
 <1439803465-19683-3-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <18468574.WHJNqYO5N4@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, August 17, 2015 05:24:24 PM Pi-Cheng Chen wrote:
> Mediatek MT8173 is an ARMv8 based quad-core (2*Cortex-A53 and
> 2*Cortex-A72) SoC with duall clusters. For each cluster, two voltage
> inputs, Vproc and Vsram are supplied by two regulators. For the big
> cluster, two regulators come from different PMICs. In this case, when
> scaling voltage inputs of the cluster, the voltages of two regulator
> inputs need to be controlled by software explicitly under the SoC
> specific limitation:
> 
> 	100mV < Vsram - Vproc < 200mV
> 
> which is called 'voltage tracking' mechanism. And when scaling the
> frequency of cluster clock input, the input MUX need to be parented to
> another "intermediate" stable PLL first and reparented to the original
> PLL once the original PLL is stable at the target frequency. This patch
> implements those mechanisms to enable CPU DVFS support for Mediatek
> MT8173 SoC.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm      |   7 +
>  drivers/cpufreq/Makefile         |   1 +
>  drivers/cpufreq/mt8173-cpufreq.c | 524 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 532 insertions(+)
>  create mode 100644 drivers/cpufreq/mt8173-cpufreq.c

[...]

> +static struct platform_driver mt8173_cpufreq_platdrv = {
> +	.driver = {
> +		.name	= "mt8173-cpufreq",
> +	},
> +	.probe		= mt8173_cpufreq_probe,
> +};
> +
> +static int mt8173_cpufreq_driver_init(void)
> +{
> +	struct platform_device *pdev;
> +	int err;
> +
> +	err = platform_driver_register(&mt8173_cpufreq_platdrv);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Since there's no place to hold device registration code and no
> +	 * device tree based way to match cpufreq driver yet, both the driver
> +	 * and the device registration codes are put here to handle defer
> +	 * probing.
> +	 */
> +	pdev = platform_device_register_simple("mt8173-cpufreq", -1, NULL, 0);

This is not very friendly for multiplatform support
(mt8173_cpufreq_driver_init() can be called on other platforms,
i.e. Samsung Exynos7 one if ARCH_EXYNOS7 is also enabled in
the kernel config).

Why can't it be fixed with checking Device Tree with
of_machine_is_compatible("mediatek,mt8173")
(assuming that it can be used on arm64 like on arm32)?

> +	if (IS_ERR(pdev)) {
> +		pr_err("failed to register mtk-cpufreq platform device\n");
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
> +device_initcall(mt8173_cpufreq_driver_init);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
