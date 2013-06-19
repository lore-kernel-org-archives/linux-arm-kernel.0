From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 19 Jun 2013 22:29:22 +0200
Subject: [PATCH v2 6/7] drivers: bus: imx-weim: Add support for
 i.MX1/21/25/27/31/35/50/51/53
In-Reply-To: <1371672993.387718746@f288.i.mail.ru>
References: <1371671678-6345-1-git-send-email-shc_work@mail.ru>
 <1371671678-6345-6-git-send-email-shc_work@mail.ru>
 <20130619200757.GC14308@pengutronix.de>
 <1371672993.387718746@f288.i.mail.ru>
Message-ID: <20130619202922.GM32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 12:16:33AM +0400, Alexander Shiyan wrote:
> > Hi Alexander,
> > 
> > Nice work!
> > 
> > On Wed, Jun 19, 2013 at 11:54:37PM +0400, Alexander Shiyan wrote:
> > > - - fsl,weim-cs-timing:	The timing array, contains 6 timing values for the
> > > + - fsl,weim-cs-timing:	The timing array, contains timing values for the
> > >  			child node. We can get the CS index from the child
> > > -			node's "reg" property. This property contains the values
> > > -			for the registers EIM_CSnGCR1, EIM_CSnGCR2, EIM_CSnRCR1,
> > > +			node's "reg" property. For example, if i.MX6Q CPU
> > > +			is used, this property contains the values for the
> > > +			registers EIM_CSnGCR1, EIM_CSnGCR2, EIM_CSnRCR1,
> > >  			EIM_CSnRCR2, EIM_CSnWCR1, EIM_CSnWCR2 in this order.
> > > +			For other i.MX CPUs count of register and register
> > > +			names may be different.
> > 
> > I think here we should have a more precise description for each SoC.
> 
> OK.
> 
> > >  Example for an imx6q-sabreauto board, the NOR flash connected to the WEIM:
> > >  
> > > diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> > > index 1f70e84..4faedc21 100644
> > > --- a/drivers/bus/Kconfig
> > > +++ b/drivers/bus/Kconfig
> > > @@ -8,10 +8,10 @@ config IMX_WEIM
> > >  	bool "Freescale EIM DRIVER"
> > >  	depends on ARCH_MXC
> > >  	help
> > > -	  Driver for i.MX6 WEIM controller.
> > > +	  Driver for i.MX WEIM controller.
> > >  	  The WEIM(Wireless External Interface Module) works like a bus.
> > >  	  You can attach many different devices on it, such as NOR, onenand.
> > > -	  But now, we only support the Parallel NOR.
> > > +	  But now, we only support the "of_physmap" driver.
> > 
> > This comment is wrong. In the early versions of this patch indeed only
> > parallel NOR was supported, but now there is no limitation on the device
> > type anymore.
> 
> I am do not think so. But I will not insist on his opinion.
> I checked the operation only for physmap-flash and mtd-ram.

The first version of the driver looked for a child node named 'nor' and
registered only that one. Now it calls of_platform_populate which
registers everything found under the weim node.

> 
> ...
> > >  static const struct of_device_id weim_id_table[] = {
> > > +	/* i.MX1/21 */
> > > +	{ .compatible = "fsl,imx1-weim", .data = &imx1_weim_devtype, },
> > > +	/* i.MX25/27/31/35 */
> > > +	{ .compatible = "fsl,imx25-weim", .data = &imx25_weim_devtype, },
> > 
> > We usually name the compatible name after the oldest i.MX supporting
> > this IP, not after the lowest number. So this should be imx27, not
> > imx25.
> 
> OK. Seems this fact also avoid [7/7] part. Is not it?

I think i.MX50 is older than i.MX6, so 7/7 should be correct.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
