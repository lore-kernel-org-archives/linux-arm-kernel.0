From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Sep 2012 11:14:39 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <1348780923-27428-1-git-send-email-stigge@antcom.de>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdZ+1ffsMDRZXYb5RRndoXstj_QHvHOpeikRY0bas72dKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 11:22 PM, Roland Stigge <stigge@antcom.de> wrote:

Grant really need to look at this patch too...

> The recurring task of providing simultaneous access to GPIO lines (especially
> for bit banging protocols) needs an appropriate API.
>
> This patch adds a kernel internal "Block GPIO" API that enables simultaneous
> access to several GPIOs in the same gpio_chip (bit mapped). Further, it adds a
> sysfs interface (/sys/class/gpio/gpiochipXX/block).

I've had others talk about the need for this in the past, I think it may have
been Bill Gatliff who brought it up.

I'm pretty sure it's a need for the industry so we really need something
like this, thanks for working on it Roland.

>  Documentation/gpio.txt     |   52 +++++++++++++++++++
>  drivers/gpio/gpiolib.c     |  121 +++++++++++++++++++++++++++++++++++++++++++++
>  include/asm-generic/gpio.h |    7 ++
>  include/linux/gpio.h       |   24 ++++++++
>  4 files changed, 204 insertions(+)

You probably want to patch Documentation/ABI/testing/sysfs-gpio as well.

> @@ -686,6 +731,13 @@ read-only attributes:
>
>         "ngpio" ... how many GPIOs this manges (N to N + ngpio - 1)
>
> +       "block" ... get/set Block GPIO:
> +                   * reads: space separated list of GPIO inputs of this chip that
> +                     are set to 1, e.g. "83 85 87 99"
> +                   * write: space separated list of GPIO outputs of this chip
> +                     that are to be set or cleared, e.g. "80 -83 -85" (prefix
> +                     "-" clears)

This sort of breaks the sysfs convention of one value per file,
does it not?

It's not like I have some better idea, just we need to think about
other possible solutions.

The GPIO sysfs interface is not universally liked. What are the
typical applications you have for this? Industrial control by
bit-banging userspace processes?

I've heard about people doing that kind of things and running
these processes as real-time scheduled and then running e.g.
factory lines and other scary stuff through the GPIO sysfs ...

J-C:s comments are valid as well, will not repeat them.

Yours,
Linus Walleij
