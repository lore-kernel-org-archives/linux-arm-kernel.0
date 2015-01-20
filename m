From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 20 Jan 2015 14:26:13 +0100
Subject: [PATCHv3 0/2] Driver for TI tlc59116 16 Channel i2c LED driver
In-Reply-To: <54BE258A.10808@ti.com>
References: <1421277308-3477-1-git-send-email-andrew@lunn.ch>
 <54B9259C.3070403@ti.com> <20150116191734.GB31577@lunn.ch>
 <54BE258A.10808@ti.com>
Message-ID: <20150120132613.GJ2938@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm not familiar with the LED/PWM frameworks, so I want to summarize our
> use case and how I guess this should be done:
> 
> We use the TLC59108 to provide backlight to a LCD, but in addition to
> that, it is used as a GPIO expander (or GPO, as it cannot do input). In
> your earlier patch versions there were some 'gpio' leftovers. Does your
> board have such GPIO use also?

No, only LEDs.
 
> So my current thinking is that TLC591xx should be a LED driver (as it
> sounded to me that PWM is not quite suitable for it). On top of that, we
> need generic 'led-backlight' and 'led-gpio' drivers, each of which uses
> the given LED driver to do the hardware manipulation, and they expose a
> backlight device and gpio device, respectively.

That sounds sensible. led-backlight seems to be mostly implemented
already via the led trigger code. Adding a minimal backlight_ops does
not look too hard. You might also be able to do some cleanup of the
other led based backlight drivers. 

led-gpio looks like more work, but i don't see why it should not be
possible. One thing i do need to check is that if the brightness is
set to 255 the output is not set to 255/256 on and you have a regular
glitch. For an LED that does not really matter, but for GPIO it would
not be good.

    Andrew
