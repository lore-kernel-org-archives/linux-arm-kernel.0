From: dianders@chromium.org (Doug Anderson)
Date: Thu, 20 Apr 2017 12:45:44 -0700
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <87mvbaykn1.fsf@eliezer.anholt.net>
References: <1795308650.27171.9a53158f-312d-40ce-80ce-8bf792d8db34.open-xchange@email.1und1.de>
 <172093673.40121.1492427140661@email.1und1.de>
 <CAD=FV=WJBTUcMPw8OgQT_jhz0H8AsH=YqWMR7LtudUKrF5-XOA@mail.gmail.com>
 <79b9b35b-0600-771f-4cd2-9e03c5ba3a25@i2se.com>
 <186569458.91967.1492547106553@email.1und1.de>
 <CAD=FV=VHkJFrsJDmMytbUw=WjKQaGZ-8Ewfy5bPCA82AWS4O2Q@mail.gmail.com>
 <212870399.174480.1492633502649@email.1und1.de>
 <87mvbaykn1.fsf@eliezer.anholt.net>
Message-ID: <CAD=FV=XKkKr5ZeU098Co4JDRfa-Sv6dvZ-kt-c8Ui9_SfHjRkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 20, 2017 at 11:54 AM, Eric Anholt <eric@anholt.net> wrote:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
>
>> Hi,
>>
>>> Doug Anderson <dianders@chromium.org> hat am 18. April 2017 um 22:41 geschrieben:
>>>
>>>
>>> It's hard to know for sure that all of this time is really in
>>> urb_enqueue().  Possible we could have task switched out and been
>>> blocked elsewhere.  Using ftrace to get more fine-grained timings
>>> would be useful.  ktime_get(), ktime_sub(), and ktime_to_us() are your
>>> friends here if you want to use trace_printk.
>>
>> i'm a newbie to ftrace, so i hope this would be helpful.
>>
>> # connect PL2303 to the onboard hub
>> # echo 0 > options/sleep-time
>> # echo 0 > function_profile_enabled
>> # echo 1 > function_profile_enabled
>> # ./usb_test
>> # Waiting for at least 20 seconds and then disconnect PL2303
>> # echo 0 > function_profile_enabled
>> # cat trace_stat/function0
>>
>>   Function                               Hit    Time            Avg             s^2
>>   --------                               ---    ----            ---             ---
>>   bcm2835_handle_irq                  361347    219567633 us     607.636 us      1485199 us
>>   __handle_domain_irq                1082482    212639551 us     196.437 us      3642030 us
>>   generic_handle_irq                 1082482    100592051 us     92.927 us       50511334 us
>>   irq_exit                           1082482    98197771 us     90.715 us       29649040 us
>>   handle_level_irq                   1082482    95812379 us     88.511 us       51910093 us
>
> If I'm reading this output right, we're spending half of our interrupt
> processing time in irq_exit(), so even if dwc2's interrupt was free (the
> generic_handle_irq() chain), we'd be eating about half the CPU getting
> back out of the interrupt handler, right?
>
> I don't really know anything about DWC2 or USB, but is there any way we
> could mitigate the interrupt frequency with this hardware?  If nothing
> else, could we loop reading gintsts until it reads back 0?

Take ftrace with a little bit of a grain of salt, especially on older
/ slower ARMs (without the arch timer).  Whenever ftrace takes a log
it grabs a timestamp.  This can be an expensive (ish) operation.  Even
on newer CPUs it's still not free if you call it as much as ftrace,
but on older CPUs it's extra expensive.

I spent a chunk of time working on optimizations for that on exynos
since it showed up in profiles as an expensive operation (Chrome asks
for the time a lot during its internal profiling).  Some of that type
of data is in commit 3252a646aa2c ("clocksource: exynos_mct: Only use
32-bits where possible").
