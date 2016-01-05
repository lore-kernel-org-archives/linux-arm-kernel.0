From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 5 Jan 2016 11:31:37 +0100
Subject: [PATCH v3 1/3] clocksource/vt8500: Increase the minimum delta
In-Reply-To: <20160105100054.GS19062@n2100.arm.linux.org.uk>
References: <1451654683-2401-1-git-send-email-v1ron@mail.ru>
 <1451654683-2401-2-git-send-email-v1ron@mail.ru>
 <568B8653.2010301@linaro.org> <20160105124242.17bbe09d@v1ron-s7>
 <20160105100054.GS19062@n2100.arm.linux.org.uk>
Message-ID: <568B9B89.5040001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2016 11:00 AM, Russell King - ARM Linux wrote:
> On Tue, Jan 05, 2016 at 12:42:42PM +0300, Roman Volkov wrote:
>> Why multiply by two? Good question. Maybe there is a reserve for
>> stability. The value passed by the system to the set_next_event() should
>> be not lesser than this value, and theoretically, we should not
>> multiply MIN_OSCR_DELTA by two. As I can see, in many drivers there is
>> no such minimal values at all.
>
> It's a speciality of the StrongARM/PXA hardware.  It takes a certain
> number of OSCR cycles for the value written to hit the compare registers.
> So, if a very small delta is written (eg, the compare register is written
> with a value of OSCR + 1), the OSCR will have incremented past this value
> before it hits the underlying hardware.  The result is, that you end up
> waiting a very long time for the OSCR to wrap before the event fires.
>
> So, we introduce a check in set_next_event() to detect this and return
> -ETIME if the calculated delta is too small, which causes the generic
> clockevents code to retry after adding the min_delta specified in
> clockevents_config_and_register() to the current time value.
>
> min_delta must be sufficient that we don't re-trip the -ETIME check - if
> we do, we will return -ETIME, forward the next event time, try to set it,
> return -ETIME again, and basically lock the system up.  So, min_delta
> must be larger than the check inside set_next_event().  A factor of two
> was chosen to ensure that this situation would never occur.

Russell,

thank you for taking the time to write this detailed explanation. I 
believe that clarifies everything (the issue with the lockup and the 
value of the min delta).

Roman,

If we are in the situation Russell is describing above, failing 
gracefully as mentioned before does not make sense.

Do you have a idea why this is happening with 4.2 and not before ?

> The PXA code worked on PXA systems for years, and I'd suggest no one
> changes this mechanism without access to a wide range of PXA systems,
> otherwise they're risking breakage.

Copy that :)


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
