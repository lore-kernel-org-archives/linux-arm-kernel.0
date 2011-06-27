From: highguy@gmail.com (Stijn Devriendt)
Date: Mon, 27 Jun 2011 12:57:46 +0200
Subject: [PATCH 0/2] RFC: gpio: driver-local pin configuration
In-Reply-To: <1307695731-28018-1-git-send-email-linus.walleij@stericsson.com>
References: <1307695731-28018-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <BANLkTinxptCJRETreCpUoV-nU2K4fuFcmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 10:48 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> This is a modification of the previous generic GPIO configuration
> patch series.
>
> I'm Cc:ing everyone involved in earlier discussions so we can
> move forward on this consolidation work, lest I cannot convert
> my drivers to use struct gpio_chip / gpiolib.
>
> Background: Grant didn't like the idea of an ioctl() like
> configuration function in the struct gpio_chip vtable, so we
> decided to see if it was wiser to go back to the initial suggestion
> of making it possible for drivers to dereference the struct
> gpio_chip and perform driver-local operations via regular
> function calls instead.
>
I couldn't find Grant's rationale in an e-mail thread somewhere, but
except from the few comments I passed on, I liked the approach.

> So in this patch set I expose gpio_to_chip(), then alter the
> previous rewrite of the U300 GPIO driver to instead use a local
> configuration function by wrapping the previously defined config
> function into this:
>

I rather dislike exposing the gpio_to_chip. It makes implementations
work around gpiolib completely. We might as well strip it out
completely then and go back to drivers doing platform specific GPIO
register accesses.

I have a patch lying around somewhere which introduces the concept of
gpio groups. This is already a step up from the single gpio-pin access
and will duplicate every effort to do things like the configuration below.
It already duplicates most of the calls for multiple pins...

> /* External function to configure pins */
> int u300_gpio_set_config(unsigned gpio, u16 param, unsigned long *data)
> {
> ? ? ? ?struct gpio_chip *chip = gpio_to_chip(gpio);
> ? ? ? ?unsigned offset = gpio - chip->base;
>
> ? ? ? ?return u300_gpio_config(chip, offset, param, data);
> }
>
> This one is then exposed in the chip-specific header ?in
> <linux/gpio/u300.h>, and all the configuration defines that
> were previously globally generic in <linux/gpio.h> are also
> moved there and made driver-specific without any attempt of
> generalizing this.
>
How about a SPI flash that has its chip select hooked up to a
GPIO that requires setting open-drain for example. Now that
SPI-driver needs to be aware of each independent gpio-chip
implementation.

Stijn
