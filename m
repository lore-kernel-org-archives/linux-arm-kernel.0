From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 23 Dec 2014 21:49:04 +0100
Subject: [PATCH] media: i2c/adp1653: devicetree support for adp1653
In-Reply-To: <20141223152325.75e8cb4a@concha.lan.sisa.samsung.com>
References: <20141203214641.GA1390@amd>
 <20141223152325.75e8cb4a@concha.lan.sisa.samsung.com>
Message-ID: <20141223204903.GA1780@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2014-12-23 15:23:25, Mauro Carvalho Chehab wrote:
> Em Wed, 3 Dec 2014 22:46:41 +0100
> Pavel Machek <pavel@ucw.cz> escreveu:
> 
> > 
> > We are moving to device tree support on OMAP3, but that currently
> > breaks ADP1653 driver. This adds device tree support, plus required
> > documentation.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> Please be sure to check your patch with checkpatch. There are several
> issues on it:

> WARNING: DT compatible string "adi,adp1653" appears un-documented -- check ./Documentation/devicetree/bindings/
> #78: FILE: arch/arm/boot/dts/omap3-n900.dts:572:
> +		compatible = "adi,adp1653";

Hmm. Take a look at part quoted below. Someone needs to fix
checkpatch. Ccing authors.

> ERROR: trailing whitespace
> WARNING: line over 80 characters

Will fix.

> ERROR: trailing statements should be on next line
> #177: FILE: drivers/media/i2c/adp1653.c:454:
> +	if (!child) return -EINVAL;

I actually did these on purporse... the function is trivial, and by
keeping returns on one line it fits into screen. I see you want it
fixed below, so I'll do that for next version.

								Pavel

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
> > @@ -0,0 +1,38 @@
> > +* Analog Devices ADP1653 flash LED driver
> > +
> > +Required Properties:
> > +
> > +  - compatible: Must contain one of the following
> > +    - "adi,adp1653"
> > +
> > +  - reg: I2C slave address
> > +
> > +  - gpios: References to the GPIO that controls the power for the chip.
> > +
> > +There are two led outputs available - flash and indicator. One led is
> > +represented by one child node, nodes need to be named "flash" and "indicator".
> > +
> > +Required properties of the LED child node:
> > +- max-microamp : see Documentation/devicetree/bindings/leds/common.txt
> > +
> > +Required properties of the flash LED child node:
> > +
> > +- flash-max-microamp : see Documentation/devicetree/bindings/leds/common.txt
> > +- flash-timeout-microsec : see Documentation/devicetree/bindings/leds/common.txt
> > +
> > +Example:
> > +
> > +        adp1653: led-controller at 30 {
> > +                compatible = "adi,adp1653";
> > +		reg = <0x30>;
> > +                gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
> > +
> > +		flash {
> > +                        flash-timeout-microsec = <500000>;
> > +                        flash-max-microamp = <320000>;
> > +                        max-microamp = <50000>;
> > +		};
> > +                indicator {
> > +                        max-microamp = <17500>;
> > +		};
> > +        };

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
