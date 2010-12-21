From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 21 Dec 2010 09:39:44 +0900
Subject: [PATCH 06/17] ARM: S5P64X0: Segregate audio devices
In-Reply-To: <1292562007-19780-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
	<1292562007-19780-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <018101cba0a7$95c9bd00$c15d3700$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> 
> From: Jassi Brar <jassi.brar@samsung.com>
> 
Hi Jassi,

Maybe this is from Rajeshwari Shinde?

From: Rajeshwari Shinde <rajeshwari.s@samsung.com>

> Segregate I2S devices for S5P6440 and S5P6450.
> 
> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  arch/arm/mach-s5p64x0/dev-audio.c         |  123
++++++++++++++++++++++++++-
> --
>  arch/arm/plat-samsung/include/plat/devs.h |    2 +
>  2 files changed, 112 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-s5p64x0/dev-audio.c
b/arch/arm/mach-s5p64x0/dev-
> audio.c
> index 14f89e7..35f1f22 100644
> --- a/arch/arm/mach-s5p64x0/dev-audio.c
> +++ b/arch/arm/mach-s5p64x0/dev-audio.c
> @@ -24,13 +24,13 @@ static const char *rclksrc[] = {
>  	[1] = "sclk_audio2",
>  };
> 
> -static int s5p64x0_cfg_i2s(struct platform_device *pdev)
> +static int s5p6440_cfg_i2s(struct platform_device *pdev)
>  {
> -	/* configure GPIO for i2s port */
>  	switch (pdev->id) {
>  	case 0:
> -		s3c_gpio_cfgpin_range(S5P6440_GPR(4), 5, S3C_GPIO_SFN(5));
> -		s3c_gpio_cfgpin_range(S5P6440_GPR(13), 2, S3C_GPIO_SFN(5));
> +		s3c_gpio_cfgpin_range(S5P6440_GPC(4), 2, S3C_GPIO_SFN(5));
> +		s3c_gpio_cfgpin(S5P6440_GPC(7), S3C_GPIO_SFN(5));
> +		s3c_gpio_cfgpin_range(S5P6440_GPH(6), 4, S3C_GPIO_SFN(5));
>  		break;
>  	default:
>  		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
> @@ -40,8 +40,8 @@ static int s5p64x0_cfg_i2s(struct platform_device *pdev)
>  	return 0;
>  }
> 
> -static struct s3c_audio_pdata s5p64x0_i2s_pdata = {
> -	.cfg_gpio = s5p64x0_cfg_i2s,
> +static struct s3c_audio_pdata s5p6440_i2s_pdata = {
> +	.cfg_gpio = s5p6440_cfg_i2s,
>  	.type = {
>  		.i2s = {
>  			.quirks = QUIRK_PRI_6CHAN,
> @@ -50,7 +50,7 @@ static struct s3c_audio_pdata s5p64x0_i2s_pdata = {
>  	},
>  };
> 
> -static struct resource s5p64x0_iis0_resource[] = {
> +static struct resource s5p64x0_i2s0_resource[] = {
>  	[0] = {
>  		.start	= S5P64X0_PA_I2S,
>  		.end	= S5P64X0_PA_I2S + 0x100 - 1,
> @@ -71,20 +71,117 @@ static struct resource s5p64x0_iis0_resource[] = {
>  struct platform_device s5p6440_device_iis = {
>  	.name		= "samsung-i2s",
>  	.id		= 0,
> -	.num_resources	= ARRAY_SIZE(s5p64x0_iis0_resource),
> -	.resource	= s5p64x0_iis0_resource,
> +	.num_resources	= ARRAY_SIZE(s5p64x0_i2s0_resource),
> +	.resource	= s5p64x0_i2s0_resource,
>  	.dev = {
> -		.platform_data = &s5p64x0_i2s_pdata,
> +		.platform_data = &s5p6440_i2s_pdata,
> +	},
> +};
> +
> +static int s5p6450_cfg_i2s(struct platform_device *pdev)
> +{
> +	switch (pdev->id) {
> +	case 0:
> +		s3c_gpio_cfgpin_range(S5P6450_GPR(4), 5, S3C_GPIO_SFN(5));
> +		s3c_gpio_cfgpin_range(S5P6450_GPR(13), 2, S3C_GPIO_SFN(5));
> +		break;
> +	case 1:
> +		s3c_gpio_cfgpin(S5P6440_GPB(4), S3C_GPIO_SFN(5));
> +		s3c_gpio_cfgpin_range(S5P6450_GPC(0), 4, S3C_GPIO_SFN(5));
> +		break;
> +	case 2:
> +		s3c_gpio_cfgpin_range(S5P6450_GPK(0), 5, S3C_GPIO_SFN(5));
> +		break;
> +	default:
> +		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct s3c_audio_pdata s5p6450_i2s0_pdata = {
> +	.cfg_gpio = s5p6450_cfg_i2s,
> +	.type = {
> +		.i2s = {
> +			.quirks = QUIRK_PRI_6CHAN,
> +			.src_clk = rclksrc,
> +		},
>  	},
>  };
> 
>  struct platform_device s5p6450_device_iis0 = {
>  	.name		= "samsung-i2s",
>  	.id		= 0,
> -	.num_resources	= ARRAY_SIZE(s5p64x0_iis0_resource),
> -	.resource	= s5p64x0_iis0_resource,
> +	.num_resources	= ARRAY_SIZE(s5p64x0_i2s0_resource),
> +	.resource	= s5p64x0_i2s0_resource,
> +	.dev = {
> +		.platform_data = &s5p6450_i2s0_pdata,
> +	},
> +};
> +
> +static struct s3c_audio_pdata s5p6450_i2s_pdata = {
> +	.cfg_gpio = s5p6450_cfg_i2s,
> +	.type = {
> +		.i2s = {
> +			.src_clk = rclksrc,
> +		},
> +	},
> +};
> +
> +static struct resource s5p6450_i2s1_resource[] = {
> +	[0] = {
> +		.start	= S5P6450_PA_I2S1,
> +		.end	= S5P6450_PA_I2S1 + 0x100 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= DMACH_I2S1_TX,
> +		.end	= DMACH_I2S1_TX,
> +		.flags	= IORESOURCE_DMA,
> +	},
> +	[2] = {
> +		.start	= DMACH_I2S1_RX,
> +		.end	= DMACH_I2S1_RX,
> +		.flags	= IORESOURCE_DMA,
> +	},
> +};
> +
> +struct platform_device s5p6450_device_iis1 = {
> +	.name		= "samsung-i2s",
> +	.id		= 1,
> +	.num_resources	= ARRAY_SIZE(s5p6450_i2s1_resource),
> +	.resource	= s5p6450_i2s1_resource,
> +	.dev = {
> +		.platform_data = &s5p6450_i2s_pdata,
> +	},
> +};
> +
> +static struct resource s5p6450_i2s2_resource[] = {
> +	[0] = {
> +		.start	= S5P6450_PA_I2S2,
> +		.end	= S5P6450_PA_I2S2 + 0x100 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= DMACH_I2S2_TX,
> +		.end	= DMACH_I2S2_TX,
> +		.flags	= IORESOURCE_DMA,
> +	},
> +	[2] = {
> +		.start	= DMACH_I2S2_RX,
> +		.end	= DMACH_I2S2_RX,
> +		.flags	= IORESOURCE_DMA,
> +	},
> +};
> +
> +struct platform_device s5p6450_device_iis2 = {
> +	.name		= "samsung-i2s",
> +	.id		= 2,
> +	.num_resources	= ARRAY_SIZE(s5p6450_i2s2_resource),
> +	.resource	= s5p6450_i2s2_resource,
>  	.dev = {
> -		.platform_data = &s5p64x0_i2s_pdata,
> +		.platform_data = &s5p6450_i2s_pdata,
>  	},
>  };
> 
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-
> samsung/include/plat/devs.h
> index e9e3b6e..ec23691 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -115,6 +115,8 @@ extern struct platform_device s5p6440_device_pcm;
>  extern struct platform_device s5p6440_device_iis;
> 
>  extern struct platform_device s5p6450_device_iis0;
> +extern struct platform_device s5p6450_device_iis1;
> +extern struct platform_device s5p6450_device_iis2;
>  extern struct platform_device s5p6450_device_pcm0;
> 
>  extern struct platform_device s5pc100_device_ac97;
> --
> 1.6.2.5
