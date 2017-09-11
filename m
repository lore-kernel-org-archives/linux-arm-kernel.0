From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Sep 2017 22:53:14 +0200
Subject: [PATCH 1/5] i2c: gpio: Convert to use descriptors
In-Reply-To: <CAMuHMdXabvax2Wru8j+MC4X5F+z5hoUo1tEbX+zn2AUW6QENVA@mail.gmail.com>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <CAMuHMdXabvax2Wru8j+MC4X5F+z5hoUo1tEbX+zn2AUW6QENVA@mail.gmail.com>
Message-ID: <CACRpkdYePt_reWhVUDR9XZoR_Agscr8T9cEXk7XMpn9umO8yCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 11, 2017 at 1:27 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> FYI, I recently posted a series to deprecate (at least for DT) this error
> prone indexing, in favor of using named GPIOs:
>
>     [PATCH/RFC 0/3] i2c: gpio: Add support for named gpios in DT
>     http://www.spinics.net/lists/devicetree/msg191936.html

Grrr I seem to have fallen off the list and don't have these mails
in my inbox ....

Anyways [1/3]:

>  Required properties:
>   - compatible = "i2c-gpio";
> - - gpios: sda and scl gpio
> -
> + - sda-gpios: gpio used for the sda signal
> + - scl-gpios: gpio used for the scl signal
> + - gpios: sda and scl gpio, alternative for {sda,scl}-gpios (deprecated)

Say that the GPIOs should *always* be flagged as open drain
using e.g. (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN) as flags.

>  Optional properties:
>   - i2c-gpio,sda-open-drain: sda as open drain

These should be deprecated. Nobody understands what they mean
anyway, but they mean "I set this line up as open drain behind your
back so don't try to do open drain emulation on me", which is just
totally convoluted.

The GPIO subsystems has ways to indicate this directly to the driver
nowadays.

Add an example?

Patch [2/3]: needs to be rewritten on top of the descriptor code.
(I can do it if you like.)

Patch [3/3] should be:

+ sda-gpios = <&pfc 208 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+ scl-gpios = <&pfc 91 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;

Yours,
Linus Walleij
