From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 26 Mar 2014 11:31:59 +0100
Subject: [PATCH v5 14/14] ARM: mvebu: register the cpuidle driver for
 the Armada XP SoCs
In-Reply-To: <1395787705-31061-15-git-send-email-gregory.clement@free-electrons.com>
References: <1395787705-31061-1-git-send-email-gregory.clement@free-electrons.com>
 <1395787705-31061-15-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140326113159.48c3c405@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Tue, 25 Mar 2014 23:48:25 +0100, Gregory CLEMENT wrote:

> +int __init armada_370_xp_cpu_pm_init(void)
> +{
> +	if (!((of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu") ||
> +				of_find_compatible_node(NULL, NULL, "marvell,armada-370-pmsu"))
> +			&& of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric")
> +			&& of_machine_is_compatible("marvell,armadaxp")))
> +		return 0;

Instead of this big single condition, maybe it could be split in a
nicer way:

	/*
	 * Check that all the requirements are available to enable
	 * cpuidle. So far, it is only supported on Armada XP, cpuidle
	 * needs the coherency fabric and the PMSU enabled
         */

	if (!of_machine_is_compatible("marvell,armadaxp"))
		return 0;

	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
	if (!np)
		return 0;
	of_node_put(np);

	np = of_find_matching_node(NULL, of_pmsu_table);
	if (!np)
		return 0;
	of_node_put(np);

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
