From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Nov 2012 16:09:34 +0100
Subject: [PATCH v2 5/7] usb: chipidea: usbmisc: add support for ahb, ipg
 and per clock
In-Reply-To: <87r4nt6610.fsf@ashishki-desk.ger.corp.intel.com>
References: <1352981028-14312-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352981028-14312-6-git-send-email-m.grzeschik@pengutronix.de>
 <87r4nt6610.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20121120150934.GF24458@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 03:17:47PM +0200, Alexander Shishkin wrote:
> Michael Grzeschik <m.grzeschik@pengutronix.de> writes:
> 
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> >
> > This patch adds support for a second and third clock to the usbmisc driver. On
> > modern freescale ARM cores like the imx51, imx53 and imx6q three clocks ("ahb",
> > "ipg" and "per") must be enabled in order to access the USB core.
> >
> > ahb - AMBA High-Performance Bus clock domain
> > ipg - IP-Bus Gate clock domain
> > per - Peripheral clock domain
> 
> Looks like usbmisc_imx and ci13xxx_imx are growing more and more common
> code.
> Btw, shouldn't there be a way to specify platform's clock tree
> configuration via devicetree or whatnot so that each platform driver
> didn't have to request platform specific clocks?

In theory that is the case. The clocks should be modeled after the input
clocks of the device (ci13xxx). Every SoC should have them, but on some
SoCs some of them may not be software controllable, so they have to
provide dummy clocks for these.
So when everyting is done correctly in the driver, the calls to clk_get
could be in the core instead of ci13xxx_imx. That said, we do not have
good insights into the SoC, so we do not know exactly which clock inputs
the ci13xx has and where they are connected in the SoCs clock module.
There are some guesses in there.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
