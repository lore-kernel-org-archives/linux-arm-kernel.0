From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Jun 2013 13:11:52 -0700
Subject: [PATCH 0/2] Fix potential merge conflict for dw_apb_timer_of
In-Reply-To: <51C0A9AF.4030409@linaro.org>
References: <1371514129-22801-1-git-send-email-dinguyen@altera.com>
 <20130618150244.GC18055@amd.pavel.ucw.cz>
 <201306181738.35671.heiko@sntech.de>
 <201306182028.50762.heiko@sntech.de> <51C0A9AF.4030409@linaro.org>
Message-ID: <CAOesGMjyzTtHGTxE5722o0AXnJSGmsmDZbbq4-CYGf9=FEAJCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 11:40 AM, John Stultz <john.stultz@linaro.org> wrote:
> On 06/18/2013 11:28 AM, Heiko St?bner wrote:
>>
>> Am Dienstag, 18. Juni 2013, 17:38:35 schrieb Heiko St?bner:
>>>
>>> Hi Pavel,
>>>
>>> Am Dienstag, 18. Juni 2013, 17:02:44 schrieb Pavel Machek:
>>>>
>>>> Hi!
>>>>
>>>>>> The following 2 patches will eliminate the need for the patch in John
>>>>>> Stultz's tree. If there is to be merge of the 2 trees, then the
>>>>>> patch:
>>>>>>
>>>>>> dw_apb_timer_of.c: Remove parts that were picoxcell-specific
>>>>>>
>>>>>> can be removed from John's tree to avoid a merge-conflict.
>>>>>>
>>>>>> Based on arm-soc/for-next:
>>>>>>
>>>>>> PATCH[1/2] - Rename "dw-apb-timer-osc" and "dw-apb-timer-sp" bindings
>>>>>> to just "dw-apb-timer"
>>>>>> PATCH[2/2] - Fix user/system reporting by fixing read_sched_clock()
>>>>>
>>>>> Pavel/Jamie: Can you take a look at these too and make sure these cover
>>>>> what you were doing.
>>>>
>>>> [It seems like Heiko St?bner was not aware of patches in the clock
>>>> tree, so did pretty much equivalent patch.]
>>>
>>> Correct ... I was going after what was in linux-next and the tip.git
>>> [which
>>> I also only saw recently at all] does not seem to be part of it.
>>>
>>>> Dinh's changes look good to me, but
>>>>
>>>> [PATCH v2 4/4] clocksource: dw_apb_timer_of: use clocksource_of_init
>>>>
>>>> does not exactly look nice: (I'm sorry I did not see original series,
>>>> before it was merged to -soc.). The function counts number of times it
>>>> was called, and behaves differently in each case. It is not very
>>>> traditional kernel code at the very least.
>>>>
>>>> +static int num_called;
>>>> +static void __init dw_apb_timer_init(struct device_node *timer)
>>>>
>>>>   {
>>>>
>>>> -       struct device_node *event_timer, *source_timer;
>>>> -
>>>> -       event_timer = of_find_matching_node(NULL, osctimer_ids);
>>>> -       if (!event_timer)
>>>> -               panic("No timer for clockevent");
>>>> -       add_clockevent(event_timer);
>>>> -
>>>> -       source_timer = of_find_matching_node(event_timer,
>>>> osctimer_ids);
>>>> -       if (!source_timer)
>>>> -               panic("No timer for clocksource");
>>>> -       add_clocksource(source_timer);
>>>> -
>>>> -       of_node_put(source_timer);
>>>> +       switch (num_called) {
>>>> +       case 0:
>>>> +               pr_debug("%s: found clockevent timer\n", __func__);
>>>> +               add_clockevent(timer);
>>>> +               of_node_put(timer);
>>>> +               break;
>>>> +       case 1:
>>>> +               pr_debug("%s: found clocksource timer\n", __func__);
>>>> +               add_clocksource(timer);
>>>> +               of_node_put(timer);
>>>> +               init_sched_clock();
>>>> +               break;
>>>> +       default:
>>>> +               break;
>>>> +       }
>>>>
>>>> -       init_sched_clock();
>>>> +       num_called++;
>>>>
>>>>   }
>>>>
>>>> Heiko, can you take a look at John Stultz tree? We modified this area
>>>> already... I understand you only have one timer on your silicon?
>>
>> also it seems like not being able to use the apb_timer as sched_clock will
>> hurt my platform too.
>>
>> I've tried to use the arm_arch_timer, but when the arch_timer_get_cntfrq()
>> function gets called, I only get an "undefined instruction" Oops for the
>> executed asm in there.
>>
>> As there is no manual available for the SoC, I can only guess that it
>> doesn't
>> contain such a component. This is fueled additionally by the PPI part of
>> the
>> gic only having 3 interrupt sources [there is small excerpt of the
>> soc-manual
>> floating around that contains this information], with one already being
>> the
>> twd interrupt, while the arm_arch_timer seems to require 4 itself.
>>
>> Therefore it would cool, if we could keep the sched_clock functionality
>> (provided by the clocksource timer) around somehow.
>
>
> So whats the plan now?
>
> I'm feeling likely to revert "dw_apb_timer_of.c: Remove parts that were
> picoxcell-specific" in my tree and leave the rest of the wreckage to the
> arm-soc folks to sort out (either getting the fix in or reverting the lot
> and trying again for 3.12), unless we get some agreed upon path forward
> sorted quickly here.

It was bad timing that linux-next was down for a week right around the
time of all of this, but not much we can do about in hindsight.

I'd be OK with reverting on your side and revisiting for 3.12. Arnd is
doing arm-soc merges for a bit so it's up to him if he wants to try
merging it without conflicts on our side.


-Olof
