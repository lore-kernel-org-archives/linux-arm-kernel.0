From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Fri, 4 Mar 2016 12:52:15 +0200
Subject: [PATCH 6/9] spi: imx: remove unnecessary bit clearing in
 mx51_ecspi_config
In-Reply-To: <1456302033-25638-7-git-send-email-s.hauer@pengutronix.de>
References: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
 <1456302033-25638-7-git-send-email-s.hauer@pengutronix.de>
Message-ID: <56D968DF.7000007@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 24.02.2016 10:20, Sascha Hauer wrote:
> This reverts patch 1476253cef (spi: imx: fix ecspi mode setup)
> The patch tried to fix something by clearing bits in the cfg variable,
> but cfg is initialized to zero on function entry. There are no bits to
> clear.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I believe here the expected fix should be

----8<----

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6a4ff27..9c9bae0 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -316,9 +316,10 @@ static void __maybe_unused mx51_ecspi_trigger(struct
spi_imx_data *spi_imx)
 static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
-	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0, dma = 0;
+	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, dma = 0;
 	u32 tx_wml_cfg, rx_wml_cfg, rxt_wml_cfg;
 	u32 clk = config->speed_hz, delay, reg;
+	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);

 	/*
 	 * The hardware seems to have a race condition when changing modes. The

----8<----

> ---
>  drivers/spi/spi-imx.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 15b23f0..287ec0c 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -366,20 +366,13 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
>  
>  	if (config->mode & SPI_CPHA)
>  		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
> -	else
> -		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
>  
>  	if (config->mode & SPI_CPOL) {
>  		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
>  		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
> -	} else {
> -		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
> -		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
>  	}
>  	if (config->mode & SPI_CS_HIGH)
>  		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
> -	else
> -		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(config->cs);
>  
>  	/* CTRL register always go first to bring out controller from reset */
>  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
> 

--
With best wishes,
Vladimir
