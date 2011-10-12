From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 12 Oct 2011 12:24:27 +0200
Subject: [PATCH V4 3/3] ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using
	generic names
In-Reply-To: <1318412587-29987-4-git-send-email-rajeshwari.s@samsung.com>
References: <1318412587-29987-1-git-send-email-rajeshwari.s@samsung.com>
	<1318412587-29987-4-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <4E956ADB.3060604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajeshwari,

On 10/12/2011 11:43 AM, Rajeshwari Shinde wrote:
> Add support for lookup of sdhci-s3c controller clocks using generic names
> for s3c2416, s3c64xx, s5pc100, s5pv210 and exynos4 SoC's.
> 
> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
> ---
>  arch/arm/mach-exynos4/clock.c         |   88 ++++++++++-------
>  arch/arm/mach-s3c2416/clock.c         |   68 +++++++------
>  arch/arm/mach-s3c64xx/clock.c         |  126 +++++++++++++++----------
>  arch/arm/mach-s5pc100/clock.c         |  130 ++++++++++++++++----------
>  arch/arm/mach-s5pv210/clock.c         |  167 ++++++++++++++++++++-------------
>  arch/arm/plat-s3c24xx/s3c2443-clock.c |   15 ++-
>  6 files changed, 359 insertions(+), 235 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
> index 9f50e33..c6383b9 100644
> --- a/arch/arm/mach-exynos4/clock.c
> +++ b/arch/arm/mach-exynos4/clock.c
> @@ -1157,42 +1157,6 @@ static struct clksrc_clk clksrcs[] = {
>  		.reg_div = { .reg = S5P_CLKDIV_MFC, .shift = 0, .size = 4 },
>  	}, {
>  		.clk		= {
> -			.name		= "sclk_mmc",
> -			.devname	= "s3c-sdhci.0",
> -			.parent		= &clk_dout_mmc0.clk,
> -			.enable		= exynos4_clksrc_mask_fsys_ctrl,
> -			.ctrlbit	= (1 << 0),
> -		},
> -		.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 8, .size = 8 },
> -	}, {
> -		.clk		= {
> -			.name		= "sclk_mmc",
> -			.devname	= "s3c-sdhci.1",
> -			.parent         = &clk_dout_mmc1.clk,
> -			.enable		= exynos4_clksrc_mask_fsys_ctrl,
> -			.ctrlbit	= (1 << 4),
> -		},
> -		.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 24, .size = 8 },
> -	}, {
> -		.clk		= {
> -			.name		= "sclk_mmc",
> -			.devname	= "s3c-sdhci.2",
> -			.parent         = &clk_dout_mmc2.clk,
> -			.enable		= exynos4_clksrc_mask_fsys_ctrl,
> -			.ctrlbit	= (1 << 8),
> -		},
> -		.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 8, .size = 8 },
> -	}, {
> -		.clk		= {
> -			.name		= "sclk_mmc",
> -			.devname	= "s3c-sdhci.3",
> -			.parent         = &clk_dout_mmc3.clk,
> -			.enable		= exynos4_clksrc_mask_fsys_ctrl,
> -			.ctrlbit	= (1 << 12),
> -		},
> -		.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 24, .size = 8 },
> -	}, {
> -		.clk		= {
>  			.name		= "sclk_dwmmc",
>  			.parent         = &clk_dout_mmc4.clk,
>  			.enable		= exynos4_clksrc_mask_fsys_ctrl,
> @@ -1250,6 +1214,50 @@ static struct clksrc_clk clk_sclk_uart3 = {
>  	.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 12, .size = 4 },
>  };
>  
> +static struct clksrc_clk clk_sclk_mmc0 = {
> +	.clk		= {
> +		.name		= "sclk_mmc",
> +		.devname	= "s3c-sdhci.0",

Would it make sense to drop this 'devname' field here and others
until sclk_mmc3 ....

> +		.parent		= &clk_dout_mmc0.clk,
> +		.enable		= exynos4_clksrc_mask_fsys_ctrl,
> +		.ctrlbit	= (1 << 0),
> +	},
> +	.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 8, .size = 8 },
> +};
> +
> +static struct clksrc_clk clk_sclk_mmc1 = {
> +	.clk		= {
> +		.name		= "sclk_mmc",
> +		.devname	= "s3c-sdhci.1",

> +		.parent         = &clk_dout_mmc1.clk,
> +		.enable		= exynos4_clksrc_mask_fsys_ctrl,
> +		.ctrlbit	= (1 << 4),
> +	},
> +	.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 24, .size = 8 },
> +};
> +
> +static struct clksrc_clk clk_sclk_mmc2 = {
> +	.clk		= {
> +		.name		= "sclk_mmc",
> +		.devname	= "s3c-sdhci.2",

> +		.parent         = &clk_dout_mmc2.clk,
> +		.enable		= exynos4_clksrc_mask_fsys_ctrl,
> +		.ctrlbit	= (1 << 8),
> +	},
> +	.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 8, .size = 8 },
> +};
> +
> +static struct clksrc_clk clk_sclk_mmc3 = {
> +	.clk		= {
> +		.name		= "sclk_mmc",
> +		.devname	= "s3c-sdhci.3",

> +		.parent         = &clk_dout_mmc3.clk,
> +		.enable		= exynos4_clksrc_mask_fsys_ctrl,
> +		.ctrlbit	= (1 << 12),
> +	},
> +	.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 24, .size = 8 },
> +};
> +
>  /* Clock initialization code */
>  static struct clksrc_clk *sysclks[] = {
>  	&clk_mout_apll,
> @@ -1289,6 +1297,10 @@ static struct clksrc_clk *clksrc_cdev[] = {
>  	&clk_sclk_uart1,
>  	&clk_sclk_uart2,
>  	&clk_sclk_uart3,
> +	&clk_sclk_mmc0,
> +	&clk_sclk_mmc1,
> +	&clk_sclk_mmc2,
> +	&clk_sclk_mmc3,

..then drop the above 4 lines...

>  };
>  
>  static struct clk_lookup exynos4_clk_lookup[] = {
> @@ -1296,6 +1308,10 @@ static struct clk_lookup exynos4_clk_lookup[] = {
>  	CLKDEV_INIT("exynos4210-uart.1", "clk_uart_baud0", &clk_sclk_uart1.clk),
>  	CLKDEV_INIT("exynos4210-uart.2", "clk_uart_baud0", &clk_sclk_uart2.clk),
>  	CLKDEV_INIT("exynos4210-uart.3", "clk_uart_baud0", &clk_sclk_uart3.clk),
> +	CLKDEV_INIT("exynos4-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
> +	CLKDEV_INIT("exynos4-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
> +	CLKDEV_INIT("exynos4-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
> +	CLKDEV_INIT("exynos4-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),

..and add something like:

 +	CLKDEV_INIT("s3c-sdhci.0", "sclk_mmc", &clk_sclk_mmc0.clk),
 +	CLKDEV_INIT("s3c-sdhci.1", "sclk_mmc", &clk_sclk_mmc1.clk),
 +	CLKDEV_INIT("s3c-sdhci.2", "sclk_mmc", &clk_sclk_mmc2.clk),
 +	CLKDEV_INIT("s3c-sdhci.3", "sclk_mmc", &clk_sclk_mmc3.clk),

?

Also I'm wondering why we're using different device names for clk_sclk_mmc0..3
clocks, i.e. exynos4-sdhci.? and s3c-sdhci.? ?

Does it all work on exynos ? I would expect the device name to be same
across all the clock definitions, otherwise clk_get(dev, ..) will fail.

>  };
>  

Regards
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
