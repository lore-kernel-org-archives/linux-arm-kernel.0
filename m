From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 19 Nov 2015 09:57:40 +0900
Subject: [PATCH v3] SPI: s3c64xx: pass DMA arguments in platform data
In-Reply-To: <3835977.ZFLKtOk346@wuerfel>
References: <3835977.ZFLKtOk346@wuerfel>
Message-ID: <564D1E84.6070808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.11.2015 23:21, Arnd Bergmann wrote:
> The s3c64xx platform data already contains a pointer to the
> DMA filter function, but not to the associated data.
> 
> This simplifies the code and makes it more generic by
> passing the data along with the filter function like
> we do for other drivers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3: leave pl330 support in place. this is not needed any more, but this
>     patch should not remove it. We will however need to come back to
>     this for multiplatform support, so a combined s3c64xx+s5p gets the
>     right filter function
> v3: fix bug in probe function that caused the DT case to use polling mode
> v2: This version is now independent of the ASoC changes.
> 
> diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> index 07a5a6e6dcaa..b53d4ff3befb 100644
> --- a/arch/arm/plat-samsung/devs.c
> +++ b/arch/arm/plat-samsung/devs.c
> @@ -1105,9 +1105,7 @@ struct platform_device s3c_device_wdt = {
>  #ifdef CONFIG_S3C64XX_DEV_SPI0
>  static struct resource s3c64xx_spi0_resource[] = {
>  	[0] = DEFINE_RES_MEM(S3C_PA_SPI0, SZ_256),
> -	[1] = DEFINE_RES_DMA(DMACH_SPI0_TX),
> -	[2] = DEFINE_RES_DMA(DMACH_SPI0_RX),
> -	[3] = DEFINE_RES_IRQ(IRQ_SPI0),
> +	[1] = DEFINE_RES_IRQ(IRQ_SPI0),
>  };
>  
>  struct platform_device s3c64xx_device_spi0 = {
> @@ -1135,6 +1133,8 @@ void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
>  	pd.num_cs = num_cs;
>  	pd.src_clk_nr = src_clk_nr;
>  	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_gpio;
> +	pd.dma_tx = (void *)DMACH_SPI0_TX;
> +	pd.dma_rx = (void *)DMACH_SPI0_RX;
>  #if defined(CONFIG_PL330_DMA)
>  	pd.filter = pl330_filter;
>  #elif defined(CONFIG_S3C64XX_PL080)
> @@ -1150,9 +1150,7 @@ void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
>  #ifdef CONFIG_S3C64XX_DEV_SPI1
>  static struct resource s3c64xx_spi1_resource[] = {
>  	[0] = DEFINE_RES_MEM(S3C_PA_SPI1, SZ_256),
> -	[1] = DEFINE_RES_DMA(DMACH_SPI1_TX),
> -	[2] = DEFINE_RES_DMA(DMACH_SPI1_RX),
> -	[3] = DEFINE_RES_IRQ(IRQ_SPI1),
> +	[1] = DEFINE_RES_IRQ(IRQ_SPI1),
>  };
>  
>  struct platform_device s3c64xx_device_spi1 = {
> @@ -1180,12 +1178,15 @@ void __init s3c64xx_spi1_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
>  	pd.num_cs = num_cs;
>  	pd.src_clk_nr = src_clk_nr;
>  	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi1_cfg_gpio;
> +	pd.dma_tx = (void *)DMACH_SPI1_TX;
> +	pd.dma_rx = (void *)DMACH_SPI1_RX;
>  #if defined(CONFIG_PL330_DMA)
>  	pd.filter = pl330_filter;
>  #elif defined(CONFIG_S3C64XX_PL080)
>  	pd.filter = pl08x_filter_id;
>  #endif
>  
> +

That empty line is not needed here.

Rest is good so with removal of this empty line:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
