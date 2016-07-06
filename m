From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Jul 2016 11:34:37 +0200
Subject: [PATCH] gpio: document how to order GPIO controllers
In-Reply-To: <20160705180447.GP16643@pengutronix.de>
References: <1467355333-8813-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160705140546.GA10601@rob-hp-laptop> <20160705180447.GP16643@pengutronix.de>
Message-ID: <CACRpkdbH+KRXbxFdfyAE44fBNctK4cWV+KRLwQBTzSGLvLMEDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2016 at 8:04 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> [Rob]:

>> Like SPI and I2C, I'm against further abuse of aliases for this purpose
>> [1].

So what about the usecase for serial ports, where we use this
to make sure the console come out where we want it? Is that
also considered abuse or legitimate use? Note: I'm not trying to be
snarky, I'm trying to understand what is the right and wrong use
of alias. I'm confused about it right now :(

>> Why is deterministic numbering needed?

This is the big question, we all agree on that.

> in my case (with a pre 4.8 kernel) it's to control GPIO48 with
> /sys/class/gpio/gpio48.

That is understandable. However as many people have pointed
out, if this is inherently broken since the introduction of
off-chip devices and even more by deferred probing. For some
odd silicon state making one GPIO's clock or something randomly
defer the probe, this would happen to become unpredictable
also on SoC-embedded GPIO chips. It's just that we don't see
it very much because it is deterministic in practice.

We need to face it: relying on fixed GPIO numbering is just a
big fragile mess that we're trying to duct-tape.

> But also when using the gpio chardev device
> (that will hit 4.8-rc1 AFAIK) there is one device file per gpio chip.

Yeah and the argument is that the numbering also of the chip
instance should be made more deterministic, so gpiochip0,
gpiochip1 ... gpiochipN are intuitive to a human user.

> root at hostname:/sys/bus/gpio/devices ls -l
> lrwxrwxrwx    1 root     root             0 Jul  5 20:52 gpiochip0 -> ../../../devices/platform/soc/53f00000.aips/53f9c000.gpio/gpiochip0
> lrwxrwxrwx    1 root     root             0 Jul  5 20:52 gpiochip1 -> ../../../devices/platform/soc/53f00000.aips/53fa4000.gpio/gpiochip1
> lrwxrwxrwx    1 root     root             0 Jul  5 20:52 gpiochip2 -> ../../../devices/platform/soc/53f00000.aips/53fcc000.gpio/gpiochip2
> lrwxrwxrwx    1 root     root             0 Jul  5 20:52 gpiochip3 -> ../../../devices/platform/soc/53f00000.aips/53fd0000.gpio/gpiochip3
>
> That is we have:
>
>         Hardware name | software gpiochip
>             GPIO4     |      gpiochip0
>             GPIO3     |      gpiochip1
>             GPIO1     |      gpiochip2
>             GPIO2     |      gpiochip3
>
> I bet that's the probe order because when sorted by address (and so
> by order in the device tree) we have exactly this ordering. (Compare
> with $(grep gpio@ arch/arm/boot/dts/imx25.dtsi).)

That is super-unintuitive for a human user, I agree 100%.

> For a new interface this is OK, still I predict users will complain if
> the numbers used don't match naturally the hardware names. And IMHO they
> are right.

I agree, and I think that if aliases can alleviate the situation we should
allow them and encourage them. They are the best duct-tape we can
find for the DT systems.

Unfortunately it is not my call, because DT bindings and alias use
is not under my jurisdiction.

I *THINK* the view of the device core maintainers is that udev
and sysfs hierarchies should be used to uniquely identify a certain
device, and that relying on device numbering is too fragile.

The network and disks people faced this problem before us, and
their solution was things like using sysfs/udev to make sure
the device get presented the right way to userspace and
handled the way it should.

Yours,
Linus Walleij
