From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 05 Apr 2017 10:03:45 +0200
Subject: [PATCH v2 2/4] cpufreq: imx6q: Set max suspend_freq to avoid
 changes during suspend
In-Reply-To: <5f61b819733127ddc7d41e82bf703a355c845b49.1491324640.git.leonard.crestez@nxp.com>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
 <5f61b819733127ddc7d41e82bf703a355c845b49.1491324640.git.leonard.crestez@nxp.com>
Message-ID: <1491379425.2904.0.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 04.04.2017, 20:04 +0300 schrieb Leonard Crestez:
> If the cpufreq driver tries to modify voltage/freq during suspend/resume
> it might need to control an external PMIC via I2C or SPI but those
> devices might be already suspended. This issue is likely to happen
> whenever the LDOs have their vin-supply set.
> 
> To avoid this scenario we just increase cpufreq to the maximum before
> suspend.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index be90ee3..786122e 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -161,8 +161,13 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  
>  static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>  {
> +	int ret;
> +
>  	policy->clk = arm_clk;
> -	return cpufreq_generic_init(policy, freq_table, transition_latency);
> +	ret = cpufreq_generic_init(policy, freq_table, transition_latency);
> +	policy->suspend_freq = policy->max;
> +
> +	return ret;
>  }
>  
>  static struct cpufreq_driver imx6q_cpufreq_driver = {
> @@ -173,6 +178,7 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
>  	.init = imx6q_cpufreq_init,
>  	.name = "imx6q-cpufreq",
>  	.attr = cpufreq_generic_attr,
> +	.suspend = cpufreq_generic_suspend,
>  };
>  
>  static int imx6q_cpufreq_probe(struct platform_device *pdev)
