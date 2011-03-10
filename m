From: sbkim73@samsung.com (Sangbeom Kim)
Date: Thu, 10 Mar 2011 13:48:22 +0900
Subject: [PATCH v4 1/3] ARM: S5P: Add s5p_timer support for HRT
In-Reply-To: <20110309141016.GB2737@pulham.picochip.com>
References: <1299636813-4869-1-git-send-email-sbkim73@samsung.com>
	<1299636813-4869-2-git-send-email-sbkim73@samsung.com>
	<20110309141016.GB2737@pulham.picochip.com>
Message-ID: <002d01cbdede$65e19660$31a4c320$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

As you said, .shift		= 32, is useless line.

And Do you mean that Is needed error handling of clk_enable  like below?

	clk_enable(timerclk);

	if (IS_ERR(timerclk)){
		clk_put(timerclk)
		panic("failed to enable timers clock");
	}

There is no another clk_enable for timerclk.
I will add clk_enable error handling code.

Thanks and regards,
S.B. Kim

On Wednesday, March 09, 2011 11:10 PM, Jamie Iles <Jamie@jamieiles.com>
wrote

> -----Original Message-----
> > +static struct clock_event_device time_event_device = {
> > +	.name		= "s5p_event_timer",
> > +	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> > +	.rating		= 200,
> > +	.shift		= 32,
> 
> You are using clockevents_calc_mult_shift so you don't need to specify
> .shift here.
> 
> > +	unsigned long event_id = timer_source.event_id;
> > +	unsigned long source_id = timer_source.source_id;
> > +
> > +	timerclk = clk_get(NULL, "timers");
> > +	if (IS_ERR(timerclk))
> > +		panic("failed to get timers clock for timer");
> > +
> > +	clk_enable(timerclk);
> 
> clk_enable() can fail, should you be checking the return here and the
> other clk_enable() calls?
> 
> Jamie
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
