From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 9 Feb 2016 11:02:01 +0100
Subject: [PATCH 1/2] clocksource/drivers/lpc32xx: Support periodic mode
In-Reply-To: <CAAEAJfBO5jARMZyu62ccRWjA_A69qfBfHBcWncYbqOdPkYqSMQ@mail.gmail.com>
References: <1454136379-7517-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <CAGhQ9VxO7Rsus8Js_oZDBxWzEHuUHnRyoVTVmawbtXmK7tNMcw@mail.gmail.com>
 <CAAEAJfAVTJm-PzhjkRmkdNG39sH7eHyEXaSX4q0=TCQ0468Heg@mail.gmail.com>
 <CAAEAJfD8LUV=t97RN3U4uqgzCLP89AQtHqBccKGd6-EskP9DOQ@mail.gmail.com>
 <CAGhQ9VxtqkW4PLrpQWsyZu9bgB_98mmO=WZ7gvaeN_DWQ5M3rg@mail.gmail.com>
 <CAAEAJfBO5jARMZyu62ccRWjA_A69qfBfHBcWncYbqOdPkYqSMQ@mail.gmail.com>
Message-ID: <CAGhQ9VyAtJMN70Zh6gHhUCvfzUVRYn17wOg=D4kcbZ4dWQLG3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 3 February 2016 at 17:03, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> Hi Joachim,
>
> (Ccing Vladimir)
>
> On 1 February 2016 at 18:55, Joachim  Eastwood <manabian@gmail.com> wrote:
>> On 1 February 2016 at 16:09, Ezequiel Garcia
>> <ezequiel@vanguardiasur.com.ar> wrote:
>>> On 31 January 2016 at 17:07, Ezequiel Garcia
>>> <ezequiel@vanguardiasur.com.ar> wrote:
>>>> On 30 January 2016 at 16:39, Joachim  Eastwood <manabian@gmail.com> wrote:
>>>>> Hi Ezequiel,
>>>>>
>>>>> On 30 January 2016 at 07:46, Ezequiel Garcia
>>>>> <ezequiel@vanguardiasur.com.ar> wrote:
>>>>>> This commit adds the support for periodic mode. This is done by not
>>>>>> setting the MR0S (Stop on TnMR0) bit on MCR, thus allowing
>>>>>> interrupts to be periodically generated on MR0 matches.
>>>>>>
>>>>>> In order to do this, move the initial configuration that is specific to
>>>>>> the one shot mode to clock_event_device.set_state_oneshot.
>>>>>>
>>> [...]
>>>>
>>>>>
>>>>> I will look more closely at the new timer setup later.
>>>>>
>>>>> btw, didn't I look through a version of this you sent me privately
>>>>> quite some time ago?
>>>>> I think I had a comment about using TIMER_PR instead of TIMER_MR0
>>>>> then. Unsure if that is still valid, though.
>>>>>
>>>>
>>>> Ah, right. It was ages ago, and forgot your previous review. Sorry about that.
>>>> Using TIMER_PR looks less invasive so I'll send a v2 using it instead.
>>>
>>> Actually, using the prescale counter and MR0 = 1 resulted in exactly
>>> half the number of interrupts that I expected (HZ / 2). Using this
>>> patch, with PR=0 and MR0=ticks_per_jiggies, I can see HZ no. of
>>> interrupts per sec.
>>>
>>> Why did you choose to use the prescale in your oneshot implementation?
>>
>> The clockevent code was copied from arch/arm/mach-lpc32xx/timer.c so
>> it's really old code.
>> I think it is a strange way to use the timer, but the logic still
>> seems good to me.
>>
>>> Did you test or measure the timer expire using the PR and MR0 = 1?
>>
>> I really can't remember. I do remember going through the timer setup
>> and it seemed like a valid, albeit slightly strange, way to use the
>> timer.
>>
>>> To be honest, I'm still trying to make some sense out of my results.
>>
>> I'll see if can find the time to do some more testing over here as well.
>>

Sorry for the late reply.

> I wrote a small test driver to toggle a GPIO on a timer event.
> One-shot usage of the timers results in the same measurements
> with either implementation.
>
> In other words, when triggering a one-shot timer (MCR_MR0S is set),
> I get the same results using the prescale counter (PR=ticks, MR0=1)
> or the timer counter (PR=0, MR0=ticks).
>
> Here's the branch in case you want to play with it:
> http://git.infradead.org/users/ezequielg/linux/shortlog/refs/heads/misc_timer_test
>
> My logic analyzer is quite crappy, but it was clear that one-shot timers
> expired correctly at the configured time, with either implementation.

Ok. That is a good thing.

> However, when configuring the timer in periodic mode (MCR_MR0S
> is cleared), the result is always ~twice the programmed value
> (as if it takes two TC cycles to complete one event).
>
> Hence, it seems the prescale counter is not suitable for periodic mode.

I see.

> How about we change the current oneshot implementation
> to not use the prescale counter at all, and so when the periodic
> mode is introduced it'll be consistent with oneshot?

Makes sense to me. I think using the match registers will make the
timer setup easier to follow too.


Hopefully Vladimir can give it a test on LPC32xx also. But afaik the
timer IP should be exactly the same.


regards,
Joachim Eastwood
