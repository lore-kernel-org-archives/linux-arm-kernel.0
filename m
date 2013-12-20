From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Dec 2013 10:10:18 +0800
Subject: [PATCH v2 3/3] cpufreq: imx6q: add of_init_opp_table
In-Reply-To: <1387485338-21225-3-git-send-email-john.tobias.ph@gmail.com>
References: <1387485338-21225-1-git-send-email-john.tobias.ph@gmail.com>
 <1387485338-21225-3-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <20131220021017.GI7172@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 12:35:38PM -0800, John Tobias wrote:
> Add a routine check to see if the platform supplied the OPP table.
> Incase there's no OPP table exist, it will try to initialise it.
> 
> It's been tested on iMX6SL board where the platform doesn't have
> an OPP table.
> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 11 +++++++++++

Running get_maintainer.pl on the patch, you will see you should copy the
following person and lists on the patch.

 "Rafael J. Wysocki" <rjw@rjwysocki.net>
 Viresh Kumar <viresh.kumar@linaro.org>
 cpufreq at vger.kernel.org
 linux-pm at vger.kernel.org

This can also be found in file MAINTAINERS.

CPU FREQUENCY DRIVERS
M:      Rafael J. Wysocki <rjw@rjwysocki.net>
M:      Viresh Kumar <viresh.kumar@linaro.org>
L:      cpufreq at vger.kernel.org
L:      linux-pm at vger.kernel.org
S:      Maintained
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
T:      git git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
F:      drivers/cpufreq/
F:      include/linux/cpufreq.h

Shawn

>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 4b3f18e..8c56898 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -166,6 +166,17 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> +	/* Get the OPP table, if the platform did not supply it. */
> +	num = dev_pm_opp_get_opp_count(cpu_dev);
> +	if (num < 0) {
> +		ret = of_init_opp_table(cpu_dev);
> +		if (ret < 0) {
> +			dev_err(cpu_dev, "failed to init OPP table\n");
> +			ret = -ENODEV;
> +			goto put_node;
> +		}
> +	}
> +
>  	arm_clk = devm_clk_get(cpu_dev, "arm");
>  	pll1_sys_clk = devm_clk_get(cpu_dev, "pll1_sys");
>  	pll1_sw_clk = devm_clk_get(cpu_dev, "pll1_sw");
> -- 
> 1.8.3.2
> 
