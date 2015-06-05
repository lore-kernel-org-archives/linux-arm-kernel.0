From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 05 Jun 2015 14:58:18 +0800
Subject: [PATCH 2/3] ARM: rockchip: ensure CPU to enter WIF state
In-Reply-To: <5571427B.1040406@rock-chips.com>
References: <1433479677-18086-1-git-send-email-wxt@rock-chips.com>
 <1433479677-18086-3-git-send-email-wxt@rock-chips.com>
 <5571427B.1040406@rock-chips.com>
Message-ID: <5571488A.5040609@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015?06?05? 14:32, Kever Yang ??:
> Hi Caesar,
>
> Subject typo WIF/WFI.
OK

>
> On 06/05/2015 12:47 PM, Caesar Wang wrote:
>> In idle mode, core1/2/3 of Cortex-A17 should be either power off or in
>> WFI/WFE state.
>> we can delay 1ms to ensure the CPU enter WFI state.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> ---
>>
>>   arch/arm/mach-rockchip/platsmp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/platsmp.c 
>> b/arch/arm/mach-rockchip/platsmp.c
>> index 1230d3d..978c357 100644
>> --- a/arch/arm/mach-rockchip/platsmp.c
>> +++ b/arch/arm/mach-rockchip/platsmp.c
>> @@ -316,6 +316,9 @@ static void __init 
>> rockchip_smp_prepare_cpus(unsigned int max_cpus)
>>   #ifdef CONFIG_HOTPLUG_CPU
>>   static int rockchip_cpu_kill(unsigned int cpu)
>>   {
>> +    /* ensure CPU can enter the WFI/WFE state */
>> +    mdelay(1);
>> +
> Does it matter if core is not in WFI state when we want to power down it?
>
As HuangTao suggestion,

In gerenal, we need enter the WFI state when core power down, right?
That will be more better if the hardware can judge the state.

Anyway, we can delay 1ms or more to wait the WFI state.
That should be more better, right?

> Thanks,
> - Kever
>>       pmu_set_power_domain(0 + cpu, false);
>>       return 1;
>>   }
>
>
>
>
