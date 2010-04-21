From: rpurdie@rpsys.net (Richard Purdie)
Date: Wed, 21 Apr 2010 10:21:10 -0700
Subject: orion5x and GPIO blink question
In-Reply-To: <1271836632.2330.128.camel@pasglop>
References: <1271836632.2330.128.camel@pasglop>
Message-ID: <1271870470.1629.85.camel@rex>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-04-21 at 17:57 +1000, Benjamin Herrenschmidt wrote:
> While fixing up the dns-323 support for rev C I noticed something fishy
> when you use leds-gpio with the "set_blink" callback like the dns323
> code does for using HW blinking.
> 
> The problem is that there's pretty much no clean way to turn the
> blinking off via this API. It sucks, ie, it's a bug in the leds
> subsystem imho, blinking should have it's own enable/disable argument
> rather than relying on set_brightness() to stop blinking but that's how
> they did it so there's no point arguing about it.

If you have blink enabled/disabled options along with set_brightness you
can end up in a state where you disable blinking but the brightness the
LED is left with is effectively random. This is why the LED core does
things that way and I stand by that as it gives defined behaviour (and
mirrors the sysfs interface).

I appreciate in the world of GPIO controllers and the leds-gpio layer
this is tricky to implement but this is more of a mismatch between the
GPIO layer and the LED subsystem which was not addressed in the design
of leds-gpio.

> Now, one way to fix that would be to have the orion5x GPIO stuff simply
> clear the blink bit whenever orion_gpio_set_value() is called.
> 
> Would that break any known setup ? (Other than slightly slowing down
> the GPIO accesses which might be undesirable).
> 
> Another solution might be to be a bit smarter and have leds-gpio
> implement a different set_blink() function that takes an additional
> enable/disable argument, and would call that whenever set_brightness is
> called on a currently blinking GPIO.
> 
> But that means fixing all the in-tree users of leds-gpio set_blink()
> callback (I haven't counted, but it should be easily greppable).
> 
> Opinions ?

I'd be ok with either solution but the bug seems to be in leds-gpio and
therefore fixing it there by adding the extra parameter would have
slight preference rather than having the GPIO layer do magic.

Cheers,

Richard
