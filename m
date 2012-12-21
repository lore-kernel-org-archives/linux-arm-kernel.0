From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Dec 2012 14:06:31 -0700
Subject: [PATCH V3 5/5] ARM: tegra20: cpuidle: apply coupled cpuidle for
 powered-down mode
In-Reply-To: <1356073828.26029.49.camel@jlo-ubuntu-64.nvidia.com>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
 <1355797861-12759-6-git-send-email-josephl@nvidia.com>
 <50D350C1.6070400@wwwdotorg.org>
 <1356073828.26029.49.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <50D4CF57.4030301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21/2012 12:10 AM, Joseph Lo wrote:
> On Fri, 2012-12-21 at 01:54 +0800, Stephen Warren wrote:
>> On 12/17/2012 07:31 PM, Joseph Lo wrote:
>>> The "powered-down" cpuidle mode of Tegra20 needs the CPU0 be the last one
>>> core to go into this mode before other core. The coupled cpuidle framework
>>> can help to sync the MPCore to coupled state then go into "powered-down"
>>> idle mode together. The driver can just assume the MPCore come into
>>> "powered-down" mode at the same time. No need to take care if the CPU_0
>>> goes into this mode along and only can put it into safe idle mode (WFI).
>>>
>>> The powered-down state of Tegra20 requires power gating both CPU cores.
>>> When the secondary CPU requests to enter powered-down state, it saves
>>> its own contexts and then enters WFI for waiting CPU0 in the same state.
>>> When the CPU0 requests powered-down state, it attempts to put the secondary
>>> CPU into reset to prevent it from waking up. Then power down both CPUs
>>> together and power off the cpu rail.
>>>
>>> Be aware of that, you may see the legacy power state "LP2" in the code
>>> which is exactly the same meaning of "CPU power down".
>>
>>> diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
>>
>>> +static void tegra20_wake_reset_cpu_1(void)
>>
>> Nit/bikeshe: I think tegra20_wake_from_reset_cpu_1() might be a slightly
>> more descriptive name? I assume the function works on CPU1, which is
>> assumed to be in reset, and removes reset from the CPU so it boots.
>>
> Yes.
> Do you mean this function running on CPU1? It runs on CPU0 to wake up
> CPU1. About the function name, it looks more appropriate.

Sorry for bikeshedding even more, perhaps
tegra20_wake_cpu_1_from_reset(); that makes the word-order better English.

>>> @@ -137,6 +241,9 @@ int __init tegra20_cpuidle_init(void)
>>>  	for_each_possible_cpu(cpu) {
>>>  		dev = &per_cpu(tegra_idle_device, cpu);
>>>  		dev->cpu = cpu;
>>> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>>> +		dev->coupled_cpus = *cpu_online_mask;
>>> +#endif
>>
>> That CONFIG option is selected by ARCH_TEGRA_2x_SOC, which must be
>> enabled for this file to be compiled. So, you can drop the ifdef, and
>> make the code uncondtional.
> 
> No, I found I need this if I want to make the device works on UP case.
> Then I need to do something like below, when we disable SMP.
> 
>> 	config ARCH_TEGRA_2x_SOC 
>> 	bool "Enable support for Tegra20 family" 
>> +	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP 
>> 	select ARCH_REQUIRE_GPIOLIB 
>> 	select ARM_ERRATA_720789 
>> 	select ARM_ERRATA_742230 
> 
> This will be updated in next version as well.

OK, if the Kconfig looks like that, you're right - the ifdef in the .c
file is needed.
