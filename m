From: mgr@pengutronix.de (Michael Grzeschik)
Date: Fri, 23 Nov 2012 17:20:51 +0100
Subject: [PATCH v3 5/7] usb: chipidea: usbmisc: add support for ahb,
 ipg and per clock
In-Reply-To: <20121123065115.GC22420@nchen-desktop>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
 <1353506793-8354-6-git-send-email-m.grzeschik@pengutronix.de>
 <20121123065115.GC22420@nchen-desktop>
Message-ID: <20121123162051.GA31008@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 02:51:16PM +0800, Peter Chen wrote:
> On Wed, Nov 21, 2012 at 03:06:31PM +0100, Michael Grzeschik wrote:
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > 
> > This patch adds support for a second and third clock to the usbmisc driver. On
> > modern freescale ARM cores like the imx51, imx53 and imx6q three clocks ("ahb",
> > "ipg" and "per") must be enabled in order to access the USB core.
> 
> The imx6q usb's clock structure is different with old mxc serials (mx3x, mx5x)
> due to different PHY. This patch will cause mx6q's probe fail, the message
> like below:
> 
> imx_usb 2184000.usb: Failed to get clock, err=-2
> imx_usb: probe of 2184000.usb failed with error -2
> 
> The mx5x (50, 51, 53) and mx6q's clock structure like below:
> 
> mx5x:
> - usboh3_ipg_ahb: CCGR2(index13), used to access register
> (like your ahb)

That is probably the one, which already gets enabled inside the
ci13xxx_imx code.

> - usboh3_60M: CCGR2(index14), used to access register at serial phy mode
> as the phy is at serial mode, we need to use it at the first before the phy
> goes to other modes.
> (like your ipg)



> usbphy: used to transfer data
> (like your per)

The "per" clk is a different clk than the usbphy. We have an usbphy clk
aswell on the mx5x. As discussed before [1], we need a solution to enable
the usbphy clk. The current approach is to let the nop-xceiver enable
this.

[1] http://www.spinics.net/lists/linux-usb/msg74489.html

> mx6q:
> - usboh3(Index 162 at DT), used to access register
> - usbphy(Index 182 for otg port at DT), at phy controller

> So, we may consider a way to consolidate both mx6q (mx28) and mxc (mx5x, mx3x)
> platforms.

Yes, we will discuss a real clktree solution in the usbmisc driver for
the different cores. The first thoughts are, that the clk configuration
has completely to be done inside the usbmisc driver. For this, the
usbmisc needs to become a hard dependency for the ci13xxx_imx glue code.

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
