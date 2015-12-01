From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 1 Dec 2015 15:04:36 +0100
Subject: [PATCH 1/2] regulator: Add coupled regulator
In-Reply-To: <CANLsYkzBjDTCr1NPkPAQXnR5LCQ0MFFGb8EXXO2oVaxuZ0DH_A@mail.gmail.com>
References: <1448897346-17780-1-git-send-email-maxime.ripard@free-electrons.com>
 <1448897346-17780-2-git-send-email-maxime.ripard@free-electrons.com>
 <CANLsYkzBjDTCr1NPkPAQXnR5LCQ0MFFGb8EXXO2oVaxuZ0DH_A@mail.gmail.com>
Message-ID: <20151201140436.GQ29263@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Mon, Nov 30, 2015 at 10:17:45AM -0700, Mathieu Poirier wrote:
> On 30 November 2015 at 08:29, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Some boards, in order to power devices that have a quite high power
> > consumption, wire multiple regulators in parallel.
> >
> > In such a case, the regulators need to be kept in sync, all of them being
> > enabled or disabled in parallel.
> >
> > This also requires to expose only the voltages that are common to all the
> > regulators.
> >
> > Eventually support for changing the voltage in parallel should be added
> > too, possibly with delays between each other to avoid having a too brutal
> > peak consumption.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/regulator/Kconfig                     |   7 +
> >  drivers/regulator/Makefile                    |   1 +
> >  drivers/regulator/coupled-voltage-regulator.c | 241 ++++++++++++++++++++++++++
> >  3 files changed, 249 insertions(+)
> >  create mode 100644 drivers/regulator/coupled-voltage-regulator.c
> >
> > diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> > index 8df0b0e62976..6ba7bc8fda13 100644
> > --- a/drivers/regulator/Kconfig
> > +++ b/drivers/regulator/Kconfig
> > @@ -35,6 +35,13 @@ config REGULATOR_FIXED_VOLTAGE
> >           useful for systems which use a combination of software
> >           managed regulators and simple non-configurable regulators.
> >
> > +config REGULATOR_COUPLED_VOLTAGE
> > +       tristate "Coupled voltage regulator support"
> > +       help
> > +         This driver provides support for regulators that are an
> > +         aggregate of other regulators in the system, and need to
> > +         keep them all in sync.
> > +
> >  config REGULATOR_VIRTUAL_CONSUMER
> >         tristate "Virtual regulator consumer support"
> >         help
> > diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> > index 0f8174913c17..c05839257386 100644
> > --- a/drivers/regulator/Makefile
> > +++ b/drivers/regulator/Makefile
> > @@ -22,6 +22,7 @@ obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
> >  obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
> >  obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
> >  obj-$(CONFIG_REGULATOR_BCM590XX) += bcm590xx-regulator.o
> > +obj-$(CONFIG_REGULATOR_COUPLED_VOLTAGE) += coupled-voltage-regulator.o
> >  obj-$(CONFIG_REGULATOR_DA903X) += da903x.o
> >  obj-$(CONFIG_REGULATOR_DA9052) += da9052-regulator.o
> >  obj-$(CONFIG_REGULATOR_DA9055) += da9055-regulator.o
> > diff --git a/drivers/regulator/coupled-voltage-regulator.c b/drivers/regulator/coupled-voltage-regulator.c
> > new file mode 100644
> > index 000000000000..dc7aa2aca7e6
> > --- /dev/null
> > +++ b/drivers/regulator/coupled-voltage-regulator.c
> > @@ -0,0 +1,241 @@
> > +/*
> > + * Copyright 2015 Free Electrons
> > + * Copyright 2015 NextThing Co.
> > + *
> > + * Author: Maxime Ripard <maxime.ripard@free-electrons.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of the
> > + * License, or (at your option) any later version.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/regulator/driver.h>
> > +#include <linux/regulator/of_regulator.h>
> > +
> > +#define COUPLED_REGULATOR_MAX_SUPPLIES 16
> > +
> > +struct coupled_regulator {
> > +       struct regulator        **regulators;
> > +       int                     n_regulators;
> > +
> 
> Extra line.
> 
> > +       int                     *voltages;
> > +       int                     n_voltages;
> > +};
> 
> This new structure needs documentation.

Ack.

> > +
> > +static int coupled_regulator_disable(struct regulator_dev *rdev)
> > +{
> > +       struct coupled_regulator *creg = rdev_get_drvdata(rdev);
> > +       int ret, i;
> > +
> > +       for (i = 0; i < creg->n_regulators; i++) {
> > +               ret = regulator_disable(creg->regulators[i]);
> > +               if (ret)
> > +                       break;
> > +       }
> > +
> > +       return ret;
> > +}
> 
> What happens to the other regulators when an element of the chain
> fails to disable?  Should they be powered on again?
> 
> > +
> > +static int coupled_regulator_enable(struct regulator_dev *rdev)
> > +{
> > +       struct coupled_regulator *creg = rdev_get_drvdata(rdev);
> > +       int ret, i;
> > +
> > +       for (i = 0; i < creg->n_regulators; i++) {
> > +               ret = regulator_enable(creg->regulators[i]);
> > +               if (ret)
> > +                       break;
> > +       }
> > +
> > +       return ret;
> > +}
> 
> Same thing here - shouldn't the previously enabled regulators be
> switched off when one fails to come on?  It might be worth documenting
> the behaviour being enacted.

That's actually a very good question, and I don't have a good answer
to it. I guess the safest approach would be to roll back and do the
opposite operation on the one we previously enabled / disabled.

I wonder whether it might damage the hardware or not though.

Mark?

> > +
> > +static int coupled_regulator_is_enabled(struct regulator_dev *rdev)
> > +{
> > +       struct coupled_regulator *creg = rdev_get_drvdata(rdev);
> > +       int ret = 0, i;
> > +
> > +       for (i = 0; i < creg->n_regulators; i++) {
> > +               ret &= regulator_is_enabled(creg->regulators[i]);
> 
> Why is the '&=' here?  Since it is set to '0' from the start, won't it
> always clear all the bits in a potential error return code?  Apologies
> if I'm missing something.

It was supposed to be a bitwise or, and not an and, sorry.

But your comment on the error code that might be altered is still
valid though, I'll rework that part.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/de3729a6/attachment-0001.sig>
