From: sbkim73@samsung.com (Sangbeom Kim)
Date: Mon, 28 Feb 2011 16:56:35 +0900
Subject: [PATCH 1/3] ARM: S5P: Add s5p_timer support for HRT
In-Reply-To: <AANLkTinCyXm_z8tcjRHCYEvi79ifj+joKK7E8Kzboi2G@mail.gmail.com>
References: <1298688357-20775-1-git-send-email-sbkim73@samsung.com>
	<1298688357-20775-2-git-send-email-sbkim73@samsung.com>
	<AANLkTinCyXm_z8tcjRHCYEvi79ifj+joKK7E8Kzboi2G@mail.gmail.com>
Message-ID: <000601cbd71d$080cc870$18265950$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Walleij,

Thanks for your suggest.
I will apply your suggest in the next version.
Thanks & Regards,

S.B. Kim

2011/2/26 Linus Walleij <linux.walleij@linaro.org> wrote:
> -----Original Message-----
> From: linux-samsung-soc-owner at vger.kernel.org [mailto:linux-samsung-soc-
> owner at vger.kernel.org] On Behalf Of Linus Walleij
> Sent: Saturday, February 26, 2011 6:34 PM
> To: Sangbeom Kim
> Cc: linux-arm-kernel at lists.infradead.org; linux-samsung-
> soc at vger.kernel.org; kgene.kim at samsung.com; ben-linux at fluff.org
> Subject: Re: [PATCH 1/3] ARM: S5P: Add s5p_timer support for HRT
> 
> 2011/2/26 Sangbeom Kim <sbkim73@samsung.com>:
> > (...)
> > +static void s5p_clockevent_init(void)
> > +{
> > + ? ? ? unsigned long pclk;
> > + ? ? ? unsigned long clock_rate;
> > + ? ? ? unsigned int irq_number;
> > + ? ? ? struct clk *tscaler;
> > +
> > + ? ? ? pclk = clk_get_rate(timerclk);
> > +
> > + ? ? ? tscaler = clk_get_parent(tdiv_event);
> > +
> > + ? ? ? clk_set_rate(tscaler, pclk / 2);
> > + ? ? ? clk_set_rate(tdiv_event, pclk / 2);
> > + ? ? ? clk_set_parent(tin_event, tdiv_event);
> > +
> > + ? ? ? clock_rate = clk_get_rate(tin_event);
> > + ? ? ? clock_count_per_tick = clock_rate / HZ;
> > +
> > + ? ? ? time_event_device.mult =
> > + ? ? ? ? ? ? ? div_sc(clock_rate, NSEC_PER_SEC,
time_event_device.shift);
> > + ? ? ? time_event_device.max_delta_ns =
> > + ? ? ? ? ? ? ? clockevent_delta2ns(-1, &time_event_device);
> > + ? ? ? time_event_device.min_delta_ns =
> > + ? ? ? ? ? ? ? clockevent_delta2ns(1, &time_event_device);
> 
> This is a very complicated and inprecise way of doing this nowadays.
> Skip hardcoding the shift value and calculating mult like that and use
> 
> /* Be able to sleep for atleast 4 seconds (usually more) */
> #define EVT_MIN_RANGE 4
> 
> clockevents_calc_mult_shift(&time_event_device,
>                                     clock_rate, EVT_MIN_RANGE);
> 
> > (...)
> > +static void s5p_clocksource_init(void)
> > +{
> > + ? ? ? unsigned long pclk;
> > + ? ? ? unsigned long clock_rate;
> > +
> > + ? ? ? pclk = clk_get_rate(timerclk);
> > +
> > + ? ? ? clk_set_rate(tdiv_source, pclk / 2);
> > + ? ? ? clk_set_parent(tin_source, tdiv_source);
> > +
> > + ? ? ? clock_rate = clk_get_rate(tin_source);
> > +
> > + ? ? ? s5p_time_setup(timer_source.source_id, TCNT_MAX);
> > + ? ? ? s5p_time_start(timer_source.source_id, PERIODIC);
> > +
> > + ? ? ? if (clocksource_register_hz(&time_clocksource, clock_rate))
> > + ? ? ? ? ? ? ? panic("%s: can't register clocksource\n",
> time_clocksource.name);
> > +}
> 
> This is more like it :-)
> 
> But you probably also want to add a sched_clock hook for this
> platform too, so you get some nice scheduling resolution.
> 
> I suggest you look at the simple straight-forward driver
> for U300 in arch/arm/mach-u300/timer.c for inspiration.
> It's using the same timer that is used for clocksource for
> sched_clock().
> 
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-
> soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
