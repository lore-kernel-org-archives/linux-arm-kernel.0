From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Jun 2013 09:23:56 -0700
Subject: [PATCH 3/4] mmc: omap_hsmmc: Remux pins to support SDIO
 interrupt and PM runtime
In-Reply-To: <CACRpkdZ5CUvULBFpdHZ_AMotqfUdBcAQ63+8cT+r6TZ77bUWOA@mail.gmail.com>
References: <20130607214557.18581.75288.stgit@localhost>
 <20130607214957.18581.90624.stgit@localhost>
 <CACRpkdZ5CUvULBFpdHZ_AMotqfUdBcAQ63+8cT+r6TZ77bUWOA@mail.gmail.com>
Message-ID: <20130610162356.GL8164@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [130610 09:09]:
> 
> You can use the new infrastructure to make the core select:
> 
> pinctrl_pm_select_default_state(host->dev);
> pinctrl_pm_select_idle_state(host->dev);

OK great.
 
> What is the semantic difference between "default" and "active"?

We only should remux the pins that need remuxing as that's done
every time hitting idle. So I think we should have the following
default groups:

default		Static pins that don't change, no need to remux
		configured in consumer driver probe like we already
		do

active		Optional dynamic pins remuxed for runtime, can be
		configured and selected in consumer driver probe.
		The consumer driver may also want to select this
		state in PM runtime resume.

idle		Optional dynamic pins remuxed for idle. The consumer
		driver may also want to select this state in PM
		runtime suspend depending on device_can_wakeup()
		and driver specific needs.
 
> If this is something very generic that a lot of platforms will want
> to have, why not add it to include/linux/pinctrl/pinctrl-state.h
> and augment the core to cache and handle this too?

Yes we should do that assuming the above grouping makes sense
to you.
 
> However in this case I *suspect* that what you really want
> to do it to rename the state called "default" to "sleep"
> (it appears the default state is sleepy) and then rename
> the "active" state to "default" (as this is the defined semantic
> meaning of "default" from <linux/pinctrl/pinctrl-state.h>.

The idle state above could also be called sleep instead of idle
if you prefer that.

> But maybe I'm not quite getting the subtle difference between
> "default" and "active" here so enlighten me.

I think the confusion is caused by the fact that we need three
mux groups, not just two :) The toggling between active and idle
is the hotpath as that can potentially happen for multiple drivers
every time we enter and exit idle.

Regards,

Tony
