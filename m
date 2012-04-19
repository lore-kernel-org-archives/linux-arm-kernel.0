From: B29397@freescale.com (Chen Peter-B29397)
Date: Thu, 19 Apr 2012 02:54:18 +0000
Subject: [PATCH 08/10] MXS: Add separate MXS EHCI HCD driver
In-Reply-To: <20120418094546.GO3852@pengutronix.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334714869-19282-9-git-send-email-marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B766FD@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120418084001.GN3852@pengutronix.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B767E8@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120418094546.GO3852@pengutronix.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B76EB5@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



 
> >
> > > > >
> > > > > This driver will handle i.MX233/i.MX28 and I hope soon i.MX6Q. I
> > > tried to
> > > > > keep
> > > > > this separate from the MXC EHCI to avoid further polution of the
> MXC
> > > EHCI,
> > > > > though eventually these two might be merged.
> > > > >
> > > > As mxc and mxs platforms use the same USB controller (chipidea's),
> I
> > > wonder if
> > > > you can use ehci-mxc, or change name from ehci-mxc to ehci-imx?
> > > > Sascha, what's your opinion?
> > >
> > > Maybe better ehci-imx. I think it's a good idea to not use the ehci-
> mxc
> > > glue code but instead write a mxs specific glue code with having in
> > > mind that later we want to drop ehci-mxc and use ehci-imx for all imx
> > > including mxs. This assumes the USB folks are ok with this, I don't
> > > know.
> > >
> > How about create a patch changing name from ehci-mxc to ehci-imx first,
> then add
> > mx28/mx23/mx6q host ehci driver. I can do it.
> 
> ehci-imx won't need clock handling and it won't need phy handling. Also
> the setup of the portsc register won't be in the new driver. The
> clk_get(dev, "usb_phy1") part is horribly broken anyway. It's more than
> just a rename.
>
It depends on how you want things to go on, you can
- Create ehci-mxs first, then clean up clk/phy at ehci-mxs/ehci-mxc after 
generic phy driver and i.mx usb DT support is added, then merge ehci-mxs
and ehci-mxc to one ehci-imx. Not sure usb maintainers agree it or not.
- Or rename ehci-mxc to ehci-imx, add mx28 support to ehci-imx. Then, 
clean up clk/phy after phy driver and DT support are ready. This way
the driver ehci-mxs will not appear at drivers/usb/host all the time.

 
> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |
