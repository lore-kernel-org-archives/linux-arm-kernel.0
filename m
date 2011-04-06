From: rpurdie@rpsys.net (Richard Purdie)
Date: Wed, 06 Apr 2011 04:52:18 -0700
Subject: [PATCH v2] leds: provide helper to register "leds-gpio" devices
In-Reply-To: <1302035048-25819-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110405163338.GA11832@n2100.arm.linux.org.uk>
	<1302035048-25819-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1302090738.22904.8.camel@rex>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-04-05 at 22:24 +0200, Uwe Kleine-K?nig wrote:
> This function makes a deep copy of the platform data to allow it to live
> in init memory.
> The definition cannot go into leds-gpio.c because it needs to be builtin
> to be usable by platforms.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> changes since v1:
>  - don't add __init to the declaration of gpio_led_register_device
> 
>  drivers/leds/led-core.c |   27 ++++++++++++++++++++++++++-
>  include/linux/leds.h    |   12 ++++++++++++
>  2 files changed, 38 insertions(+), 1 deletions(-)

Can you explain the reasoning for this a little further please? It
sounds like instead of leaving the platform data in memory (which is
reasonable since we need it), we're now adding code to make a copy of
this data so we can remove the original. Why?

I have a rather strong dislike of adding "always builtin" functions as
they suggest something is wrong with the approach. led-core.c has always
been intentionally as minimal as we could get it.

In times when things like boot time are important it also seems like bad
form to be copying data around just so we can throw one copy away during
the boot process. What memory savings (which I assume is the
motivation?) is this giving us at what cost?

I guess the motivation might be that if a given platform has many
different LED configurations, you're trying to remove the ones you don't
need from memory? Given all the above I'd suggest that this function
should really be added to the platform device code if anywhere and
doesn't belong in the LED subsystem as its not an LED specific problem.

Cheers,

Richard

-- 
Linux Foundation
http://www.yoctoproject.org/
