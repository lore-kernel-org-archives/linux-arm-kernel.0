From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Sep 2010 16:53:57 +0200
Subject: [PATCH 1/6] spi-imx: add CSPI and eCSPI support for i.MX51 MCU
In-Reply-To: <1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
Message-ID: <20100902145357.GL14214@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

On Thu, Sep 02, 2010 at 03:51:59PM +0800, Jason Wang wrote:
> There are 3 SPI controllers on i.MX51, one is called CSPI and is
> 100% compatible with the one on i.MX35, the other two are called
> eCSPI and are not compatible with existing controllers on other
> i.MX platforms, here we add support of these three controllers in
> the imx spi driver.
> 
> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
> ---
>  drivers/spi/spi_imx.c |  135 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 131 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 7972e90..8d9c9da 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -155,6 +155,120 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
>  	return 7;
>  }
>  
> +/* MX51 eCSPI post divider */
> +static unsigned int spi_imx_clkdiv_3(unsigned int fin,
> +		unsigned int fspi)
> +{
> +	int i, div = 1;
> +
> +	for (i = 0; i < 15; i++) {
> +		if (fspi * div >= fin)
> +			return i;
> +		div <<= 1;
> +	}
> +
> +	return 15;
> +}
This is different in Sascha's patch.  Didn't try yet to understand the
difference.

> +
> +#define MX51_INTREG_TEEN		(1 << 0)
> +#define MX51_INTREG_RREN		(1 << 3)
> +
> +#define MX51_CSPICTRL_ENABLE		(1 << 0)
> +#define MX51_CSPICTRL_XCH		(1 << 2)
> +
> +#define MX51_CSPICTRL_BL_SHIFT		20
> +#define MX51_CSPICTRL_CS_SHIFT		18
> +#define MX51_CSPICTRL_DR_SHIFT		8
> +#define MX51_CSPICTRL_MODE_SHIFT	4
> +#define MX51_CSPICONF_PHA_SHIFT		0
> +#define MX51_CSPICONF_POL_SHIFT		4
> +#define MX51_CSPICONF_SSPOL_SHIFT	12
> +#define MX51_CSPICONF_SSCTL_SHIFT	8
> +
> +#define MX51_CSPICTRL_CSMASK		0x3
> +#define MX51_CSPIINT			0x10
> +#define MX51_CSPICONF			0xC
> +#define MX51_CSPISTATUS			0x18
> +#define MX51_STATUS_RR			(1 << 3)
> +
> +#define MAX_CHIPSELECT_NUM 4
> +
> +static int get_chipselect(struct spi_imx_data *spi_imx,
> +			  struct spi_imx_config *config)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_CHIPSELECT_NUM; i++) {
> +		if (config->cs == spi_imx->chipselect[i])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +static void mx51_intctrl(struct spi_imx_data *spi_imx, int enable)
> +{
> +	unsigned int val = 0;
> +
> +	if (enable & MXC_INT_TE)
> +		val |= MX51_INTREG_TEEN;
> +	if (enable & MXC_INT_RR)
> +		val |= MX51_INTREG_RREN;
> +
> +	writel(val, spi_imx->base + MX51_CSPIINT);
> +}
> +
> +static void mx51_trigger(struct spi_imx_data *spi_imx)
> +{
> +	unsigned int reg;
> +
> +	reg = readl(spi_imx->base + MXC_CSPICTRL);
> +	reg |= MX51_CSPICTRL_XCH;
> +	writel(reg, spi_imx->base + MXC_CSPICTRL);
> +}
> +
> +static int mx51_config(struct spi_imx_data *spi_imx,
> +		struct spi_imx_config *config)
> +{
> +	unsigned int config_reg = 0;
> +	unsigned int ctrl_reg = MX51_CSPICTRL_ENABLE;
> +	int chan;
> +
> +	chan = get_chipselect(spi_imx, config);
> +	if (chan < 0)
> +		return chan;
can this happen?  Does that have to do with using a GPIO for CS?

> +	ctrl_reg |= (chan & MX51_CSPICTRL_CSMASK) << MX51_CSPICTRL_CS_SHIFT;
> +	ctrl_reg |= (1 << (chan & MX51_CSPICTRL_CSMASK)) <<
> +		MX51_CSPICTRL_MODE_SHIFT;
> +	ctrl_reg |= spi_imx_clkdiv_3(spi_imx->spi_clk, config->speed_hz) <<
> +		MX51_CSPICTRL_DR_SHIFT;
> +
> +	ctrl_reg |= (config->bpw - 1) << MX51_CSPICTRL_BL_SHIFT;
> +
> +
duplicated empty line

> +	if (config->mode & SPI_CPHA)
> +		config_reg |= (1 << (chan & MX51_CSPICTRL_CSMASK)) <<
> +			MX51_CSPICONF_PHA_SHIFT;
> +	if (config->mode & SPI_CPOL)
> +		config_reg |= (1 << (chan & MX51_CSPICTRL_CSMASK)) <<
> +			MX51_CSPICONF_POL_SHIFT;
> +	if (config->mode & SPI_CS_HIGH)
> +		config_reg |= (1 << (chan & MX51_CSPICTRL_CSMASK)) <<
> +			MX51_CSPICONF_SSPOL_SHIFT;
> +
> +	config_reg |= (1 << (chan & MX51_CSPICTRL_CSMASK)) <<
> +		MX51_CSPICONF_SSCTL_SHIFT;
> +
> +	writel(ctrl_reg, spi_imx->base + MXC_CSPICTRL);
> +	writel(config_reg, spi_imx->base + MX51_CSPICONF);
> +
> +	return 0;
> +}
> +
> +static int mx51_rx_available(struct spi_imx_data *spi_imx)
> +{
> +	return readl(spi_imx->base + MX51_CSPISTATUS) & MX51_STATUS_RR;
> +}
> +
>  #define MX31_INTREG_TEEN	(1 << 0)
>  #define MX31_INTREG_RREN	(1 << 3)
>  
> @@ -209,7 +323,7 @@ static int mx31_config(struct spi_imx_data *spi_imx,
>  
>  	if (cpu_is_mx31())
>  		reg |= (config->bpw - 1) << MX31_CSPICTRL_BC_SHIFT;
> -	else if (cpu_is_mx25() || cpu_is_mx35()) {
> +	else if (cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51()) {
>  		reg |= (config->bpw - 1) << MX35_CSPICTRL_BL_SHIFT;
>  		reg |= MX31_CSPICTRL_SSCTL;
>  	}
> @@ -223,7 +337,7 @@ static int mx31_config(struct spi_imx_data *spi_imx,
>  	if (config->cs < 0) {
>  		if (cpu_is_mx31())
>  			reg |= (config->cs + 32) << MX31_CSPICTRL_CS_SHIFT;
> -		else if (cpu_is_mx25() || cpu_is_mx35())
> +		else if (cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51())
>  			reg |= (config->cs + 32) << MX35_CSPICTRL_CS_SHIFT;
>  	}
>  
> @@ -567,7 +681,14 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
>  		goto out_iounmap;
>  	}
>  
> -	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35()) {
> +	/* i.MX51 has two eCSPI and one CSPI controllers, eCSPI controllers are
> +	 * not compatible with existing SPI controllers on other i.MX platforms,
> +	 * while CSPI controller is 100% compatible with the one on the i.MX35.
> +	 * We set the platform device id to 2 for this CSPI at i.MX51 board init
> +	 * level to distinguish it from two eCSPI controllers.
> +	 */
This comment is missing in Sascha's driver.  I like it.
BTW, I'd like to make use of platform ids in this driver.  This would
make this ugly "on imx51 id2 is a cspi" distinction unnecessary.

> +	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35() ||
> +	    (cpu_is_mx51() && (pdev->id == 2))) {
>  		spi_imx->intctrl = mx31_intctrl;
>  		spi_imx->config = mx31_config;
>  		spi_imx->trigger = mx31_trigger;
> @@ -582,6 +703,11 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
>  		spi_imx->config = mx1_config;
>  		spi_imx->trigger = mx1_trigger;
>  		spi_imx->rx_available = mx1_rx_available;
> +	} else if (cpu_is_mx51()) {
> +		spi_imx->intctrl = mx51_intctrl;
> +		spi_imx->config = mx51_config;
> +		spi_imx->trigger = mx51_trigger;
> +		spi_imx->rx_available = mx51_rx_available;
>  	} else
>  		BUG();
>  
> @@ -599,7 +725,8 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
>  		writel(1, spi_imx->base + MXC_RESET);
>  
>  	/* drain receive buffer */
> -	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35())
> +	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35() ||
> +	    (cpu_is_mx51() && (pdev->id == 2)))
>  		while (readl(spi_imx->base + MX3_CSPISTAT) & MX3_CSPISTAT_RR)
>  			readl(spi_imx->base + MXC_CSPIRXDATA);
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
