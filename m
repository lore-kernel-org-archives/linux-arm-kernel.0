From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 14 Jan 2011 13:48:40 +0800
Subject: [PATCH v4 05/10] net/fec: add dual fec support for mx28
In-Reply-To: <20110113144805.GS24920@pengutronix.de>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
	<1294297998-26930-6-git-send-email-shawn.guo@freescale.com>
	<20110113144805.GS24920@pengutronix.de>
Message-ID: <20110114054838.GA14491@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, Jan 13, 2011 at 03:48:05PM +0100, Uwe Kleine-K?nig wrote:

[...]

> > +/* Controller is ENET-MAC */
> > +#define FEC_QUIRK_ENET_MAC           (1 << 0)
> does this really qualify to be a quirk?
> 
My understanding is that ENET-MAC is a type of "quirky" FEC
controller.

> > +/* Controller needs driver to swap frame */
> > +#define FEC_QUIRK_SWAP_FRAME         (1 << 1)
> IMHO this is a bit misnamed.  FEC_QUIRK_NEEDS_BE_DATA or similar would
> be more accurate.
> 
When your make this change, you may want to pick a better name for
function swap_buffer too.

[...]

> > +static void *swap_buffer(void *bufaddr, int len)
> > +{
> > +     int i;
> > +     unsigned int *buf = bufaddr;
> > +
> > +     for (i = 0; i < (len + 3) / 4; i++, buf++)
> > +             *buf = cpu_to_be32(*buf);
> if len isn't a multiple of 4 this accesses bytes behind len.  Is this
> generally OK here?  (E.g. because skbs always have a length that is a
> multiple of 4?)
The len may not be a multiple of 4.  But I believe bufaddr is always
a buffer allocated in a length that is a multiple of 4, and the 1~3
bytes exceeding the len very likely has no data that matters.  But
yes, it deserves a safer implementation.

[...]

> > +     /*
> > +      * The dual fec interfaces are not equivalent with enet-mac.
> > +      * Here are the differences:
> > +      *
> > +      *  - fec0 supports MII & RMII modes while fec1 only supports RMII
> > +      *  - fec0 acts as the 1588 time master while fec1 is slave
> > +      *  - external phys can only be configured by fec0
> > +      *
> > +      * That is to say fec1 can not work independently. It only works
> > +      * when fec0 is working. The reason behind this design is that the
> > +      * second interface is added primarily for Switch mode.
> > +      *
> > +      * Because of the last point above, both phys are attached on fec0
> > +      * mdio interface in board design, and need to be configured by
> > +      * fec0 mii_bus.
> > +      */
> > +     if ((id_entry->driver_data & FEC_QUIRK_ENET_MAC) && pdev->id) {
> > +             /* fec1 uses fec0 mii_bus */
> > +             fep->mii_bus = fec0_mii_bus;
> > +             return 0;
> What happens if imx28-fec.1 is probed before imx28-fec.0?
It's something that generally should not happen, as these two fec are
not equivalent, and fec.1 should always be added after fec.0 if you
intend to get dual interfaces.  But yes, we should add error checking
for this case in the driver.

-- 
Regards,
Shawn
