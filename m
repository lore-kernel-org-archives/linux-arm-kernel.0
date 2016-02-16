From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Feb 2016 16:35:07 +0100
Subject: [PATCH] pinctrl: sunxi: set pin function as input on export
In-Reply-To: <20160216080004.GA24625@box2.japko.eu>
References: <1454942242-25690-1-git-send-email-krzysztof.adamski@tieto.com>
 <CACRpkdbd4f3yj2MnR6PU5SuhV5Tj4HzWLc0UX8jQkcJp7MoTig@mail.gmail.com>
 <20160216080004.GA24625@box2.japko.eu>
Message-ID: <CACRpkdZuNM5GAh5wWpJmAxkX_XVos5j1kd6aZCfgpQJ7zGug7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 9:00 AM, Krzysztof Adamski
<krzysztof.adamski@tieto.com> wrote:

> While sysfs API may be very limited it does have it's strengths too. One of
> them is that it's trivially scriptable even from bash or other scripting
> languages

Feel free to contribute a tool to tools/gpio that perform what you
need from scripts, using a chardev.

But overall it is subject to the same issue as always: we open
a chardev and hold it to keep references to it even if the hardware
goes away. Scripting doesn't seem supergood at opening chardevs
and holding them and are thus inherently fragile.

With a chardev we can handle that gracefully.

As it is right now, files in sysfs can just disappear while your script
is running (if e.g. the GPIO is on a USB device or so) and then all
hell breaks loose I think. So it is very fragile.

> and the other one is that it's there for so long that it's very
> popular and it will take much time before all the tutorials and existing
> applications are updated. So, well, I still find it useful to have good
> support for it.

See commit fe95046e960b4b76e73dc1486955d93f47276134
it is deprecated but will be around until (at least) 2020.

The chardev will be promoted as it is *always* available, whereas
the sysfs has a Kconfig option you must switch on.

> I find current behaviour of sysfs interface broken (it says that GPIO is in
> input mode when in reality it isn't) and still think it's a good idea to fix
> it. But putting sysfs issue aside, wouldn't it be safer to set some well
> known state of the pin when requesting it instead of leaving it at whatever
> was set before?

We have this for in-kernel consumers (<linux/gpio/consumer.h>):

/**
 * Optional flags that can be passed to one of gpiod_* to configure direction
 * and output value. These values cannot be OR'd.
 */
enum gpiod_flags {
        GPIOD_ASIS      = 0,
        GPIOD_IN        = GPIOD_FLAGS_BIT_DIR_SET,
        GPIOD_OUT_LOW   = GPIOD_FLAGS_BIT_DIR_SET | GPIOD_FLAGS_BIT_DIR_OUT,
        GPIOD_OUT_HIGH  = GPIOD_FLAGS_BIT_DIR_SET | GPIOD_FLAGS_BIT_DIR_OUT |
                          GPIOD_FLAGS_BIT_DIR_VAL,
};

We have not yet specified a proper ABI for usespace. Are these
flags the same as you would want for userspace?

My feeling is that unless specified ASIS is what you want.

Especially if there is also an ABI to read the line value.

Let's get the chardev right in this regard and use that.

> The same question goes for freeing, actually, shouldn't the
> pin be disabled when we call gpio_free instead of leaving it at its last
> state?

Well maybe we should have an ABI specifying what state we
want it to be left in, if e.g. the userspace application either quit
without saying anything, or more importantly, if it crashes.

With the chardev we can do that.

> There are existing drivers that set gpio direction to input when requesting
> the pin (for example pinctrl-plgpio.c, pinctrl-sirf.c) so sunxi wouldn't be
> the only driver to do this. This does also show that indeed the problem is
> not sunxi specific, though.

Drivers can do pretty much what they want, they are supposed
to handle the hardware as well as they can. They might be doing this
for a reason or not, better ask the driver writers and/or send them
patches to augment the behaviour.

Yours,
Linus Walleij
