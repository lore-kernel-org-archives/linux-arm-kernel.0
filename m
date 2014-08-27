From: olof@lixom.net (Olof Johansson)
Date: Wed, 27 Aug 2014 15:33:15 -0700
Subject: [PATCH] clocksource: arch_timer: Fix code to use physical timers
 when requested
In-Reply-To: <53FE5B09.2020403@codeaurora.org>
References: <1409173419-13076-1-git-send-email-sonnyrao@chromium.org>
 <CAOesGMjK65Rc-K0fyFUUJLw6huLT82E-nqJwZO4PqhgopF96Ow@mail.gmail.com>
 <CAPz6YkWAPtuy4sAuAK9GtpDgfGsccxeS+pqqe_t_R818Jt01qA@mail.gmail.com>
 <53FE5B09.2020403@codeaurora.org>
Message-ID: <CAOesGMhTivDzJFuxONggcJ6N5UvZopKa=+tv9PoPX593cpnm0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 3:26 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> +Mark (author of change in question)
>
> On 08/27/14 14:27, Sonny Rao wrote:
>> On Wed, Aug 27, 2014 at 2:19 PM, Olof Johansson <olof@lixom.net> wrote:
>>> On Wed, Aug 27, 2014 at 2:03 PM, Sonny Rao <sonnyrao@chromium.org> wrote:
>>>> This is a bug fix for using physical arch timers when
>>>> the arch_timer_use_virtual boolean is false.  It restores the
>>>> arch_counter_get_cntpct() function after removal in
>>>>
>>>> 0d651e4e "clocksource: arch_timer: use virtual counters"
>>>>
>>>> and completes the implementation of memory mapped access for physical
>>>> timers, so if a system is trying to use physical timers, it will
>>>> function properly.
>>>>
>>>> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>>> Acked-by: Olof Johansson <olof@lixom.net>
>>>
>>> This should have a:
>>>
>>> Fixes: 0d651e4e65e9 ("clocksource: arch_timer: use virtual counters")
>>>
>>> tag too, and possibly cc stable?
>> Ok, as far as stable goes, this patch wouldn't apply cleanly going all
>> the way back to  0d651e4e65e9
>> As-is, it would need to go after 220069945b29 "clocksource:
>> arch_timer: Add support for memory mapped timers" and there would need
>> to be another, simpler, version that went between those two commits.
>>
>> So, I'm not sure what to do in this situation regarding stable?

Greg tends to make a best-effort, you'll find out when he looks at
backporting and can reply with a "punt" or "here's the right patch"
then.

> Is there any reason why the virtual counter can't be read? Maybe we're
> the hyp and we need to make sure we don't use the virtual timer so that
> the guest can use it, but that doesn't have any effect on the usage of
> the virtual counter for the clocksource.

There are several cases where virtual is unusable -- in particular it
might not have been configured properly (i.e. the phys/virt offset is
at a bad value).


-Olof
