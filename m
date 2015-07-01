From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 1 Jul 2015 09:51:49 +0200 (CEST)
Subject: [PATCH v2 4/9] arm: twr-k70f120m: timer driver for Kinetis SoC
In-Reply-To: <1435667250-28299-5-git-send-email-pawelo@king.net.pl>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <1435667250-28299-5-git-send-email-pawelo@king.net.pl>
Message-ID: <alpine.DEB.2.11.1507010944580.3916@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Jun 2015, Paul Osmialowski wrote:
> +static struct kinetis_clock_event_ddata
> +		kinetis_clockevent_tmrs[KINETIS_PIT_CHANNELS] = {
> +	{
> +		.evtdev = {
> +			.name		= "kinetis-clockevent0",
> +			.rating		= 200,
> +			.features	=
> +			    CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +			.set_next_event	= kinetis_clockevent_tmr_set_next_event,
> +			.set_state_periodic =
> +				kinetis_clockevent_tmr_set_state_periodic,
> +			.set_state_oneshot =
> +				kinetis_clockevent_tmr_set_state_oneshot,
> +			.set_state_oneshot_stopped =
> +				kinetis_clockevent_tmr_set_state_oneshot,
> +			.set_state_shutdown =
> +				kinetis_clockevent_tmr_set_state_oneshot,
> +		},
> +	},
> +	{
> +		.evtdev = {
> +			.name		= "kinetis-clockevent1",
> +		},

So how is that supposed to work if timer 1,2 or 3 is selected from
device tree? The function pointers are not initialized.

You really do not need that array at all. You can simply set the name
at init time.

> +		clockevents_register_device(
> +				&kinetis_clockevent_tmrs[chan].evtdev);
> +
> +		kinetis_pit_init(&kinetis_clockevent_tmrs[chan],
> +						(rate / HZ) - 1);
> +		kinetis_pit_enable(&kinetis_clockevent_tmrs[chan], 1);

No point doing this. The core code has invoked the set_periodic call
back via clockevents_register_device() already.

Thanks,

	tglx
