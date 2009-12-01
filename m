From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 1 Dec 2009 18:17:13 +0000
Subject: [PATCH 3/7] S3C64XX: Add support for CLK_SRC2 configured clocks
In-Reply-To: <1259340239-12067-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20091127164312.GA11913@rakim.wolfsonmicro.main>
	<1259340239-12067-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20091201181713.GL4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2009 at 04:43:55PM +0000, Mark Brown wrote:
> The S3C6410 has two clock source registers used for the clock muxes
> but currently the s3c_clksrc_clk infrastructure hardcodes the first
> one (where almost all of the clocks are). Make the source register
> a part of the clock definition to support addition of clocks using
> CLK_SRC2.

the clock updates that where posted late last night will sort this
out.
 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/plat-s3c64xx/s3c6400-clock.c |   21 ++++++++++++++++++---
>  1 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> index 6ffa21e..b7e2015 100644
> --- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
> +++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> @@ -61,6 +61,7 @@ struct clksrc_clk {
>  
>  	unsigned int		divider_shift;
>  	void __iomem		*reg_divider;
> +	void __iomem		*reg_src;
>  };
>  
>  static struct clk clk_fout_apll = {
> @@ -86,6 +87,7 @@ static struct clksrc_clk clk_mout_apll = {
>  	.shift		= S3C6400_CLKSRC_APLL_MOUT_SHIFT,
>  	.mask		= S3C6400_CLKSRC_APLL_MOUT,
>  	.sources	= &clk_src_apll,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  static struct clk clk_fout_epll = {
> @@ -111,6 +113,7 @@ static struct clksrc_clk clk_mout_epll = {
>  	.shift		= S3C6400_CLKSRC_EPLL_MOUT_SHIFT,
>  	.mask		= S3C6400_CLKSRC_EPLL_MOUT,
>  	.sources	= &clk_src_epll,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  static struct clk *clk_src_mpll_list[] = {
> @@ -131,6 +134,7 @@ static struct clksrc_clk clk_mout_mpll = {
>  	.shift		= S3C6400_CLKSRC_MPLL_MOUT_SHIFT,
>  	.mask		= S3C6400_CLKSRC_MPLL_MOUT,
>  	.sources	= &clk_src_mpll,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  static unsigned int armclk_mask;
> @@ -313,7 +317,7 @@ static int s3c64xx_setparent_clksrc(struct clk *clk, struct clk *parent)
>  {
>  	struct clksrc_clk *sclk = to_clksrc(clk);
>  	struct clk_sources *srcs = sclk->sources;
> -	u32 clksrc = __raw_readl(S3C_CLK_SRC);
> +	u32 clksrc = __raw_readl(sclk->reg_src);
>  	int src_nr = -1;
>  	int ptr;
>  
> @@ -327,7 +331,7 @@ static int s3c64xx_setparent_clksrc(struct clk *clk, struct clk *parent)
>  		clksrc &= ~sclk->mask;
>  		clksrc |= src_nr << sclk->shift;
>  
> -		__raw_writel(clksrc, S3C_CLK_SRC);
> +		__raw_writel(clksrc, sclk->reg_src);
>  
>  		clk->parent = parent;
>  		return 0;
> @@ -374,6 +378,7 @@ static struct clksrc_clk clk_mmc0 = {
>  	.sources	= &clkset_spi_mmc,
>  	.divider_shift	= S3C6400_CLKDIV1_MMC0_SHIFT,
>  	.reg_divider	= S3C_CLK_DIV1,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  static struct clksrc_clk clk_mmc1 = {
> @@ -392,6 +397,7 @@ static struct clksrc_clk clk_mmc1 = {
>  	.sources	= &clkset_spi_mmc,
>  	.divider_shift	= S3C6400_CLKDIV1_MMC1_SHIFT,
>  	.reg_divider	= S3C_CLK_DIV1,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  static struct clksrc_clk clk_mmc2 = {
> @@ -410,6 +416,7 @@ static struct clksrc_clk clk_mmc2 = {
>  	.sources	= &clkset_spi_mmc,
>  	.divider_shift	= S3C6400_CLKDIV1_MMC2_SHIFT,
>  	.reg_divider	= S3C_CLK_DIV1,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  static struct clksrc_clk clk_usbhost = {
> @@ -428,6 +435,7 @@ static struct clksrc_clk clk_usbhost = {
>  	.sources	= &clkset_uhost,
>  	.divider_shift	= S3C6400_CLKDIV1_UHOST_SHIFT,
>  	.reg_divider	= S3C_CLK_DIV1,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  static struct clksrc_clk clk_uart_uclk1 = {
> @@ -446,6 +454,7 @@ static struct clksrc_clk clk_uart_uclk1 = {
>  	.sources	= &clkset_uart,
>  	.divider_shift	= S3C6400_CLKDIV2_UART_SHIFT,
>  	.reg_divider	= S3C_CLK_DIV2,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  /* Where does UCLK0 come from? */
> @@ -466,6 +475,7 @@ static struct clksrc_clk clk_spi0 = {
>  	.sources	= &clkset_spi_mmc,
>  	.divider_shift	= S3C6400_CLKDIV2_SPI0_SHIFT,
>  	.reg_divider	= S3C_CLK_DIV2,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  static struct clksrc_clk clk_spi1 = {
> @@ -484,6 +494,7 @@ static struct clksrc_clk clk_spi1 = {
>  	.sources	= &clkset_spi_mmc,
>  	.divider_shift	= S3C6400_CLKDIV2_SPI1_SHIFT,
>  	.reg_divider	= S3C_CLK_DIV2,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  static struct clk clk_iis_cd0 = {
> @@ -530,6 +541,7 @@ static struct clksrc_clk clk_audio0 = {
>  	.sources	= &clkset_audio0,
>  	.divider_shift	= S3C6400_CLKDIV2_AUDIO0_SHIFT,
>  	.reg_divider	= S3C_CLK_DIV2,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  static struct clk *clkset_audio1_list[] = {
> @@ -561,6 +573,7 @@ static struct clksrc_clk clk_audio1 = {
>  	.sources	= &clkset_audio1,
>  	.divider_shift	= S3C6400_CLKDIV2_AUDIO1_SHIFT,
>  	.reg_divider	= S3C_CLK_DIV2,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  static struct clksrc_clk clk_irda = {
> @@ -579,6 +592,7 @@ static struct clksrc_clk clk_irda = {
>  	.sources	= &clkset_irda,
>  	.divider_shift	= S3C6400_CLKDIV2_IRDA_SHIFT,
>  	.reg_divider	= S3C_CLK_DIV2,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  static struct clk *clkset_camif_list[] = {
> @@ -606,6 +620,7 @@ static struct clksrc_clk clk_camif = {
>  	.sources	= &clkset_camif,
>  	.divider_shift	= S3C6400_CLKDIV0_CAM_SHIFT,
>  	.reg_divider	= S3C_CLK_DIV0,
> +	.reg_src	= S3C_CLK_SRC,
>  };
>  
>  /* Clock initialisation code */
> @@ -630,7 +645,7 @@ static struct clksrc_clk *init_parents[] = {
>  static void __init_or_cpufreq s3c6400_set_clksrc(struct clksrc_clk *clk)
>  {
>  	struct clk_sources *srcs = clk->sources;
> -	u32 clksrc = __raw_readl(S3C_CLK_SRC);
> +	u32 clksrc = __raw_readl(clk->reg_src);
>  
>  	clksrc &= clk->mask;
>  	clksrc >>= clk->shift;
> -- 
> 1.6.5.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
