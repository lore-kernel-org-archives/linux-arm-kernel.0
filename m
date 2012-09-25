From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Tue, 25 Sep 2012 11:35:14 +0900
Subject: [PATCH 1/3] mmc: sdhci: rename platform_8bit_width to
 platform_bus_width
In-Reply-To: <1348471345-30785-2-git-send-email-s.hauer@pengutronix.de>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <50611862.7010201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2012 04:22 PM, Sascha Hauer wrote:
> The 8bit in the function name is misleading. When set, it will be
> used to set the bus width, regardless of whether 8bit or another
> bus width is requested, so change the function name to
> platform_bus_width.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mmc/host/sdhci-pci.c   |    4 ++--
>  drivers/mmc/host/sdhci-pxav2.c |    2 +-
>  drivers/mmc/host/sdhci-s3c.c   |    8 ++++----
>  drivers/mmc/host/sdhci-tegra.c |    4 ++--
>  drivers/mmc/host/sdhci.c       |    8 ++++----
>  drivers/mmc/host/sdhci.h       |    2 +-
>  6 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 504da715..cf34b8d 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -934,7 +934,7 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
>  	return 0;
>  }
>  
> -static int sdhci_pci_8bit_width(struct sdhci_host *host, int width)
> +static int sdhci_pci_bus_width(struct sdhci_host *host, int width)
>  {
>  	u8 ctrl;
>  
> @@ -976,7 +976,7 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
>  
>  static struct sdhci_ops sdhci_pci_ops = {
>  	.enable_dma	= sdhci_pci_enable_dma,
> -	.platform_8bit_width	= sdhci_pci_8bit_width,
> +	.platform_bus_width	= sdhci_pci_bus_width,
>  	.hw_reset		= sdhci_pci_hw_reset,
>  };
>  
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index b6ee885..f380de8 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -121,7 +121,7 @@ static u32 pxav2_get_max_clock(struct sdhci_host *host)
>  static struct sdhci_ops pxav2_sdhci_ops = {
>  	.get_max_clock = pxav2_get_max_clock,
>  	.platform_reset_exit = pxav2_set_private_registers,
> -	.platform_8bit_width = pxav2_mmc_set_width,
> +	.platform_bus_width = pxav2_mmc_set_width,
>  };
>  
>  #ifdef CONFIG_OF
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index a50c205..776ef3a 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -322,14 +322,14 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>  }
>  
>  /**
> - * sdhci_s3c_platform_8bit_width - support 8bit buswidth
> + * sdhci_s3c_platform_bus_width - support 8bit buswidth
>   * @host: The SDHCI host being queried
>   * @width: MMC_BUS_WIDTH_ macro for the bus width being requested
>   *
>   * We have 8-bit width support but is not a v3 controller.
> - * So we add platform_8bit_width() and support 8bit width.
> + * So we add platform_bus_width() and support 8bit width.
>   */
> -static int sdhci_s3c_platform_8bit_width(struct sdhci_host *host, int width)
> +static int sdhci_s3c_platform_bus_width(struct sdhci_host *host, int width)
>  {
>  	u8 ctrl;
>  
> @@ -359,7 +359,7 @@ static struct sdhci_ops sdhci_s3c_ops = {
>  	.get_max_clock		= sdhci_s3c_get_max_clk,
>  	.set_clock		= sdhci_s3c_set_clock,
>  	.get_min_clock		= sdhci_s3c_get_min_clock,
> -	.platform_8bit_width	= sdhci_s3c_platform_8bit_width,
> +	.platform_bus_width	= sdhci_s3c_platform_bus_width,
>  };
>  
>  static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 0810ccc..1f51667 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -144,7 +144,7 @@ static void tegra_sdhci_reset_exit(struct sdhci_host *host, u8 mask)
>  	}
>  }
>  
> -static int tegra_sdhci_8bit(struct sdhci_host *host, int bus_width)
> +static int tegra_sdhci_buswidth(struct sdhci_host *host, int bus_width)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_tegra *tegra_host = pltfm_host->priv;
> @@ -171,7 +171,7 @@ static struct sdhci_ops tegra_sdhci_ops = {
>  	.read_l     = tegra_sdhci_readl,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_l    = tegra_sdhci_writel,
> -	.platform_8bit_width = tegra_sdhci_8bit,
> +	.platform_bus_width = tegra_sdhci_buswidth,
>  	.platform_reset_exit = tegra_sdhci_reset_exit,
>  };
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9a11dc3..9043a3c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1372,11 +1372,11 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>  	/*
>  	 * If your platform has 8-bit width support but is not a v3 controller,
>  	 * or if it requires special setup code, you should implement that in
> -	 * platform_8bit_width().
> +	 * platform_bus_width().
>  	 */
> -	if (host->ops->platform_8bit_width)
> -		host->ops->platform_8bit_width(host, ios->bus_width);
> -	else {
> +	if (host->ops->platform_bus_width) {
> +		host->ops->platform_bus_width(host, ios->bus_width);
> +	} else {
Why add the brackets? 

Best Regards,
Jaehoon Chung
>  		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>  		if (ios->bus_width == MMC_BUS_WIDTH_8) {
>  			ctrl &= ~SDHCI_CTRL_4BITBUS;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 97653ea..efce211 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -267,7 +267,7 @@ struct sdhci_ops {
>  	unsigned int	(*get_max_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_min_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
> -	int		(*platform_8bit_width)(struct sdhci_host *host,
> +	int		(*platform_bus_width)(struct sdhci_host *host,
>  					       int width);
>  	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
>  					     u8 power_mode);
> 
