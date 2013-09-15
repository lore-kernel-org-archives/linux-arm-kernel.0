From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 15 Sep 2013 19:31:13 +0200
Subject: [PATCH v2 11/12] cpuidle: mvebu: Add initial CPU idle support
 for Armada 370/XP SoC
In-Reply-To: <5235C587.4030802@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
 <1379066801-16276-12-git-send-email-gregory.clement@free-electrons.com>
 <52333112.2050003@linaro.org> <5235C587.4030802@free-electrons.com>
Message-ID: <5235EEE1.8020501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2013 04:34 PM, Gregory CLEMENT wrote:
> Hi Daniel,
> 
> thanks for you review,
> 
> On 13/09/2013 17:36, Daniel Lezcano wrote:
>> On 09/13/2013 12:06 PM, Gregory CLEMENT wrote:
>>> Add the wfi, cpu idle and cpu deep idle power states support for the
>>> Armada XP SoCs.
>>>
>>> All the latencies and the power consumption values used at the
>>> "armada_370_xp_idle_driver" structure are preliminary and will be
>>> modified in the future after running some measurements and analysis.
>>>
>>> Based on the work of Nadav Haklai.
>>>
>>> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> ---
>>>  drivers/cpuidle/Kconfig.arm             |   5 ++
>>>  drivers/cpuidle/Makefile                |   1 +
>>>  drivers/cpuidle/cpuidle-armada-370-xp.c | 103 ++++++++++++++++++++++++++++++++
>>>  drivers/cpuidle/suspend-armada-370-xp.S |  91 ++++++++++++++++++++++++++++
>>
>> Somehow, you will have to move "suspend-armada-370-xp.S" into arch/arm.
> 
> Does it mean that you want I move it for the next version?

Yes please.

[ ... ]

>>> +static struct cpuidle_driver armada_370_xp_idle_driver = {
>>> +	.name			= "armada_370_xp_idle",
>>> +	.states[0]		= ARM_CPUIDLE_WFI_STATE,
>>> +	.states[1]		= {
>>> +		.enter			= armada_370_xp_enter_idle,
>>> +		.exit_latency		= 10,
>>> +		.power_usage		= 50,
>>> +		.target_residency	= 100,
>>> +		.flags			= CPUIDLE_FLAG_TIME_VALID,
>>> +		.name			= "MV CPU IDLE",
>>> +		.desc			= "CPU power down",
>>> +	},
>>> +	.states[2]		= {
>>> +		.enter			= armada_370_xp_enter_idle,
>>> +		.exit_latency		= 100,
>>> +		.power_usage		= 5,
>>> +		.target_residency	= 1000,
>>> +		.flags			= CPUIDLE_FLAG_TIME_VALID,
>>> +		.name			= "MV CPU DEEP IDLE",
>>> +		.desc			= "CPU and L2 Fabric power down",
>>> +	},
>>> +	.state_count = ARMADA_370_XP_MAX_STATES,
>>> +};
>>
>> What about the local timers ? Are they shutdown ?
> 
> I need to chekc it.

Ok, if it is the case, there is the flag CPUIDLE_FLAG_TIMER_STOP to tell
the cpuidle framework to switch to the broadcast timer with this state.

>>> +static int __init armada_370_xp_cpuidle_init(void)
>>> +{
>>> +	if (!of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu"))
>>> +		return -ENODEV;
>>> +
>>> +	if (!of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
>>> +		return -ENODEV;
>>> +
>>> +	pr_info("Initializing Armada-XP CPU power management ");
>>> +
>>> +	armada_370_xp_pmsu_enable_l2_powerdown_onidle();
>>> +
>>> +	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
>>> +}
>>> +
>>> +module_init(armada_370_xp_cpuidle_init);
>>
>> Isn't it possible to replace it by module_platform_driver ? like ux500
>> or kirkwood ?
> 
> It should be possible indeed, I will check it.

That would be great. It is a nicer approach for the single zImage IMHO.

Thanks !
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
