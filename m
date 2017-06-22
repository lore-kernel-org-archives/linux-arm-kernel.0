From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Thu, 22 Jun 2017 16:11:35 +0200
Subject: [RFC PATCH 1/4] EDAC: mvebu: Add driver for Marvell Armada SoCs
In-Reply-To: <1497014062.3536.52.camel@pengutronix.de>
References: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
 <20170608041124.4624-2-chris.packham@alliedtelesis.co.nz>
 <1497014062.3536.52.camel@pengutronix.de>
Message-ID: <1498140695.2533.76.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Fr, 2017-06-09 at 15:14 +0200, Jan L?bbe wrote:
> > +static void mvebu_init_csrows(struct mem_ctl_info *mci,
> > +                             struct mvebu_mc_pdata *pdata)
> [...]
> > +     devtype = (ctl >> 20) & 0x3;
> > +     switch (devtype) {
> > +     case 0x0:
> > +             dimm->dtype = DEV_X32;
> > +             break;
> > +     case 0x2:               /* could be X8 too, but no way to tell
> */
> > +             dimm->dtype = DEV_X16;
> > +             break;
> > +     case 0x3:
> > +             dimm->dtype = DEV_X4;
> > +             break;
> > +     default:
> > +             dimm->dtype = DEV_UNKNOWN;
> > +             break;
> > +     }
> This register is documented as reserved? I pulled the X8/X16
> information from the Address Control Register (CSnStruct bits).

Do you have more information on how to decode the Bus width?

It's not clear from the MV78230/78x60 docs:
- The SDRAM Configuration Register, offset 15 bit is:
  0 = Half (32 bit data bus)
  1 = Full (64 bit data bus)
- The SDRAM Address Control Register, offsets 0-1, 4-5, 8-9 and 12-13
(for CS 0, 1, 3 and 4):
  0 = X8
  1 = X16
  2 and 3 are not documented

Is this clearer in your documentation, so that we can have the same code
handle both variants? Otherwise, we'd probably need separate DT
compatibles.

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
