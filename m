From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 27 Nov 2012 08:34:22 +0100
Subject: [PATCH 2/9] usb: chipidea: ci13xxx_imx: add 2nd and 3rd clock to
 support imx5x and newer
In-Reply-To: <20121127065026.GA18593@nchen-desktop>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-3-git-send-email-m.grzeschik@pengutronix.de>
 <20121126092931.GA15740@nchen-desktop>
 <20121126102232.GG10369@pengutronix.de>
 <20121127065026.GA18593@nchen-desktop>
Message-ID: <20121127073422.GJ10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 02:50:26PM +0800, Peter Chen wrote:
> On Mon, Nov 26, 2012 at 11:22:32AM +0100, Sascha Hauer wrote:
> > On Mon, Nov 26, 2012 at 05:29:31PM +0800, Peter Chen wrote:
> > > On Wed, Nov 14, 2012 at 05:19:03PM +0100, Michael Grzeschik wrote:
> > > > This patch adds support for a second and third clock to the chipidea driver. On
> > > > modern freescale ARM cores like the imx51, imx53 and imx6q three clocks ("ahb",
> > > > "ipg" and "per") must be enabled in order to access the USB core.
> > > > 
> > > > In the original driver, the clock was requested without specifying the
> > > > connection id, further all mainline ARM archs with support for the chipidea
> > > > core (imx23, imx28) register their USB clock without a connection id.
> > > > 
> > > > This patch first renames the existing clk variable to clk_ahb. The connection
> > > > id "ahb" is added to the devm_clk_get() call. Then the clocks "ipg" and "per"
> > > > are requested. As all archs don't specify a connection id, all clk_get return
> > > > the same clock. This ensures compatibility to existing USB support and adds
> > > > support for imx5x at the same time.
> > > > 
> > > > This patch has been tested on imx28 and on imx53 with seperate "ahb", "ipg"
> > > > and "per" clocks.
> > > mx23, mx28, and mx6q has the same usb clock sources and different with
> > > mxc (mx5x, mx3x).
> > > 
> > > I am not sure which method is better:
> > > - Add dummy clock at clock.c
> > > - Add platform information(id_table or something similar) at driver.
> > > 
> > > Add dummy clock may confuse some users, for example, mx6q has no
> > > "per" and "ipg" clock at all.
> > 
> > The general idea is: The USB core has different input clocks. The driver
> > has to be provided with these input clocks. When i.MX6 does not have
> > these clocks, it only means that this SoC has no software controllable
> > gates for these clocks, thus they are not documented. Still this SoC
> > has these clocks.
> > This way we can describe the differences between the SoC purely on SoC
> > level without bothering the driver.
> > You might want to ask your hardware guys to get more information what
> > input clocks the USB core actually has, there actually is a lot of
> > guesswork in it due to missing/inconsistent/confusing documentation.
> Discussed with USB IC module owner, some feedback like below:
> - You are correct, the input clock for controller is always same, there
> are three sources:
> 	- ahb
> 	- xcvr_clk
> 	- xcvr_ser_clk
> - ahb: the source is the system ipg and ahb source, but for usb subsystem,
> there is NO separate control for ipg and ahb, there is only one bit
> to control ipg and ahb clock together, just like we say usboh3_ipg_ahb bit
> at CCM for mx51. The USB controller internal will have two clocks, one for
> ipg (visit register), and the other is ahb (access DDR). 
> From the system point, we only need to control usboh3_ipg_ahb,
> so, this clock is better as "usb_ahb". "ipg" clock for usb may only the
> system ipg clock.

The i.MX27 has separate gates for ipg (PCCR1[25]) and ahb PCCR1[11])

> 
> -xcvr_clk: it is the phy output clk, the software can't control it,
> (for mx28/mx6q, it can be controlled from phy controller), the software
> can only choose the PHY clk source.
> 
> -xcvr_ser_clk, it is used at serial phy mode, we need it as the default
> phy mode is serial.
> I find we take it as "usb_per" at mx5 platform, but this xcvr_ser_clk is
> fixed (60M), and can't be adjusted (it is not different with 54M TLL clock).
> 
> So in order to consolidate i.mx usb clock, do you think below definitions
> are ok:
> usb_ahb: ahb clock used to visit register and access DDR
> usb_ipg: system ipg clock (mx28 usb no ipg clock)
> usb_per: serial phy clock, it is useless if serial phy is not supported, eg mx28, mx6q.
> usb_phy: phy clock source, either from 24M or PLL.
> 
> So, in order to align with kinds of platforms, I suggest:
> If the clock exists and share the same bit at CCM with others
> (like usb_ahb and usb_ipg at some platforms), give the same clock num
> but different connection id.

Yes.

> If the clock does not exists, just give a dummy clock but with 
> connection id (like usb_per at imx6q).

Yes.

Thanks for the informations, it's good to be able to get feedback from
the hardware people.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
