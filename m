From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 31 Mar 2015 18:40:33 +0200
Subject: [PATCH v2] ARM: mvebu: Disable CPU Idle on Armada 38x
In-Reply-To: <20150331180401.177f5124@free-electrons.com>
References: <1424889050-1008-1-git-send-email-gregory.clement@free-electrons.com>
 <20150331180401.177f5124@free-electrons.com>
Message-ID: <551ACE01.7020307@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 31/03/2015 18:04, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Wed, 25 Feb 2015 19:30:50 +0100, Gregory CLEMENT wrote:
>> On Armada 38x SoCs, under heavy I/O load, the system hangs when CPU
>> Idle is enabled. Waiting for a solution to this issue, this patch
>> disables the CPU Idle support for this SoC.
>>
>> As CPU Hot plug support also uses some of the CPU Idle functions it is
>> also affected by the same issue. This patch disables it also for the
>> Armada 38x SoCs.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Cc: <stable@vger.kernel.org> # v3.17 +
> 
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> I tested on Armada 38x, and indeed CPU hotplug is properly disabled,
> and it doesn't prevent suspend/resume (not supported yet in mainline,
> but hopefully soon to be supported).

Great!

> 
> Some minor comments below.
> 
>> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
>> index 8b9f5e202ccf..2145f192662f 100644
>> --- a/arch/arm/mach-mvebu/pmsu.c
>> +++ b/arch/arm/mach-mvebu/pmsu.c
>> @@ -415,6 +415,9 @@ static __init int armada_38x_cpuidle_init(void)
>>  	void __iomem *mpsoc_base;
>>  	u32 reg;
>>  
>> +	pr_warn("CPU Idle is currently broken on Armada 38x: disabling");
> 
> Idle -> idle
> 
OK
>> +	return 0;
>> +
>>  	np = of_find_compatible_node(NULL, NULL,
>>  				     "marvell,armada-380-coherency-fabric");
>>  	if (!np)
>> @@ -469,13 +472,23 @@ static __init int armada_xp_cpuidle_init(void)
>>  static int __init mvebu_v7_cpu_pm_init(void)
>>  {
>>  	struct device_node *np;
>> -	int ret;
>> +	int ret = 0;
> 
> Not clear why this change is needed.

It was a left over of an older version I will remove it.

> 
>>  
>>  	np = of_find_matching_node(NULL, of_pmsu_table);
>>  	if (!np)
>>  		return 0;
>>  	of_node_put(np);
>>  
>> +	/*
>> +	 * Currently the CPU Idle support for Armada 38x is broken, as
>> +	 * the CPU Hotplug uses some of the CPU Idle functions it is
>> +	 * broken too, so let's disable it
>> +	 */
>> +	if (of_machine_is_compatible("marvell,armada380")) {
>> +		cpu_hotplug_disable();
>> +		pr_warn("CPU Hotplug support is currently broken on Armada 38x: disabling");
> 
> Hotplug -> hotplug.
OK


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
