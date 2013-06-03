From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Jun 2013 13:41:06 +0800
Subject: [RFC v2 3/5] SPI: imx: Remove "maybe_unused" attributes
In-Reply-To: <1370168531-22718-3-git-send-email-shc_work@mail.ru>
References: <1370168531-22718-1-git-send-email-shc_work@mail.ru>
 <1370168531-22718-3-git-send-email-shc_work@mail.ru>
Message-ID: <20130603054104.GI13970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 02, 2013 at 02:22:09PM +0400, Alexander Shiyan wrote:
> The SPI driver is being compiled for all i.MX platforms, so "maybe_unused"
> attributes is no longer needed. This patch removes these attributes.
> 
Though I'm not the fan of using __maybe_unused, the commit log is not
quite correct.  It's not true that all i.MX platforms have to be
compiled together.  I can easily build a kernel for a particular i.MX
platform by deselect other platforms from defconfig.

Shawn

> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/spi/spi-imx.c | 45 +++++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 65f73d6..3b703f8 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -235,7 +235,7 @@ static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi)
>  		(post << MX51_ECSPI_CTRL_POSTDIV_OFFSET);
>  }
>  
> -static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
> +static void mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
>  {
>  	unsigned val = 0;
>  
> @@ -248,7 +248,7 @@ static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int
>  	writel(val, spi_imx->base + MX51_ECSPI_INT);
>  }
>  
> -static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
> +static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
>  {
>  	u32 reg;
>  
> @@ -257,8 +257,8 @@ static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
>  	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
>  }
>  
> -static int __maybe_unused mx51_ecspi_config(struct spi_device *spi,
> -		struct spi_imx_config *config)
> +static int mx51_ecspi_config(struct spi_device *spi,
> +			     struct spi_imx_config *config)
>  {
>  	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
>  	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0;
> @@ -298,12 +298,12 @@ static int __maybe_unused mx51_ecspi_config(struct spi_device *spi,
>  	return 0;
>  }
>  
> -static int __maybe_unused mx51_ecspi_rx_available(struct spi_imx_data *spi_imx)
> +static int mx51_ecspi_rx_available(struct spi_imx_data *spi_imx)
>  {
>  	return readl(spi_imx->base + MX51_ECSPI_STAT) & MX51_ECSPI_STAT_RR;
>  }
>  
> -static void __maybe_unused mx51_ecspi_reset(struct spi_imx_data *spi_imx)
> +static void mx51_ecspi_reset(struct spi_imx_data *spi_imx)
>  {
>  	/* drain receive buffer */
>  	while (mx51_ecspi_rx_available(spi_imx))
> @@ -333,7 +333,7 @@ static void __maybe_unused mx51_ecspi_reset(struct spi_imx_data *spi_imx)
>   * the i.MX35 has a slightly different register layout for bits
>   * we do not use here.
>   */
> -static void __maybe_unused mx31_intctrl(struct spi_imx_data *spi_imx, int enable)
> +static void mx31_intctrl(struct spi_imx_data *spi_imx, int enable)
>  {
>  	unsigned int val = 0;
>  
> @@ -345,7 +345,7 @@ static void __maybe_unused mx31_intctrl(struct spi_imx_data *spi_imx, int enable
>  	writel(val, spi_imx->base + MXC_CSPIINT);
>  }
>  
> -static void __maybe_unused mx31_trigger(struct spi_imx_data *spi_imx)
> +static void mx31_trigger(struct spi_imx_data *spi_imx)
>  {
>  	unsigned int reg;
>  
> @@ -354,8 +354,7 @@ static void __maybe_unused mx31_trigger(struct spi_imx_data *spi_imx)
>  	writel(reg, spi_imx->base + MXC_CSPICTRL);
>  }
>  
> -static int __maybe_unused mx31_config(struct spi_device *spi,
> -		struct spi_imx_config *config)
> +static int mx31_config(struct spi_device *spi, struct spi_imx_config *config)
>  {
>  	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
>  	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
> @@ -386,12 +385,12 @@ static int __maybe_unused mx31_config(struct spi_device *spi,
>  	return 0;
>  }
>  
> -static int __maybe_unused mx31_rx_available(struct spi_imx_data *spi_imx)
> +static int mx31_rx_available(struct spi_imx_data *spi_imx)
>  {
>  	return readl(spi_imx->base + MX31_CSPISTATUS) & MX31_STATUS_RR;
>  }
>  
> -static void __maybe_unused mx31_reset(struct spi_imx_data *spi_imx)
> +static void mx31_reset(struct spi_imx_data *spi_imx)
>  {
>  	/* drain receive buffer */
>  	while (readl(spi_imx->base + MX31_CSPISTATUS) & MX31_STATUS_RR)
> @@ -411,7 +410,7 @@ static void __maybe_unused mx31_reset(struct spi_imx_data *spi_imx)
>  #define MX21_CSPICTRL_DR_SHIFT	14
>  #define MX21_CSPICTRL_CS_SHIFT	19
>  
> -static void __maybe_unused mx21_intctrl(struct spi_imx_data *spi_imx, int enable)
> +static void mx21_intctrl(struct spi_imx_data *spi_imx, int enable)
>  {
>  	unsigned int val = 0;
>  
> @@ -423,7 +422,7 @@ static void __maybe_unused mx21_intctrl(struct spi_imx_data *spi_imx, int enable
>  	writel(val, spi_imx->base + MXC_CSPIINT);
>  }
>  
> -static void __maybe_unused mx21_trigger(struct spi_imx_data *spi_imx)
> +static void mx21_trigger(struct spi_imx_data *spi_imx)
>  {
>  	unsigned int reg;
>  
> @@ -432,8 +431,7 @@ static void __maybe_unused mx21_trigger(struct spi_imx_data *spi_imx)
>  	writel(reg, spi_imx->base + MXC_CSPICTRL);
>  }
>  
> -static int __maybe_unused mx21_config(struct spi_device *spi,
> -		struct spi_imx_config *config)
> +static int mx21_config(struct spi_device *spi, struct spi_imx_config *config)
>  {
>  	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
>  	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_MASTER;
> @@ -457,12 +455,12 @@ static int __maybe_unused mx21_config(struct spi_device *spi,
>  	return 0;
>  }
>  
> -static int __maybe_unused mx21_rx_available(struct spi_imx_data *spi_imx)
> +static int mx21_rx_available(struct spi_imx_data *spi_imx)
>  {
>  	return readl(spi_imx->base + MXC_CSPIINT) & MX21_INTREG_RR;
>  }
>  
> -static void __maybe_unused mx21_reset(struct spi_imx_data *spi_imx)
> +static void mx21_reset(struct spi_imx_data *spi_imx)
>  {
>  	writel(1, spi_imx->base + MXC_RESET);
>  }
> @@ -478,7 +476,7 @@ static void __maybe_unused mx21_reset(struct spi_imx_data *spi_imx)
>  #define MX1_CSPICTRL_MASTER	(1 << 10)
>  #define MX1_CSPICTRL_DR_SHIFT	13
>  
> -static void __maybe_unused mx1_intctrl(struct spi_imx_data *spi_imx, int enable)
> +static void mx1_intctrl(struct spi_imx_data *spi_imx, int enable)
>  {
>  	unsigned int val = 0;
>  
> @@ -490,7 +488,7 @@ static void __maybe_unused mx1_intctrl(struct spi_imx_data *spi_imx, int enable)
>  	writel(val, spi_imx->base + MXC_CSPIINT);
>  }
>  
> -static void __maybe_unused mx1_trigger(struct spi_imx_data *spi_imx)
> +static void mx1_trigger(struct spi_imx_data *spi_imx)
>  {
>  	unsigned int reg;
>  
> @@ -499,8 +497,7 @@ static void __maybe_unused mx1_trigger(struct spi_imx_data *spi_imx)
>  	writel(reg, spi_imx->base + MXC_CSPICTRL);
>  }
>  
> -static int __maybe_unused mx1_config(struct spi_device *spi,
> -		struct spi_imx_config *config)
> +static int mx1_config(struct spi_device *spi, struct spi_imx_config *config)
>  {
>  	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
>  	unsigned int reg = MX1_CSPICTRL_ENABLE | MX1_CSPICTRL_MASTER;
> @@ -519,12 +516,12 @@ static int __maybe_unused mx1_config(struct spi_device *spi,
>  	return 0;
>  }
>  
> -static int __maybe_unused mx1_rx_available(struct spi_imx_data *spi_imx)
> +static int mx1_rx_available(struct spi_imx_data *spi_imx)
>  {
>  	return readl(spi_imx->base + MXC_CSPIINT) & MX1_INTREG_RR;
>  }
>  
> -static void __maybe_unused mx1_reset(struct spi_imx_data *spi_imx)
> +static void mx1_reset(struct spi_imx_data *spi_imx)
>  {
>  	writel(1, spi_imx->base + MXC_RESET);
>  }
> -- 
> 1.8.1.5
> 
