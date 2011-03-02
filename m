From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 Mar 2011 13:09:43 +0100
Subject: [PATCH] ARM: mxs/mx28evk: add flexcan devices
In-Reply-To: <20110302114549.GC21601@S2100-06.ap.freescale.net>
References: <1299063284-21795-1-git-send-email-shawn.guo@freescale.com>
	<20110302111148.GV29521@pengutronix.de>
	<20110302114549.GC21601@S2100-06.ap.freescale.net>
Message-ID: <20110302120943.GY29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 07:45:50PM +0800, Shawn Guo wrote:
> On Wed, Mar 02, 2011 at 12:11:48PM +0100, Sascha Hauer wrote:
> > Hi Shawn,
> > 
> Hi Sascha,
> 
> > On Wed, Mar 02, 2011 at 06:54:44PM +0800, Shawn Guo wrote:
> > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > > ---
> > >  arch/arm/mach-mxs/Kconfig        |    1 +
> > >  arch/arm/mach-mxs/mach-mx28evk.c |   37 +++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 38 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> > > index 55bf075..9a1f2cb 100644
> > > --- a/arch/arm/mach-mxs/Kconfig
> > > +++ b/arch/arm/mach-mxs/Kconfig
> > > @@ -31,6 +31,7 @@ config MACH_MX28EVK
> > >  	select MXS_HAVE_AMBA_DUART
> > >  	select MXS_HAVE_PLATFORM_AUART
> > >  	select MXS_HAVE_PLATFORM_FEC
> > > +	select MXS_HAVE_PLATFORM_FLEXCAN
> > >  	select MXS_OCOTP
> > >  	default y
> > >  	help
> > > diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
> > > index 1f0b708..3cefb73 100644
> > > --- a/arch/arm/mach-mxs/mach-mx28evk.c
> > > +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> > > @@ -28,6 +28,7 @@
> > >  #include "devices-mx28.h"
> > >  #include "gpio.h"
> > >  
> > > +#define MX28EVK_FLEXCAN_SWITCH	MXS_GPIO_NR(2, 13)
> > >  #define MX28EVK_FEC_PHY_POWER	MXS_GPIO_NR(2, 15)
> > >  #define MX28EVK_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
> > >  
> > > @@ -95,6 +96,15 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
> > >  	/* phy reset line */
> > >  	MX28_PAD_ENET0_RX_CLK__GPIO_4_13 |
> > >  		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > > +
> > > +	/* flexcan0 */
> > > +	MX28_PAD_GPMI_RDY2__CAN0_TX,
> > > +	MX28_PAD_GPMI_RDY3__CAN0_RX,
> > > +	/* flexcan1 */
> > > +	MX28_PAD_GPMI_CE2N__CAN1_TX,
> > > +	MX28_PAD_GPMI_CE3N__CAN1_RX,
> > > +	/* transceiver power control */
> > > +	MX28_PAD_SSP1_CMD__GPIO_2_13,
> > >  };
> > >  
> > >  /* fec */
> > > @@ -178,8 +188,28 @@ error:
> > >  	return -ETIMEDOUT;
> > >  }
> > >  
> > > +/* flexcan */
> > > +static void mx28evk_flexcan_switch(int enable)
> > > +{
> > > +	static int count;
> > > +
> > > +	if (enable) {
> > > +		if (!count++)
> > > +			gpio_set_value(MX28EVK_FLEXCAN_SWITCH, 1);
> > > +	} else {
> > > +		if (!--count)
> > > +			gpio_set_value(MX28EVK_FLEXCAN_SWITCH, 0);
> > > +	}
> > > +}
> > 
> > Why this count variable? It shouldn't hurt to call gpio_set_value
> > multiple times.
> > 
> This gpio controls the power of both flexcan0 and flexcan1
> transceivers, and we do not want one power-off really shut the power
> down if the other is still on.

Ok, I see. You should add a comment making this clear. Or maybe even
better, add a switch function for each controller and do the actual
switching based on "both off" instead of a counter. This even will
work when the flexcan driver has unbalanced switch calls.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
