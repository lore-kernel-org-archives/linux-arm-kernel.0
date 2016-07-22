From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 22 Jul 2016 10:19:32 +0930
Subject: [PATCH 06/12] gpio: Add Aspeed driver
In-Reply-To: <CAP=VYLrJfRmKOoDWTpBrD5+iPdX6J9r609FzZ0CkzDd7vGBWyw@mail.gmail.com>
References: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
 <1468994313-13538-7-git-send-email-andrew@aj.id.au>
 <CAP=VYLrJfRmKOoDWTpBrD5+iPdX6J9r609FzZ0CkzDd7vGBWyw@mail.gmail.com>
Message-ID: <1469148572.5468.2.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-07-21 at 16:12 -0400, Paul Gortmaker wrote:
> On Wed, Jul 20, 2016 at 1:58 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> > 
> > From: Joel Stanley <joel@jms.id.au>
> > 
> > The Aspeed SoCs contain GPIOs grouped by letter, where each letter group
> > contains 8 pins. The GPIO letter groups are then banked in sets of four
> > in the register layout.
> > 
> > The implementation exposes multiple banks through the one driver, and
> > requests and releases pins via the pinctrl subsystem. The hardware
> > supports generation of interrupts with per-pin triggers, and exposes this
> > capability through an irqchip and devicetree.
> > 
> > A number of supported features are not yet implemented: Configuration of
> > interrupt direction (ARM or LPC), debouncing, and provides WDT reset
> > tolerance for output ports.
> > 
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Alistair Popple <alistair@popple.id.au>
> > Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > ?arch/arm/mach-aspeed/Kconfig |???4 +
> > ?drivers/gpio/Kconfig?????????|???8 +-
> > ?drivers/gpio/Makefile????????|???1 +
> > ?drivers/gpio/gpio-aspeed.c???| 456 +++++++++++++++++++++++++++++++++++++++++++
> > ?4 files changed, 468 insertions(+), 1 deletion(-)
> > ?create mode 100644 drivers/gpio/gpio-aspeed.c
> > 
> > diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> > index 25a0ae01429e..a52de9d3adfb 100644
> > --- a/arch/arm/mach-aspeed/Kconfig
> > +++ b/arch/arm/mach-aspeed/Kconfig
> > @@ -6,6 +6,10 @@ menuconfig ARCH_ASPEED
> > ????????select ASPEED_WATCHDOG
> > ????????select MOXART_TIMER
> > ????????select PINCTRL
> > +???????select GPIOLIB
> > +???????select GPIO_ASPEED
> > +???????select GPIO_SYSFS
> > +
> > ????????help
> > ??????????Say Y here if you want to run your kernel on an ASpeed BMC SoC.
> > 
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 536112fd2466..2c21b5db09cd 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -137,6 +137,13 @@ config GPIO_ATH79
> > ??????????Select this option to enable GPIO driver for
> > ??????????Atheros AR71XX/AR724X/AR913X SoC devices.
> > 
> > +config GPIO_ASPEED
> > +???????bool "Aspeed GPIO support"
> Since this is a bool Kconfig...
> 
> > 
> > +???????depends on (ARCH_ASPEED || COMPILE_TEST) && OF
> > +???????select GENERIC_IRQ_CHIP
> > +???????help
> > +?????????Say Y here to support Aspeed AST2400 and AST2500 GPIO controllers.
> > +
> [...]
> 
> ?> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> > 
> > new file mode 100644
> > index 000000000000..7885adc1332a
> > --- /dev/null
> > +++ b/drivers/gpio/gpio-aspeed.c
> > @@ -0,0 +1,456 @@
> > +/*
> > + * Copyright 2015 IBM Corp
> > + *
> > + * Joel Stanley <joel@jms.id.au>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#include 
> ...can you please get rid of module.h and all the MODULE_
> stuff and use the built in registration????Alternatively change it to
> a tristate if there is a valid use case for it to be modular.
> 

I'll change it to tristate; I don't see a reason to require it be built
in.

Cheers,

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160722/8f3dd62b/attachment.sig>
