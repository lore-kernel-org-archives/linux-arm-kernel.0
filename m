From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 19 May 2012 23:06:40 -0600
Subject: [PATCH v2 2/6] spi: s3c64xx: move controller information into
 driver data
In-Reply-To: <1337333613-6216-3-git-send-email-thomas.abraham@linaro.org>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120520050640.858363E03B8@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 May 2012 15:03:29 +0530, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> Platform data is used to specify controller hardware specific information
> such as the tx/rx fifo level mask and bit offset of rx fifo level. Such
> information is not suitable to be supplied from device tree. Instead,
> it can be moved into the driver data and removed from platform data.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Jaswinder Singh <jaswinder.singh@linaro.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/arm/mach-exynos/clock-exynos4.c             |   18 +-
>  arch/arm/mach-exynos/setup-spi.c                 |   25 ---
>  arch/arm/mach-s3c24xx/clock-s3c2416.c            |    2 +-
>  arch/arm/mach-s3c24xx/clock-s3c2443.c            |    2 +-
>  arch/arm/mach-s3c24xx/common-s3c2443.c           |    4 +-
>  arch/arm/mach-s3c24xx/setup-spi.c                |    8 -
>  arch/arm/mach-s3c64xx/clock.c                    |   20 ++--
>  arch/arm/mach-s3c64xx/setup-spi.c                |   13 --
>  arch/arm/mach-s5p64x0/clock-s5p6440.c            |   12 +-
>  arch/arm/mach-s5p64x0/clock-s5p6450.c            |   12 +-
>  arch/arm/mach-s5p64x0/setup-spi.c                |   16 --
>  arch/arm/mach-s5pc100/clock.c                    |   30 ++--
>  arch/arm/mach-s5pc100/setup-spi.c                |   22 ---
>  arch/arm/mach-s5pv210/clock.c                    |   14 +-
>  arch/arm/mach-s5pv210/setup-spi.c                |   15 --
>  arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |   15 --
>  drivers/spi/spi-s3c64xx.c                        |  180 ++++++++++++++++++----
>  17 files changed, 210 insertions(+), 198 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-exynos/clock-exynos4.c
> index bcb7db4..10a46a9 100644
> --- a/arch/arm/mach-exynos/clock-exynos4.c
> +++ b/arch/arm/mach-exynos/clock-exynos4.c
> @@ -586,17 +586,17 @@ static struct clk exynos4_init_clocks_off[] = {
>  		.ctrlbit	= (1 << 13),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.0",
> +		.devname	= "exynos4210-spi.0",
>  		.enable		= exynos4_clk_ip_peril_ctrl,
>  		.ctrlbit	= (1 << 16),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.1",
> +		.devname	= "exynos4210-spi.1",
>  		.enable		= exynos4_clk_ip_peril_ctrl,
>  		.ctrlbit	= (1 << 17),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.2",
> +		.devname	= "exynos4210-spi.2",
>  		.enable		= exynos4_clk_ip_peril_ctrl,
>  		.ctrlbit	= (1 << 18),
>  	}, {
> @@ -1245,7 +1245,7 @@ static struct clksrc_clk exynos4_clk_sclk_mmc3 = {
>  static struct clksrc_clk exynos4_clk_sclk_spi0 = {
>  	.clk	= {
>  		.name		= "sclk_spi",
> -		.devname	= "s3c64xx-spi.0",
> +		.devname	= "exynos4210-spi.0",
>  		.enable		= exynos4_clksrc_mask_peril1_ctrl,
>  		.ctrlbit	= (1 << 16),
>  	},
> @@ -1257,7 +1257,7 @@ static struct clksrc_clk exynos4_clk_sclk_spi0 = {
>  static struct clksrc_clk exynos4_clk_sclk_spi1 = {
>  	.clk	= {
>  		.name		= "sclk_spi",
> -		.devname	= "s3c64xx-spi.1",
> +		.devname	= "exynos4210-spi.1",
>  		.enable		= exynos4_clksrc_mask_peril1_ctrl,
>  		.ctrlbit	= (1 << 20),
>  	},
> @@ -1269,7 +1269,7 @@ static struct clksrc_clk exynos4_clk_sclk_spi1 = {
>  static struct clksrc_clk exynos4_clk_sclk_spi2 = {
>  	.clk	= {
>  		.name		= "sclk_spi",
> -		.devname	= "s3c64xx-spi.2",
> +		.devname	= "exynos4210-spi.2",
>  		.enable		= exynos4_clksrc_mask_peril1_ctrl,
>  		.ctrlbit	= (1 << 24),
>  	},
> @@ -1347,9 +1347,9 @@ static struct clk_lookup exynos4_clk_lookup[] = {
>  	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos4_clk_pdma0),
>  	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos4_clk_pdma1),
>  	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos4_clk_mdma1),
> -	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0", &exynos4_clk_sclk_spi0.clk),
> -	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk0", &exynos4_clk_sclk_spi1.clk),
> -	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk0", &exynos4_clk_sclk_spi2.clk),
> +	CLKDEV_INIT("exynos4210-spi.0", "spi_busclk0", &exynos4_clk_sclk_spi0.clk),
> +	CLKDEV_INIT("exynos4210-spi.1", "spi_busclk0", &exynos4_clk_sclk_spi1.clk),
> +	CLKDEV_INIT("exynos4210-spi.2", "spi_busclk0", &exynos4_clk_sclk_spi2.clk),
>  };
>  
>  static int xtal_rate;
> diff --git a/arch/arm/mach-exynos/setup-spi.c b/arch/arm/mach-exynos/setup-spi.c
> index 833ff40..a71ec4d 100644
> --- a/arch/arm/mach-exynos/setup-spi.c
> +++ b/arch/arm/mach-exynos/setup-spi.c
> @@ -12,17 +12,8 @@
>  #include <linux/platform_device.h>
>  
>  #include <plat/gpio-cfg.h>
> -#include <plat/s3c64xx-spi.h>
>  
>  #ifdef CONFIG_S3C64XX_DEV_SPI0
> -struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
> -	.fifo_lvl_mask	= 0x1ff,
> -	.rx_lvl_offset	= 15,
> -	.high_speed	= 1,
> -	.clk_from_cmu	= true,
> -	.tx_st_done	= 25,
> -};
> -
>  int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
>  {
>  	s3c_gpio_cfgpin(EXYNOS4_GPB(0), S3C_GPIO_SFN(2));
> @@ -34,14 +25,6 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
>  #endif
>  
>  #ifdef CONFIG_S3C64XX_DEV_SPI1
> -struct s3c64xx_spi_info s3c64xx_spi1_pdata __initdata = {
> -	.fifo_lvl_mask	= 0x7f,
> -	.rx_lvl_offset	= 15,
> -	.high_speed	= 1,
> -	.clk_from_cmu	= true,
> -	.tx_st_done	= 25,
> -};
> -
>  int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
>  {
>  	s3c_gpio_cfgpin(EXYNOS4_GPB(4), S3C_GPIO_SFN(2));
> @@ -53,14 +36,6 @@ int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
>  #endif
>  
>  #ifdef CONFIG_S3C64XX_DEV_SPI2
> -struct s3c64xx_spi_info s3c64xx_spi2_pdata __initdata = {
> -	.fifo_lvl_mask	= 0x7f,
> -	.rx_lvl_offset	= 15,
> -	.high_speed	= 1,
> -	.clk_from_cmu	= true,
> -	.tx_st_done	= 25,
> -};
> -
>  int s3c64xx_spi2_cfg_gpio(struct platform_device *dev)
>  {
>  	s3c_gpio_cfgpin(EXYNOS4_GPC1(1), S3C_GPIO_SFN(5));
> diff --git a/arch/arm/mach-s3c24xx/clock-s3c2416.c b/arch/arm/mach-s3c24xx/clock-s3c2416.c
> index 8702ecf..a582ba1 100644
> --- a/arch/arm/mach-s3c24xx/clock-s3c2416.c
> +++ b/arch/arm/mach-s3c24xx/clock-s3c2416.c
> @@ -144,7 +144,7 @@ static struct clk_lookup s3c2416_clk_lookup[] = {
>  	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &hsmmc0_clk),
>  	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &hsmmc_mux0.clk),
>  	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &hsmmc_mux1.clk),
> -	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &hsspi_mux.clk),
> +	CLKDEV_INIT("s3c2443-spi.0", "spi_busclk2", &hsspi_mux.clk),
>  };
>  
>  void __init s3c2416_init_clocks(int xtal)
> diff --git a/arch/arm/mach-s3c24xx/clock-s3c2443.c b/arch/arm/mach-s3c24xx/clock-s3c2443.c
> index a4c5a52..7f689ce 100644
> --- a/arch/arm/mach-s3c24xx/clock-s3c2443.c
> +++ b/arch/arm/mach-s3c24xx/clock-s3c2443.c
> @@ -181,7 +181,7 @@ static struct clk *clks[] __initdata = {
>  
>  static struct clk_lookup s3c2443_clk_lookup[] = {
>  	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_hsmmc),
> -	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &clk_hsspi.clk),
> +	CLKDEV_INIT("s3c2443-spi.0", "spi_busclk2", &clk_hsspi.clk),
>  };
>  
>  void __init s3c2443_init_clocks(int xtal)
> diff --git a/arch/arm/mach-s3c24xx/common-s3c2443.c b/arch/arm/mach-s3c24xx/common-s3c2443.c
> index aeeb2be..aeb4a24 100644
> --- a/arch/arm/mach-s3c24xx/common-s3c2443.c
> +++ b/arch/arm/mach-s3c24xx/common-s3c2443.c
> @@ -559,7 +559,7 @@ static struct clk hsmmc1_clk = {
>  
>  static struct clk hsspi_clk = {
>  	.name		= "spi",
> -	.devname	= "s3c64xx-spi.0",
> +	.devname	= "s3c2443-spi.0",
>  	.parent		= &clk_p,
>  	.enable		= s3c2443_clkcon_enable_p,
>  	.ctrlbit	= S3C2443_PCLKCON_HSSPI,
> @@ -633,7 +633,7 @@ static struct clk_lookup s3c2443_clk_lookup[] = {
>  	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_p),
>  	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_esys_uart.clk),
>  	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.0", &hsmmc1_clk),
> -	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0", &hsspi_clk),
> +	CLKDEV_INIT("s3c2443-spi.0", "spi_busclk0", &hsspi_clk),
>  };
>  
>  void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
> diff --git a/arch/arm/mach-s3c24xx/setup-spi.c b/arch/arm/mach-s3c24xx/setup-spi.c
> index 5712c85..42abe15 100644
> --- a/arch/arm/mach-s3c24xx/setup-spi.c
> +++ b/arch/arm/mach-s3c24xx/setup-spi.c
> @@ -13,19 +13,11 @@
>  #include <linux/platform_device.h>
>  
>  #include <plat/gpio-cfg.h>
> -#include <plat/s3c64xx-spi.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/regs-gpio.h>
>  
>  #ifdef CONFIG_S3C64XX_DEV_SPI0
> -struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
> -	.fifo_lvl_mask	= 0x7f,
> -	.rx_lvl_offset	= 13,
> -	.tx_st_done	= 21,
> -	.high_speed	= 1,
> -};
> -
>  int s3c64xx_spi0_cfg_gpio(struct platform_device *pdev)
>  {
>  	/* enable hsspi bit in misccr */
> diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
> index 52f079a..28041e8 100644
> --- a/arch/arm/mach-s3c64xx/clock.c
> +++ b/arch/arm/mach-s3c64xx/clock.c
> @@ -178,13 +178,13 @@ static struct clk init_clocks_off[] = {
>  		.ctrlbit	= S3C_CLKCON_PCLK_KEYPAD,
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.0",
> +		.devname	= "s3c6410-spi.0",
>  		.parent		= &clk_p,
>  		.enable		= s3c64xx_pclk_ctrl,
>  		.ctrlbit	= S3C_CLKCON_PCLK_SPI0,
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.1",
> +		.devname	= "s3c6410-spi.1",
>  		.parent		= &clk_p,
>  		.enable		= s3c64xx_pclk_ctrl,
>  		.ctrlbit	= S3C_CLKCON_PCLK_SPI1,
> @@ -331,7 +331,7 @@ static struct clk init_clocks_off[] = {
>  
>  static struct clk clk_48m_spi0 = {
>  	.name		= "spi_48m",
> -	.devname	= "s3c64xx-spi.0",
> +	.devname	= "s3c6410-spi.0",
>  	.parent		= &clk_48m,
>  	.enable		= s3c64xx_sclk_ctrl,
>  	.ctrlbit	= S3C_CLKCON_SCLK_SPI0_48,
> @@ -339,7 +339,7 @@ static struct clk clk_48m_spi0 = {
>  
>  static struct clk clk_48m_spi1 = {
>  	.name		= "spi_48m",
> -	.devname	= "s3c64xx-spi.1",
> +	.devname	= "s3c6410-spi.1",
>  	.parent		= &clk_48m,
>  	.enable		= s3c64xx_sclk_ctrl,
>  	.ctrlbit	= S3C_CLKCON_SCLK_SPI1_48,
> @@ -802,7 +802,7 @@ static struct clksrc_clk clk_sclk_mmc2 = {
>  static struct clksrc_clk clk_sclk_spi0 = {
>  	.clk	= {
>  		.name		= "spi-bus",
> -		.devname	= "s3c64xx-spi.0",
> +		.devname	= "s3c6410-spi.0",
>  		.ctrlbit	= S3C_CLKCON_SCLK_SPI0,
>  		.enable		= s3c64xx_sclk_ctrl,
>  	},
> @@ -814,7 +814,7 @@ static struct clksrc_clk clk_sclk_spi0 = {
>  static struct clksrc_clk clk_sclk_spi1 = {
>  	.clk	= {
>  		.name		= "spi-bus",
> -		.devname	= "s3c64xx-spi.1",
> +		.devname	= "s3c6410-spi.1",
>  		.ctrlbit	= S3C_CLKCON_SCLK_SPI1,
>  		.enable		= s3c64xx_sclk_ctrl,
>  	},
> @@ -858,10 +858,10 @@ static struct clk_lookup s3c64xx_clk_lookup[] = {
>  	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
>  	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
>  	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
> -	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
> -	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &clk_48m_spi0),
> -	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
> -	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk2", &clk_48m_spi1),
> +	CLKDEV_INIT("s3c6410-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
> +	CLKDEV_INIT("s3c6410-spi.0", "spi_busclk2", &clk_48m_spi0),
> +	CLKDEV_INIT("s3c6410-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
> +	CLKDEV_INIT("s3c6410-spi.1", "spi_busclk2", &clk_48m_spi1),
>  };
>  
>  #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
> diff --git a/arch/arm/mach-s3c64xx/setup-spi.c b/arch/arm/mach-s3c64xx/setup-spi.c
> index d9592ad..ff999d9 100644
> --- a/arch/arm/mach-s3c64xx/setup-spi.c
> +++ b/arch/arm/mach-s3c64xx/setup-spi.c
> @@ -12,15 +12,8 @@
>  #include <linux/platform_device.h>
>  
>  #include <plat/gpio-cfg.h>
> -#include <plat/s3c64xx-spi.h>
>  
>  #ifdef CONFIG_S3C64XX_DEV_SPI0
> -struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
> -	.fifo_lvl_mask	= 0x7f,
> -	.rx_lvl_offset	= 13,
> -	.tx_st_done	= 21,
> -};
> -
>  int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
>  {
>  	s3c_gpio_cfgall_range(S3C64XX_GPC(0), 3,
> @@ -30,12 +23,6 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
>  #endif
>  
>  #ifdef CONFIG_S3C64XX_DEV_SPI1
> -struct s3c64xx_spi_info s3c64xx_spi1_pdata __initdata = {
> -	.fifo_lvl_mask	= 0x7f,
> -	.rx_lvl_offset	= 13,
> -	.tx_st_done	= 21,
> -};
> -
>  int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
>  {
>  	s3c_gpio_cfgall_range(S3C64XX_GPC(4), 3,
> diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
> index ee1e8e7..55ea3ab 100644
> --- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
> +++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
> @@ -227,13 +227,13 @@ static struct clk init_clocks_off[] = {
>  		.ctrlbit	= (1 << 17),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.0",
> +		.devname	= "s5p64x0-spi.0",
>  		.parent		= &clk_pclk_low.clk,
>  		.enable		= s5p64x0_pclk_ctrl,
>  		.ctrlbit	= (1 << 21),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.1",
> +		.devname	= "s5p64x0-spi.1",
>  		.parent		= &clk_pclk_low.clk,
>  		.enable		= s5p64x0_pclk_ctrl,
>  		.ctrlbit	= (1 << 22),
> @@ -467,7 +467,7 @@ static struct clksrc_clk clk_sclk_uclk = {
>  static struct clksrc_clk clk_sclk_spi0 = {
>  	.clk	= {
>  		.name		= "sclk_spi",
> -		.devname	= "s3c64xx-spi.0",
> +		.devname	= "s5p64x0-spi.0",
>  		.ctrlbit	= (1 << 20),
>  		.enable		= s5p64x0_sclk_ctrl,
>  	},
> @@ -479,7 +479,7 @@ static struct clksrc_clk clk_sclk_spi0 = {
>  static struct clksrc_clk clk_sclk_spi1 = {
>  	.clk	= {
>  		.name		= "sclk_spi",
> -		.devname	= "s3c64xx-spi.1",
> +		.devname	= "s5p64x0-spi.1",
>  		.ctrlbit	= (1 << 21),
>  		.enable		= s5p64x0_sclk_ctrl,
>  	},
> @@ -519,8 +519,8 @@ static struct clk_lookup s5p6440_clk_lookup[] = {
>  	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_pclk_low.clk),
>  	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_sclk_uclk.clk),
>  	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
> -	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
> -	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
> +	CLKDEV_INIT("s5p64x0.0", "spi_busclk1", &clk_sclk_spi0.clk),
> +	CLKDEV_INIT("s5p64x0.1", "spi_busclk1", &clk_sclk_spi1.clk),
>  	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
>  	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
>  	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
> diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
> index dae6a13..f3e0ef3 100644
> --- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
> +++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
> @@ -236,13 +236,13 @@ static struct clk init_clocks_off[] = {
>  		.ctrlbit	= (1 << 17),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.0",
> +		.devname	= "s5p64x0-spi.0",
>  		.parent		= &clk_pclk_low.clk,
>  		.enable		= s5p64x0_pclk_ctrl,
>  		.ctrlbit	= (1 << 21),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.1",
> +		.devname	= "s5p64x0-spi.1",
>  		.parent		= &clk_pclk_low.clk,
>  		.enable		= s5p64x0_pclk_ctrl,
>  		.ctrlbit	= (1 << 22),
> @@ -528,7 +528,7 @@ static struct clksrc_clk clk_sclk_uclk = {
>  static struct clksrc_clk clk_sclk_spi0 = {
>  	.clk	= {
>  		.name		= "sclk_spi",
> -		.devname	= "s3c64xx-spi.0",
> +		.devname	= "s5p64x0-spi.0",
>  		.ctrlbit	= (1 << 20),
>  		.enable		= s5p64x0_sclk_ctrl,
>  	},
> @@ -540,7 +540,7 @@ static struct clksrc_clk clk_sclk_spi0 = {
>  static struct clksrc_clk clk_sclk_spi1 = {
>  	.clk	= {
>  		.name		= "sclk_spi",
> -		.devname	= "s3c64xx-spi.1",
> +		.devname	= "s5p64x0-spi.1",
>  		.ctrlbit	= (1 << 21),
>  		.enable		= s5p64x0_sclk_ctrl,
>  	},
> @@ -562,8 +562,8 @@ static struct clk_lookup s5p6450_clk_lookup[] = {
>  	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_pclk_low.clk),
>  	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_sclk_uclk.clk),
>  	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
> -	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
> -	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
> +	CLKDEV_INIT("s5p64x0-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
> +	CLKDEV_INIT("s5p64x0-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
>  	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
>  	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
>  	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
> diff --git a/arch/arm/mach-s5p64x0/setup-spi.c b/arch/arm/mach-s5p64x0/setup-spi.c
> index e9b8412..1cf84b5 100644
> --- a/arch/arm/mach-s5p64x0/setup-spi.c
> +++ b/arch/arm/mach-s5p64x0/setup-spi.c
> @@ -10,19 +10,9 @@
>  
>  #include <linux/gpio.h>
>  #include <linux/platform_device.h>
> -#include <linux/io.h>
> -
>  #include <plat/gpio-cfg.h>
> -#include <plat/cpu.h>
> -#include <plat/s3c64xx-spi.h>
>  
>  #ifdef CONFIG_S3C64XX_DEV_SPI0
> -struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
> -	.fifo_lvl_mask	= 0x1ff,
> -	.rx_lvl_offset	= 15,
> -	.tx_st_done	= 25,
> -};
> -
>  int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
>  {
>  	if (soc_is_s5p6450())
> @@ -36,12 +26,6 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
>  #endif
>  
>  #ifdef CONFIG_S3C64XX_DEV_SPI1
> -struct s3c64xx_spi_info s3c64xx_spi1_pdata __initdata = {
> -	.fifo_lvl_mask	= 0x7f,
> -	.rx_lvl_offset	= 15,
> -	.tx_st_done	= 25,
> -};
> -
>  int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
>  {
>  	if (soc_is_s5p6450())
> diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
> index 16eca4e..9262197 100644
> --- a/arch/arm/mach-s5pc100/clock.c
> +++ b/arch/arm/mach-s5pc100/clock.c
> @@ -564,19 +564,19 @@ static struct clk init_clocks_off[] = {
>  		.ctrlbit	= (1 << 5),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.0",
> +		.devname	= "s5pc100-spi.0",
>  		.parent		= &clk_div_d1_bus.clk,
>  		.enable		= s5pc100_d1_4_ctrl,
>  		.ctrlbit	= (1 << 6),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.1",
> +		.devname	= "s5pc100-spi.1",
>  		.parent		= &clk_div_d1_bus.clk,
>  		.enable		= s5pc100_d1_4_ctrl,
>  		.ctrlbit	= (1 << 7),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.2",
> +		.devname	= "s5pc100-spi.2",
>  		.parent		= &clk_div_d1_bus.clk,
>  		.enable		= s5pc100_d1_4_ctrl,
>  		.ctrlbit	= (1 << 8),
> @@ -702,7 +702,7 @@ static struct clk clk_hsmmc0 = {
>  
>  static struct clk clk_48m_spi0 = {
>  	.name		= "spi_48m",
> -	.devname	= "s3c64xx-spi.0",
> +	.devname	= "s5pc100-spi.0",
>  	.parent		= &clk_mout_48m.clk,
>  	.enable		= s5pc100_sclk0_ctrl,
>  	.ctrlbit	= (1 << 7),
> @@ -710,7 +710,7 @@ static struct clk clk_48m_spi0 = {
>  
>  static struct clk clk_48m_spi1 = {
>  	.name		= "spi_48m",
> -	.devname	= "s3c64xx-spi.1",
> +	.devname	= "s5pc100-spi.1",
>  	.parent		= &clk_mout_48m.clk,
>  	.enable		= s5pc100_sclk0_ctrl,
>  	.ctrlbit	= (1 << 8),
> @@ -718,7 +718,7 @@ static struct clk clk_48m_spi1 = {
>  
>  static struct clk clk_48m_spi2 = {
>  	.name		= "spi_48m",
> -	.devname	= "s3c64xx-spi.2",
> +	.devname	= "s5pc100-spi.2",
>  	.parent		= &clk_mout_48m.clk,
>  	.enable		= s5pc100_sclk0_ctrl,
>  	.ctrlbit	= (1 << 9),
> @@ -1085,7 +1085,7 @@ static struct clksrc_clk clk_sclk_mmc2 = {
>  static struct clksrc_clk clk_sclk_spi0 = {
>  	.clk	= {
>  		.name		= "sclk_spi",
> -		.devname	= "s3c64xx-spi.0",
> +		.devname	= "s5pc100-spi.0",
>  		.ctrlbit	= (1 << 4),
>  		.enable		= s5pc100_sclk0_ctrl,
>  	},
> @@ -1097,7 +1097,7 @@ static struct clksrc_clk clk_sclk_spi0 = {
>  static struct clksrc_clk clk_sclk_spi1 = {
>  	.clk	= {
>  		.name		= "sclk_spi",
> -		.devname	= "s3c64xx-spi.1",
> +		.devname	= "s5pc100-spi.1",
>  		.ctrlbit	= (1 << 5),
>  		.enable		= s5pc100_sclk0_ctrl,
>  	},
> @@ -1109,7 +1109,7 @@ static struct clksrc_clk clk_sclk_spi1 = {
>  static struct clksrc_clk clk_sclk_spi2 = {
>  	.clk	= {
>  		.name		= "sclk_spi",
> -		.devname	= "s3c64xx-spi.2",
> +		.devname	= "s5pc100-spi.2",
>  		.ctrlbit	= (1 << 6),
>  		.enable		= s5pc100_sclk0_ctrl,
>  	},
> @@ -1315,12 +1315,12 @@ static struct clk_lookup s5pc100_clk_lookup[] = {
>  	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
>  	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
>  	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
> -	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_48m_spi0),
> -	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &clk_sclk_spi0.clk),
> -	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_48m_spi1),
> -	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk2", &clk_sclk_spi1.clk),
> -	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk1", &clk_48m_spi2),
> -	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk2", &clk_sclk_spi2.clk),
> +	CLKDEV_INIT("s5pc100-spi.0", "spi_busclk1", &clk_48m_spi0),
> +	CLKDEV_INIT("s5pc100-spi.0", "spi_busclk2", &clk_sclk_spi0.clk),
> +	CLKDEV_INIT("s5pc100-spi.1", "spi_busclk1", &clk_48m_spi1),
> +	CLKDEV_INIT("s5pc100-spi.1", "spi_busclk2", &clk_sclk_spi1.clk),
> +	CLKDEV_INIT("s5pc100-spi.2", "spi_busclk1", &clk_48m_spi2),
> +	CLKDEV_INIT("s5pc100-spi.2", "spi_busclk2", &clk_sclk_spi2.clk),
>  };
>  
>  void __init s5pc100_register_clocks(void)
> diff --git a/arch/arm/mach-s5pc100/setup-spi.c b/arch/arm/mach-s5pc100/setup-spi.c
> index 431a6f7..4b42718 100644
> --- a/arch/arm/mach-s5pc100/setup-spi.c
> +++ b/arch/arm/mach-s5pc100/setup-spi.c
> @@ -12,16 +12,8 @@
>  #include <linux/platform_device.h>
>  
>  #include <plat/gpio-cfg.h>
> -#include <plat/s3c64xx-spi.h>
>  
>  #ifdef CONFIG_S3C64XX_DEV_SPI0
> -struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
> -	.fifo_lvl_mask	= 0x7f,
> -	.rx_lvl_offset	= 13,
> -	.high_speed	= 1,
> -	.tx_st_done	= 21,
> -};
> -
>  int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
>  {
>  	s3c_gpio_cfgall_range(S5PC100_GPB(0), 3,
> @@ -31,13 +23,6 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
>  #endif
>  
>  #ifdef CONFIG_S3C64XX_DEV_SPI1
> -struct s3c64xx_spi_info s3c64xx_spi1_pdata __initdata = {
> -	.fifo_lvl_mask	= 0x7f,
> -	.rx_lvl_offset	= 13,
> -	.high_speed	= 1,
> -	.tx_st_done	= 21,
> -};
> -
>  int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
>  {
>  	s3c_gpio_cfgall_range(S5PC100_GPB(4), 3,
> @@ -47,13 +32,6 @@ int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
>  #endif
>  
>  #ifdef CONFIG_S3C64XX_DEV_SPI2
> -struct s3c64xx_spi_info s3c64xx_spi2_pdata __initdata = {
> -	.fifo_lvl_mask	= 0x7f,
> -	.rx_lvl_offset	= 13,
> -	.high_speed	= 1,
> -	.tx_st_done	= 21,
> -};
> -
>  int s3c64xx_spi2_cfg_gpio(struct platform_device *dev)
>  {
>  	s3c_gpio_cfgpin(S5PC100_GPG3(0), S3C_GPIO_SFN(3));
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index 09609d5..fcdf52d 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c
> @@ -445,19 +445,19 @@ static struct clk init_clocks_off[] = {
>  		.ctrlbit	= (1 << 11),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.0",
> +		.devname	= "s5pv210-spi.0",
>  		.parent		= &clk_pclk_psys.clk,
>  		.enable		= s5pv210_clk_ip3_ctrl,
>  		.ctrlbit	= (1<<12),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.1",
> +		.devname	= "s5pv210-spi.1",
>  		.parent		= &clk_pclk_psys.clk,
>  		.enable		= s5pv210_clk_ip3_ctrl,
>  		.ctrlbit	= (1<<13),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.2",
> +		.devname	= "s5pv210-spi.2",
>  		.parent		= &clk_pclk_psys.clk,
>  		.enable		= s5pv210_clk_ip3_ctrl,
>  		.ctrlbit	= (1<<14),
> @@ -1035,7 +1035,7 @@ static struct clksrc_clk clk_sclk_mmc3 = {
>  static struct clksrc_clk clk_sclk_spi0 = {
>  	.clk		= {
>  		.name		= "sclk_spi",
> -		.devname	= "s3c64xx-spi.0",
> +		.devname	= "s5pv210-spi.0",
>  		.enable		= s5pv210_clk_mask0_ctrl,
>  		.ctrlbit	= (1 << 16),
>  	},
> @@ -1047,7 +1047,7 @@ static struct clksrc_clk clk_sclk_spi0 = {
>  static struct clksrc_clk clk_sclk_spi1 = {
>  	.clk		= {
>  		.name		= "sclk_spi",
> -		.devname	= "s3c64xx-spi.1",
> +		.devname	= "s5pv210-spi.1",
>  		.enable		= s5pv210_clk_mask0_ctrl,
>  		.ctrlbit	= (1 << 17),
>  	},
> @@ -1331,8 +1331,8 @@ static struct clk_lookup s5pv210_clk_lookup[] = {
>  	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
>  	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
>  	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
> -	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
> -	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
> +	CLKDEV_INIT("s5pv210-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
> +	CLKDEV_INIT("s5pv210-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
>  };
>  
>  void __init s5pv210_register_clocks(void)
> diff --git a/arch/arm/mach-s5pv210/setup-spi.c b/arch/arm/mach-s5pv210/setup-spi.c
> index f43c504..2cd66a6 100644
> --- a/arch/arm/mach-s5pv210/setup-spi.c
> +++ b/arch/arm/mach-s5pv210/setup-spi.c
> @@ -12,16 +12,8 @@
>  #include <linux/platform_device.h>
>  
>  #include <plat/gpio-cfg.h>
> -#include <plat/s3c64xx-spi.h>
>  
>  #ifdef CONFIG_S3C64XX_DEV_SPI0
> -struct s3c64xx_spi_info s3c64xx_spi0_pdata = {
> -	.fifo_lvl_mask	= 0x1ff,
> -	.rx_lvl_offset	= 15,
> -	.high_speed	= 1,
> -	.tx_st_done	= 25,
> -};
> -
>  int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
>  {
>  	s3c_gpio_cfgpin(S5PV210_GPB(0), S3C_GPIO_SFN(2));
> @@ -33,13 +25,6 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
>  #endif
>  
>  #ifdef CONFIG_S3C64XX_DEV_SPI1
> -struct s3c64xx_spi_info s3c64xx_spi1_pdata = {
> -	.fifo_lvl_mask	= 0x7f,
> -	.rx_lvl_offset	= 15,
> -	.high_speed	= 1,
> -	.tx_st_done	= 25,
> -};
> -
>  int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
>  {
>  	s3c_gpio_cfgpin(S5PV210_GPB(4), S3C_GPIO_SFN(2));
> diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> index fa95e9a..4e9b9c3 100644
> --- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> +++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> @@ -33,28 +33,13 @@ struct s3c64xx_spi_csinfo {
>  /**
>   * struct s3c64xx_spi_info - SPI Controller defining structure
>   * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] field.
> - * @clk_from_cmu: If the SPI clock/prescalar control block is present
> - *     by the platform's clock-management-unit and not in SPI controller.
>   * @num_cs: Number of CS this controller emulates.
>   * @cfg_gpio: Configure pins for this SPI controller.
> - * @fifo_lvl_mask: All tx fifo_lvl fields start at offset-6
> - * @rx_lvl_offset: Depends on tx fifo_lvl field and bus number
> - * @high_speed: If the controller supports HIGH_SPEED_EN bit
> - * @tx_st_done: Depends on tx fifo_lvl field
>   */
>  struct s3c64xx_spi_info {
>  	int src_clk_nr;
> -	bool clk_from_cmu;
> -
>  	int num_cs;
> -
>  	int (*cfg_gpio)(struct platform_device *pdev);
> -
> -	/* Following two fields are for future compatibility */
> -	int fifo_lvl_mask;
> -	int rx_lvl_offset;
> -	int high_speed;
> -	int tx_st_done;
>  };
>  
>  /**
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 6a3d51a..f6bc0e3 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -31,6 +31,8 @@
>  #include <mach/dma.h>
>  #include <plat/s3c64xx-spi.h>
>  
> +#define MAX_SPI_PORTS		3
> +
>  /* Registers and bit-fields */
>  
>  #define S3C64XX_SPI_CH_CFG		0x00
> @@ -113,9 +115,12 @@
>  
>  #define S3C64XX_SPI_FBCLK_MSK		(3<<0)
>  
> -#define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & (1 << (i)->tx_st_done)) ? 1 : 0)
> -#define TX_FIFO_LVL(v, i) (((v) >> 6) & (i)->fifo_lvl_mask)
> -#define RX_FIFO_LVL(v, i) (((v) >> (i)->rx_lvl_offset) & (i)->fifo_lvl_mask)
> +#define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
> +#define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
> +				(1 << (i)->port_conf->tx_st_done)) ? 1 : 0)
> +#define TX_FIFO_LVL(v, i) (((v) >> 6) & FIFO_LVL_MASK(i))
> +#define RX_FIFO_LVL(v, i) (((v) >> (i)->port_conf->rx_lvl_offset) & \
> +					FIFO_LVL_MASK(i))
>  
>  #define S3C64XX_SPI_MAX_TRAILCNT	0x3ff
>  #define S3C64XX_SPI_TRAILCNT_OFF	19
> @@ -134,6 +139,28 @@ struct s3c64xx_spi_dma_data {
>  };
>  
>  /**
> + * struct s3c64xx_spi_info - SPI Controller hardware info
> + * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
> + * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
> + * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
> + * @high_speed: True, if the controller supports HIGH_SPEED_EN bit.
> + * @clk_from_cmu: True, if the controller does not include a clock mux and
> + *	prescaler unit.
> + *
> + * The Samsung s3c64xx SPI controller are used on various Samsung SoC's but
> + * differ in some aspects such as the size of the fifo and spi bus clock
> + * setup. Such differences are specified to the driver using this structure
> + * which is provided as driver data to the driver.
> + */
> +struct s3c64xx_spi_port_config {
> +	int	fifo_lvl_mask[MAX_SPI_PORTS];
> +	int	rx_lvl_offset;
> +	int	tx_st_done;
> +	bool	high_speed;
> +	bool	clk_from_cmu;
> +};
> +
> +/**
>   * struct s3c64xx_spi_driver_data - Runtime info holder for SPI driver.
>   * @clk: Pointer to the spi clock.
>   * @src_clk: Pointer to the clock used to generate SPI signals.
> @@ -171,6 +198,8 @@ struct s3c64xx_spi_driver_data {
>  	struct s3c64xx_spi_dma_data	rx_dma;
>  	struct s3c64xx_spi_dma_data	tx_dma;
>  	struct samsung_dma_ops		*ops;
> +	struct s3c64xx_spi_port_config	*port_conf;
> +	unsigned			port_id;
>  };
>  
>  static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
> @@ -179,7 +208,6 @@ static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
>  
>  static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>  {
> -	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
>  	void __iomem *regs = sdd->regs;
>  	unsigned long loops;
>  	u32 val;
> @@ -195,7 +223,7 @@ static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>  	loops = msecs_to_loops(1);
>  	do {
>  		val = readl(regs + S3C64XX_SPI_STATUS);
> -	} while (TX_FIFO_LVL(val, sci) && loops--);
> +	} while (TX_FIFO_LVL(val, sdd) && loops--);
>  
>  	if (loops == 0)
>  		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO\n");
> @@ -204,7 +232,7 @@ static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>  	loops = msecs_to_loops(1);
>  	do {
>  		val = readl(regs + S3C64XX_SPI_STATUS);
> -		if (RX_FIFO_LVL(val, sci))
> +		if (RX_FIFO_LVL(val, sdd))
>  			readl(regs + S3C64XX_SPI_RX_DATA);
>  		else
>  			break;
> @@ -302,7 +330,6 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>  				struct spi_device *spi,
>  				struct spi_transfer *xfer, int dma_mode)
>  {
> -	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
>  	void __iomem *regs = sdd->regs;
>  	u32 modecfg, chcfg;
>  
> @@ -352,7 +379,7 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>  	if (xfer->rx_buf != NULL) {
>  		sdd->state |= RXBUSY;
>  
> -		if (sci->high_speed && sdd->cur_speed >= 30000000UL
> +		if (sdd->port_conf->high_speed && sdd->cur_speed >= 30000000UL
>  					&& !(sdd->cur_mode & SPI_CPHA))
>  			chcfg |= S3C64XX_SPI_CH_HS_EN;
>  
> @@ -392,7 +419,6 @@ static inline void enable_cs(struct s3c64xx_spi_driver_data *sdd,
>  static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
>  				struct spi_transfer *xfer, int dma_mode)
>  {
> -	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
>  	void __iomem *regs = sdd->regs;
>  	unsigned long val;
>  	int ms;
> @@ -409,7 +435,7 @@ static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
>  		val = msecs_to_loops(ms);
>  		do {
>  			status = readl(regs + S3C64XX_SPI_STATUS);
> -		} while (RX_FIFO_LVL(status, sci) < xfer->len && --val);
> +		} while (RX_FIFO_LVL(status, sdd) < xfer->len && --val);
>  	}
>  
>  	if (!val)
> @@ -428,8 +454,8 @@ static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
>  		if (xfer->rx_buf == NULL) {
>  			val = msecs_to_loops(10);
>  			status = readl(regs + S3C64XX_SPI_STATUS);
> -			while ((TX_FIFO_LVL(status, sci)
> -				|| !S3C64XX_SPI_ST_TX_DONE(status, sci))
> +			while ((TX_FIFO_LVL(status, sdd)
> +				|| !S3C64XX_SPI_ST_TX_DONE(status, sdd))
>  					&& --val) {
>  				cpu_relax();
>  				status = readl(regs + S3C64XX_SPI_STATUS);
> @@ -478,12 +504,11 @@ static inline void disable_cs(struct s3c64xx_spi_driver_data *sdd,
>  
>  static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
>  {
> -	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
>  	void __iomem *regs = sdd->regs;
>  	u32 val;
>  
>  	/* Disable Clock */
> -	if (sci->clk_from_cmu) {
> +	if (sdd->port_conf->clk_from_cmu) {
>  		clk_disable(sdd->src_clk);
>  	} else {
>  		val = readl(regs + S3C64XX_SPI_CLK_CFG);
> @@ -527,7 +552,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
>  
>  	writel(val, regs + S3C64XX_SPI_MODE_CFG);
>  
> -	if (sci->clk_from_cmu) {
> +	if (sdd->port_conf->clk_from_cmu) {
>  		/* Configure Clock */
>  		/* There is half-multiplier before the SPI */
>  		clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
> @@ -553,7 +578,6 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
>  static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
>  						struct spi_message *msg)
>  {
> -	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
>  	struct device *dev = &sdd->pdev->dev;
>  	struct spi_transfer *xfer;
>  
> @@ -569,7 +593,7 @@ static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
>  	/* Map until end or first fail */
>  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>  
> -		if (xfer->len <= ((sci->fifo_lvl_mask >> 1) + 1))
> +		if (xfer->len <= ((FIFO_LVL_MASK(sdd) >> 1) + 1))
>  			continue;
>  
>  		if (xfer->tx_buf != NULL) {
> @@ -603,7 +627,6 @@ static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
>  static void s3c64xx_spi_unmap_mssg(struct s3c64xx_spi_driver_data *sdd,
>  						struct spi_message *msg)
>  {
> -	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
>  	struct device *dev = &sdd->pdev->dev;
>  	struct spi_transfer *xfer;
>  
> @@ -612,7 +635,7 @@ static void s3c64xx_spi_unmap_mssg(struct s3c64xx_spi_driver_data *sdd,
>  
>  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>  
> -		if (xfer->len <= ((sci->fifo_lvl_mask >> 1) + 1))
> +		if (xfer->len <= ((FIFO_LVL_MASK(sdd) >> 1) + 1))
>  			continue;
>  
>  		if (xfer->rx_buf != NULL
> @@ -631,7 +654,6 @@ static int s3c64xx_spi_transfer_one_message(struct spi_master *master,
>  					    struct spi_message *msg)
>  {
>  	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
> -	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
>  	struct spi_device *spi = msg->spi;
>  	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
>  	struct spi_transfer *xfer;
> @@ -686,7 +708,7 @@ static int s3c64xx_spi_transfer_one_message(struct spi_master *master,
>  		}
>  
>  		/* Polling method for xfers not bigger than FIFO capacity */
> -		if (xfer->len <= ((sci->fifo_lvl_mask >> 1) + 1))
> +		if (xfer->len <= ((FIFO_LVL_MASK(sdd) >> 1) + 1))
>  			use_dma = 0;
>  		else
>  			use_dma = 1;
> @@ -840,7 +862,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>  	pm_runtime_get_sync(&sdd->pdev->dev);
>  
>  	/* Check if we can provide the requested rate */
> -	if (!sci->clk_from_cmu) {
> +	if (!sdd->port_conf->clk_from_cmu) {
>  		u32 psr, speed;
>  
>  		/* Max possible */
> @@ -921,7 +943,7 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
>  	/* Disable Interrupts - we use Polling if not DMA mode */
>  	writel(0, regs + S3C64XX_SPI_INT_EN);
>  
> -	if (!sci->clk_from_cmu)
> +	if (!sdd->port_conf->clk_from_cmu)
>  		writel(sci->src_clk_nr << S3C64XX_SPI_CLKSEL_SRCSHFT,
>  				regs + S3C64XX_SPI_CLK_CFG);
>  	writel(0, regs + S3C64XX_SPI_MODE_CFG);
> @@ -942,6 +964,13 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
>  	flush_fifo(sdd);
>  }
>  
> +static inline struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
> +						struct platform_device *pdev)
> +{
> +	return (struct s3c64xx_spi_port_config *)
> +			 platform_get_device_id(pdev)->driver_data;
> +}
> +
>  static int __init s3c64xx_spi_probe(struct platform_device *pdev)
>  {
>  	struct resource	*mem_res, *dmatx_res, *dmarx_res;
> @@ -1000,6 +1029,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, master);
>  
>  	sdd = spi_master_get_devdata(master);
> +	sdd->port_conf = s3c64xx_spi_get_port_config(pdev);
>  	sdd->master = master;
>  	sdd->cntrlr_info = sci;
>  	sdd->pdev = pdev;
> @@ -1008,10 +1038,11 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
>  	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
>  	sdd->rx_dma.dmach = dmarx_res->start;
>  	sdd->rx_dma.direction = DMA_DEV_TO_MEM;
> +	sdd->port_id = pdev->id;
>  
>  	sdd->cur_bpw = 8;
>  
> -	master->bus_num = pdev->id;
> +	master->bus_num = sdd->port_id;
>  	master->setup = s3c64xx_spi_setup;
>  	master->prepare_transfer_hardware = s3c64xx_spi_prepare_transfer;
>  	master->transfer_one_message = s3c64xx_spi_transfer_one_message;
> @@ -1071,7 +1102,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Setup Deufult Mode */
> -	s3c64xx_spi_hwinit(sdd, pdev->id);
> +	s3c64xx_spi_hwinit(sdd, sdd->port_id);
>  
>  	spin_lock_init(&sdd->lock);
>  	init_completion(&sdd->xfer_completion);
> @@ -1096,7 +1127,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
>  
>  	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d "
>  					"with %d Slaves attached\n",
> -					pdev->id, master->num_chipselect);
> +					sdd->port_id, master->num_chipselect);
>  	dev_dbg(&pdev->dev, "\tIOmem=[0x%x-0x%x]\tDMA=[Rx-%d, Tx-%d]\n",
>  					mem_res->end, mem_res->start,
>  					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
> @@ -1189,7 +1220,7 @@ static int s3c64xx_spi_resume(struct device *dev)
>  	clk_enable(sdd->src_clk);
>  	clk_enable(sdd->clk);
>  
> -	s3c64xx_spi_hwinit(sdd, pdev->id);
> +	s3c64xx_spi_hwinit(sdd, sdd->port_id);
>  
>  	spi_master_resume(master);
>  
> @@ -1227,6 +1258,100 @@ static const struct dev_pm_ops s3c64xx_spi_pm = {
>  			   s3c64xx_spi_runtime_resume, NULL)
>  };
>  
> +#if defined(CONFIG_CPU_S3C2416) || defined(CONFIG_CPU_S3C2443)
> +struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
> +	.fifo_lvl_mask	= { 0x7f },
> +	.rx_lvl_offset	= 13,
> +	.tx_st_done	= 21,
> +	.high_speed	= true,
> +};
> +#define S3C2443_SPI_PORT_CONFIG ((kernel_ulong_t)&s3c2443_spi_port_config)
> +#else
> +#define S3C2443_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
> +#endif
> +
> +#ifdef CONFIG_ARCH_S3C64XX
> +struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
> +	.fifo_lvl_mask	= { 0x7f, 0x7F },
> +	.rx_lvl_offset	= 13,
> +	.tx_st_done	= 21,
> +};
> +#define S3C6410_SPI_PORT_CONFIG ((kernel_ulong_t)&s3c6410_spi_port_config)
> +#else
> +#define S3C6410_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
> +#endif /* CONFIG_ARCH_S3C64XX */
> +
> +#ifdef CONFIG_ARCH_S5P64X0
> +struct s3c64xx_spi_port_config s5p64x0_spi_port_config = {
> +	.fifo_lvl_mask	= { 0x1ff, 0x7F },
> +	.rx_lvl_offset	= 15,
> +	.tx_st_done	= 25,
> +};
> +#define S5P64X0_SPI_PORT_CONFIG ((kernel_ulong_t)&s5p64x0_spi_port_config)
> +#else
> +#define S5P64X0_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
> +#endif /* CONFIG_ARCH_S5P64X0 */
> +
> +#ifdef CONFIG_ARCH_S5PC100
> +struct s3c64xx_spi_port_config s5pc100_spi_port_config = {
> +	.fifo_lvl_mask	= { 0x7f, 0x7F },
> +	.rx_lvl_offset	= 13,
> +	.tx_st_done	= 21,
> +	.high_speed	= true,
> +};
> +#define S5PC100_SPI_PORT_CONFIG ((kernel_ulong_t)&s5pc100_spi_port_config)
> +#else
> +#define S5PC100_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
> +#endif /* CONFIG_ARCH_S5PC100 */
> +
> +#ifdef CONFIG_ARCH_S5PV210
> +struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
> +	.fifo_lvl_mask	= { 0x1ff, 0x7F },
> +	.rx_lvl_offset	= 15,
> +	.tx_st_done	= 25,
> +	.high_speed	= 1,
> +};
> +#define S5PV210_SPI_PORT_CONFIG ((kernel_ulong_t)&s5pv210_spi_port_config)
> +#else
> +#define S5PV210_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
> +#endif /* CONFIG_ARCH_S5PV210 */
> +
> +#ifdef CONFIG_ARCH_EXYNOS4
> +struct s3c64xx_spi_port_config exynos4_spi_port_config = {
> +	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F },
> +	.rx_lvl_offset	= 15,
> +	.tx_st_done	= 25,
> +	.high_speed	= 1,
> +	.clk_from_cmu	= true,
> +};
> +#define EXYNOS4_SPI_PORT_CONFIG ((kernel_ulong_t)&exynos4_spi_port_config)
> +#else
> +#define EXYNOS4_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
> +#endif /* CONFIG_ARCH_EXYNOS4 */
> +
> +static struct platform_device_id s3c64xx_spi_driver_ids[] = {
> +	{
> +		.name		= "s3c2443-spi",
> +		.driver_data	= S3C2443_SPI_PORT_CONFIG,
> +	}, {
> +		.name		= "s3c6410-spi",
> +		.driver_data	= S3C6410_SPI_PORT_CONFIG,
> +	}, {
> +		.name		= "s5p64x0-spi",
> +		.driver_data	= S5P64X0_SPI_PORT_CONFIG,
> +	}, {
> +		.name		= "s5pc100-spi",
> +		.driver_data	= S5PC100_SPI_PORT_CONFIG,
> +	}, {
> +		.name		= "s5pv210-spi",
> +		.driver_data	= S5PV210_SPI_PORT_CONFIG,
> +	}, {
> +		.name		= "exynos4210-spi",
> +		.driver_data	= EXYNOS4_SPI_PORT_CONFIG,
> +	},
> +	{ },
> +};
> +
>  static struct platform_driver s3c64xx_spi_driver = {
>  	.driver = {
>  		.name	= "s3c64xx-spi",
> @@ -1234,6 +1359,7 @@ static struct platform_driver s3c64xx_spi_driver = {
>  		.pm = &s3c64xx_spi_pm,
>  	},
>  	.remove = s3c64xx_spi_remove,
> +	.id_table = s3c64xx_spi_driver_ids,
>  };
>  MODULE_ALIAS("platform:s3c64xx-spi");
>  
> -- 
> 1.6.6.rc2
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
