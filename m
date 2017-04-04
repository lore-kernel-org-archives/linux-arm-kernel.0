From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 04 Apr 2017 11:51:40 +0200
Subject: [PATCH 3/5] cpufreq: imx6q: Set max suspend_freq to avoid
 changes during suspend
In-Reply-To: <94d99b261124b813adecf11e86a0ffe05c37f276.1490987945.git.leonard.crestez@nxp.com>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
 <94d99b261124b813adecf11e86a0ffe05c37f276.1490987945.git.leonard.crestez@nxp.com>
Message-ID: <1491299500.2367.16.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 31.03.2017, 22:25 +0300 schrieb Leonard Crestez:
> If the cpufreq driver tries to modify voltage/freq during suspend/resume
> it might need to control an external PMIC via I2C or SPI but those
> devices might be already suspended.
> 
> To avoid this scenario we just increase cpufreq to highest setpoint
> before suspend. This issue can easily be triggered by ldo-bypass but in
> theory any regulator set_voltage call can end up having to modify
> external supply voltages.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index be90ee3..e2c1fbf 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -162,6 +162,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	policy->clk = arm_clk;
> +	policy->suspend_freq = freq_table[soc_opp_count - 1].frequency;

I think soc_opp_count includes all OPPs from the DT, some of which might
be disabled based on the fuse settings of the SoC. So this should
probably not switch to the highest OPP unconditionally, but rather
switch to the highest _enabled_ OPP.

Regards,
Lucas
 
>  	return cpufreq_generic_init(policy, freq_table, transition_latency);
>  }
>  
> @@ -173,6 +174,7 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
>  	.init = imx6q_cpufreq_init,
>  	.name = "imx6q-cpufreq",
>  	.attr = cpufreq_generic_attr,
> +	.suspend = cpufreq_generic_suspend,
>  };
>  
>  static int imx6q_cpufreq_probe(struct platform_device *pdev)
