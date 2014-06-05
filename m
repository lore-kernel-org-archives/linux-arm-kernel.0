From: dianders@chromium.org (Doug Anderson)
Date: Thu, 5 Jun 2014 10:14:05 -0700
Subject: [PATCH 2/3] clocksource: exynos_mct: cache mct upper count
In-Reply-To: <CAKfTPtBeYMW7kOrAhVrqoWhTHfLAtcMeY9FXxZpm7CNAM7NdaA@mail.gmail.com>
References: <1401903034-20074-1-git-send-email-dianders@chromium.org>
 <1401903034-20074-2-git-send-email-dianders@chromium.org>
 <CAKfTPtBeYMW7kOrAhVrqoWhTHfLAtcMeY9FXxZpm7CNAM7NdaA@mail.gmail.com>
Message-ID: <CAD=FV=Xy84f=KFO4SLmW27=ztt_hxSiBMJSMAwhw9RxKAaFU-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vincent,

On Thu, Jun 5, 2014 at 12:55 AM, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> On 4 June 2014 19:30, Doug Anderson <dianders@chromium.org> wrote:
>> From: Mandeep Singh Baines <msb@chromium.org>
>>
>> Saves one register read.  Note that the upper count only changes every
>> ~178 seconds with a 24MHz source clock, so it's likely it hasn't
>> changed from call to call.
>
> Hi Doug,
>
> Have you checked that the time saved in using a 32bits counter instead
> of a 64bits one is not lost in the handle of the wrap of sched_clock
> which occurs every 178s instead of never ?
>
> sched_clock_poll function will be called every 178s

Probably should move this to the discussion in the other patch where
we're talking about moving to 32-bits?

...but in general I have no benchmarks at all that how much the
scheduler is affected by this change.  All of my benchmarks are based
on gettimeofday(), where the improvement is clear.  Do you have a
suggested way to check?

I think that it's pretty clear that we'll want to take either the
32-bit conversion or the 64-bit optimizations I sent out.  If you take
out gettimeofday() overhead, I believe that the actual read of the MCT
(exynos_frc_read) took about:
* ~800ns per call with the original 64-bit code
* ~500ns per call with the optimized 64-bit code (both patch 2 and 3)
* ~500ns per call with the 32-bit code

The 32-bit code is slightly faster but not significantly (like 530ns
vs 500ns).  ...but it is definitely simpler.

If we find that the schedule clock wrap overhead is real then that
would be a good reason to take the 64-bit version.
