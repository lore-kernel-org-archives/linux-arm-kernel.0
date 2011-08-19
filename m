From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Aug 2011 22:52:26 +0900
Subject: [PATCH v2] ARM: S3C64XX: Use module identification for Craggamore
	system builds
In-Reply-To: <1313498575-13465-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1313498575-13465-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <004101cc5e77$3ad49030$b07db090$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> The Cragganmore system is modular with I2C based identification chips on
> the system allowing identification of the system build. Provide a stub I2C
> driver which parses the module IDs and uses them to select the appropriate
> audio subsystem components to register. To avoid confusion due to having
> the mini-driver in the system the driver is placed in a separate file.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> Add a bunch more modules to the table.  No devices are registered for
> most of the modules but the text is useful for diagnostics if nothing
> else.
> 
>  arch/arm/mach-s3c64xx/Kconfig                 |    1 +
>  arch/arm/mach-s3c64xx/Makefile                |    2 +-
>  arch/arm/mach-s3c64xx/include/mach/crag6410.h |   23 ++++
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c  |  173
> +++++++++++++++++++++++++
>  arch/arm/mach-s3c64xx/mach-crag6410.c         |   85 +------------
>  5 files changed, 203 insertions(+), 81 deletions(-)
>  create mode 100644 arch/arm/mach-s3c64xx/include/mach/crag6410.h
>  create mode 100644 arch/arm/mach-s3c64xx/mach-crag6410-module.c
> 
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index f057b6a..5552e04 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -288,5 +288,6 @@ config MACH_WLF_CRAGG_6410
>  	select S3C_DEV_RTC
>  	select S3C64XX_DEV_SPI
>  	select S3C24XX_GPIO_EXTRA128
> +	select I2C
>  	help
>  	  Machine support for the Wolfson Cragganmore S3C6410 variant.
> diff --git a/arch/arm/mach-s3c64xx/Makefile
b/arch/arm/mach-s3c64xx/Makefile
> index 61b4034..5fdea6a 100644
> --- a/arch/arm/mach-s3c64xx/Makefile
> +++ b/arch/arm/mach-s3c64xx/Makefile
> @@ -55,7 +55,7 @@ obj-$(CONFIG_MACH_HMT)		+= mach-hmt.o
>  obj-$(CONFIG_MACH_SMARTQ)	+= mach-smartq.o
>  obj-$(CONFIG_MACH_SMARTQ5)	+= mach-smartq5.o
>  obj-$(CONFIG_MACH_SMARTQ7)	+= mach-smartq7.o
> -obj-$(CONFIG_MACH_WLF_CRAGG_6410) += mach-crag6410.o
> +obj-$(CONFIG_MACH_WLF_CRAGG_6410) += mach-crag6410.o mach-crag6410-
> module.o
> 
>  # device support
> 
> diff --git a/arch/arm/mach-s3c64xx/include/mach/crag6410.h
b/arch/arm/mach-
> s3c64xx/include/mach/crag6410.h
> new file mode 100644
> index 0000000..be9074e
> --- /dev/null
> +++ b/arch/arm/mach-s3c64xx/include/mach/crag6410.h
> @@ -0,0 +1,23 @@
> +/* Cragganmore 6410 shared definitions
> + *
> + * Copyright 2011 Wolfson Microelectronics plc
> + *	Mark Brown <broonie@opensource.wolfsonmicro.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef MACH_CRAG6410_H
> +#define MACH_CRAG6410_H
> +
> +#include <linux/gpio.h>
> +
> +#define BANFF_PMIC_IRQ_BASE		IRQ_BOARD_START
> +#define GLENFARCLAS_PMIC_IRQ_BASE	(IRQ_BOARD_START + 64)
> +
> +#define PCA935X_GPIO_BASE		GPIO_BOARD_START
> +#define CODEC_GPIO_BASE		(GPIO_BOARD_START + 8)
> +#define GLENFARCLAS_PMIC_GPIO_BASE	(GPIO_BOARD_START + 16)
> +
> +#endif
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-
> s3c64xx/mach-crag6410-module.c
> new file mode 100644
> index 0000000..0708fa0
> --- /dev/null
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> @@ -0,0 +1,173 @@
> +/* Speyside modules for Cragganmore - board data probing
> + *
> + * Copyright 2011 Wolfson Microelectronics plc
> + *	Mark Brown <broonie@opensource.wolfsonmicro.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +
> +#include <linux/mfd/wm831x/irq.h>
> +#include <linux/mfd/wm831x/gpio.h>
> +
> +#include <sound/wm8996.h>
> +#include <sound/wm8962.h>
> +#include <sound/wm9081.h>
> +
> +#include <mach/crag6410.h>
> +
> +static struct wm8996_retune_mobile_config wm8996_retune[] = {
> +	{
> +		.name = "Sub LPF",
> +		.rate = 48000,
> +		.regs = {
> +			0x6318, 0x6300, 0x1000, 0x0000, 0x0004, 0x2000,
> 0xF000,
> +			0x0000, 0x0004, 0x2000, 0xF000, 0x0000, 0x0004,
> 0x2000,
> +			0xF000, 0x0000, 0x0004, 0x1000, 0x0800, 0x4000
> +		},
> +	},
> +	{
> +		.name = "Sub HPF",
> +		.rate = 48000,
> +		.regs = {
> +			0x000A, 0x6300, 0x1000, 0x0000, 0x0004, 0x2000,
> 0xF000,
> +			0x0000, 0x0004, 0x2000, 0xF000, 0x0000, 0x0004,
> 0x2000,
> +			0xF000, 0x0000, 0x0004, 0x1000, 0x0800, 0x4000
> +		},
> +	},
> +};
> +
> +static struct wm8996_pdata wm8996_pdata __initdata = {
> +	.ldo_ena = S3C64XX_GPN(7),
> +	.gpio_base = CODEC_GPIO_BASE,
> +	.micdet_def = 1,
> +	.inl_mode = WM8996_DIFFERRENTIAL_1,
> +	.inr_mode = WM8996_DIFFERRENTIAL_1,
> +
> +	.irq_flags = IRQF_TRIGGER_RISING,
> +
> +	.gpio_default = {
> +		0x8001, /* GPIO1 == ADCLRCLK1 */
> +		0x8001, /* GPIO2 == ADCLRCLK2, input due to CPU */
> +		0x0141, /* GPIO3 == HP_SEL */
> +		0x0002, /* GPIO4 == IRQ */
> +		0x020e, /* GPIO5 == CLKOUT */
> +	},
> +
> +	.retune_mobile_cfgs = wm8996_retune,
> +	.num_retune_mobile_cfgs = ARRAY_SIZE(wm8996_retune),
> +};
> +
> +static struct wm8962_pdata wm8962_pdata __initdata = {
> +	.gpio_init = {
> +		0,
> +		WM8962_GPIO_FN_OPCLK,
> +		WM8962_GPIO_FN_DMICCLK,
> +		0,
> +		0x8000 | WM8962_GPIO_FN_DMICDAT,
> +		WM8962_GPIO_FN_IRQ,    /* Open drain mode */
> +	},
> +	.irq_active_low = true,
> +};
> +
> +static struct wm9081_pdata wm9081_pdata __initdata = {
> +	.irq_high = false,
> +	.irq_cmos = false,
> +};
> +
> +static const struct i2c_board_info wm1254_devs[] = {
> +	{ I2C_BOARD_INFO("wm8996", 0x1a),
> +	  .platform_data = &wm8996_pdata,
> +	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
> +	},
> +	{ I2C_BOARD_INFO("wm9081", 0x6c),
> +	  .platform_data = &wm9081_pdata, },
> +};
> +
> +static const struct i2c_board_info wm1259_devs[] = {
> +	{ I2C_BOARD_INFO("wm8962", 0x1a),
> +	  .platform_data = &wm8962_pdata,
> +	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
> +	},
> +};
> +
> +
> +static __devinitdata const struct {
> +	u8 id;
> +	const char *name;
> +	const struct i2c_board_info *i2c_devs;
> +	int num_i2c_devs;
> +} gf_mods[] = {
> +	{ .id = 0x01, .name = "1250-EV1 Springbank" },
> +	{ .id = 0x02, .name = "1251-EV1 Jura" },
> +	{ .id = 0x03, .name = "1252-EV1 Glenlivet" },
> +	{ .id = 0x11, .name = "6249-EV2 Glenfarclas", },
> +	{ .id = 0x21, .name = "1275-EV1 Mortlach" },
> +	{ .id = 0x25, .name = "1274-EV1 Glencadam" },
> +	{ .id = 0x31, .name = "1253-EV1 Tomatin", },
> +	{ .id = 0x39, .name = "1254-EV1 Dallas Dhu",
> +	  .i2c_devs = wm1254_devs, .num_i2c_devs =
> ARRAY_SIZE(wm1254_devs) },
> +	{ .id = 0x3a, .name = "1259-EV1 Tobermory",
> +	  .i2c_devs = wm1259_devs, .num_i2c_devs =
> ARRAY_SIZE(wm1259_devs) },
> +	{ .id = 0x3b, .name = "1255-EV1 Kilchoman" },
> +	{ .id = 0x3c, .name = "1273-EV1 Longmorn" },
> +};
> +
> +static __devinit int wlf_gf_module_probe(struct i2c_client *i2c,
> +					 const struct i2c_device_id *i2c_id)
> +{
> +	int ret, i, j, id, rev;
> +
> +	ret = i2c_smbus_read_byte_data(i2c, 0);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to read ID: %d\n", ret);
> +		return ret;
> +	}
> +
> +	id = (ret & 0xfe) >> 2;
> +	rev = ret & 0x3;
> +	for (i = 0; i < ARRAY_SIZE(gf_mods); i++)
> +		if (id == gf_mods[i].id)
> +			break;
> +
> +	if (i < ARRAY_SIZE(gf_mods)) {
> +		dev_info(&i2c->dev, "%s revision %d\n",
> +			 gf_mods[i].name, rev + 1);
> +		for (j = 0; j < gf_mods[i].num_i2c_devs; j++) {
> +			if (!i2c_new_device(i2c->adapter,
> +					    &(gf_mods[i].i2c_devs[j])))
> +				dev_err(&i2c->dev,
> +					"Failed to register dev: %d\n",
ret);
> +		}
> +	} else {
> +		dev_warn(&i2c->dev, "Unknown module ID %d revision %d\n",
> +			 id, rev);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id wlf_gf_module_id[] = {
> +	{ "wlf-gf-module", 0 },
> +	{ }
> +};
> +
> +static struct i2c_driver wlf_gf_module_driver = {
> +	.driver = {
> +		.name = "wlf-gf-module",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = wlf_gf_module_probe,
> +	.id_table = wlf_gf_module_id,
> +};
> +
> +static int __init wlf_gf_module_register(void)
> +{
> +	return i2c_add_driver(&wlf_gf_module_driver);
> +}
> +module_init(wlf_gf_module_register);
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-
> s3c64xx/mach-crag6410.c
> index 90baf1c..f74a811 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -47,6 +47,7 @@
>  #include <mach/regs-sys.h>
>  #include <mach/regs-gpio.h>
>  #include <mach/regs-modem.h>
> +#include <mach/crag6410.h>
> 
>  #include <mach/regs-gpio-memport.h>
> 
> @@ -65,17 +66,6 @@
>  #include <plat/iic.h>
>  #include <plat/pm.h>
> 
> -#include <sound/wm8996.h>

Hmm...Why is this <sound/wm8915.h> in my tree?


> -#include <sound/wm8962.h>
> -#include <sound/wm9081.h>
> -
> -#define BANFF_PMIC_IRQ_BASE		IRQ_BOARD_START
> -#define GLENFARCLAS_PMIC_IRQ_BASE	(IRQ_BOARD_START + 64)
> -
> -#define PCA935X_GPIO_BASE		GPIO_BOARD_START
> -#define CODEC_GPIO_BASE		(GPIO_BOARD_START + 8)
> -#define GLENFARCLAS_PMIC_GPIO_BASE	(GPIO_BOARD_START + 16)
> -
>  /* serial port setup */
> 
>  #define UCON (S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
> @@ -620,81 +610,16 @@ static struct wm831x_pdata glenfarclas_pmic_pdata
> __initdata = {
>  	.disable_touch = true,
>  };
> 
> -static struct wm8996_retune_mobile_config wm8996_retune[] = {
> -	{
> -		.name = "Sub LPF",
> -		.rate = 48000,
> -		.regs = {
> -			0x6318, 0x6300, 0x1000, 0x0000, 0x0004, 0x2000,
> 0xF000,
> -			0x0000, 0x0004, 0x2000, 0xF000, 0x0000, 0x0004,
> 0x2000,
> -			0xF000, 0x0000, 0x0004, 0x1000, 0x0800, 0x4000
> -		},
> -	},
> -	{
> -		.name = "Sub HPF",
> -		.rate = 48000,
> -		.regs = {
> -			0x000A, 0x6300, 0x1000, 0x0000, 0x0004, 0x2000,
> 0xF000,
> -			0x0000, 0x0004, 0x2000, 0xF000, 0x0000, 0x0004,
> 0x2000,
> -			0xF000, 0x0000, 0x0004, 0x1000, 0x0800, 0x4000
> -		},
> -	},
> -};
> -
> -static struct wm8996_pdata wm8996_pdata __initdata = {
> -	.ldo_ena = S3C64XX_GPN(7),
> -	.gpio_base = CODEC_GPIO_BASE,
> -	.micdet_def = 1,
> -	.inl_mode = WM8996_DIFFERRENTIAL_1,
> -	.inr_mode = WM8996_DIFFERRENTIAL_1,
> -
> -	.irq_flags = IRQF_TRIGGER_RISING,
> -
> -	.gpio_default = {
> -		0x8001, /* GPIO1 == ADCLRCLK1 */
> -		0x8001, /* GPIO2 == ADCLRCLK2, input due to CPU */
> -		0x0141, /* GPIO3 == HP_SEL */
> -		0x0002, /* GPIO4 == IRQ */
> -		0x020e, /* GPIO5 == CLKOUT */
> -	},
> -
> -	.retune_mobile_cfgs = wm8996_retune,
> -	.num_retune_mobile_cfgs = ARRAY_SIZE(wm8996_retune),
> -};
> -
> -static struct wm8962_pdata wm8962_pdata __initdata = {
> -	.gpio_init = {
> -		0,
> -		WM8962_GPIO_FN_OPCLK,
> -		WM8962_GPIO_FN_DMICCLK,
> -		0,
> -		0x8000 | WM8962_GPIO_FN_DMICDAT,
> -		WM8962_GPIO_FN_IRQ,    /* Open drain mode */
> -	},
> -	.irq_active_low = true,
> -};
> -
> -static struct wm9081_pdata wm9081_pdata __initdata = {
> -	.irq_high = false,
> -	.irq_cmos = false,
> -};
> -
>  static struct i2c_board_info i2c_devs1[] __initdata = {
>  	{ I2C_BOARD_INFO("wm8311", 0x34),
>  	  .irq = S3C_EINT(0),
>  	  .platform_data = &glenfarclas_pmic_pdata },
> 
> +	{ I2C_BOARD_INFO("wlf-gf-module", 0x24) },
> +	{ I2C_BOARD_INFO("wlf-gf-module", 0x25) },
> +	{ I2C_BOARD_INFO("wlf-gf-module", 0x26) },
> +
>  	{ I2C_BOARD_INFO("wm1250-ev1", 0x27) },
> -	{ I2C_BOARD_INFO("wm8996", 0x1a),
> -	  .platform_data = &wm8996_pdata,
> -	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
> -	},
> -	{ I2C_BOARD_INFO("wm9081", 0x6c),
> -	  .platform_data = &wm9081_pdata, },
> -	{ I2C_BOARD_INFO("wm8962", 0x1a),
> -	  .platform_data = &wm8962_pdata,
> -	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
> -	},
>  };
> 
>  static void __init crag6410_map_io(void)
> --
> 1.7.5.4

Hi Mark,

Probably, this is v3 not v2 ;)
And my tree should be against on -rc2 not -rc1.

Anyway, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
