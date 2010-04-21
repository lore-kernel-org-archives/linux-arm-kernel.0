From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 21 Apr 2010 10:29:52 -0400 (EDT)
Subject: orion5x and GPIO blink question
In-Reply-To: <1271836632.2330.128.camel@pasglop>
References: <1271836632.2330.128.camel@pasglop>
Message-ID: <alpine.LFD.2.00.1004211020010.7232@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Apr 2010, Benjamin Herrenschmidt wrote:

> Hi folks !
> 
> While fixing up the dns-323 support for rev C I noticed something fishy
> when you use leds-gpio with the "set_blink" callback like the dns323
> code does for using HW blinking.
> 
> The problem is that there's pretty much no clean way to turn the
> blinking off via this API. It sucks, ie, it's a bug in the leds
> subsystem imho, blinking should have it's own enable/disable argument
> rather than relying on set_brightness() to stop blinking but that's how
> they did it so there's no point arguing about it.
> 
> Now, one way to fix that would be to have the orion5x GPIO stuff simply
> clear the blink bit whenever orion_gpio_set_value() is called.
> 
> Would that break any known setup ? (Other than slightly slowing down
> the GPIO accesses which might be undesirable).

I don't think anything would break.  However the current overhead of the 
API for something that ultimately is a simple bit flip is something that 
I don't like much. Any bitbang protocol on top of this might only be 
horribly inneficient.  Adding yet more overhead to it is a bit 
disconcerting.

> Another solution might be to be a bit smarter and have leds-gpio
> implement a different set_blink() function that takes an additional
> enable/disable argument, and would call that whenever set_brightness is
> called on a currently blinking GPIO.
> 
> But that means fixing all the in-tree users of leds-gpio set_blink()
> callback (I haven't counted, but it should be easily greppable).
> 
> Opinions ?

I always have a preference for fixing things properly.  And with a quick 
grep there seems to be very few set_blink in the whole tree.


Nicolas
