From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Jul 2016 20:04:47 +0200
Subject: [PATCH] gpio: document how to order GPIO controllers
In-Reply-To: <20160705140546.GA10601@rob-hp-laptop>
References: <1467355333-8813-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160705140546.GA10601@rob-hp-laptop>
Message-ID: <20160705180447.GP16643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 09:05:46AM -0500, Rob Herring wrote:
> On Fri, Jul 01, 2016 at 08:42:13AM +0200, Uwe Kleine-K?nig wrote:
> > This uses the same approach that is already used for spi, i2c and
> > several other controllers to ensure a consistent numbering independent
> > of probe order. This is in use for several gpio drivers that already now
> > use of_alias_get_id(np, "gpio").
> 
> Like SPI and I2C, I'm against further abuse of aliases for this purpose 
> [1].

I considered spi and i2c the good examples here :-|

> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > Linus requested such a patch as part of a change that introduces
> > this mechanism to the gpio-omap driver[1]. IMHO this is better done in a
> > separate patch, so here it comes.
> > 
> > Best regards
> > Uwe
> > 
> > [1] http://thread.gmane.org/gmane.linux.kernel.gpio/17399/focus=17629
> > 
> >  Documentation/devicetree/bindings/gpio/gpio.txt | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
> > index 68d28f62a6f4..5dbacc8f094a 100644
> > --- a/Documentation/devicetree/bindings/gpio/gpio.txt
> > +++ b/Documentation/devicetree/bindings/gpio/gpio.txt
> > @@ -227,6 +227,24 @@ Example of two SOC GPIO banks defined as gpio-controller nodes:
> >  		#gpio-cells = <2>;
> >  	};
> >  
> > +Usually the GPIO banks in SoCs are ordered, that is there is a dedicated "first
> > +gpio bank". To fix this ordering in the device tree use aliases starting at 0
> > +(even if the first bank is called "GPIO1" in the hardware reference).
> > +This is necessary/handy to ensure deterministical numbering of GPIOs and GPIO
> > +controllers.
> 
> Why is deterministic numbering needed?

in my case (with a pre 4.8 kernel) it's to control GPIO48 with
/sys/class/gpio/gpio48. But also when using the gpio chardev device
(that will hit 4.8-rc1 AFAIK) there is one device file per gpio chip.

Now consider a user who wants to control/debug direction and value of
GPIO48 (or GPIO2.16 for the chardev case). The strait forward approach
is to use /sys/class/gpio/gpio48 (or /dev/dontknowthename2 with offset
16). I doubt there is a platform where it didn't work like this up to
now and I'd consider it a userspace breakage to force the user to know
that the 2nd gpio bank is located at address 0x53fd0000 and so to lookup
the gpio bank below /sys/bus/platform/devices/53fd0000.gpio/.

On an i.MX25 device I currently see:

root at hostname:/sys/bus/gpio/devices ls -l
lrwxrwxrwx    1 root     root             0 Jul  5 20:52 gpiochip0 -> ../../../devices/platform/soc/53f00000.aips/53f9c000.gpio/gpiochip0
lrwxrwxrwx    1 root     root             0 Jul  5 20:52 gpiochip1 -> ../../../devices/platform/soc/53f00000.aips/53fa4000.gpio/gpiochip1
lrwxrwxrwx    1 root     root             0 Jul  5 20:52 gpiochip2 -> ../../../devices/platform/soc/53f00000.aips/53fcc000.gpio/gpiochip2
lrwxrwxrwx    1 root     root             0 Jul  5 20:52 gpiochip3 -> ../../../devices/platform/soc/53f00000.aips/53fd0000.gpio/gpiochip3

That is we have:

	Hardware name | software gpiochip
	    GPIO4     |      gpiochip0
	    GPIO3     |      gpiochip1
	    GPIO1     |      gpiochip2
	    GPIO2     |	     gpiochip3

I bet that's the probe order because when sorted by address (and so
by order in the device tree) we have exactly this ordering. (Compare
with $(grep gpio@ arch/arm/boot/dts/imx25.dtsi).)

For a new interface this is OK, still I predict users will complain if
the numbers used don't match naturally the hardware names. And IMHO they
are right.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
