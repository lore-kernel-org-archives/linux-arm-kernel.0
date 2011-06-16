From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 21:22:45 +0100
Subject: [RFC PATCH 06/16] ARM: local timers: move Tegra
	to	LOCAL_TIMER_DEVICES/ARM_SMP_TWD
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04992C0804@HQMAIL01.nvidia.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<1308251204-16719-7-git-send-email-marc.zyngier@arm.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04992C0804@HQMAIL01.nvidia.com>
Message-ID: <4DFA6615.7000700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/06/11 21:07, Stephen Warren wrote:
> Marc Zyngier wrote at Thursday, June 16, 2011 1:07 PM:
>> Convert the Tegra platforms to use the new arm_smp_twd driver.
>> Add the platform device and register it as early platform device.
> 
> ...
>> diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
>> index 9035042..4e1ecd0 100644
>> --- a/arch/arm/mach-tegra/timer.c
>> +++ b/arch/arm/mach-tegra/timer.c
> 
> ...
>> +static struct platform_device *tegra_early_devices[] = {
>> +	&tegra_twd_device,
>> +};
> 
> In the cases where the timer device is registered within a timer-specific
> file, as here, and hence is likely the only device to be registered, does
> it make sense to elide the platform_device array above, and ...
> 
> ...
>> @@ -241,6 +261,8 @@ static void __init tegra_init_timer(void)
>>  	tegra_clockevent.cpumask = cpu_all_mask;
>>  	tegra_clockevent.irq = tegra_timer_irq.irq;
>>  	clockevents_register_device(&tegra_clockevent);
>> +	early_platform_add_devices(tegra_early_devices,
>> +				   ARRAY_SIZE(tegra_early_devices));
>>  }
> 
> ... and just refer to the single device directly here:
> 
> early_platform_add_devices(&tegra_twd_device, 1);
> 
> ?

Unfortunately not. From include/linux/platform_device.h:
void early_platform_add_devices(struct platform_device **devs, int num);

There is no equivalent of platform_device_register() for early devices,
so the array is mandatory.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
