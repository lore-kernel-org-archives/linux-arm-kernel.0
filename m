From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 14 Aug 2014 11:21:53 +0200
Subject: [PATCH 4/4] gpio: pca953x: Add DT binding for reset gpio
In-Reply-To: <CACRpkdY1x41=b_q83fejkTHXGG8GYDFNRUXdt=1AR_R4N18Rwg@mail.gmail.com>
References: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
 <1406618686-22385-5-git-send-email-mpa@pengutronix.de>
 <CACRpkdY0TqVH1tJR1H89S5hvdJUboQdVtNvZnL3NeWit4f+amw@mail.gmail.com>
 <1407507094.3354.11.camel@paszta.hi.pengutronix.de>
 <CACRpkdY1x41=b_q83fejkTHXGG8GYDFNRUXdt=1AR_R4N18Rwg@mail.gmail.com>
Message-ID: <1408008113.4035.29.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Am Montag, den 11.08.2014, 10:43 +0200 schrieb Linus Walleij:
> On Fri, Aug 8, 2014 at 4:11 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Am Freitag, den 08.08.2014, 15:14 +0200 schrieb Linus Walleij:
> >> On Tue, Jul 29, 2014 at 9:24 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> >>
> >> > The pca953x has a negated reset input. This patch adds a DT binding for
> >> > the reset gpio and resets the chip when it is probed. This will reset
> >> > the device and leave the gpio in the correct state so reset is not
> >> > triggered.
> >> >
> >> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >>
> >> Why on earth should this be in the GPIO driver?
> >>
> >> The driver should be in drivers/reset/reset-gpio.c and you
> >> should provide a separate driver for it.
> >
> > I still think we should keep using the reset-gpios binding for simple
> > cases like this; I see no reason to add a separate device to the device
> > tree for a single GPIO.
> 
> In any case you have to propose something generic that
> happens in drivers/gpio/gpiolib.c at the end of the
> gpiochip_add() function, because this will likely appear in
> many other systems.

In general, I'd like to keep drivers in control over how and when the
reset is asserted; mainly because there are variations of reset,
powerdown/enable, and bootstrap pins that have to be taken into account.

On some devices the powerdown needs to be deasserted before the reset
can work, on some devices it might be the other way around, or the
powerdown pin may cause a reset itself, or there are bootstrap pins that
need to be configured a certain way while the reset is issued (but are
used for something else while the device is active). Others occasionally
need to reset the chip while in operation.

If you expect none of those issues for GPIO chips, I don't argue against
doing this for the drivers in gpiochip_add, if it is documented that
this function might reset the chip.
This would work with a separate gpio reset provider driver by just
calling device_reset(chip->dev) at the end of gpiochip_add.
With my previous suggestion, as Maxime points out, I'd still need to
find a way to provide the duration of the reset pulse.

> The binding should also be generic in
> Documentation/devicetree/bindings/gpio/gpio.txt
> not for just this driver.

Ideally it should be the same as all other devices with an external
reset pin.

> >> As it happens, Houcheng Lin has already proposed such a
> >> driver:
> >> http://marc.info/?l=linux-kernel&m=140309916607115&w=2
> >
> > That is a different issue, as there the device does not appear on the
> > bus until the reset is released.
> 
> You're just looking at the patch description. Look at what the
> driver does.
> 
> I wrote this reply to the patch:
> http://marc.info/?l=linux-kernel&m=140480593524472&w=2
> 
> With a delay of zero, the reset will be released
> immediately, by the use of a helper OF node and this driver
> from the reset subsystem. It's nice, generic code that solves
> a generic problem of deasserting GPIO lines for
> some reset.

Yes, it does what you want. But its purpose is different, it's a bit
indirect for the use case at hand, and we'll still find cases where this
won't work (interaction with other pins). As to whether the sub-node
might conflict with existing bindings, I don't know. This is something
that should be taken to devicetree discussion list.

regards
Philipp
