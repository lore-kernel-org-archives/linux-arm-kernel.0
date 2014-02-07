From: nm@ti.com (Nishanth Menon)
Date: Fri, 7 Feb 2014 10:16:44 -0600
Subject: [PATCH v3 1/7] cpufreq: cpufreq-cpu0: allow use of optional boost
 mode frequencies
In-Reply-To: <1391788548-13056-2-git-send-email-thomas.ab@samsung.com>
References: <1391788548-13056-1-git-send-email-thomas.ab@samsung.com>
 <1391788548-13056-2-git-send-email-thomas.ab@samsung.com>
Message-ID: <52F506EC.2070907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2014 09:55 AM, Thomas Abraham wrote:
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
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> index f055515..60f321a 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> @@ -19,6 +19,8 @@ Optional properties:
>  - cooling-min-level:
>  - cooling-max-level:
>       Please refer to Documentation/devicetree/bindings/thermal/thermal.txt.
> +- boost-frequency:
> +     Please refer to Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>  
>  Examples:
>  
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 4b029c0..52cc704 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -187,6 +187,7 @@ config GENERIC_CPUFREQ_CPU0
>  	tristate "Generic CPU0 cpufreq driver"
>  	depends on HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL
>  	select PM_OPP
> +	select CPU_FREQ_BOOST_SW
>  	help
>  	  This adds a generic cpufreq driver for CPU0 frequency management.
>  	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index 0c12ffc..06539eb 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -195,6 +195,9 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  			transition_latency += ret * 1000;
>  	}
>  
> +	if (of_find_property(cpu_dev->of_node, "boost-frequency", NULL))
> +		cpu0_cpufreq_driver.boost_supported = true;
> +
>  	ret = cpufreq_register_driver(&cpu0_cpufreq_driver);
>  	if (ret) {
>  		pr_err("failed register driver: %d\n", ret);
> 

might as well hide that under the opp api which returns a bool that
says if boost is supported or not. that allows the parse to be
isolated to a single location.

-- 
Regards,
Nishanth Menon
