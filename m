From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 26 Mar 2014 07:30:25 -0300
Subject: [PATCH v5 14/14] ARM: mvebu: register the cpuidle driver for the
 Armada XP SoCs
In-Reply-To: <1395787705-31061-15-git-send-email-gregory.clement@free-electrons.com>
References: <1395787705-31061-1-git-send-email-gregory.clement@free-electrons.com>
 <1395787705-31061-15-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140326103025.GD941@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Mar 25, Gregory CLEMENT wrote:
> @@ -285,4 +290,21 @@ static struct notifier_block armada_370_xp_cpu_pm_notifier = {
>  	.notifier_call = armada_370_xp_cpu_pm_notify,
>  };
>  
> +int __init armada_370_xp_cpu_pm_init(void)
> +{
> +	if (!((of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu") ||
> +				of_find_compatible_node(NULL, NULL, "marvell,armada-370-pmsu"))
> +			&& of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric")
> +			&& of_machine_is_compatible("marvell,armadaxp")))
> +		return 0;
> +

of_find_compatible_node() gets the returned node, so you should put it
after using it. How about something along this pseudo-code?

pmsu = of_find_compatible_node(pmsu);
coherency_fabric = of_find_compatible_node(coherency_fabric);

if (pmsu && coherency_fabric && of_machine_is_compatible(armadaxp)) {
	/* Do your thing ... */
}

of_node_put(pmsu);
of_node_put(coherency_fabric);

And you also gain some readability, as a side effect.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
