From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 9 Dec 2011 12:08:07 +0100
Subject: [PATCH] [RFC] pinctrl: add a driver for Energy Micro's efm32 SoCs
In-Reply-To: <20111209051413.GK7913@S2100-06.ap.freescale.net>
References: <1323384057-31452-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF1750B77BD8@HQMAIL01.nvidia.com>
 <20111209010147.GH7913@S2100-06.ap.freescale.net>
 <4EE18403.30604@nvidia.com>
 <20111209043220.GJ7913@S2100-06.ap.freescale.net>
 <4EE192DC.3080209@nvidia.com>
 <20111209051413.GK7913@S2100-06.ap.freescale.net>
Message-ID: <20111209110807.GG27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 01:14:14PM +0800, Shawn Guo wrote:
> On Thu, Dec 08, 2011 at 09:47:24PM -0700, Stephen Warren wrote:
> > 
> > pin X: function = UART A TX
> > pin Y: function = UART A RX
> > 
> 
> We really do not expect per pin function mapping but per block function
> mapping.  That said, the UART driver is going to tell pinctrl subsystem
> "I'm UARTA, please set all my pins up for me".

I still think it should be "I'm board Y, please set all my pins up for me"

Drivers should not be bothered with pin muxing *at all*. When we add
pinmux_request to drivers all SoCs using this driver are doomed to
implement pinmux support regardless if they have any pinmux support in
hardware or not.
Where this leads we can currently see in current next branch with the
smc91x driver where one single board has a regulator for.  Suddenly all
other boards using this driver stopped working because they have no
regulator provided for the driver.
There is this CONFIG_REGULATOR_DUMMY option which will cause *all*
regulator_request to succeed on all regulators in this binary which
disqualifies this option for multiboard/SoC Kernels.

A pin setup is board specific and not driver specific. There are only
some corner cases where a driver has to do something with the pin setup
like for example on i.MX6 where the drive strength setting has to be
changed with different card speeds.

There is also no value in being able to say which pins are allocated
by which driver. All we really want is being able to abstract the
pinmux in some common way and being able to detect conflicts.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
