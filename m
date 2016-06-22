From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Jun 2016 17:16:44 +0100
Subject: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
In-Reply-To: <20160619010823.GC26875@pengutronix.de>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdaVRTj4jpGQp9nDKo8RAPDPUaApp4jAdBGRgd45bqo2zQ@mail.gmail.com>
 <20160615072404.GB26768@pengutronix.de>
 <CACRpkdYK1C5px+A_O1sF99KTPTob9qTQpipEaRLHnNx5=AokLg@mail.gmail.com>
 <20160619010823.GC26875@pengutronix.de>
Message-ID: <20160622161644.GD31817@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 19, 2016 at 03:08:23AM +0200, Uwe Kleine-K?nig wrote:
> Hello Linus,
> 
> On Sat, Jun 18, 2016 at 10:25:45AM +0200, Linus Walleij wrote:
> > On Wed, Jun 15, 2016 at 9:24 AM, Uwe Kleine-K?nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Wed, Jun 15, 2016 at 08:56:58AM +0200, Linus Walleij wrote:
> > 
> > >> The GPIO numbering scheme is a matter of Linux internals and
> > >> not about hardware description IMO.
> > >
> > > Not sure if I should agree here or not. It's very usual that the
> > > "internal" gpio numbers match the hardware reference manual. I know this
> > > from imx, at91, all pre-dt platforms, I'm sure there are more, and I bet
> > > I'm not the only one relying on this for omap.
> > 
> > I think it will still match nicely against the chip-local offsets of the
> > primary gpiochip so it'll be fine with a chardev too. The same was/is
> 
> I cannot follow. What is the primary gpiochip? The first one? What is a
> "chip-local offset". Just 3 for the fourth gpio of a given gpio bank?
> I guess the problem is that I didn't follow development of the gpio
> chardev.

If I've understood correctly, Linus was on about the id space for GPIOs
under a particular gpiochip. If I've understand correctly, you're trying
to ensure consistent numbering the the *global* ID space shared by all
GPIO chips present in a system?

> > the case of the first interrupts on x86 I think, but with the plethora of
> > irqchips and dependency on probe order etc the assumption is
> > nowadays to dangerous.
> > 
> > > And this is very usual in the dt world, too:
> > >
> > > $ git grep -El 'gpio. = \&gpio' arch/arm/boot/dts | wc -l
> > > 37
> > 
> > Aha I didn't even know. Well I guess I could allow it for OMAP too
> > then, but I want an ACK from one of the DT binding maintainers.

In general, our use of aliases is rather ill-defined. It would be nicer
if we could address devices in a similar manner to disks or partitions,
e.g. by path or uuid, but I don't think we have anything sensible we can
use there.

Given that, I can see the use of an alias to provide a consistent way of
referring to a particular gpiochip (and maybe we need to expose the
alises information somehow to userspace), but IMO that's independent of
any global ID space, probe ordering, etc.

Thanks,
Mark.
