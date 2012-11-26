From: mgr@pengutronix.de (Michael Grzeschik)
Date: Mon, 26 Nov 2012 16:44:13 +0100
Subject: [PATCH v3 5/7] usb: chipidea: usbmisc: add support for ahb,
 ipg and per clock
In-Reply-To: <20121125091834.GA16661@nchen-desktop>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
 <1353506793-8354-6-git-send-email-m.grzeschik@pengutronix.de>
 <20121123065115.GC22420@nchen-desktop>
 <20121123162051.GA31008@pengutronix.de>
 <20121125091834.GA16661@nchen-desktop>
Message-ID: <20121126154413.GB31008@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 25, 2012 at 05:18:35PM +0800, Peter Chen wrote:
> On Fri, Nov 23, 2012 at 05:20:51PM +0100, Michael Grzeschik wrote:
> > > usbphy: used to transfer data
> > > (like your per)
> > 
> > The "per" clk is a different clk than the usbphy. We have an usbphy clk
> > aswell on the mx5x. As discussed before [1], we need a solution to enable
> > the usbphy clk. The current approach is to let the nop-xceiver enable
> > this.
> > 
> > [1] http://www.spinics.net/lists/linux-usb/msg74489.html
> It does not matter which the name is, this clock is related to usb 480M or 
> its source. We use nop-xceiver is just to create struct usb_otg
> and usb_phy. Clock information can be at imx specific file like
> cil13xxx_imx.

I think the clock task needs to become a sepreate topic, apart from this
series.

> > 
> > > mx6q:
> > > - usboh3(Index 162 at DT), used to access register
> > > - usbphy(Index 182 for otg port at DT), at phy controller
> > 
> > > So, we may consider a way to consolidate both mx6q (mx28) and mxc (mx5x, mx3x)
> > > platforms.
> > 
> > Yes, we will discuss a real clktree solution in the usbmisc driver for
> > the different cores. The first thoughts are, that the clk configuration
> > has completely to be done inside the usbmisc driver. For this, the
> > usbmisc needs to become a hard dependency for the ci13xxx_imx glue code.
> 
> For my mind, imx usb clock handling is better only at place, that is
> cil13xxx_imx. We can have imx_clk_enable and imx_clk_disable in it,
> and handling clk in imx_clk_enable using id_table or what else platform
> specific.

As already mentioned, the clock layout differs from SoC to SoC.
Therefore the usbmisc can become a mandatory instance over the
ci13xxx_imx instances in all imx cases. This controlling interface can
define the special clock setups and connection types for the underlying
usb cores.

I will send the next series without this clock handling.

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
