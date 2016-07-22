From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Jul 2016 16:55:45 +0200
Subject: [PATCH] arm: dts: sun7i-a20-bananapi: name the GPIO lines
In-Reply-To: <1468496825-4896-1-git-send-email-linux@rempel-privat.de>
References: <1468496825-4896-1-git-send-email-linux@rempel-privat.de>
Message-ID: <CACRpkdZLG1Ffdiw3xkP4G0XBr=WDXg2Vbh2Xmgno1PTNhfZHfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 1:47 PM, Oleksij Rempel <linux@rempel-privat.de> wrote:

> This names the GPIO lines on the Banana Pi board in accordance with
> the A20_Banana_Pi v1.4 Specification.
>
> This will make these line names reflect through to userspace
> so that they can easily be identified and used with the new
> character device ABI.
>
> Some care has been taken to name all lines, not just those used
> by the external connectors, also lines that are muxed into some
> other function than GPIO: these are named "[FOO]" so that users
> can see with lsgpio what all lines are used for.
>
> Ps: most of the text was taken from Linux Wallej patch.

LinuS

>
> Cc: devicetree at vger.kernel.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>

Nice usecase!

> +       /*
> +        * Legend: proper name = the GPIO line is used as GPIO
> +        *         NC = not connected (not routed from the SoC)
> +        *         "[PER]" = pin is muxed for peripheral (not GPIO)
> +        *         "" = no idea, schematic doesn't say, could be
> +        *              unrouted (not connected to any external pin)
> +        *         LSEC = Low Speed External Connector
> +        *         HSEC = High Speed External Connector
> +        */

So maybe we should make this naming convention a suggested
standard. People seem to like it.

> +       gpio-line-names =
> +               /* PA */
> +               "[ERXD3]", "[ERXD2]", "[ERXD1]", "[ERXD0]", "[ETXD3]",
> +                       "[ETXD2]", "[ETXD1]", "[ETXD0]",
> +               "[ERXCK]", "[ERXERR]", "[ERXDV]", "[EMDC]", "[EMDIO]",
> +                       "[ETXEN]", "[ETXCK]", "[ECRS]",
> +               "[ECOL]", "[ETXERR]", "", "", "", "", "", "",
> +               "", "", "", "", "", "", "", "",
> +               /* PB */
> +               "[PMU-SCK]", "[PMU-SDA]", "", "", "", "NC", "NC", "NC",
> +               "NC", "[USB0-DRV]", "NC", "NC", "NC", "NC", "", "",
> +               "", "", "", "", "SCL", "SDA", "", "",

Are these bit-banged SCL and SDA for doing I2C with
GPIO? Otherwise you probably want to name them "[SCL]" and "[SDA]"

> +               "TXD0", "RXD0", "IO-1", "PH3", "[USB0-IDDET]", "PH5", "", "",

Same here. You probably want "[TXD0]" etc unless you're bit-banging
the serial port. "IO-1" sounds like a real GPIO though and should
probably be named like that without [] and "PH3" what is that really?
A device-muxed pin or some kind of GPIO?

> +               "", "", "[SD0-DET]", "", "", "", "", "",
> +               "NC", "", "", "", "IO-4", "IO-5", "NC", "[EMAC-PWR-EN]",

So these seem correct too.

> +               "[LED1]", "NC", "NC", "NC", "", "", "", "",

"LED1" seems like the right name, if this is a GPIO used to drive
a LED.

> +               "", "", "", "IO-GCLK", "NC", "NC", "NC", "NC",

WHat is IO-GCLK? A real GPIO line used for toggling a clock?
Or a hardware clock signal? In the first case it it correctly named,
in the other case it should be "[IO-GCLK]".

> +               "NC", "NC", "[SPI-CE0]", "[SPI-CLK]", "[SPI-MOSI]",
> +                       "[SPI-MISO]", "[SPI-CE1]", "NC",
> +               "IO-6", "IO-3", "IO-2", "IO-0", "", "", "", "",

Looks right.

Yours,
Linus Walleij
