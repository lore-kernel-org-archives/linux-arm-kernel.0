From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 30 Nov 2010 16:21:01 +0900
Subject: [PATCH 02/10] ARM S3C2416: Add address map and clock definitions
	for HSMMC0
In-Reply-To: <1290969027-10178-2-git-send-email-jekhor@gmail.com>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
	<1290969027-10178-2-git-send-email-jekhor@gmail.com>
Message-ID: <001b01cb905f$27aea180$770be480$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yauhen Kharuzhy wrote:
> 
> Define maps for HSMMC devices.
> 
> S3C2443 has one HSMMC device with base address 0x4A800000.

Hmm...according to data sheet, there are two SD/MMC on S3C2443.
The base address of channel 0 is 0x4A800000 and channel 1 is 0x5A000000.
So, need to update your patch.

> S3C2416 has HSMMC0 at 0x4AC00000 and HSMMC1 at 0x4A800000.
> 
> So suppose that S3C2443 has only HSMMC1.
> 
Hmm...

> Define clock for hsmmc0 device and register it.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>

I meant you used different here so asked...anyway...

> ---
>  arch/arm/mach-s3c2410/include/mach/irqs.h          |    4 ++--
>  arch/arm/mach-s3c2410/include/mach/map.h           |    4 ++--
>  .../mach-s3c2410/include/mach/regs-s3c2443-clock.h |    1 +
>  arch/arm/mach-s3c2416/clock.c                      |   18
+++++++++++++-----
>  arch/arm/mach-s3c2443/Kconfig                      |    2 +-
>  arch/arm/mach-s3c2443/clock.c                      |    4 ++--
>  arch/arm/mach-s3c2443/mach-smdk2443.c              |    2 +-
>  arch/arm/plat-s3c24xx/s3c2443-clock.c              |    2 +-
>  8 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/include/mach/irqs.h b/arch/arm/mach-
> s3c2410/include/mach/irqs.h
> index 11bb0f0..e5a68ea 100644
> --- a/arch/arm/mach-s3c2410/include/mach/irqs.h
> +++ b/arch/arm/mach-s3c2410/include/mach/irqs.h
> @@ -152,8 +152,8 @@
> 
>  #define IRQ_S3C2416_HSMMC0	S3C2410_IRQ(21)		/*
> S3C2416/S3C2450 */
> 
> -#define IRQ_HSMMC0		IRQ_S3C2443_HSMMC
> -#define IRQ_HSMMC1		IRQ_S3C2416_HSMMC0
> +#define IRQ_HSMMC0		IRQ_S3C2416_HSMMC0
> +#define IRQ_HSMMC1		IRQ_S3C2443_HSMMC
> 
Hmm...yeah, IRQ_HSMMC0 is (21) and IRQ_HSMMC1 is (20).

>  #define IRQ_S3C2443_LCD1	S3C2410_IRQSUB(14)
>  #define IRQ_S3C2443_LCD2	S3C2410_IRQSUB(15)
> diff --git a/arch/arm/mach-s3c2410/include/mach/map.h b/arch/arm/mach-
> s3c2410/include/mach/map.h
> index cd3983a..25bbf5a 100644
> --- a/arch/arm/mach-s3c2410/include/mach/map.h
> +++ b/arch/arm/mach-s3c2410/include/mach/map.h
> @@ -112,8 +112,8 @@
>  #define S3C_PA_IIC          S3C2410_PA_IIC
>  #define S3C_PA_UART	    S3C24XX_PA_UART
>  #define S3C_PA_USBHOST	S3C2410_PA_USBHOST
> -#define S3C_PA_HSMMC0	    S3C2443_PA_HSMMC
> -#define S3C_PA_HSMMC1	    S3C2416_PA_HSMMC0
> +#define S3C_PA_HSMMC0	    S3C2416_PA_HSMMC0
> +#define S3C_PA_HSMMC1	    S3C2443_PA_HSMMC

Please refer to my previous comment.
S3C2443 has 2 channel.

>  #define S3C_PA_WDT	    S3C2410_PA_WATCHDOG
>  #define S3C_PA_NAND	    S3C24XX_PA_NAND
> 
> diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
> b/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
> index 101aeea..44494a5 100644
> --- a/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
> +++ b/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
> @@ -86,6 +86,7 @@
>  #define S3C2443_HCLKCON_LCDC		(1<<9)
>  #define S3C2443_HCLKCON_USBH		(1<<11)
>  #define S3C2443_HCLKCON_USBD		(1<<12)
> +#define S3C2416_HCLKCON_HSMMC0		(1<<15)

Right.

>  #define S3C2443_HCLKCON_HSMMC		(1<<16)
>  #define S3C2443_HCLKCON_CFC		(1<<17)
>  #define S3C2443_HCLKCON_SSMC		(1<<18)
> diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
> index 7ccf5a2..3b02d85 100644
> --- a/arch/arm/mach-s3c2416/clock.c
> +++ b/arch/arm/mach-s3c2416/clock.c
> @@ -38,12 +38,11 @@ static unsigned int armdiv[8] = {
>  	[7] = 8,
>  };
> 
> -/* ID to hardware numbering, 0 is HSMMC1, 1 is HSMMC0 */

Why remove?

>  static struct clksrc_clk hsmmc_div[] = {
>  	[0] = {
>  		.clk = {
>  			.name	= "hsmmc-div",
> -			.id	= 1,
> +			.id	= 0,
>  			.parent	= &clk_esysclk.clk,
>  		},
>  		.reg_div = { .reg = S3C2416_CLKDIV2, .size = 2, .shift = 6
},
> @@ -51,7 +50,7 @@ static struct clksrc_clk hsmmc_div[] = {
>  	[1] = {
>  		.clk = {
>  			.name	= "hsmmc-div",
> -			.id	= 0,
> +			.id	= 1,
>  			.parent	= &clk_esysclk.clk,
>  		},
>  		.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 6
},
> @@ -61,7 +60,7 @@ static struct clksrc_clk hsmmc_div[] = {
>  static struct clksrc_clk hsmmc_mux[] = {
>  	[0] = {
>  		.clk	= {
> -			.id	= 1,
> +			.id	= 0,
>  			.name	= "hsmmc-if",
>  			.ctrlbit = (1 << 6),
>  			.enable = s3c2443_clkcon_enable_s,
> @@ -77,7 +76,7 @@ static struct clksrc_clk hsmmc_mux[] = {
>  	},
>  	[1] = {
>  		.clk	= {
> -			.id	= 0,
> +			.id	= 1,
>  			.name	= "hsmmc-if",
>  			.ctrlbit = (1 << 12),
>  			.enable = s3c2443_clkcon_enable_s,
> @@ -93,6 +92,13 @@ static struct clksrc_clk hsmmc_mux[] = {
>  	},
>  };
> 
> +static struct clk hsmmc0_clk = {
> +	.name		= "hsmmc",
> +	.id		= 0,
> +	.parent		= &clk_h,
> +	.enable		= s3c2443_clkcon_enable_h,
> +	.ctrlbit	= S3C2416_HCLKCON_HSMMC0,
> +};
> 
>  static inline unsigned int s3c2416_fclk_div(unsigned long clkcon0)
>  {
> @@ -130,6 +136,8 @@ void __init s3c2416_init_clocks(int xtal)
>  	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
>  		s3c_register_clksrc(clksrcs[ptr], 1);
> 
> +	s3c24xx_register_clock(&hsmmc0_clk);
> +
>  	s3c_pwmclk_init();
> 
>  }
> diff --git a/arch/arm/mach-s3c2443/Kconfig b/arch/arm/mach-s3c2443/Kconfig
> index 4fef723..0b7f0d6 100644
> --- a/arch/arm/mach-s3c2443/Kconfig
> +++ b/arch/arm/mach-s3c2443/Kconfig
> @@ -24,7 +24,7 @@ config MACH_SMDK2443
>  	bool "SMDK2443"
>  	select CPU_S3C2443
>  	select MACH_SMDK
> -	select S3C_DEV_HSMMC
> +	select S3C_DEV_HSMMC1

Please check S3C2443's HSMMC...

>  	help
>  	  Say Y here if you are using an SMDK2443
> 
> diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
> index 0c3c0c8..f4ec6d5 100644
> --- a/arch/arm/mach-s3c2443/clock.c
> +++ b/arch/arm/mach-s3c2443/clock.c
> @@ -196,7 +196,7 @@ static struct clksrc_clk clk_hsspi = {
>  static struct clksrc_clk clk_hsmmc_div = {
>  	.clk	= {
>  		.name		= "hsmmc-div",
> -		.id		= -1,
> +		.id		= 1,
>  		.parent		= &clk_esysclk.clk,
>  	},
>  	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 6 },
> @@ -231,7 +231,7 @@ static int s3c2443_enable_hsmmc(struct clk *clk, int
> enable)
> 
>  static struct clk clk_hsmmc = {
>  	.name		= "hsmmc-if",
> -	.id		= -1,
> +	.id		= 1,
>  	.parent		= &clk_hsmmc_div.clk,
>  	.enable		= s3c2443_enable_hsmmc,
>  	.ops		= &(struct clk_ops) {
> diff --git a/arch/arm/mach-s3c2443/mach-smdk2443.c b/arch/arm/mach-
> s3c2443/mach-smdk2443.c
> index 4337f0a..d3b2922 100644
> --- a/arch/arm/mach-s3c2443/mach-smdk2443.c
> +++ b/arch/arm/mach-s3c2443/mach-smdk2443.c
> @@ -105,7 +105,7 @@ static struct s3c2410_uartcfg smdk2443_uartcfgs[]
> __initdata = {
>  static struct platform_device *smdk2443_devices[] __initdata = {
>  	&s3c_device_wdt,
>  	&s3c_device_i2c0,
> -	&s3c_device_hsmmc0,
> +	&s3c_device_hsmmc1,
>  #ifdef CONFIG_SND_SOC_SMDK2443_WM9710
>  	&s3c_device_ac97,
>  #endif
> diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-
> s3c24xx/s3c2443-clock.c
> index 461f070..82f2d4a 100644
> --- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
> +++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
> @@ -271,7 +271,7 @@ static struct clk init_clocks[] = {
>  		.ctrlbit	= S3C2443_HCLKCON_DMA5,
>  	}, {
>  		.name		= "hsmmc",
> -		.id		= 0,
> +		.id		= 1,
>  		.parent		= &clk_h,
>  		.enable		= s3c2443_clkcon_enable_h,
>  		.ctrlbit	= S3C2443_HCLKCON_HSMMC,
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
