From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 14 Jan 2013 12:06:31 +0100 (CET)
Subject: [PATCHv2 1/4] clockevents: Add generic timer broadcast
 receiver
In-Reply-To: <1357742770-15028-2-git-send-email-mark.rutland@arm.com>
References: <1357742770-15028-1-git-send-email-mark.rutland@arm.com>
 <1357742770-15028-2-git-send-email-mark.rutland@arm.com>
Message-ID: <alpine.LFD.2.02.1301141204421.7475@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jan 2013, Mark Rutland wrote:
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> +extern int tick_receive_broadcast(void);
> +#else
> +static inline int tick_receive_broadcast(void)
> +{
> +	return 0;
> +}

What's the inline function for? If an arch does not have broadcasting
support it should not have a receive broadcast function call either.

> +#endif
> +
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>  extern void clockevents_notify(unsigned long reason, void *arg);
>  #else
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index f113755..5079bb7 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -125,6 +125,18 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
>  	return ret;
>  }
>  
> +int tick_receive_broadcast(void)
> +{
> +	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
> +	struct clock_event_device *evt = td->evtdev;
> +
> +	if (!evt)
> +		return -ENODEV;

Is anything going to use the return value?

Thanks,

	tglx
