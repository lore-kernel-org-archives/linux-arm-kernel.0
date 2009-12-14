From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 14 Dec 2009 11:41:38 +0100
Subject: [PATCH 3/4] regulator: add voltage selection capability to
	mc13783 regulators.
In-Reply-To: <20091213200142.GC14024@pengutronix.de>
References: <1260635829.2054.16.camel@climbing-alby>
	<1260636523.2054.28.camel@climbing-alby>
	<1260636819.2054.33.camel@climbing-alby>
	<1260636976.2054.36.camel@climbing-alby>
	<20091213200142.GC14024@pengutronix.de>
Message-ID: <1260787298.2022.55.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il giorno dom, 13/12/2009 alle 21.01 +0100, Uwe Kleine-K?nig ha scritto:
> On Sat, Dec 12, 2009 at 05:56:16PM +0100, Alberto Panizzo wrote:
> > This patch, complete the mc13783 regulator subsystem driver with 
> > voltage selecting capability.
> > Main Switches (SW1AB, SW2AB) are not supported yet.
> > 
> > Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> > ---
> >  drivers/regulator/mc13783-regulator.c |  375 ++++++++++++++++++++++++++++++---
> >  1 files changed, 348 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
> > index 9f99862..ed78137 100644
> > --- a/drivers/regulator/mc13783-regulator.c
> > +++ b/drivers/regulator/mc13783-regulator.c
> > @@ -2,6 +2,7 @@
> >   * Regulator Driver for Freescale MC13783 PMIC
> >   *
> >   * Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
> > + * Copyright 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
> >   *
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of the GNU General Public License version 2 as
> > @@ -18,9 +19,47 @@
> >  
> >  #define MC13783_REG_SWITCHERS4			28
> >  #define MC13783_REG_SWITCHERS4_PLLEN			(1 << 18)
> > +#define MC13783_REG_SWITCHERS4_PLLVSEL			(1 << 19)
> > +#define MC13783_REG_SWITCHERS4_PLLVSEL_M		(7 << 19)
> >  
> >  #define MC13783_REG_SWITCHERS5			29
> >  #define MC13783_REG_SWITCHERS5_SW3EN			(1 << 20)
> > +#define MC13783_REG_SWITCHERS5_SW3VSEL			18
> This looks inconsitent:
> 	MC13783_REG_SWITCHERS4_PLLVSEL	(1 << 19)
> 	MC13783_REG_SWITCHERS5_SW3VSEL	18
> 
> I didn't check the rest of the patch though it would be great if you
> wouldn't need all those arrays as they occupy much memory.
> 
> Best regards
> Uwe
> 

Yes this is a mistake and.. I'm not sure to embrace SWITCHERS4_PLL in
the regulators stuff at all.
The code that I propose can enable/disable and set the multiplication
factor for the PLL but this is not a voltage regulator!

Maybe the PLL must be initialised and controlled via another driver, 
in the audio codec?

For the arrays, also for me it is not the better code that I wrote
but voltages values have no regular stepping and this way is a great 
self explain way.
Look at tables 4-18 and 4-19 of the mc13783 information for GPL drivers..

The other ways are:
- Compress arrays in different phases, with complex initialisation.
- Write as many function as different regulators there are, increasing
  the driver complexity and also the text instead of data memory..

Sure, I have to correct all the coding style issues asserted by Mark!

Alberto.
