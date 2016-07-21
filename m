From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Jul 2016 21:55:01 +0200
Subject: [PATCH v2 3/4] drivers: reset: Add STM32 reset driver
In-Reply-To: <CAP=VYLq+Yp=dyMLY5zp8evNJ+jLkUgJ_s19gD1uC6KP8MmXPDQ@mail.gmail.com>
References: <1469092768-17489-1-git-send-email-gabriel.fernandez@st.com>
 <1469092768-17489-4-git-send-email-gabriel.fernandez@st.com>
 <CAP=VYLq+Yp=dyMLY5zp8evNJ+jLkUgJ_s19gD1uC6KP8MmXPDQ@mail.gmail.com>
Message-ID: <34955897.5sjo821nJx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 21, 2016 3:48:09 PM CEST Paul Gortmaker wrote:
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > index 5d65a93..64ebb0c 100644
> > --- a/drivers/reset/Makefile
> > +++ b/drivers/reset/Makefile
> > @@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
> >  obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
> >  obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
> >  obj-$(CONFIG_ARCH_MESON) += reset-meson.o
> > +obj-$(CONFIG_ARCH_STM32) += reset-stm32.o
> 
> In my tree, this Kconfig ARCH_STM32 is a bool, so...
> 
> >  obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
> >  obj-$(CONFIG_ARCH_STI) += sti/
> >  obj-$(CONFIG_ARCH_HISI) += hisilicon/
> > diff --git a/drivers/reset/reset-stm32.c b/drivers/reset/reset-stm32.c
> > new file mode 100644
> > index 0000000..993af2a
> > --- /dev/null
> > +++ b/drivers/reset/reset-stm32.c
> > @@ -0,0 +1,113 @@
> > +/*
> > + * Copyright (C) Maxime Coquelin 2015
> > + * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>_
> > + * License terms:  GNU General Public License (GPL), version 2
> > + *
> > + * Heavily based on sunxi driver from Maxime Ripard.
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> 
> ...we probably don't need module.h here or any of the other
> MODULE_<blah> tags/macros either.  Use the builtin for the
> register and all should be good.

I wonder if we should have separate symbols for each reset driver
instead. Those could be allowed to be tristate, and could also
be enabled for compile testing on other architectures.

I actually made a patch for that a while ago, to simplify the
dependencies around reset drivers.

	Arnd
