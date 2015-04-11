From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 11 Apr 2015 08:32:58 +0530
Subject: [PATCH] cpufreq: fix qoriq uniprocessor build
In-Reply-To: <8186394.6fcP6P730e@wuerfel>
References: <8186394.6fcP6P730e@wuerfel>
Message-ID: <CAKohpomGUfYsuFnCN3y_=WOG44sbVNy4OFTQ6VFy+69dOhj9kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 April 2015 at 03:47, Arnd Bergmann <arnd@arndb.de> wrote:
> The qoriq-cpufreq driver contains a hack for powerpc to include
> asm/smp.h on uniprocessor builds so it can get the hardware CPU
> number. On ARM, it does not require this hack, but instead gets
> a compile error:
>
> In file included from drivers/cpufreq/qoriq-cpufreq.c:24:0:
> arch/arm/include/asm/smp.h:18:3: error: #error "<asm/smp.h> included in non-SMP build"
> arch/arm/include/asm/smp.h:21:0: warning: "raw_smp_processor_id" redefined
>
> This adds an #ifdef to mirror the one in its get_cpu_physical_id()
> function.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 2f249358eedaf ("cpufreq: qoriq: rename the driver")
> Cc: Tang Yuantian <Yuantian.Tang@freescale.com>
>
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 9fd51c860308..88b21ae0d6b0 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -21,7 +21,9 @@
>  #include <linux/slab.h>
>  #include <linux/smp.h>
>
> +#if !defined(CONFIG_ARM)
>  #include <asm/smp.h>   /* for get_hard_smp_processor_id() in UP configs */
> +#endif

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
