From: ola@adapteva.com (Ola Jeppsson)
Date: Fri, 10 Apr 2015 17:09:01 +0200
Subject: [PATCH v2] arm: zynq: Fix system clock with multi_v7_defconfig
In-Reply-To: <26139139.4pXlnbLfh0@wuerfel>
References: <550F6EDA.30709@adapteva.com>
 <BY2FFO11FD0520A960F287A6B7BA6A9DAE20D0@BY2FFO11FD052.protection.gbl>
 <26139139.4pXlnbLfh0@wuerfel>
Message-ID: <5527E78D.9040908@adapteva.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-04-10 15:44, Arnd Bergmann wrote:
> On Monday 23 March 2015 08:05:45 Michal Simek wrote:
>> Hi,
>>
>> On 03/23/2015 02:39 AM, Ola Jeppsson wrote:
>>> As mentioned in this commit:
>>> arm: zynq: Don't use arm_global_timer with cpufreq
>>> 61f1fc7e9258a169ac8afb5ddf657a181e60d052
>>>
>>> arm_global_timer depends on the CPU frequency. With cpufreq altering the
>>> CPU frequency arm_global_timer will not maintain a stable time base. So
>>> arm_global_timer must not be the clocksource when cpufreq is enabled.
>>>
>>> The above commit tries to solve this at build time by only selecting
>>> CONFIG_ARM_GLOBAL_TIMER if CONFIG_CPU_FREQ is disabled. This is not
>>> always sufficient because other machs can also enable
>>> CONFIG_ARM_GLOBAL_TIMER.
>>>
>>> Therefore: If built with CONFIG_CPU_FREQ and CONFIG_ARM_GLOBAL_TIMER,
>>> disable (on Zynq) the arm_global_timer devicetree node at boot before
>>> clock sources are initialized. This ensures that arm_global_timer will
>>> not be selected clocksource.
>>>
>>> Signed-off-by: Ola Jeppsson <ola@adapteva.com>
>
>> Arnd: Waiting for your thoughts on this one?
>> It is some sort of arch/arm/mach-mvebu/board-v7.c quirk code.
>>
>> I don't think it can be done via Kconfig because it will affect others.
> (catching up with old email)
>
> I think it's ok to work around the problem like this in principle.
>
> However, I have one concern about the way this condition is detected.
> At the moment, you assume that all zynq variants suffer from this
> problem and no other chip has it.
>
> How would you handle the situation if a future zynq variant fixes
> the problem?
The check is only applicable on Cortex A9 zynqs.
Assume for now that it is broken on all those variants. If it gets fixed on some variant add a
of_machine_is_compatible() check?
> What if it turns out to be a more common problem and we actually
> want to work around it in the arm global timer implementation
> by dynamically adapting to CPU frequency changes? I believe some
> other drivers (x86 tsc?) do this. Would we be able to detect this case
> on zynq?
>
> 	Arnd
If  the arm global timer implementation gets cpufreq scaling support, this check isn't needed and should be removed?
The only thing that happens if it is left in is that you end up with an inferior, but correct, clock source (which is what you already had before cpufreq support in arm-global-timer).


Thanks,
Ola
