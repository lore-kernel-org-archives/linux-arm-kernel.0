From: rob.lee@linaro.org (Rob Lee)
Date: Wed, 18 Jul 2012 11:19:02 -0500
Subject: IRQ and FIQ disabling during sleep states.
In-Reply-To: <4FFEF5DA.8000505@linaro.org>
References: <20120711123020.GW2416@tbergstrom-lnx.Nvidia.com>
 <4FFEF5DA.8000505@linaro.org>
Message-ID: <CAMXH7KG_Q50AEkwm1B7YuhN2iy287BbMg8PB1EvBgNmBFCEvOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Peter and Daniel,

On Thu, Jul 12, 2012 at 11:05 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 07/11/2012 02:30 PM, Peter De Schrijver wrote:
>> Hi,
>>
>> I noticed several platforms exhibit different behaviour wrt disabling IRQ or
>> FIQ when entering a CPU idle state. Tegra for example disables both FIQ and
>> IRQ when entering CPU clockstop, but OMAP seems to only disable FIQs? Also
>> the generic cpuidle_wrap_enter() function, enables IRQs after return from
>> the idle state, but doesn't disable them.
>>
>> Some questions:
>>
>> 1) I assume we need to disable IRQ/FIQ to not confuse the cpuidle code due to
>>    late interrupts?

Part of the a cpuidle irq and time keeping consolidation and cleanup
patch that went in a while back removed all the irq disable calls from
arm platform code as they are they are already disabled at the
arch/arm level in kernel/process.c before calling cpu_idle_call.  I
meant to remove these redundant platform calls for all ARM platforms
but it's possible I missed one for Tegra if its platform irq disable
still exists.

>> 2) What prevents us from unifying this?
It may be good to also disable the FIQ's at the same time as IRQ's in
arch/arm/kernel/process.c.  I had made some mention of also global
disabling FIQs in my initial RFC submission and you can see the
responses here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-December/076036.html
Given the response, I didn't pursue making any changes to FIQ
disabling.  But if would have suggested doing so at same location as
irq's are being disabled for ARM, perhaps it would have been better
received.  Now that many arm systems are using FIQs for handling
interrupts in the secure trust zone world, that may change things as
well.

Rob




>
>
> AFAIR, Rob Lee discussed about this point already. Maybe he has a
> pointer to the discussion.
>
>
>
> --
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
