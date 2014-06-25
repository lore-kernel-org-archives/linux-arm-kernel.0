From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 25 Jun 2014 13:34:56 +0530
Subject: [PATCH] ARM: shmobile: Remove opps table check for cpufreq
In-Reply-To: <53AA8130.2020304@bp.renesas.com>
References: <53AA8130.2020304@bp.renesas.com>
Message-ID: <CAKohpo=vEJ0chenDiPQiAMHUTmuRArQPAbG1ym94-9FN32z+DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 June 2014 13:28, Gaku Inami <gaku.inami.xw@bp.renesas.com> wrote:
> This patch is based on feedback from Viresh Kumar.
> Since cpufreq-cpu0 driver has already check opp table, there is no
> need to same check in mach-shmobile.
>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> ---
>
> Based on : renesas-devel-v3.16-rc2-20140623

I hope you have tested that this doesn't break it :)

>  arch/arm/mach-shmobile/cpufreq.c |   16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/cpufreq.c b/arch/arm/mach-shmobile/cpufreq.c
> index e2c868f..8a24b2b 100644
> --- a/arch/arm/mach-shmobile/cpufreq.c
> +++ b/arch/arm/mach-shmobile/cpufreq.c
> @@ -8,24 +8,10 @@
>   * for more details.
>   */
>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>
>  int __init shmobile_cpufreq_init(void)
>  {
> -       struct device_node *np;
> -
> -       np = of_cpu_device_node_get(0);
> -       if (np == NULL) {
> -               pr_err("failed to find cpu0 node\n");
> -               return 0;
> -       }
> -
> -       if (of_get_property(np, "operating-points", NULL))
> -               platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
> -
> -       of_node_put(np);
> -
> +       platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
>         return 0;
>  }

Now that there is nothing else in this file, do you really need a separate
file for cpufreq?

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
