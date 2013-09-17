From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Sep 2013 11:04:17 +0100
Subject: [PATCH] [PATCH] clocksource: tcb: fix min_delta calculation
In-Reply-To: <20130917095600.GJ26819@ludovic.desroches@atmel.com>
References: <1379077365-18458-1-git-send-email-mkl@pengutronix.de>
 <20130917095600.GJ26819@ludovic.desroches@atmel.com>
Message-ID: <20130917100417.GQ12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 11:56:00AM +0200, Ludovic Desroches wrote:
> Any reason to not do this:
> 
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -144,6 +144,9 @@ static void tc_mode(enum clock_event_mode m, struct
> clock_event_device *d)
>  
>  static int tc_next_event(unsigned long delta, struct clock_event_device
> *d)
>  {
> +       if (delta < d->min_delta_ticks)
> +               delta = d->min_delta_ticks;
> +
>         __raw_writel(delta, tcaddr + ATMEL_TC_REG(2, RC));
>  
>         /* go go gadget! */
> 
> Then we can keep the same min_delta.

You really should not play such games in your set_next_event() code - if
the interval is not supported, you should return -ETIME so that the core
code knows about it and can adjust things to suit.  If you're getting
deltas which are too small for the hardware, that'll either be because
the bounds are wrong, or there's a bug in the core code.
