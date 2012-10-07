From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 7 Oct 2012 16:20:04 +0100
Subject: [PATCH v3] GPIO: Add support for GPIO on CLPS711X-target platform
In-Reply-To: <20121007191227.f1e74cad.shc_work@mail.ru>
References: <1349106153-27371-1-git-send-email-shc_work@mail.ru>
 <20121005090204.GL4625@n2100.arm.linux.org.uk>
 <20121007135334.3ed2b9a5.shc_work@mail.ru>
 <20121007102803.GT4625@n2100.arm.linux.org.uk>
 <20121007191227.f1e74cad.shc_work@mail.ru>
Message-ID: <20121007152004.GU4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 07, 2012 at 07:12:27PM +0400, Alexander Shiyan wrote:
> On Sun, 7 Oct 2012 11:28:03 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > > ...
> > > > > +++ b/arch/arm/mach-clps711x/include/mach/gpio.h
> > > > > @@ -0,0 +1,27 @@
> > > > > +/*
> > > > > + *  This file contains the CLPS711X GPIO definitions.
> > > > > + *
> > > > > + *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
> > > > > + *
> > > > > + * This program is free software; you can redistribute it and/or modify
> > > > > + * it under the terms of the GNU General Public License as published by
> > > > > + * the Free Software Foundation; either version 2 of the License, or
> > > > > + * (at your option) any later version.
> > > > > + */
> > > > > +
> > > > > +/* Simple helper for convert port & pin to GPIO number */
> > > > > +#define CLPS711X_GPIO(port, bit)	((port) * 8 + (bit))
> > > > > +
> > > > > +/* Temporaty definitions for GPIO-ports */
> > > > > +/* Will be removed after remove clps_read(write) macros */
> > > > > +#include <mach/hardware.h>
> > > > > +#define _PADR	(CLPS711X_VIRT_BASE + PADR)
> > > > > +#define _PBDR	(CLPS711X_VIRT_BASE + PBDR)
> > > > > +#define _PCDR	(CLPS711X_VIRT_BASE + PCDR)
> > > > > +#define _PDDR	(CLPS711X_VIRT_BASE + PDDR)
> > > > > +#define _PADDR	(CLPS711X_VIRT_BASE + PADDR)
> > > > > +#define _PBDDR	(CLPS711X_VIRT_BASE + PBDDR)
> > > > > +#define _PCDDR	(CLPS711X_VIRT_BASE + PCDDR)
> > > > > +#define _PDDDR	(CLPS711X_VIRT_BASE + PDDDR)
> > > > > +#define _PEDR	(CLPS711X_VIRT_BASE + PEDR)
> > > > > +#define _PEDDR	(CLPS711X_VIRT_BASE + PEDDR)
> > > > 
> > > > Why can't this file (or the bulk of it) live in drivers/gpio ?
> > > We should have access for macros in gpio.h from board support files
> > > and other drivers. From drivers/gpio it not possible.
> > > If you ask about port definitions, as I say before, it will be
> > > removed later after rework on platform hardware definitions.
> > 
> > No other drivers should be directly accessing the GPIO registers -
> > doing so is likely a bug because of the inherent lack of locking,
> > which will cause race conditions.
> > 
> > All accesses to GPIOs should be done via gpiolib, even from board
> > support files.
> 
> Yes, and I am say only about macro that calculate GPIO-number from
> port number and bit position. Access to this is a helpful for understand
> source code.

Sorry, I don't think you're understanding.

Why can't you put:

#define _PADR        (CLPS711X_VIRT_BASE + PADR)

and the other macros inside drivers/gpio/gpio-clps711x.c ?  This should
be the _only_ file which uses them.
