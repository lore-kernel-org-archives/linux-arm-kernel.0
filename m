From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 14 May 2015 20:14:43 +0530
Subject: smp_twd fix for adapting to cpu frequency change
In-Reply-To: <CACRpkdZzAO4hAJKyAoeqnud9LeDG4nSK7y9cLZaEBdVOnq-ocw@mail.gmail.com>
References: <CAPub14_+XXjKyZVh3E8QQjY4sB4gVB=kaApuODptoizqfEUH_Q@mail.gmail.com>
 <CACRpkdZzAO4hAJKyAoeqnud9LeDG4nSK7y9cLZaEBdVOnq-ocw@mail.gmail.com>
Message-ID: <CAOh2x==hn27GRh9+YmYXVruuvhP4k46itkP7WL_feOUTJ92u7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 8, 2012 at 5:03 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, May 3, 2012 at 1:15 PM, shiraz hashim
> <shiraz.linux.kernel@gmail.com> wrote:
>
>> In your following patch,
>>
>>    commit 4fd7f9b128107034fa925b6877fae3c275f0da86
>>    Author: Linus Walleij <linus.walleij@linaro.org>
>>    Date:   Tue Dec 13 12:48:18 2011 +0100
>>
>>        ARM: 7212/1: smp_twd: reconfigure clockevents after cpufreq change
>>
>>        This break-out from Colin Cross' cpufreq-aware TWD patch
>>        will handle the case when our localtimer's clock changes with
>>        the cpu clock. A cpufreq transtion notifier will be registered
>>        only if the platform has supplied a specified clock to the TWD.
>>
>>        After a cpufreq transition, update the clockevent's frequency
>>        by fetching the new clock rate from the clock framework and
>>        reprogram the next clock event.
>>
>>        The necessary changes in the clockevents framework was done by
>>        Thomas Gleixner in kernel v3.0.
>>
>>
>> When we handle twd_cpufreq_transition and reprogram the clock event,
>> the TWD_TIMER_LOAD register still contains the old load value
>> for CLOCK_EVT_MODE_PERIODIC case.
>>
>> This results in wrong number of events generated per second.
>>
>> Shouldn't we reprogram the TWD_TIMER_LOAD register to new
>> twd_timer_rate / HZ on frequency change as well ?
>
> Yep the clockevents_update_freq() is explicitly only for the
> on-shot mode, so you'd either need to write the new period
> value directly in twd_update_frequency().
>
> I guess we didn't notice because almost noone use the
> periodic mode on these timers...
>
> I guess clockevents_update_freq() could just call
> the .set_mode() function for periodic mode again, but that
> seems a bit ugly, since the modeset code might do other things
> than just reinitialize the timer. And it won't account for the
> running event.
>
> So this solution will try to do what you describe, but I'm
> still a bit uncertain, since the currently running event will
> probably use the old load value, then the new value won't get
> used until the next event. Maybe that's fair enough?
>
> I don't know it it's OK for driver code to inspect the internal
> clockevent mode like this code does though, maybe Thomas
> has opinions on this...
>
> Can you test this snippet?
> Thomas: does this look sane?
>
> From d40c3c3302a2f89ab973b41b350153c144f6bded Mon Sep 17 00:00:00 2001
> From: Linus Walleij <linus.walleij@linaro.org>
> Date: Tue, 8 May 2012 13:26:43 +0200
> Subject: [PATCH] ARM: smp_twd: reprogram loadvalue for periodic event
>
> The code to handle frequency transitions of the TWD only
> handle one-shot events. Let's try to account for this by
> checking the state of the event.
>
> Reported-by: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/kernel/smp_twd.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index fef42b2..98b27e6 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -104,9 +104,17 @@ static void twd_timer_stop(struct clock_event_device *clk)
>   */
>  static void twd_update_frequency(void *data)
>  {
> +       struct clock_event_device *evt = *__this_cpu_ptr(twd_evt);
> +
>         twd_timer_rate = clk_get_rate(twd_clk);
>
> -       clockevents_update_freq(*__this_cpu_ptr(twd_evt), twd_timer_rate);
> +       /* If we're in periodic mode, just put in a new load value */
> +       if (evt->mode == CLOCK_EVT_MODE_PERIODIC) {
> +               __raw_writel(twd_timer_rate / HZ, twd_base + TWD_TIMER_LOAD);
> +               return;
> +       }
> +
> +       clockevents_update_freq(evt, twd_timer_rate);
>  }
>
>  static int twd_cpufreq_transition(struct notifier_block *nb,

Linus,

Did you ever fixed it up? I think Mason has hit this now:

http://www.spinics.net/lists/arm-kernel/msg417617.html
