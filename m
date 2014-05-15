From: olof@lixom.net (Olof Johansson)
Date: Thu, 15 May 2014 16:39:10 -0700
Subject: [PATCH] arm: dts: exynos5: Remove multi core timer
In-Reply-To: <53754CE2.3000905@gmail.com>
References: <1400188079-21832-1-git-send-email-chirantan@chromium.org>
 <53752E25.9060604@gmail.com>
 <CAD=FV=WKOtZaUyzTWNqR=vi_L=U-Q1dct2U_oCYi3ZJv6401Hg@mail.gmail.com>
 <53753443.8010303@gmail.com>
 <CAD=FV=V8UZoeOqEwfx_E015pLM+amTt51LrUa+dk7mTdn=vKgA@mail.gmail.com>
 <53753C17.1090002@gmail.com>
 <CAD=FV=WGa7j_As_NpySxU7OEd_SzuGWK6oxU6UeiJ-4HsoWvvg@mail.gmail.com>
 <CAJFHJrrgWGc4XGQB0ysLufAg3Wouz-aYXu97Sy2Kp=HzK+akVQ@mail.gmail.com>
 <CAASgrz2Nr69tpfC8ka9gbs2OvjLEGsvgAj4vBCFxhsamuFum7w@mail.gmail.com>
 <53754CE2.3000905@gmail.com>
Message-ID: <CAOesGMizW3vrOWdwYNP1x2U0vdtnTe+8r22H7-6c76zT=7rM=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 4:25 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 16.05.2014 01:18, David Riley wrote:
>> On Thu, May 15, 2014 at 4:03 PM, Chirantan Ekbote
>> <chirantan@chromium.org> wrote:
>>> Hi Tomasz,
>>>
>>> On Thu, May 15, 2014 at 3:44 PM, Doug Anderson <dianders@chromium.org> wrote:
>>>> Tomasz,
>>>>
>>>> On Thu, May 15, 2014 at 3:13 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>>>>> NOTE: if for some reason we need to keep the MCT around, we're
>>>>>> definitely going to need to account for the fact that tweaking it
>>>>>> affects the arch timer.  ...and having the arch timer is really nice
>>>>>> since:
>>>>>
>>>>> [Let me reorder the points below to make it easier to comment:]
>>>>>
>>>>>> * it's faster to access.
>>>>>> * it is accessible from userspace for really fast access.
>>>>>
>>>>> Do you have some data on whether it is a significant difference,
>>>>> especially considering real use cases?
>>>>
>>>> I know that Chrome makes _a lot_ of calls to gettimeofday() for
>>>> profiling purposes, enough that it showed up on benchmarks.  In fact,
>>>> we made a change to the MCT to make accesses faster and there's a
>>>> small mention of the benchmarking that was done at:
>>>>
>>>> https://chromium-review.googlesource.com/#/c/32190/
>>>>
>>>> ...that change probably should be sent upstream, actually.
>>>>
>>>> I'll let Chirantan comment on how much faster arch timers were.
>>>> ...and I think David Riley (also CCed now) may be able to comment on
>>>> the benefits of userspace timers.
>>>>
>>>
>>> When I profiled gettimeofday() calls, they were about 50 - 60% faster
>>> with the arch timers compared to the mct.
>>
>> When I profiled gettimeofday(), the standard systems call version took
>> about 2.5x longer than through a vDSO interface.
>
> Sounds like we should invent a new kind of jokes, starting with "When I
> profiled gettimeofday()". ;)
>
> Just kidding.
>
> The raw improvement looks quite good, but what I'm more concerned about
> is whether this has any significant effect on real use cases. As Doug
> mentioned, Chrome makes a lot of calls to gettimeofday(), but he also
> mentioned that this is for profiling purposes. Is performance of
> gettimeofday() really that crucial in this case? Are there any other use
> cases when this improvement is significant?

In general, yes. gettimeofday() is normally the prime candidate for
vDSO implementaiton (see Nathan Lynch's patch set in the last couple
of months for enabling this). Speeding up gettimeofday() does have
real benefit for some workloads.

> Anyway, I'm by no means opposed to switching to arch timers. They
> provide a well designed, generic interface and drivers shared by
> multiple platforms, which means more code sharing and possibly more eyes
> looking at the code, which is always good. However if they don't support
> low power states correctly, we can't just remove MCT.

Yeah, this will definitely need to be tested. Do the low power states
work on exynos5 upstream such that they can be tested? The snow
chromebook has a u-boot bug that makes AFTR not work, so it's not a
suitable platform to test on, unfortunately.

And if we need MCT for low power states, we'll need MCT to co-exist
with arch timers. Maybe by checking for the presence of those dt nodes
+ CONFIG_ARM_ARCH_TIMER, or somesuch. But let's discuss that when we
know more.


-Olof
