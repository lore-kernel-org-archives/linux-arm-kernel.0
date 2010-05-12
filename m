From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 May 2010 15:05:07 +0900
Subject: [PATCH 10/16] ARM: S5PC100: Move i2c helpers from plat-s5pc1xx to
	mach-s5pc100
In-Reply-To: <1270190944-21644-11-git-send-email-m.szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-11-git-send-email-m.szyprowski@samsung.com>
Message-ID: <001d01caf199$15266ad0$3f734070$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Move i2c helpers from plat-s5pc1xx to mach-s5pc100.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pc100/Kconfig                      |    5 +++
>  arch/arm/mach-s5pc100/Makefile                     |    1 +
>  arch/arm/mach-s5pc100/cpu.c                        |    5 +++
>  arch/arm/mach-s5pc100/include/mach/map.h           |    2 +
>  arch/arm/mach-s5pc100/setup-i2c0.c                 |   13 ++++++--
>  .../{plat-s5pc1xx => mach-s5pc100}/setup-i2c1.c    |    4 +-
>  arch/arm/plat-s5pc1xx/setup-i2c0.c                 |   30
--------------------
>  7 files changed, 24 insertions(+), 36 deletions(-)
>  rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/setup-i2c1.c (89%)
>  delete mode 100644 arch/arm/plat-s5pc1xx/setup-i2c0.c
> 
> diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
> index 1e7b9a7..03a51e2 100644
> --- a/arch/arm/mach-s5pc100/Kconfig
> +++ b/arch/arm/mach-s5pc100/Kconfig
> @@ -19,6 +19,11 @@ config S5PC100_SETUP_FB_24BPP
>  	help
>            Common setup code for S5PC100 with an 24bpp RGB display helper.
> 
> +config S5PC100_SETUP_I2C1
> +	bool
> +	help
> +	  Common setup code for i2c bus 1.
> +
>  config MACH_SMDKC100
>  	bool "SMDKC100"
>  	select CPU_S5PC100
> diff --git a/arch/arm/mach-s5pc100/Makefile
b/arch/arm/mach-s5pc100/Makefile
> index 878dc61..522d8b7 100644
> --- a/arch/arm/mach-s5pc100/Makefile
> +++ b/arch/arm/mach-s5pc100/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_CPU_S5PC100)	+= setup-i2c0.o
>  # Device setup
> 
>  obj-$(CONFIG_S5PC100_SETUP_FB_24BPP) += setup-fb-24bpp.o
> +obj-$(CONFIG_S5PC100_SETUP_I2C1) += setup-i2c1.o
> 
>  # machine support
> 
> diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
> index 7d65b61..ec92290 100644
> --- a/arch/arm/mach-s5pc100/cpu.c
> +++ b/arch/arm/mach-s5pc100/cpu.c
> @@ -38,6 +38,7 @@
>  #include <plat/cpu.h>
>  #include <plat/devs.h>
>  #include <plat/clock.h>
> +#include <plat/iic-core.h>
>  #include <plat/s5pc100.h>
> 
>  /* Initial IO mappings */
> @@ -77,6 +78,10 @@ static void s5pc100_idle(void)
>  void __init s5pc100_map_io(void)
>  {
>  	iotable_init(s5pc100_iodesc, ARRAY_SIZE(s5pc100_iodesc));
> +
> +	/* the i2c devices are directly compatible with s3c2440 */
> +	s3c_i2c0_setname("s3c2440-i2c");
> +	s3c_i2c1_setname("s3c2440-i2c");
>  }
> 
>  void __init s5pc100_init_clocks(int xtal)
> diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-
> s5pc100/include/mach/map.h
> index f08fd76..82a1c9d 100644
> --- a/arch/arm/mach-s5pc100/include/mach/map.h
> +++ b/arch/arm/mach-s5pc100/include/mach/map.h
> @@ -51,6 +51,7 @@
>  #define S5P_SZ_UART		SZ_256
> 
>  #define S5PC100_PA_IIC0		(0xEC100000)
> +#define S5PC100_PA_IIC1		(0xEC200000)
> 
>  #define S5PC100_PA_FB		(0xEE000000)
> 
> @@ -61,6 +62,7 @@
>  /* compatibiltiy defines. */
>  #define S3C_PA_UART		S5PC100_PA_UART
>  #define S3C_PA_IIC		S5PC100_PA_IIC0
> +#define S3C_PA_IIC1		S5PC100_PA_IIC1
>  #define S3C_PA_FB		S5PC100_PA_FB
> 
>  #endif /* __ASM_ARCH_MAP_H */
> diff --git a/arch/arm/mach-s5pc100/setup-i2c0.c
b/arch/arm/mach-s5pc100/setup-
> i2c0.c
> index 8f65e58..dd3174e 100644
> --- a/arch/arm/mach-s5pc100/setup-i2c0.c
> +++ b/arch/arm/mach-s5pc100/setup-i2c0.c
> @@ -1,9 +1,9 @@
>  /* linux/arch/arm/mach-s5pc100/setup-i2c0.c
>   *
> - * Copyright (c) 2009 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com/
> + * Copyright 2009 Samsung Electronics Co.
> + *	Byungho Min <bhmin@samsung.com>
>   *
> - * I2C0 GPIO configuration.
> + * Base S5PC100 I2C bus 0 gpio configuration
>   *
>   * Based on plat-s3c64xx/setup-i2c0.c
>   *
> @@ -17,9 +17,14 @@
> 
>  struct platform_device; /* don't need the contents */
> 
> +#include <linux/gpio.h>
>  #include <plat/iic.h>
> +#include <plat/gpio-cfg.h>
> 
>  void s3c_i2c0_cfg_gpio(struct platform_device *dev)
>  {
> -	/* Will be populated later */
> +	s3c_gpio_cfgpin(S5PC100_GPD(3), S3C_GPIO_SFN(2));
> +	s3c_gpio_setpull(S5PC100_GPD(3), S3C_GPIO_PULL_UP);
> +	s3c_gpio_cfgpin(S5PC100_GPD(4), S3C_GPIO_SFN(2));
> +	s3c_gpio_setpull(S5PC100_GPD(4), S3C_GPIO_PULL_UP);
>  }
> diff --git a/arch/arm/plat-s5pc1xx/setup-i2c1.c
b/arch/arm/mach-s5pc100/setup-
> i2c1.c
> similarity index 89%
> rename from arch/arm/plat-s5pc1xx/setup-i2c1.c
> rename to arch/arm/mach-s5pc100/setup-i2c1.c
> index a0a8b4a..d1fec26 100644
> --- a/arch/arm/plat-s5pc1xx/setup-i2c1.c
> +++ b/arch/arm/mach-s5pc100/setup-i2c1.c
> @@ -1,9 +1,9 @@
> -/* linux/arch/arm/plat-s3c64xx/setup-i2c1.c
> +/* linux/arch/arm/mach-s5pc100/setup-i2c1.c
>   *
>   * Copyright 2009 Samsung Electronics Co.
>   *	Byungho Min <bhmin@samsung.com>
>   *
> - * Base S5PC1XX I2C bus 1 gpio configuration
> + * Base S5PC100 I2C bus 1 gpio configuration
>   *
>   * Based on plat-s3c64xx/setup-i2c1.c
>   *
> diff --git a/arch/arm/plat-s5pc1xx/setup-i2c0.c
b/arch/arm/plat-s5pc1xx/setup-i2c0.c
> deleted file mode 100644
> index 5e4a7c3..0000000
> --- a/arch/arm/plat-s5pc1xx/setup-i2c0.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/* linux/arch/arm/plat-s5pc1xx/setup-i2c0.c
> - *
> - * Copyright 2009 Samsung Electronics Co.
> - *	Byungho Min <bhmin@samsung.com>
> - *
> - * Base S5PC1XX I2C bus 0 gpio configuration
> - *
> - * Based on plat-s3c64xx/setup-i2c0.c
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -
> -struct platform_device; /* don't need the contents */
> -
> -#include <linux/gpio.h>
> -#include <plat/iic.h>
> -#include <plat/gpio-cfg.h>
> -
> -void s3c_i2c0_cfg_gpio(struct platform_device *dev)
> -{
> -	s3c_gpio_cfgpin(S5PC100_GPD(3), S3C_GPIO_SFN(2));
> -	s3c_gpio_setpull(S5PC100_GPD(3), S3C_GPIO_PULL_UP);
> -	s3c_gpio_cfgpin(S5PC100_GPD(4), S3C_GPIO_SFN(2));
> -	s3c_gpio_setpull(S5PC100_GPD(4), S3C_GPIO_PULL_UP);
> -}
> --
> 1.6.4

Looks good.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
