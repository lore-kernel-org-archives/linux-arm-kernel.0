From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 Jan 2013 19:28:59 +0800
Subject: [PATCH 2/3] cpufreq: add imx6q-cpufreq driver
In-Reply-To: <20130108085756.GM1906@pengutronix.de>
References: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
 <1357628043-19256-3-git-send-email-shawn.guo@linaro.org>
 <20130108085756.GM1906@pengutronix.de>
Message-ID: <20130108112856.GA19534@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 09:57:56AM +0100, Sascha Hauer wrote:
...
> > +	/* scaling up?  scale voltage before frequency */
> > +	if (freqs.new > freqs.old) {
> > +		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> > +		if (ret) {
> > +			pr_err("failed to scale voltage up: %d\n", ret);
> > +			freqs.new = freqs.old;
> > +			return ret;
> > +		}
> 
> So this regulator_set_voltage_tol can fail, ...
> 
> > +
> > +		/*
> > +		 * Need to increase vddpu and vddsoc for safety
> > +		 * if we are about to run at 1.2 GHz.
> > +		 */
> > +		if (freqs.new == FREQ_1P2_GHZ / 1000) {
> > +			regulator_set_voltage_tol(pu_reg,
> > +					PU_SOC_VOLTAGE_HIGH, 0);
> > +			regulator_set_voltage_tol(soc_reg,
> > +					PU_SOC_VOLTAGE_HIGH, 0);
> 
> ... but these can't?
> 
I initially have return of every single clk and regulator API call
checked and try to recover everything for error cases.  The driver
becomes messy and hard to read with error message and recovering
code all over the places.  And I think it's a little bit over
engineering, so end up choosing to check on selected and critical
part to make sure clk and regulator subsystem work good.

> > +		}
> > +	}
> > +
> > +	/*
> > +	 * The setpoints are selected per PLL/PDF frequencies, so we need to
> > +	 * reprogram PLL for frequency scaling.  The procedure of reprogramming
> > +	 * PLL1 is as blow.
> 
> s/blow/below/
> 
Thanks.

> > +	 *
> > +	 *  - Enable pll2_pfd2_396m_clk and reparent pll1_sw_clk to it
> > +	 *  - Disable pll1_sys_clk and reprogram it
> > +	 *  - Enable pll1_sys_clk and reparent pll1_sw_clk back to it
> > +	 *  - Disable pll2_pfd2_396m_clk
> > +	 */
> 
> [...]
> 
> > +
> > +static struct cpufreq_driver imx6q_cpufreq_driver = {
> > +	.verify = imx6q_verify_speed,
> > +	.target = imx6q_set_target,
> > +	.get = imx6q_get_speed,
> > +	.init = imx6q_cpufreq_init,
> > +	.exit = imx6q_cpufreq_exit,
> > +	.name = "imx6q-cpufreq",
> > +	.attr = imx6q_cpufreq_attr,
> > +};
> > +
> > +static int imx6q_cpufreq_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *np;
> > +	int ret;
> > +
> > +	np = of_find_node_by_path("/cpus/cpu at 0");
> > +	if (!np) {
> > +		pr_err("failed to find cpu0 node\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	cpu_dev = get_cpu_device(0);
> > +	if (!cpu_dev) {
> > +		pr_err("failed to get cpu0 device\n");
> 
> Since you have a struct device * you should use it throughout the driver
> to give the messages a bit more context.
> 
In that case, the context will be "cpu cpu0: ...", while we have the
context be "imx6q-cpufreq: ..." right now, since we have the following
line at the very beginning of the code.

#define pr_fmt(fmt)     KBUILD_MODNAME ": " fmt

I think we have a better context with pr_* than dev_* in this case.

> > +		ret = -ENODEV;
> > +		goto put_node;
> > +	}
> > +
> > +	cpu_dev->of_node = np;
> > +
> > +	arm_clk = clk_get(cpu_dev, "arm");
> > +	pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
> > +	pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
> > +	step_clk = clk_get(cpu_dev, "step");
> > +	pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
> 
> devm_*?
> 
That what I tried to do at the first time.  But the dev of cpu is
special, and managed functions do not work as we expect with it.

Shawn
