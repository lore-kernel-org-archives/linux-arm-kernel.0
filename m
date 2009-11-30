From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Nov 2009 13:10:17 +0100
Subject: [PATCH 8/9 v2] MXC: Add a digital audio multiplexer driver
In-Reply-To: <eedb5540911300356p2b41eeaakee050953ad39ec26@mail.gmail.com>
References: <1258022525-21078-2-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-3-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-4-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-5-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-6-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-7-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-8-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-9-git-send-email-s.hauer@pengutronix.de>
	<20091112150615.GA30179@pengutronix.de>
	<eedb5540911300356p2b41eeaakee050953ad39ec26@mail.gmail.com>
Message-ID: <20091130121017.GN27548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2009 at 12:56:19PM +0100, javier Martin wrote:
> Hi Sascha,
> as you know I have been testing your i.MX27 support and I have found a
> problem in this audmux patch.
> 
> Please, see my comment below:
> 
> 
> +++ b/arch/arm/plat-mxc/audmux-v1.c
> > @@ -0,0 +1,53 @@
> > +/*
> > + * Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
> > + *
> > + * Initial development of this code was funded by
> > + * Phytec Messtechnik GmbH, http://www.phytec.de
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/clk.h>
> > +#include <mach/audmux.h>
> > +#include <mach/hardware.h>
> > +
> > +static void __iomem *audmux_base;
> > +
> > +#define MXC_AUDMUX_V1_PCR(x)   ((x) * 4)
> >
> 
> You cannot calculate AUDMUX register offsets this way because according to
> i.MX27 manual:
> 
> 0x1001_6000 (HPCR1)
> 0x1001_6004 (HPCR2)
> 0x1001_6008 (HPCR3)
> 0x1001_6010 (PPCR1)  <-- You are using 0x0C for this
> 0x1001_6014 (PPCR2)  <--- You are using 0x10 for this
> 0x1001_601C (PPCR3)  <--- You are using 0x18 for this

It's fine the way it is. See mach/audmux.h:

#define MX27_AUDMUX_HPCR1_SSI0		0
#define MX27_AUDMUX_HPCR2_SSI1		1
#define MX27_AUDMUX_HPCR3_SSI_PINS_4	2
#define MX27_AUDMUX_PPCR1_SSI_PINS_1	3
#define MX27_AUDMUX_PPCR2_SSI_PINS_2	4
#define MX27_AUDMUX_PPCR3_SSI_PINS_3	5

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
