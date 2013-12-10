From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 10 Dec 2013 08:27:07 +0100
Subject: questions of cpuidle
In-Reply-To: <52A6B5BB.3060506@linaro.org>
References: <52A5C846.30308@linaro.org> <52A5D0E0.7050201@linaro.org>
 <52A6B5BB.3060506@linaro.org>
Message-ID: <52A6C24B.3030800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2013 07:33 AM, Alex Shi wrote:
> On 12/09/2013 10:17 PM, Daniel Lezcano wrote:
>>
>> Concerning the wake up of the cpu: the cpu disabled the irq and
>> goes to sleep, it is up to the firmware to wake up the cpu when an
>> interrupt occurs. It will exits its sleep state, call
>> clock_events_notify(EXIT), by this way re-switching to the local
>> timer, and then re-enabling the local interrupt which leads to the
>> interrupt handler.
>
> Thanks a lots for excellent article and detailed explains!
>
> So, if the firmware is in response to wake up cpu. that means there
> is a unit which control the firmware and it can not be power down.

Correct.

> Do you know which unit running the firmware to wake up deep idle
> CPU.

That depends on the SoC implementation.

Some SoC have a "Power Management Unit". The PMU has several idle states
defined, each of them are described in the technical reference manual
(TRM) with the wake up sources.

Some SoC don't have any PMU and the idle states are very few, keeping
most of the logic on.

Some other SoC hide the PMU behind PSCI calls.

> And does the wake up pass via GIC to CPU? If so, does the GIC need
> keep awake when all cpu idle? If not, how the firmware give the
> interrupt to CPU? And I am wondering if the deep idle cpu voltage get
> to near 0. How the cpu get the interrupt signal?

If a deep idle state powers down the GIC, it is up to the PMU to proxy
the interrupts. When an interrupt occurs, the PMU powers up the logic,
including the GIC. The notifier call chain with cpu_suspend / cpu_resume
will save and restore the GIC registers.

But this is hardware specific and will depend on how the PMU is
implemented and how far it goes in the power management.

You have a good example in the drivers/cpuidle/cpuidle-ux500.c to
understand with the comments how the interrupts are handled through the
power management unit.

In the Xillinx documentation available on the web [1], the chapter 24.4
gives the information about one kind of PMU.

I believe the mechanism is pretty similar on all the hardware but it is
obfuscated by a generic power instruction like mwait.

   -- Daniel

[1]
http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf


>> There are some more informations in the wiki page [1].
>>
>> -- Daniel
>>
>> [1]
>> https://wiki.linaro.org/WorkingGroups/PowerManagement/Doc/WakeUpSources
>
>>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
