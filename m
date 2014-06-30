From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 30 Jun 2014 16:07:27 +0200
Subject: [PATCH 07/16] ARM: mvebu: Make the CPU idle initialization more
 generic
In-Reply-To: <1403875377-940-8-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
 <1403875377-940-8-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140630160727.628e79c3@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

On Fri, 27 Jun 2014 15:22:48 +0200, Gregory CLEMENT wrote:

> +static bool (*mvebu_v7_cpu_idle_init)(void);
> +
> +static __init bool armada_xp_cpuidle_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
> +	if (!np)
> +		return false;
> +	of_node_put(np);
> +
> +	mvebu_v7_cpuidle_device.dev.platform_data = armada_xp_370_cpu_suspend;
> +	return true;
> +}
> +
> +static struct of_device_id of_cpuidle_table[] __initdata = {
> +	{ .compatible = "marvell,armadaxp",
> +	  .data = (void *)armada_xp_cpuidle_init,
> +	},
> +	{ /* end of list */ },
> +};
> +
>  static int __init mvebu_v7_cpu_pm_init(void)
>  {
>  	struct device_node *np;
> +	const struct of_device_id *match;
> +
> +	np = of_find_matching_node_and_match(NULL, of_cpuidle_table,
> +					&match);

I'm not sure I like using of_find_matching_node_and_match() on the
entire tree to find the root node compatible string. Wouldn't it be
simpler and shorter to just do:

	if (of_machine_is_compatible("marvell,armadaxp"))
		ret = armadaxp_cpuidle_init();
	else if (of_machine_is_compatible("marvell,armada370"))
		ret = armada370_cpuidle_init();
	else if (of_machine_is_compaitble("marvell,armada380"))
		ret = armada38x_cpuidle_init();

	if (ret)
		return ret;

Also, using a boolean to return a success/error status is not the
kernel way of doing things, you should use an int instead and use
proper error codes or return 0 on success.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
