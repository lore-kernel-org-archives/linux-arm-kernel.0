From: robherring2@gmail.com (Rob Herring)
Date: Tue, 02 Apr 2013 21:31:48 -0500
Subject: [PATCH v2 12/13] ARM: move sp804 and integrator timers to
 drivers/clocksource
In-Reply-To: <515B7AC1.9090403@linaro.org>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
 <1364854883-5961-13-git-send-email-robherring2@gmail.com>
 <515A179A.8020800@linaro.org> <515B3637.8090603@gmail.com>
 <515B7AC1.9090403@linaro.org>
Message-ID: <515B9494.3060807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2013 07:41 PM, John Stultz wrote:
> On 04/02/2013 12:49 PM, Rob Herring wrote:
>> On 04/01/2013 06:26 PM, John Stultz wrote:
>>> On 04/01/2013 03:21 PM, Rob Herring wrote:
>>>> diff --git a/drivers/clocksource/integrator_ap_timer.c
>>>> b/drivers/clocksource/integrator_ap_timer.c
>>>> new file mode 100644
>>>> index 0000000..05e6204
>>>> --- /dev/null
>>>> +++ b/drivers/clocksource/integrator_ap_timer.c
>>> [snip]
>>
>>>> +CLOCKSOURCE_OF_DECLARE(integrator_ap, "integrator-timer",
>>>> ap_of_timer_init);
>>> So, most of the code here is really clockevent code and not clocksource
>>> code. I realize they were combined in the mach directory you're copying
>>> them from, but if we're going to move all this code out of the arch
>>> directory and into drivers/, I'd like to propose we not dump it all into
>>> drivers/clocksource.
>> Arguably, half the h/w is used for clocksource and half for clockevent
>> so it is equal. :) The sp804 and integrator are somewhat separated that
>> carving them up may be possible, but there are examples like i.MX timers
>> where the implementations are tied more closely together (the clockevent
>> compare value is the clocksource counter + delta).
>>
>> Where do I put the init functions which need to know about both?
> 
> Either have them init themselves via *_initcall, or call out from one to
> the other?

initcalls are too late on ARM. This is why CLOCKSOURCE_OF_DECLARE was
created, but it is tied to 1 init callback per matched DT node. The nice
thing about it is we avoid any headers with arbitrary timer init
functions and data and calls from the platform code in the DT case.

We could also create a CLOCKEVENT_OF_DECLARE and match twice, but then
that is 2 searches thru the DT.

I don't think an undefined interface of shared data that's different for
every timer is a good idea. This is typically the mapped address(es),
clocks, spinlocks, register access functions, misc flags, etc.

>> What about all the other timers that are already in drivers/clocksource?
> 
> I'm hoping to start moving those out soon.

I count 3 clkevt only, 4 clocksource only and 13 drivers with both. How
intertwined the 13 are, I don't know. I think we should get things moved
to a common spot first and look at all the various h/w first before
deciding how to best split things up.

Rob

>>> For more context here see:
>>> http://www.spinics.net/lists/arm-kernel/msg234074.html
>> Seems like this is more a maintainer issue than necessarily what is the
>> right split of code (not that those are completely unrelated). Perhaps
>> splitting maintainership between core and drivers is needed. It
>> definitely seems Thomas cannot keep up with the plethora of ARM related
>> timers and irqchips getting moved into drivers/.
> 
> Well, I'm hoping Daniel can help offload Thomas, but I've still not
> heard back if Thomas is ok with this whole proposal or not.
> 
> thanks
> -john
