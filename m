From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Jan 2011 11:43:28 +0100
Subject: [PATCH 2/3] ARM i.MX53 enable spi on EVK board
In-Reply-To: <20110111091549.GL24920@pengutronix.de>
References: <1294661334-7826-1-git-send-email-yong.shen@freescale.com>
	<1294661334-7826-2-git-send-email-yong.shen@freescale.com>
	<20110111091549.GL24920@pengutronix.de>
Message-ID: <20110111104328.GI26617@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 10:15:49AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> I'd prefer to have the following subject:
> 
> 	ARM: mx5/mx53_evk: add spi device
> 
> On Mon, Jan 10, 2011 at 08:08:53PM +0800, yong.shen at freescale.com wrote:
> > From: Yong Shen <yong.shen@freescale.com>
> > 
> > 1. some macro definitions fix
> > 2. add platform data for spi device
> > 3. register spi clocks
> > 
> > Signed-off-by: Yong Shen <yong.shen@freescale.com>
> > ---
> >  arch/arm/mach-mx5/Kconfig                    |    1 +
> >  arch/arm/mach-mx5/board-mx53_evk.c           |   14 ++++++++++++++
> >  arch/arm/mach-mx5/clock-mx51-mx53.c          |    3 +++
> >  arch/arm/mach-mx5/devices-imx53.h            |    4 ++++
> >  arch/arm/plat-mxc/devices/platform-spi_imx.c |   12 ++++++++++++
> >  arch/arm/plat-mxc/include/mach/mx53.h        |   10 +++++-----
> >  6 files changed, 39 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> > index 23b0e3f..777740b 100644
> > --- a/arch/arm/mach-mx5/Kconfig
> > +++ b/arch/arm/mach-mx5/Kconfig
> > @@ -126,6 +126,7 @@ config MACH_MX53_EVK
> >  	select IMX_HAVE_PLATFORM_IMX_UART
> >  	select IMX_HAVE_PLATFORM_IMX_I2C
> >  	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
> > +	select IMX_HAVE_PLATFORM_SPI_IMX
> >  	help
> >  	  Include support for MX53 EVK platform. This includes specific
> >  	  configurations for the board and its peripherals.
> > diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
> > index 4043451..8017d68 100644
> > --- a/arch/arm/mach-mx5/board-mx53_evk.c
> > +++ b/arch/arm/mach-mx5/board-mx53_evk.c
> > @@ -33,6 +33,8 @@
> >  #include <mach/iomux-mx53.h>
> >  
> >  #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
> > +#define EVK_ECSPI1_CS0		IMX_GPIO_NR(3, 19)
> > +#define EVK_ECSPI1_CS1		IMX_GPIO_NR(2, 30)
> >  
> >  #include "crm_regs.h"
> >  #include "devices-imx53.h"
> > @@ -89,6 +91,16 @@ static struct fec_platform_data mx53_evk_fec_pdata = {
> >  	.phy = PHY_INTERFACE_MODE_RMII,
> >  };
> >  
> > +static int mx53_evk_spi_cs[] = {
> > +	EVK_ECSPI1_CS0,
> > +	EVK_ECSPI1_CS1,
> don't you need to setup some pinmuxing to make this work?
> 
> > +};
> > +
> > +static const struct spi_imx_master mx53_evk_spi_data __initconst = {
> > +	.chipselect     = mx53_evk_spi_cs,
> > +	.num_chipselect = ARRAY_SIZE(mx53_evk_spi_cs),
> > +};
> > +
> >  static void __init mx53_evk_board_init(void)
> >  {
> >  	mxc_iomux_v3_setup_multiple_pads(mx53_evk_pads,
> > @@ -102,6 +114,8 @@ static void __init mx53_evk_board_init(void)
> >  
> >  	imx53_add_sdhci_esdhc_imx(0, NULL);
> >  	imx53_add_sdhci_esdhc_imx(1, NULL);
> > +
> > +	imx53_add_ecspi(0, &mx53_evk_spi_data);
> >  }
> >  
> >  static void __init mx53_evk_timer_init(void)
> > diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> > index d0f58a3..a20d0c0 100644
> > --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> > +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> > @@ -1330,6 +1330,9 @@ static struct clk_lookup mx53_lookups[] = {
> >  	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
> >  	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
> >  	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
> > +	_REGISTER_CLOCK("imx53-ecspi.0", NULL, ecspi1_clk)
> > +	_REGISTER_CLOCK("imx53-ecspi.1", NULL, ecspi2_clk)
> > +	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
> maybe this should better go into a seperate patch?  (i.e.
> 
> 	ARM: mx53: add support to dynamically register imx-spi devices

Yes. We should not add mix architecture support and board support in a
single patch.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
