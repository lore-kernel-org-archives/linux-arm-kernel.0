From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 18 Sep 2013 09:33:57 +0200
Subject: [PATCH] clockevents: Sanitize ticks to nsec conversion
In-Reply-To: <alpine.DEB.2.02.1309172228400.4089@ionos.tec.linutronix.de>
References: <1379077365-18458-1-git-send-email-mkl@pengutronix.de>
 <20130917095600.GJ26819@ludovic.desroches@atmel.com>
 <20130917100417.GQ12758@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1309171210450.4089@ionos.tec.linutronix.de>
 <20130917130153.GL26819@ludovic.desroches@atmel.com>
 <alpine.DEB.2.02.1309172228400.4089@ionos.tec.linutronix.de>
Message-ID: <20130918073357.GO26819@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 11:15:20PM +0200, Thomas Gleixner wrote:
> Marc Kleine-Budde pointed out, that commit 77cc982 "clocksource: use
> clockevents_config_and_register() where possible" caused a regression
> for some of the converted subarchs.
> 
> The reason is, that the clockevents core code converts the minimal
> hardware tick delta to a nanosecond value for core internal
> usage. This conversion is affected by integer math rounding loss, so
> the backwards conversion to hardware ticks will likely result in a
> value which is less than the configured hardware limitation. The
> affected subarchs used their own workaround (SIGH!) which got lost in
> the conversion.
> 
> Now instead of fixing the underlying core code problem, Marcs patch
> tried to work around the core code issue by increasing the minimal
> tick delta at clockevents registration time so the resulting limit in
> the core code backwards conversion did not violate the hardware
> limits. More SIGH!
> 
> The solution for the issue at hand is simple: adding evt->mult - 1 to
> the shifted value before the integer divison in the core conversion
> function takes care of it.
> 
> Though looking closer at the details of that function reveals another
> bogosity: The upper bounds check is broken as well. Checking for a
> resulting "clc" value greater than KTIME_MAX after the conversion is
> pointless. The conversion does:
> 
>       u64 clc = (latch << evt->shift) / evt->mult;
> 
> So there is no sanity check for (latch << evt->shift) exceeding the
> 64bit boundary. The latch argument is "unsigned long", so on a 64bit
> arch the handed in argument could easily lead to an unnoticed shift
> overflow. With the above rounding fix applied the calculation before
> the divison is:
> 
>        u64 clc = (latch << evt->shift) + evt->mult - 1;
> 
> Now we can easily verify whether the whole equation fits into the
> 64bit boundary. Shifting the "clc" result back by evt->shift MUST
> result in "latch". If that's not the case, we have a clear indicator
> for boundary violation and can limit "clc" to (1 << 63) - 1 before the
> divison by evt->mult. The resulting nsec * evt->mult in the
> programming path will therefor always be in the 64bit boundary.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

> ---
> diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> index 38959c8..4fc4826 100644
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -49,13 +49,25 @@ u64 clockevent_delta2ns(unsigned long latch, struct clock_event_device *evt)
>  		WARN_ON(1);
>  	}
>  
> +	/*
> +	 * Prevent integer rounding loss, otherwise the backward
> +	 * conversion from nsec to ticks could result in a value less
> +	 * than evt->min_delta_ticks.
> +	 */
> +	clc += evt->mult - 1;
> +
> +	/*
> +	 * Upper bound sanity check. If the backwards conversion is
> +	 * not equal latch, we know that the above (shift + rounding
> +	 * correction) exceeded the 64 bit boundary.
> +	 */
> +	if ((clc >> evt->shift) != (u64)latch)
> +		clc = ((u64)1 << 63) - 1;
> +
>  	do_div(clc, evt->mult);
> -	if (clc < 1000)
> -		clc = 1000;
> -	if (clc > KTIME_MAX)
> -		clc = KTIME_MAX;
>  
> -	return clc;
> +	/* Deltas less than 1usec are pointless noise */
> +	return clc > 1000 ? clc : 1000;
>  }
>  EXPORT_SYMBOL_GPL(clockevent_delta2ns);
