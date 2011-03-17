From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 17 Mar 2011 09:21:06 +0100
Subject: [PATCHv3 3/3] ARM: mx51: Add support for low power suspend on MX51
In-Reply-To: <1300305787-7970-3-git-send-email-Dinh.Nguyen@freescale.com>
References: <1300305787-7970-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1300305787-7970-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1300305787-7970-3-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20110317082106.GT29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2011 at 03:03:07PM -0500, Dinh.Nguyen at freescale.com wrote:
> +
> +struct clk *gpc_dvfs_clk;
> +
> +static int mx5_suspend_enter(suspend_state_t state)
> +{
> +	if (gpc_dvfs_clk == NULL)
> +		gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs_clk");

clk_get can fail and NULL can be a valid clock.

Sascha

> +
> +	clk_enable(gpc_dvfs_clk);
> +	switch (state) {
> +	case PM_SUSPEND_MEM:
> +		mx5_cpu_lp_set(STOP_POWER_OFF);
> +		break;
> +	case PM_SUSPEND_STANDBY:
> +		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (state == PM_SUSPEND_MEM) {
> +		local_flush_tlb_all();
> +		flush_cache_all();
> +
> +		/*clear the EMPGC0/1 bits */
> +		__raw_writel(0, MXC_SRPG_EMPGC0_SRPGCR);
> +		__raw_writel(0, MXC_SRPG_EMPGC1_SRPGCR);
> +	}
> +	cpu_do_idle();
> +	clk_disable(gpc_dvfs_clk);
> +
> +	return 0;
> +}
> +
> +static int mx5_pm_valid(suspend_state_t state)
> +{
> +	return (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX);
> +}
> +
> +static const struct platform_suspend_ops mx5_suspend_ops = {
> +	.valid = mx5_pm_valid,
> +	.enter = mx5_suspend_enter,
> +};
> +
> +static int __init mx5_pm_init(void)
> +{
> +	if (cpu_is_mx51())
> +		suspend_set_ops(&mx5_suspend_ops);
> +
> +	return 0;
> +}
> +device_initcall(mx5_pm_init);
> -- 
> 1.6.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
