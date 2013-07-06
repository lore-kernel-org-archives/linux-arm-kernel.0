From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 6 Jul 2013 02:12:24 +0200 (CEST)
Subject: [PATCH 9/9] clocksource: dw_apb_timer: special variant for
 rockchip rk3188 timers
In-Reply-To: <201307060056.29370.heiko@sntech.de>
References: <201307060051.09716.heiko@sntech.de>
 <201307060056.29370.heiko@sntech.de>
Message-ID: <alpine.DEB.2.02.1307060153110.32106@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 6 Jul 2013, Heiko St?bner wrote:
> +	if (of_device_is_compatible(np, "rockchip,rk3188-dw-apb-timer-osc"))
> +		*quirks |= APBTMR_QUIRK_64BIT_COUNTER | APBTMR_QUIRK_NO_EOI |
> +			   APBTMR_QUIRK_INVERSE_INTMASK |
> +			   APBTMR_QUIRK_INVERSE_PERIODIC;

Brilliant. Next time we add

> +	if (of_device_is_compatible(np, "rockchip,rk3188-dw-apb-timer-osc2"))
> +		*quirks |= APBTMR_QUIRK_64BIT_COUNTER | APBTMR_QUIRK_NO_EOI |
> +			   APBTMR_QUIRK_INVERSE_INTMASK |
> +			   APBTMR_QUIRK_INVERSE_PERIODIC | MORE_NONSENSE;

Plus the extra conditionals all over the place

and a week later

> +	if (of_device_is_compatible(np, "rockchip,rk3188-dw-apb-timer-osc3"))
> +		*quirks |= ALLNONSENSE;


This has nothing to do with QUIRKS at all. QUIRKS are our last resort
when we cannot deal with the problem in a sane way.

In this case this is simply the wrong aproach.

We can deal with it in a sane way as I pointed out before and handle
it as simple properties of the IP block. We have all mechanisms in
place to handle such properties, device tree, platform data, static
init structures. It's all there and we really do not need to plaster
the code with random QUIRK conditionals.

Did you ever consider the runtime penalty of this? Probably not,
otherwise you would have spent time on speeding up that code by
caching frequently accessed registers instead of reading them back
over and over for no reason.

Thanks,

	tglx
