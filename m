From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 15 Feb 2011 13:44:17 -0700
Subject: [PATCH] spi/imx: select master mode for all channels
In-Reply-To: <1297195739-24951-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1297195739-24951-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110215204417.GA28005@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 08, 2011 at 09:08:59PM +0100, Uwe Kleine-K?nig wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The hardware seems to have a race condition when the inactive
> channels are in slave mode. We support master mode only, so
> we can just switch all channels to master mode.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> [ukleinek: add more verbose comment about the race]
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> maybe one of our friends at Freescale can comment?

Any feedback on this one?  Or should I just merge it?

g.

> 
> Best regards
> Uwe
> 
>  drivers/spi/spi_imx.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 1cf9d5f..69d6dba 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -174,7 +174,7 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
>  #define SPI_IMX2_3_CTRL		0x08
>  #define SPI_IMX2_3_CTRL_ENABLE		(1 <<  0)
>  #define SPI_IMX2_3_CTRL_XCH		(1 <<  2)
> -#define SPI_IMX2_3_CTRL_MODE(cs)	(1 << ((cs) +  4))
> +#define SPI_IMX2_3_CTRL_MODE_MASK	(0xf << 4)
>  #define SPI_IMX2_3_CTRL_POSTDIV_OFFSET	8
>  #define SPI_IMX2_3_CTRL_PREDIV_OFFSET	12
>  #define SPI_IMX2_3_CTRL_CS(cs)		((cs) << 18)
> @@ -253,8 +253,14 @@ static int __maybe_unused spi_imx2_3_config(struct spi_imx_data *spi_imx,
>  {
>  	u32 ctrl = SPI_IMX2_3_CTRL_ENABLE, cfg = 0;
>  
> -	/* set master mode */
> -	ctrl |= SPI_IMX2_3_CTRL_MODE(config->cs);
> +	/*
> +	 * The hardware seems to have a race condition when changing modes. The
> +	 * current assumption is that the selection of the channel arrives
> +	 * earlier in the hardware than the mode bits when they are written at
> +	 * the same time.
> +	 * So set master mode for all channels as we do not support slave mode.
> +	 */
> +	ctrl |= SPI_IMX2_3_CTRL_MODE_MASK;
>  
>  	/* set clock speed */
>  	ctrl |= spi_imx2_3_clkdiv(spi_imx->spi_clk, config->speed_hz);
> -- 
> 1.7.2.3
> 
> 
> ------------------------------------------------------------------------------
> The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
> Pinpoint memory and threading errors before they happen.
> Find and fix more than 250 security defects in the development cycle.
> Locate bottlenecks in serial and parallel code that limit performance.
> http://p.sf.net/sfu/intel-dev2devfeb
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
