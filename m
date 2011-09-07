From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Sep 2011 16:06:52 +0900
Subject: [PATCH V3 5/7] ARM: S5P64X0: Add file to hold common Framebuffer
	and LCD code
In-Reply-To: <1311787878-16193-6-git-send-email-ajaykumar.rs@samsung.com>
References: <1311787878-16193-1-git-send-email-ajaykumar.rs@samsung.com>
	<1311787878-16193-6-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <000a01cc6d2c$b8529430$28f7bc90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ajay Kumar wrote:
> 
> This patch creates a file which holds the framebuffer and
> LCD code which is common for SMDK6440 and SMDK6450.
> It mainly includes:
> 	-- Basic FB window definition.
> 	-- platform data for FB and LCD.
> 	-- platform_device support for LCD.
> 
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  arch/arm/mach-s5p64x0/Kconfig                      |    5 +
>  arch/arm/mach-s5p64x0/Makefile                     |    3 +
>  .../mach-s5p64x0/include/mach/smdk64x0-common-fb.h |   26 ++++++
>  arch/arm/mach-s5p64x0/smdk64x0-common-fb.c         |   92
> ++++++++++++++++++++
>  4 files changed, 126 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5p64x0/include/mach/smdk64x0-common-
> fb.h
>  create mode 100644 arch/arm/mach-s5p64x0/smdk64x0-common-fb.c
> 
> diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
> index 4fee745..00d5873 100644
> --- a/arch/arm/mach-s5p64x0/Kconfig
> +++ b/arch/arm/mach-s5p64x0/Kconfig
> @@ -32,6 +32,11 @@ config S5P64X0_SETUP_I2C1
>  	help
>  	  Common setup code for i2c bus 1.
> 
> +config SMDK64X0_COMMON_FB
> +	bool
> +	help
> +	Common framebuffer and LCD code which can be shared across SMDKs.
> +
>  # machine support
> 
>  config MACH_SMDK6440
> diff --git a/arch/arm/mach-s5p64x0/Makefile
b/arch/arm/mach-s5p64x0/Makefile
> index 487d179..d09d81b 100644
> --- a/arch/arm/mach-s5p64x0/Makefile
> +++ b/arch/arm/mach-s5p64x0/Makefile
> @@ -22,6 +22,9 @@ obj-$(CONFIG_CPU_S5P6450)	+= clock-s5p6450.o
>  obj-$(CONFIG_MACH_SMDK6440)	+= mach-smdk6440.o
>  obj-$(CONFIG_MACH_SMDK6450)	+= mach-smdk6450.o
> 
> +#common code
> +obj-$(CONFIG_SMDK64X0_COMMON_FB)   += smdk64x0-common-fb.o
> +
>  # device support
> 
>  obj-y				+= dev-audio.o
> diff --git a/arch/arm/mach-s5p64x0/include/mach/smdk64x0-common-fb.h
> b/arch/arm/mach-s5p64x0/include/mach/smdk64x0-common-fb.h
> new file mode 100644
> index 0000000..e3b87b9
> --- /dev/null
> +++ b/arch/arm/mach-s5p64x0/include/mach/smdk64x0-common-fb.h
> @@ -0,0 +1,26 @@
> +/* linux/arch/arm/mach-s5p64x0/include/mach/smdk64x0-common-fb.h
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *         http://www.samsung.com/
> + *
> + * Includes declarations for variables and functions
> + * needed in order to support framebuffer.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/fb.h>
> +#include <linux/platform_device.h>
> +
> +#include <video/platform_lcd.h>
> +
> +#include <plat/fb.h>
> +
> +extern struct	s3c_fb_pd_win		smdk64x0_fb_win0;
> +extern struct	s3c_fb_platdata		smdk64x0_lcd_pdata;
> +extern struct	plat_lcd_data		smdk64x0_lcd_power_data;
> +extern struct	platform_device		smdk64x0_lcd_lte480wv;
> +extern void	smdk64x0_lte480_reset_power(struct plat_lcd_data *pd,
> +					    unsigned int power);
> diff --git a/arch/arm/mach-s5p64x0/smdk64x0-common-fb.c b/arch/arm/mach-
> s5p64x0/smdk64x0-common-fb.c
> new file mode 100644
> index 0000000..a3203f8
> --- /dev/null
> +++ b/arch/arm/mach-s5p64x0/smdk64x0-common-fb.c
> @@ -0,0 +1,92 @@
> +/* linux/arch/arm/mach-s5p64x0/smdk64x0-common-fb.c
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *         http://www.samsung.com/
> + *
> + * Includes definitions for variables and functions
> + * needed in order to support framebuffer.
> + * Note that this code is common across SMDK6440 and SMDK6450.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/gpio.h>
> +
> +#include <mach/regs-clock.h>
> +#include <mach/smdk64x0-common-fb.h>
> +
> +#include <plat/devs.h>
> +#include <plat/regs-fb.h>
> +
> +/* Frame Buffer */
> +struct s3c_fb_pd_win smdk64x0_fb_win0 = {
> +	.win_mode	= {
> +		.left_margin	= 8,
> +		.right_margin	= 13,
> +		.upper_margin	= 7,
> +		.lower_margin	= 5,
> +		.hsync_len	= 3,
> +		.vsync_len	= 1,
> +		.xres		= 800,
> +		.yres		= 480,
> +		.refresh	= 60,
> +	},
> +	.max_bpp	= 32,
> +	.default_bpp	= 24,
> +};
> +
> +struct s3c_fb_platdata smdk64x0_lcd_pdata __initdata = {
> +	.win[0]		= &smdk64x0_fb_win0,
> +	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
> +	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
> +	.setup_gpio	= s5p64x0_fb_gpio_setup_24bpp,
> +};
> +
> +/* LCD power controller */
> +void smdk64x0_lte480_reset_power(struct plat_lcd_data *pd,
> +					unsigned int power)
> +{
> +	unsigned int cfg;
> +	int err;
> +
> +	if (power) {
> +		cfg = readl(S5P64X0_SYS_ID) & 0xf0000;
> +		if (cfg == 0x40000) {
> +			err = gpio_request(S5P6440_GPN(5), "GPN");
> +			if (err) {
> +				printk(KERN_ERR "failed to request GPN for
> lcd reset\n");
> +				return;
> +			}
> +
> +			gpio_direction_output(S5P6440_GPN(5), 1);
> +			gpio_set_value(S5P6440_GPN(5), 0);
> +			gpio_set_value(S5P6440_GPN(5), 1);
> +			gpio_free(S5P6440_GPN(5));
> +		} else if (cfg == 0x50000) {
> +			err = gpio_request(S5P6450_GPN(5), "GPN");
> +			if (err) {
> +				printk(KERN_ERR "failed to request GPN for
> lcd reset\n");
> +				return;
> +			}
> +
> +			gpio_direction_output(S5P6450_GPN(5), 1);
> +			gpio_set_value(S5P6450_GPN(5), 0);
> +			gpio_set_value(S5P6450_GPN(5), 1);
> +			gpio_free(S5P6450_GPN(5));
> +		}
> +	}
> +}
> +
> +struct plat_lcd_data smdk64x0_lcd_power_data = {
> +	.set_power	= smdk64x0_lte480_reset_power,
> +};
> +
> +struct platform_device smdk64x0_lcd_lte480wv = {
> +	.name	= "platform-lcd",
> +	.dev	= {
> +		.parent		= &s3c_device_fb.dev,
> +		.platform_data	= &smdk64x0_lcd_power_data,
> +	}
> +};
> --
> 1.7.0.4

Well, I think, the smdk64x0-common-fb.c is not nice :(
Sorry for bothering...but I think the old version is better because of
overhead of adding file...

As I know, you need to fix small changes, please re-submit your whole series
except 1st one.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
