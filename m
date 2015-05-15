From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 15 May 2015 08:54:36 +0530
Subject: smp_twd fix for adapting to cpu frequency change
In-Reply-To: <20150514144856.GA2067@n2100.arm.linux.org.uk>
References: <CAPub14_+XXjKyZVh3E8QQjY4sB4gVB=kaApuODptoizqfEUH_Q@mail.gmail.com>
 <CACRpkdZzAO4hAJKyAoeqnud9LeDG4nSK7y9cLZaEBdVOnq-ocw@mail.gmail.com>
 <CAOh2x==hn27GRh9+YmYXVruuvhP4k46itkP7WL_feOUTJ92u7A@mail.gmail.com>
 <20150514144856.GA2067@n2100.arm.linux.org.uk>
Message-ID: <20150515032436.GF6348@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-05-15, 15:48, Russell King - ARM Linux wrote:
> This is not correct.
> 
> int __clockevents_update_freq(struct clock_event_device *dev, u32 freq)
> {
>         clockevents_config(dev, freq);
> 
>         if (dev->state == CLOCK_EVT_STATE_ONESHOT)
>                 return clockevents_program_event(dev, dev->next_event, false);
> 
>         if (dev->state == CLOCK_EVT_STATE_PERIODIC)
>                 return __clockevents_set_state(dev, CLOCK_EVT_STATE_PERIODIC);
> 
> The last two lines re-set the mode to periodic, which cause the ->set_mode
> (or its replacement) to be called.  When the driver's ->set_mode method is
> called, it is supposed to write the periodic timeout to the hardware.
> 
> So, this has the side effect of updating the hardware with the new timeout
> value.
> 
> The downside to this is that if you keep changing the clock rate before
> the TWD expires, you'll never see an interrupt from it, as you'll always
> re-start a new period from the beginning on every clock frequency change.

Ahh, this was correct when it was discussed earlier.

Commit fe79a9ba1196 ("clockevents: Adjust timer interval when
frequency changes"), fixed this in clockevents core.

-- 
viresh
