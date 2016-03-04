From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 4 Mar 2016 12:47:37 +0100
Subject: [PATCH 6/9] spi: imx: remove unnecessary bit clearing in
 mx51_ecspi_config
In-Reply-To: <56D968DF.7000007@mentor.com>
References: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
 <1456302033-25638-7-git-send-email-s.hauer@pengutronix.de>
 <56D968DF.7000007@mentor.com>
Message-ID: <20160304114737.GE21869@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 12:52:15PM +0200, Vladimir Zapolskiy wrote:
> Hi Sascha,
> 
> On 24.02.2016 10:20, Sascha Hauer wrote:
> > This reverts patch 1476253cef (spi: imx: fix ecspi mode setup)
> > The patch tried to fix something by clearing bits in the cfg variable,
> > but cfg is initialized to zero on function entry. There are no bits to
> > clear.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> I believe here the expected fix should be
> 
> ----8<----
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 6a4ff27..9c9bae0 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -316,9 +316,10 @@ static void __maybe_unused mx51_ecspi_trigger(struct
> spi_imx_data *spi_imx)
>  static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
>  		struct spi_imx_config *config)
>  {
> -	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0, dma = 0;
> +	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, dma = 0;
>  	u32 tx_wml_cfg, rx_wml_cfg, rxt_wml_cfg;
>  	u32 clk = config->speed_hz, delay, reg;
> +	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
> 

With this change applied we would indeed have to clear and not only set the bits,
but why would we do this?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
