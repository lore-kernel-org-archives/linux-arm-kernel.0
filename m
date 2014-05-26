From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 May 2014 11:42:58 +0530
Subject: [PATCH v5 1/7] cpufreq: cpufreq-cpu0: allow use of optional boost
 mode frequencies
In-Reply-To: <1400855260-6807-2-git-send-email-thomas.ab@samsung.com>
References: <1400855260-6807-1-git-send-email-thomas.ab@samsung.com>
 <1400855260-6807-2-git-send-email-thomas.ab@samsung.com>
Message-ID: <CAKohpo=MhUdYK8jEmuOB=Nj9JPBqEoUnQB6SY3vQ35yfkduUVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 May 2014 19:57, Thomas Abraham <thomas.ab@samsung.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
>
> Lookup for the optional boost-frequency property in cpu0 node and if
> available, enable support for boost mode frequencies. The frequencies
> usable in boost mode are determined while preparing the cpufreq table
> from the list of operating points available.
>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |    2 ++
>  drivers/cpufreq/Kconfig                            |    1 +
>  drivers/cpufreq/cpufreq-cpu0.c                     |    3 +++
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
> index 1fbe11f..52741b9 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -187,6 +187,7 @@ config GENERIC_CPUFREQ_CPU0
>         tristate "Generic CPU0 cpufreq driver"
>         depends on HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL
>         select PM_OPP
> +       select CPU_FREQ_BOOST_SW

Drop this. Select it from your platform driver if you want.

>         help
>           This adds a generic cpufreq driver for CPU0 frequency management.
>           It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index 1bf6bba..93d3d6d 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -194,6 +194,9 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>                         transition_latency += ret * 1000;
>         }
>
> +       if (of_find_property(cpu_dev->of_node, "boost-frequencies", NULL))
> +               cpu0_cpufreq_driver.boost_supported = true;
> +
>         ret = cpufreq_register_driver(&cpu0_cpufreq_driver);
>         if (ret) {
>                 pr_err("failed register driver: %d\n", ret);
> --
> 1.7.9.5
>
