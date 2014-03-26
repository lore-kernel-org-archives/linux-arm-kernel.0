From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 26 Mar 2014 11:38:32 +0100
Subject: [PATCH v5 14/14] ARM: mvebu: register the cpuidle driver for
 the Armada XP SoCs
In-Reply-To: <20140326113159.48c3c405@skate>
References: <1395787705-31061-1-git-send-email-gregory.clement@free-electrons.com>
 <1395787705-31061-15-git-send-email-gregory.clement@free-electrons.com>
 <20140326113159.48c3c405@skate>
Message-ID: <5332AE28.3040403@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/03/2014 11:31, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Tue, 25 Mar 2014 23:48:25 +0100, Gregory CLEMENT wrote:
> 
>> +int __init armada_370_xp_cpu_pm_init(void)
>> +{
>> +	if (!((of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu") ||
>> +				of_find_compatible_node(NULL, NULL, "marvell,armada-370-pmsu"))
>> +			&& of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric")
>> +			&& of_machine_is_compatible("marvell,armadaxp")))
>> +		return 0;
> 
> Instead of this big single condition, maybe it could be split in a
> nicer way:
> 
> 	/*
> 	 * Check that all the requirements are available to enable
> 	 * cpuidle. So far, it is only supported on Armada XP, cpuidle
> 	 * needs the coherency fabric and the PMSU enabled
>          */
> 
> 	if (!of_machine_is_compatible("marvell,armadaxp"))
> 		return 0;
> 
> 	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
> 	if (!np)
> 		return 0;
> 	of_node_put(np);
> 
> 	np = of_find_matching_node(NULL, of_pmsu_table);

Oh yes the pmsu table! I was concerned by this big condition, yesterday but
I didn't find a proper solution due to the test to the 2 comaptible string:
I forgot the pmsu table.

I will do this change (I mean using the pmsu table but also splitting the
condition in small chunk).

Thanks,

Gregory


> 	if (!np)
> 		return 0;
> 	of_node_put(np);
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
