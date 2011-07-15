From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 14 Jul 2011 20:53:42 -0600
Subject: [PATCH v2 2/7] spi/imx: use mx21 to name SPI_IMX_VER_0_0
	function and macro
In-Reply-To: <20110711073523.GB13840@pengutronix.de>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
	<1310231801-18761-3-git-send-email-shawn.guo@linaro.org>
	<20110711073523.GB13840@pengutronix.de>
Message-ID: <20110715025342.GQ2927@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 09:35:23AM +0200, Uwe Kleine-K?nig wrote:
> On Sun, Jul 10, 2011 at 01:16:36AM +0800, Shawn Guo wrote:
> > SPI_IMX_VER_0_0 covers i.mx21 and i.mx27.  It makes more sense to
> > use mx21 rather than mx27 to name SPI_IMX_VER_0_0 function and
> > macro, since i.mx21 comes out ealier than i.mx27.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >  drivers/spi/spi-imx.c |   67 +++++++++++++++++++++++++------------------------
> >  1 files changed, 34 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> > index 1c55dc9..ad928b1 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -406,70 +406,71 @@ static void __maybe_unused spi_imx0_4_reset(struct spi_imx_data *spi_imx)
> >  		readl(spi_imx->base + MXC_CSPIRXDATA);
> >  }
> >  
> > -#define MX27_INTREG_RR		(1 << 4)
> > -#define MX27_INTREG_TEEN	(1 << 9)
> > -#define MX27_INTREG_RREN	(1 << 13)
> > -
> > -#define MX27_CSPICTRL_POL	(1 << 5)
> > -#define MX27_CSPICTRL_PHA	(1 << 6)
> > -#define MX27_CSPICTRL_SSPOL	(1 << 8)
> > -#define MX27_CSPICTRL_XCH	(1 << 9)
> > -#define MX27_CSPICTRL_ENABLE	(1 << 10)
> > -#define MX27_CSPICTRL_MASTER	(1 << 11)
> > -#define MX27_CSPICTRL_DR_SHIFT	14
> > -#define MX27_CSPICTRL_CS_SHIFT	19
> > -
> > -static void __maybe_unused mx27_intctrl(struct spi_imx_data *spi_imx, int enable)
> > +#define MX21_INTREG_RR		(1 << 4)
> > +#define MX21_INTREG_TEEN	(1 << 9)
> > +#define MX21_INTREG_RREN	(1 << 13)
> > +
> > +#define MX21_CSPICTRL_POL	(1 << 5)
> > +#define MX21_CSPICTRL_PHA	(1 << 6)
> > +#define MX21_CSPICTRL_SSPOL	(1 << 8)
> > +#define MX21_CSPICTRL_XCH	(1 << 9)
> > +#define MX21_CSPICTRL_ENABLE	(1 << 10)
> > +#define MX21_CSPICTRL_MASTER	(1 << 11)
> > +#define MX21_CSPICTRL_DR_SHIFT	14
> > +#define MX21_CSPICTRL_CS_SHIFT	19
> > +
> > +static void __maybe_unused
> > +mx21_intctrl(struct spi_imx_data *spi_imx, int enable)
> this needs to be intended. I usually use 2 tabs (and I'm quite annoyed
> that vim doesn't do that for me).

More importantly, the function name should be on the same line as the
annotations and return value.  When grepping for function names, it is
more important to see the annotations that the parameters (you can
tell visually if there are parameters on the next line, but you can't
tell if there are extra annotations).

I've fixed it up.

Applied, thanks.

g.

> 
> >  {
> >  	unsigned int val = 0;
> >  
> >  	if (enable & MXC_INT_TE)
> > -		val |= MX27_INTREG_TEEN;
> > +		val |= MX21_INTREG_TEEN;
> >  	if (enable & MXC_INT_RR)
> > -		val |= MX27_INTREG_RREN;
> > +		val |= MX21_INTREG_RREN;
> >  
> >  	writel(val, spi_imx->base + MXC_CSPIINT);
> >  }
> >  
> > -static void __maybe_unused mx27_trigger(struct spi_imx_data *spi_imx)
> > +static void __maybe_unused mx21_trigger(struct spi_imx_data *spi_imx)
> >  {
> >  	unsigned int reg;
> >  
> >  	reg = readl(spi_imx->base + MXC_CSPICTRL);
> > -	reg |= MX27_CSPICTRL_XCH;
> > +	reg |= MX21_CSPICTRL_XCH;
> >  	writel(reg, spi_imx->base + MXC_CSPICTRL);
> >  }
> >  
> > -static int __maybe_unused mx27_config(struct spi_imx_data *spi_imx,
> > +static int __maybe_unused mx21_config(struct spi_imx_data *spi_imx,
> >  		struct spi_imx_config *config)
> >  {
> > -	unsigned int reg = MX27_CSPICTRL_ENABLE | MX27_CSPICTRL_MASTER;
> > +	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_MASTER;
> >  	int cs = spi_imx->chipselect[config->cs];
> >  
> >  	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, config->speed_hz) <<
> > -		MX27_CSPICTRL_DR_SHIFT;
> > +		MX21_CSPICTRL_DR_SHIFT;
> >  	reg |= config->bpw - 1;
> >  
> >  	if (config->mode & SPI_CPHA)
> > -		reg |= MX27_CSPICTRL_PHA;
> > +		reg |= MX21_CSPICTRL_PHA;
> >  	if (config->mode & SPI_CPOL)
> > -		reg |= MX27_CSPICTRL_POL;
> > +		reg |= MX21_CSPICTRL_POL;
> >  	if (config->mode & SPI_CS_HIGH)
> > -		reg |= MX27_CSPICTRL_SSPOL;
> > +		reg |= MX21_CSPICTRL_SSPOL;
> >  	if (cs < 0)
> > -		reg |= (cs + 32) << MX27_CSPICTRL_CS_SHIFT;
> > +		reg |= (cs + 32) << MX21_CSPICTRL_CS_SHIFT;
> >  
> >  	writel(reg, spi_imx->base + MXC_CSPICTRL);
> >  
> >  	return 0;
> >  }
> >  
> > -static int __maybe_unused mx27_rx_available(struct spi_imx_data *spi_imx)
> > +static int __maybe_unused mx21_rx_available(struct spi_imx_data *spi_imx)
> >  {
> > -	return readl(spi_imx->base + MXC_CSPIINT) & MX27_INTREG_RR;
> > +	return readl(spi_imx->base + MXC_CSPIINT) & MX21_INTREG_RR;
> >  }
> >  
> > -static void __maybe_unused spi_imx0_0_reset(struct spi_imx_data *spi_imx)
> > +static void __maybe_unused mx21_reset(struct spi_imx_data *spi_imx)
> >  {
> >  	writel(1, spi_imx->base + MXC_RESET);
> >  }
> > @@ -552,11 +553,11 @@ static struct spi_imx_devtype_data spi_imx_devtype_data[] = {
> >  #endif
> >  #ifdef CONFIG_SPI_IMX_VER_0_0
> >  	[SPI_IMX_VER_0_0] = {
> > -		.intctrl = mx27_intctrl,
> > -		.config = mx27_config,
> > -		.trigger = mx27_trigger,
> > -		.rx_available = mx27_rx_available,
> > -		.reset = spi_imx0_0_reset,
> > +		.intctrl = mx21_intctrl,
> > +		.config = mx21_config,
> > +		.trigger = mx21_trigger,
> > +		.rx_available = mx21_rx_available,
> > +		.reset = mx21_reset,
> >  		.fifosize = 8,
> >  	},
> >  #endif
> > -- 
> > 1.7.4.1
> > 
> > 
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
