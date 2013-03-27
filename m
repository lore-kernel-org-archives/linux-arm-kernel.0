From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 27 Mar 2013 11:39:09 -0700
Subject: [PATCH V2 8/8] cpufreq: OMAP: donot allow to be used with device
 tree
In-Reply-To: <1363715590-5131-9-git-send-email-nm@ti.com> (Nishanth Menon's
 message of "Tue, 19 Mar 2013 12:53:10 -0500")
References: <1363715590-5131-1-git-send-email-nm@ti.com>
 <1363715590-5131-9-git-send-email-nm@ti.com>
Message-ID: <87vc8c7kmq.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> We now use Soc generic cpufreq-cpu0 driver using DT entries.
> However to allow cpufreq-cpu0 and omap-cpufreq drivers to co-exist,
> we need to ensure the following using the same image:
> 1. With device tree boot, we use cpufreq-cpu0
> 2. With non device tree boot, we use omap-cpufreq
>
> In the case of (1), we will have cpu OPPs and regulator registered
> as part of the DT, to ensure that omap-cpufreq and cpufreq-cpu0 don't
> conflict in managing the frequency of the same cpu, we should not
> permit init to pass in omap-cpufreq.
>
> In the case of (2), we will not have the cpufreq-cpu0 device, hence
> only omap-cpufreq will be active.
>
> So, to acommodate both these usage conditions, we fail init of
> omap-cpufreq when we boot with device tree.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: "Beno?t Cousson" <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: linux-omap at vger.kernel.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: cpufreq at vger.kernel.org
> Cc: linux-pm at vger.kernel.org
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes in V2:
> 	- donot remove support for omap-cpufreq in non-DT boot
> 	- little more verbose commit log
> V1: https://patchwork.kernel.org/patch/2273641/
>
>  drivers/cpufreq/omap-cpufreq.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> index 9128c07..9382ed0 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -22,6 +22,7 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
>  #include <linux/opp.h>
>  #include <linux/cpu.h>
>  #include <linux/module.h>
> @@ -174,6 +175,19 @@ static inline void freq_table_free(void)
>  static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int result = 0;
> +	struct device_node *np;
> +
> +	/*
> +	 * If we have a device tree node describing OPPs,
> +	 * we will NOT permit usage of omap-cpufreq driver.
> +	 * use cpufreq-cpu0 driver to manage.
> +	 */
> +	if (of_have_populated_dt()) {
> +		for_each_child_of_node(of_find_node_by_path("/cpus"), np) {
> +			if (of_get_property(np, "operating-points", NULL))
> +				return -EPERM;
> +		}
> +	}

I think it's much cleaner to just convert this to a platform_driver like
was done for the generic driver[1].  Then the registration in the
previous patch can register the omap driver when needed.

Kevin

[1] https://patchwork.kernel.org/patch/2067751/
