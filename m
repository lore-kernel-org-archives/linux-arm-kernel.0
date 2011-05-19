From: mingo@elte.hu (Ingo Molnar)
Date: Thu, 19 May 2011 11:10:24 +0200
Subject: [patch 5/7] clockevents: Provide interface to reconfigure an
	active clock event device
In-Reply-To: <20110518210136.437459958@linutronix.de>
References: <20110518205713.947614271@linutronix.de>
	<20110518210136.437459958@linutronix.de>
Message-ID: <20110519091024.GB6251@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Some ARM SoCs have clock event devices which have their frequency
> modified due to frequency scaling. Provide an interface which allows
> to reconfigure an active device. After reconfiguration reprogram the
> current pending event.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/clockchips.h |    2 ++
>  kernel/time/clockevents.c  |   20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> Index: linux-2.6-tip/include/linux/clockchips.h
> ===================================================================
> --- linux-2.6-tip.orig/include/linux/clockchips.h
> +++ linux-2.6-tip/include/linux/clockchips.h
> @@ -132,6 +132,8 @@ extern void clockevents_config_and_regis
>  					    u32 freq, unsigned long min_delta,
>  					    unsigned long max_delta);
>  
> +extern int clockevents_reconfigure(struct clock_event_device *ce, u32 freq);
> +
>  extern void clockevents_exchange_device(struct clock_event_device *old,
>  					struct clock_event_device *new);
>  extern void clockevents_set_mode(struct clock_event_device *dev,
> Index: linux-2.6-tip/kernel/time/clockevents.c
> ===================================================================
> --- linux-2.6-tip.orig/kernel/time/clockevents.c
> +++ linux-2.6-tip/kernel/time/clockevents.c
> @@ -238,6 +238,26 @@ void clockevents_config_and_register(str
>  	clockevents_register_device(dev);
>  }
>  
> +/**
> + * clockevents_reconfigure - Reconfigure and reprogram a clock event device.
> + * @dev:	device to modify
> + * @freq:	new device frequency
> + *
> + * Reconfigure and reprogram a clock event device in oneshot
> + * mode. Must be called on the cpu for which the device delivers per
> + * cpu timer events with interrupts disabled!  Returns 0 on success,
> + * -ETIME when the event is in the past.
> + */
> +int clockevents_reconfigure(struct clock_event_device *dev, u32 freq)

This too could use a struct clockevents_params perhaps - and would only use 
params.freq for now but might be extended in the future.

But i'm fine with this API as well:

Reviewed-by: Ingo Molnar <mingo@elte.hu>

Thanks,

	Ingo
