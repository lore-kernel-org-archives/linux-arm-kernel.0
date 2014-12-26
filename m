From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 26 Dec 2014 21:33:40 +0100
Subject: [PATCHv2] media: i2c/adp1653: devicetree support for adp1653
In-Reply-To: <CAL_JsqJsDqYm-xfEM1CqNzJxfZY6vnYxaBYpT+3t4+gV2F3M1A@mail.gmail.com>
References: <20141203214641.GA1390@amd> <20141224223434.GA20669@amd>
 <CAL_JsqJsDqYm-xfEM1CqNzJxfZY6vnYxaBYpT+3t4+gV2F3M1A@mail.gmail.com>
Message-ID: <20141226203340.GA1791@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > We are moving to device tree support on OMAP3, but that currently
> > breaks ADP1653 driver. This adds device tree support, plus required
> > documentation.
> >
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >
> > ---
> >
> > Changed -microsec to -us, as requested by devicetree people.
> >
> > Fixed checkpatch issues.
> >
> > diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> > index 2d88816..2c6c7c5 100644
> > --- a/Documentation/devicetree/bindings/leds/common.txt
> > +++ b/Documentation/devicetree/bindings/leds/common.txt
> > @@ -14,6 +14,15 @@ Optional properties for child nodes:
> >       "ide-disk" - LED indicates disk activity
> >       "timer" - LED flashes at a fixed, configurable rate
> >
> > +- max-microamp : maximum intensity in microamperes of the LED
> > +                (torch LED for flash devices)
> > +- flash-max-microamp : maximum intensity in microamperes of the
> > +                       flash LED; it is mandatory if the LED should
> > +                      support the flash mode
> > +- flash-timeout-microsec : timeout in microseconds after which the flash
> > +                           LED is turned off
> 
> Doesn't all this go in your flash led binding patch?

No, I should not have included this part.

> > +Example:
> > +
> > +        adp1653: led-controller at 30 {
> > +                compatible = "adi,adp1653";
> > +               reg = <0x30>;
> > +                gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
> > +
> > +               flash {
> > +                        flash-timeout-us = <500000>;
> > +                        flash-max-microamp = <320000>;
> > +                        max-microamp = <50000>;
> > +               };
> > +                indicator {
> 
> These are different LEDs or different modes?

flash & indicator are different LEDs. One is white, one is red. Flash
can be used as a flash and as a torch.

> > +                        max-microamp = <17500>;
> 
> This is a bit inconsistent. The binding says this is for flash LEDs
> torch mode, but I see no reason why it can't be common. Can you update
> the binding doc to be clear here.

By inconsisnent, you mean you want patch below?

> Also, aren't you missing label properties?

label is optional, and as my driver does not yet use it, I forgot
about it.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

index 2c6c7c5..92d4dac 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -15,7 +15,6 @@ Optional properties for child nodes:
      "timer" - LED flashes at a fixed, configurable rate
 
 - max-microamp : maximum intensity in microamperes of the LED
-	         (torch LED for flash devices)
 - flash-max-microamp : maximum intensity in microamperes of the
                        flash LED; it is mandatory if the LED should
 		       support the flash mode


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
