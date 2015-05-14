From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 May 2015 15:48:56 +0100
Subject: smp_twd fix for adapting to cpu frequency change
In-Reply-To: <CAOh2x==hn27GRh9+YmYXVruuvhP4k46itkP7WL_feOUTJ92u7A@mail.gmail.com>
References: <CAPub14_+XXjKyZVh3E8QQjY4sB4gVB=kaApuODptoizqfEUH_Q@mail.gmail.com>
 <CACRpkdZzAO4hAJKyAoeqnud9LeDG4nSK7y9cLZaEBdVOnq-ocw@mail.gmail.com>
 <CAOh2x==hn27GRh9+YmYXVruuvhP4k46itkP7WL_feOUTJ92u7A@mail.gmail.com>
Message-ID: <20150514144856.GA2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 08:14:43PM +0530, Viresh Kumar wrote:
> On Tue, May 8, 2012 at 5:03 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Thu, May 3, 2012 at 1:15 PM, shiraz hashim
> > <shiraz.linux.kernel@gmail.com> wrote:
> >
> >> In your following patch,
> >>
> >>    commit 4fd7f9b128107034fa925b6877fae3c275f0da86
> >>    Author: Linus Walleij <linus.walleij@linaro.org>
> >>    Date:   Tue Dec 13 12:48:18 2011 +0100
> >>
> >>        ARM: 7212/1: smp_twd: reconfigure clockevents after cpufreq change
> >>
> >>        This break-out from Colin Cross' cpufreq-aware TWD patch
> >>        will handle the case when our localtimer's clock changes with
> >>        the cpu clock. A cpufreq transtion notifier will be registered
> >>        only if the platform has supplied a specified clock to the TWD.
> >>
> >>        After a cpufreq transition, update the clockevent's frequency
> >>        by fetching the new clock rate from the clock framework and
> >>        reprogram the next clock event.
> >>
> >>        The necessary changes in the clockevents framework was done by
> >>        Thomas Gleixner in kernel v3.0.
> >>
> >>
> >> When we handle twd_cpufreq_transition and reprogram the clock event,
> >> the TWD_TIMER_LOAD register still contains the old load value
> >> for CLOCK_EVT_MODE_PERIODIC case.
> >>
> >> This results in wrong number of events generated per second.
> >>
> >> Shouldn't we reprogram the TWD_TIMER_LOAD register to new
> >> twd_timer_rate / HZ on frequency change as well ?
> >
> > Yep the clockevents_update_freq() is explicitly only for the
> > on-shot mode, so you'd either need to write the new period
> > value directly in twd_update_frequency().

This is not correct.

int __clockevents_update_freq(struct clock_event_device *dev, u32 freq)
{
        clockevents_config(dev, freq);

        if (dev->state == CLOCK_EVT_STATE_ONESHOT)
                return clockevents_program_event(dev, dev->next_event, false);

        if (dev->state == CLOCK_EVT_STATE_PERIODIC)
                return __clockevents_set_state(dev, CLOCK_EVT_STATE_PERIODIC);

The last two lines re-set the mode to periodic, which cause the ->set_mode
(or its replacement) to be called.  When the driver's ->set_mode method is
called, it is supposed to write the periodic timeout to the hardware.

So, this has the side effect of updating the hardware with the new timeout
value.

The downside to this is that if you keep changing the clock rate before
the TWD expires, you'll never see an interrupt from it, as you'll always
re-start a new period from the beginning on every clock frequency change.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
