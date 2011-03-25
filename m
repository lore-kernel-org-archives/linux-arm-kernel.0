From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 25 Mar 2011 08:30:54 +0100
Subject: [PATCHv6 4/4] ARM: mx51: Add support for low power suspend on MX51
In-Reply-To: <1300915676-10359-4-git-send-email-Dinh.Nguyen@freescale.com>
References: <1300915676-10359-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1300915676-10359-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1300915676-10359-3-git-send-email-Dinh.Nguyen@freescale.com>
	<1300915676-10359-4-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20110325073054.GE7285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2011 at 04:27:56PM -0500, Dinh.Nguyen at freescale.com wrote:
> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> 
> Adds initial low power suspend functionality to MX51.
> Supports "mem" and "standby" modes.
> 
> +
> +static int __init mx5_pm_init(void)
> +{
> +	if (gpc_dvfs_clk == NULL)
> +		gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
> +
> +	if (!IS_ERR(gpc_dvfs_clk)) {
> +		if (cpu_is_mx51())
> +			suspend_set_ops(&mx5_suspend_ops);
> +	} else {
> +		printk(KERN_ERR "Cannot enter SRPG suspend -no gpc_dvfs clock!\n");
> +		return -EPERM;

This will print a warning on every non i.MX51 machine, not a good idea.
Please just bail out early on irrelevant machines.

Sascha

> +	}
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
