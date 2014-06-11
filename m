From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 11 Jun 2014 20:14:02 +0200 (CEST)
Subject: [PATCH v8 2/7] clocksource: Add support for the Mediatek SoCs
In-Reply-To: <1402490055-15197-3-git-send-email-matthias.bgg@gmail.com>
References: <1402490055-15197-1-git-send-email-matthias.bgg@gmail.com>
 <1402490055-15197-3-git-send-email-matthias.bgg@gmail.com>
Message-ID: <alpine.DEB.2.10.1406112012460.5170@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Jun 2014, Matthias Brugger wrote:
> +static void mtk_clkevt_mode(enum clock_event_mode mode,
> +				struct clock_event_device *clk)
> +{
> +	struct mtk_clock_event_device *evt = to_mtk_clk(clk);
> +
> +	mtk_clkevt_time_stop(evt, GPT_CLK_EVT);
> +
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		mtk_clkevt_time_setup(evt, evt->ticks_per_jiffy, GPT_CLK_EVT);
> +		mtk_clkevt_time_start(evt, true, GPT_CLK_EVT);
> +		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		mtk_clkevt_time_start(evt, false, GPT_CLK_EVT);

Why start the timer here? The code will call set next event right away.

> +		break;
> +	case CLOCK_EVT_MODE_UNUSED:
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +	default:
> +		/* No more interrupts will occur as source is disabled */
> +		break;
> +	}
> +}

Looks good otherwise.

Thanks,

	tglx
