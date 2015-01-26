From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 26 Jan 2015 13:46:33 +0200
Subject: [PATCHv5 2/2] leds: tlc591xx: Driver for the TI 8/16 Channel
 i2c LED driver
In-Reply-To: <1421879364-8573-3-git-send-email-andrew@lunn.ch>
References: <1421879364-8573-1-git-send-email-andrew@lunn.ch>
 <1421879364-8573-3-git-send-email-andrew@lunn.ch>
Message-ID: <54C62919.8000205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22/01/15 00:29, Andrew Lunn wrote:
> The TLC59116 is an I2C bus controlled 16-channel LED driver.  The
> TLC59108 is an I2C bus controlled 8-channel LED driver, which is very
> similar to the TLC59116. Each LED output has its own 8-bit
> fixed-frequency PWM controller to control the brightness of the LED.
> The LEDs can also be fixed off and on, making them suitable for use as
> GPOs.

So as I've mentioned, our HW uses TLC59108 not only for LED (backlight)
but also as a GPO. And as we shortly discussed (in private mails, I
think), technically it's possible to write gpio and backligth drivers
that utilize a LED driver to do the actual work.

Some years ago there was a patch from Peter to implement GPO on top of PWM:

https://lkml.org/lkml/2012/11/22/108

That wasn't merged, but there was also no outright NAK, although it
seemed different people preferred different approach. That patch is
quite similar to what we'd need for GPO on top of LED.

However, I'm still not convinced that is the correct solution. A GPO
support for a PWM output makes sense, as it's just a PWM with full
on/off output. But a LED means a, well, LED, something that emits light.
GPO on LED sounds a bit silly.

So... To me it's still slightly unclear when should one write a PWM
driver and when a LED driver. But I would say that as the TLC591xx
outputs a PWM signal, it should be a PWM driver. Then the different
users of this PWM signal could be made on top of that (LED, backlight, GPO).

What would be the technical drawbacks with having the TLC591xx driver as
a PWM, instead of LED?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150126/dde4e6d9/attachment.sig>
