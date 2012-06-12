From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 12 Jun 2012 19:21:52 +0200 (CEST)
Subject: [PATCH 1/2] clockevents: add an optional frequency update function
In-Reply-To: <1336479469-9246-1-git-send-email-linus.walleij@stericsson.com>
References: <1336479469-9246-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <alpine.LFD.2.02.1206121852310.3086@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 May 2012, Linus Walleij wrote:

Sorry for answering late and thanks for the reminder.

>  int clockevents_update_freq(struct clock_event_device *dev, u32 freq)
>  {
> +	/* Call down to the driver to reconfigure for new frequency */
> +	if (dev->update_freq)
> +		dev->update_freq(dev->mode, dev);

This shouldn't be unconditional. If the device is not used or shut
down or in oneshot mode this call is pointless. So this wants to go
below.

>  	clockevents_config(dev, freq);

Shouldn't we store the frequency in the clock_event_device structure, so
the driver has it handy when either the set_mode, reprogram or
update_freq() function is called ?

>  	if (dev->mode != CLOCK_EVT_MODE_ONESHOT)

	switch (dev->mode) {
	case CLOCK_EVT_MODE_ONESHOT:
		return clockevents_program_event(dev, dev->next_event, false);
	case CLOCK_EVT_MODE_PERIODIC:
		if (dev->update_freq)
			dev->update_freq(dev->mode, dev);
	}
	return 0;

Thanks,

	tglx
