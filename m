From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 10 Feb 2014 09:20:20 +0100
Subject: [PATCH v3 1/7] cpufreq: cpufreq-cpu0: allow use of optional boost
 mode frequencies
In-Reply-To: <1391788548-13056-2-git-send-email-thomas.ab@samsung.com>
References: <1391788548-13056-1-git-send-email-thomas.ab@samsung.com>
 <1391788548-13056-2-git-send-email-thomas.ab@samsung.com>
Message-ID: <20140210092020.768f1c31@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> Lookup for the optional boost-frequency property in cpu0 node and if
> available, enable support for boost mode frequencies. The frequencies
> usable in boost mode are determined while preparing the cpufreq table
> from the list of operating points available.
> 
> In addition to this, enable the CPU_FREQ_BOOST_SW config option for
> this driver by default. On platforms that do not support boost mode,
> the boost mode frequencies will not be specified in cpu0 node and
> hence the boost mode support will not be enabled. Since this driver
> anyways depends on THERMAL config option, it is safe to enable
> CPU_FREQ_BOOST_SW config option as default.

I think that you introduce some implicit dependency here.

I don't like the idea to enable CPU_FREQ_BOOST_SW by default and depend
on other option (THERMAL in this case).
 
I think that user shall feel free to explicitly enable or disable boost
from menuconfig.

> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt |    2 ++
>  drivers/cpufreq/Kconfig                                    |    1 +
>  drivers/cpufreq/cpufreq-cpu0.c                             |    3 +++
>  3 files changed, 6 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt index
> f055515..60f321a 100644 ---
> a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt +++
> b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt @@ -19,6
> +19,8 @@ Optional properties:
>  - cooling-min-level:
>  - cooling-max-level:
>       Please refer to
> Documentation/devicetree/bindings/thermal/thermal.txt. +-
> boost-frequency:
> +     Please refer to
> Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt 
>  Examples:
>  
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 4b029c0..52cc704 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -187,6 +187,7 @@ config GENERIC_CPUFREQ_CPU0
>  	tristate "Generic CPU0 cpufreq driver"
>  	depends on HAVE_CLK && REGULATOR && OF && THERMAL &&
> CPU_THERMAL select PM_OPP
> +	select CPU_FREQ_BOOST_SW
>  	help
>  	  This adds a generic cpufreq driver for CPU0 frequency
> management. It supports both uniprocessor (UP) and symmetric
> multiprocessor (SMP) diff --git a/drivers/cpufreq/cpufreq-cpu0.c
> b/drivers/cpufreq/cpufreq-cpu0.c index 0c12ffc..06539eb 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -195,6 +195,9 @@ static int cpu0_cpufreq_probe(struct
> platform_device *pdev) transition_latency += ret * 1000;
>  	}
>  
> +	if (of_find_property(cpu_dev->of_node, "boost-frequency",
> NULL))
> +		cpu0_cpufreq_driver.boost_supported = true;
> +

This is also a bit misleading. Here you assume, that boost is supported
when somebody define "boost-frequency" DTS attribute. Conceptually the
boost is supported when user explicitly selects
CONFIG_CPU_FREQ_BOOST_SW.


I would prefer to see approach similar to the one now found at
exynos-cpufreq.c exynos_driver struct:

static struct cpufreq_driver cpu0_cpufreq_driver = {
	.flags = CPUFREQ_STICKY,
	.verify = cpu0_verify_speed,
	.target = cpu0_set_target,
	.get = cpu0_get_speed,
#ifdef CONFIG_CPU_FREQ_BOOST_SW
	.boost_supported = true,
#endif
	... other fields ...

and also, please remove references to
CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW flag since it will not be used
after the exynos cpufreq clean up.

>  	ret = cpufreq_register_driver(&cpu0_cpufreq_driver);
>  	if (ret) {
>  		pr_err("failed register driver: %d\n", ret);


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
