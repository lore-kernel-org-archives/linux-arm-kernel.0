From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 25 Jul 2017 10:14:44 -0600
Subject: [PATCH v2 3/6] coresight: of: Use of_device_node_get_cpu helper
In-Reply-To: <1500892161-17634-4-git-send-email-suzuki.poulose@arm.com>
References: <1500892161-17634-1-git-send-email-suzuki.poulose@arm.com>
 <1500892161-17634-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkx_6vVgkra-3r-pq5WHFSvYcYfdCwoVANG3WC_KYTk_RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 July 2017 at 04:29, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> Reuse the new generic helper, of_device_node_get_cpu() to map a
> given CPU phandle to a logical CPU number.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/of_coresight.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index a187941..42ce9f8 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -16,6 +16,7 @@
>  #include <linux/clk.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/of_graph.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> @@ -104,26 +105,17 @@ static int of_coresight_alloc_memory(struct device *dev,
>  int of_coresight_get_cpu(const struct device_node *node)
>  {
>         int cpu;
> -       bool found;
> -       struct device_node *dn, *np;
> +       struct device_node *dn;
>
>         dn = of_parse_phandle(node, "cpu", 0);
> -
>         /* Affinity defaults to CPU0 */
>         if (!dn)
>                 return 0;
> -
> -       for_each_possible_cpu(cpu) {
> -               np = of_cpu_device_node_get(cpu);
> -               found = (dn == np);
> -               of_node_put(np);
> -               if (found)
> -                       break;
> -       }
> -       of_node_put(dn);
> -
> +       cpu = of_device_node_get_cpu(dn);
>         /* Affinity to CPU0 if no cpu nodes are found */
> -       return found ? cpu : 0;
> +       if (cpu >= nr_cpu_ids)
> +               return 0;
> +       return cpu;
>  }
>  EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
>

Acked-by: Mathieu Poirier <mathieu.poirier@linaro,org>

> --
> 2.7.5
>
