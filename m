From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Sep 2011 16:06:50 +0900
Subject: [PATCH V3 4/7] ARM: S5P64X0: Add GPIO and SPCON settings for LCD
In-Reply-To: <1311787878-16193-5-git-send-email-ajaykumar.rs@samsung.com>
References: <1311787878-16193-1-git-send-email-ajaykumar.rs@samsung.com>
	<1311787878-16193-5-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <000901cc6d2c$b723d830$256b8890$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ajay Kumar wrote:
> 
> This patch adds:
> 	-- GPIO lines settings(HSYNC, VSYNC, VCLK and VD) for LCD.
> 	-- Function to select LCD interface (RGB/i80)
> 
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  arch/arm/mach-s5p64x0/Kconfig                  |    6 +++
>  arch/arm/mach-s5p64x0/Makefile                 |    1 +
>  arch/arm/mach-s5p64x0/include/mach/regs-gpio.h |    4 ++
>  arch/arm/mach-s5p64x0/setup-fb.c               |   48
> ++++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/fb.h        |   14 +++++++
>  5 files changed, 73 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5p64x0/setup-fb.c
> 
> diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
> index 65c7518..4fee745 100644
> --- a/arch/arm/mach-s5p64x0/Kconfig
> +++ b/arch/arm/mach-s5p64x0/Kconfig
> @@ -21,6 +21,12 @@ config CPU_S5P6450
>  	help
>  	  Enable S5P6450 CPU support
> 
> +config S5P64X0_SETUP_FB

How about to use S5P64X0_SETUP_FB_24BPP like others?

> +	bool
> +	help
> +	  Common setup code for S5P64X0 based boards with a LCD display
> +	  through RGB interface.
> +
>  config S5P64X0_SETUP_I2C1
>  	bool
>  	help
> diff --git a/arch/arm/mach-s5p64x0/Makefile
b/arch/arm/mach-s5p64x0/Makefile
> index 5f6afdf..487d179 100644
> --- a/arch/arm/mach-s5p64x0/Makefile
> +++ b/arch/arm/mach-s5p64x0/Makefile
> @@ -28,3 +28,4 @@ obj-y				+= dev-audio.o
>  obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
> 
>  obj-$(CONFIG_S5P64X0_SETUP_I2C1)	+= setup-i2c1.o
> +obj-$(CONFIG_S5P64X0_SETUP_FB)		+= setup-fb.o
> diff --git a/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
b/arch/arm/mach-
> s5p64x0/include/mach/regs-gpio.h
> index 6ce2547..34d4412 100644
> --- a/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
> +++ b/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
> @@ -44,4 +44,8 @@
>  #define S5P64X0_EINT0MASK		(S5P_VA_GPIO +
> EINT0MASK_OFFSET)
>  #define S5P64X0_EINT0PEND		(S5P_VA_GPIO +
> EINT0PEND_OFFSET)
> 
> +#define S5P64X0_SPCON0			(S5P_VA_GPIO + 0x1A0)
> +#define S5P64X0_SPCON0_LCD_SEL_MASK	(0x3 << 0)
> +#define S5P64X0_SPCON0_LCD_SEL_RGB	(0x1 << 0)

I can't find where 'xxx_LCD_SEL_RGB' is used...of course, it can be used
later.
But please don't add definition which is not used now.

> +
>  #endif /* __ASM_ARCH_REGS_GPIO_H */
> diff --git a/arch/arm/mach-s5p64x0/setup-fb.c
b/arch/arm/mach-s5p64x0/setup-fb.c
> new file mode 100644
> index 0000000..0d9903a
> --- /dev/null
> +++ b/arch/arm/mach-s5p64x0/setup-fb.c

arch/arm/mach-s5p64x0/setup-fb-24bpp.c?

And if required, we can change it later with others next time...

> @@ -0,0 +1,48 @@
> +/* linux/arch/arm/mach-s5p64x0/setup-fb.c
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *         http://www.samsung.com/
> + *
> + * Base S5P64X0 GPIO setup information for LCD framebuffer
> + *
> + * GPIO settings for LCD on any other board based on s5p64x0
> + * should go in this file.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/fb.h>
> +#include <linux/gpio.h>
> +
> +#include <plat/fb.h>
> +#include <plat/gpio-cfg.h>
> +
> +#include <mach/regs-clock.h>
> +#include <mach/regs-gpio.h>
> +
> +void s5p64x0_fb_init(int lcd_interface_type)
> +{
> +	unsigned int cfg;
> +
> +	/* select TFT LCD type (RGB I/F) */
> +	cfg = __raw_readl(S5P64X0_SPCON0);
> +	cfg &= ~S5P64X0_SPCON0_LCD_SEL_MASK;
> +	cfg |= lcd_interface_type;
> +	__raw_writel(cfg, S5P64X0_SPCON0);

Hmm...how about to move above into its board file? So we don't need to get
the argument, lcd_interface_type...

> +}
> +
> +void s5p64x0_fb_gpio_setup_24bpp(void)
> +{
> +	unsigned int chipid;
> +
> +	chipid = __raw_readl(S5P64X0_SYS_ID) & 0xf0000;

You can use soc_is_xxx() here instead of checking of CPUID directly.

> +	if (chipid == 0x40000) {
> +		s3c_gpio_cfgrange_nopull(S5P6440_GPI(0), 16,
> S3C_GPIO_SFN(2));
> +		s3c_gpio_cfgrange_nopull(S5P6440_GPJ(0), 12,
> S3C_GPIO_SFN(2));
> +	} else if (chipid == 0x50000) {
> +		s3c_gpio_cfgrange_nopull(S5P6450_GPI(0), 16,
> S3C_GPIO_SFN(2));
> +		s3c_gpio_cfgrange_nopull(S5P6450_GPJ(0), 12,
> S3C_GPIO_SFN(2));
> +	}
> +}
> diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-
> samsung/include/plat/fb.h
> index 01f10e4..bd79c0a 100644
> --- a/arch/arm/plat-samsung/include/plat/fb.h
> +++ b/arch/arm/plat-samsung/include/plat/fb.h
> @@ -109,4 +109,18 @@ extern void s5pv210_fb_gpio_setup_24bpp(void);
>   */
>  extern void exynos4_fimd0_gpio_setup_24bpp(void);
> 
> +/**
> + * s5p64x0_fb_init() - Common setup function for LCD
> + *
> + * Select LCD I/F configuration-RGB style or i80 style
> + */
> +extern void s5p64x0_fb_init(int lcd_interface_type);
> +
> +/**
> + * s5p64x0_fb_gpio_setup_24bpp() - Common GPIO setup function for LCD
> + *
> + * Initialise the GPIO for a LCD display on the RGB interface.
> + */
> +extern void s5p64x0_fb_gpio_setup_24bpp(void);
> +
>  #endif /* __PLAT_S3C_FB_H */
> --
> 1.7.0.4

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
