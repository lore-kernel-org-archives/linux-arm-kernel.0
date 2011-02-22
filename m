From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Feb 2011 20:22:05 +0800
Subject: [PATCH v3 5/6] ARM: mxs/mx23evk: add mmc device
In-Reply-To: <20110222083344.GV22310@pengutronix.de>
References: <1298284979-14853-1-git-send-email-shawn.guo@freescale.com>
	<1298284979-14853-6-git-send-email-shawn.guo@freescale.com>
	<20110222083344.GV22310@pengutronix.de>
Message-ID: <20110222122204.GC19871@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Tue, Feb 22, 2011 at 09:33:44AM +0100, Uwe Kleine-K?nig wrote:
> On Mon, Feb 21, 2011 at 06:42:58PM +0800, Shawn Guo wrote:
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  arch/arm/mach-mxs/Kconfig        |    1 +
> >  arch/arm/mach-mxs/mach-mx23evk.c |   47 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 48 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> > index cd2fbdf..f47fae3 100644
> > --- a/arch/arm/mach-mxs/Kconfig
> > +++ b/arch/arm/mach-mxs/Kconfig
> > @@ -19,6 +19,7 @@ config MACH_MX23EVK
> >  	bool "Support MX23EVK Platform"
> >  	select SOC_IMX23
> >  	select MXS_HAVE_AMBA_DUART
> > +	select MXS_HAVE_PLATFORM_MMC
> >  	default y
> >  	help
> >  	  Include support for MX23EVK platform. This includes specific
> > diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
> > index aa06400..21519e3 100644
> > --- a/arch/arm/mach-mxs/mach-mx23evk.c
> > +++ b/arch/arm/mach-mxs/mach-mx23evk.c
> > @@ -26,17 +26,64 @@
> >  
> >  #include "devices-mx23.h"
> >  
> > +#define MX23EVK_MMC0_WRITE_PROTECT	MXS_GPIO_NR(1, 30)
> > +#define MX23EVK_MMC0_SLOT_POWER		MXS_GPIO_NR(1, 29)
> > +
> >  static const iomux_cfg_t mx23evk_pads[] __initconst = {
> >  	/* duart */
> >  	MX23_PAD_PWM0__DUART_RX | MXS_PAD_4MA,
> >  	MX23_PAD_PWM1__DUART_TX | MXS_PAD_4MA,
> > +
> > +	/* mmc */
> > +	MX23_PAD_SSP1_DATA0__SSP1_DATA0 |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX23_PAD_SSP1_DATA1__SSP1_DATA1 |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX23_PAD_SSP1_DATA2__SSP1_DATA2 |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX23_PAD_SSP1_DATA3__SSP1_DATA3 |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX23_PAD_GPMI_D08__SSP1_DATA4 |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX23_PAD_GPMI_D09__SSP1_DATA5 |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX23_PAD_GPMI_D10__SSP1_DATA6 |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX23_PAD_GPMI_D11__SSP1_DATA7 |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX23_PAD_SSP1_CMD__SSP1_CMD |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX23_PAD_SSP1_DETECT__SSP1_DETECT |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_SSP1_SCK__SSP1_SCK |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	/* write protect */
> > +	MX23_PAD_PWM4__GPIO_1_30 |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	/* slot power enable */
> > +	MX23_PAD_PWM3__GPIO_1_29 |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +};
> > +
> > +static struct mxs_mmc_platform_data mx23_mmc_pdata __initdata = {
> > +	.wp_gpio = MX23EVK_MMC0_WRITE_PROTECT,
> > +	.flags = SLOTF_8_BIT_CAPABLE,
> can this be const?
> 
Do you care this much to see a new version of the patch?

-- 
Regards,
Shawn
