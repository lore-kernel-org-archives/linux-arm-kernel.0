From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 May 2010 16:04:58 +0900
Subject: [PATCH 12/16] ARM: S5PC100: Move sdhci helpers from plat-s5pc1xx
	to mach-s5pc100
In-Reply-To: <1270190944-21644-13-git-send-email-m.szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-13-git-send-email-m.szyprowski@samsung.com>
Message-ID: <001f01caf1a1$724c4470$56e4cd50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Move sdhci helpers from plat-s5pc1xx to mach-s5pc100.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pc100/Kconfig                      |   11 +++++++++++
>  arch/arm/mach-s5pc100/Makefile                     |    2 ++
>  arch/arm/mach-s5pc100/cpu.c                        |    6 ++++++
>  arch/arm/mach-s5pc100/include/mach/map.h           |    8 ++++++++
>  .../setup-sdhci-gpio.c                             |    2 +-
>  5 files changed, 28 insertions(+), 1 deletions(-)
>  rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/setup-sdhci-gpio.c (97%)
> 
> diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
> index f2d5c23..af64da3 100644
> --- a/arch/arm/mach-s5pc100/Kconfig
> +++ b/arch/arm/mach-s5pc100/Kconfig
> @@ -24,6 +24,17 @@ config S5PC100_SETUP_I2C1
>  	help
>  	  Common setup code for i2c bus 1.
> 
> +config S5PC100_SETUP_SDHCI
> +        bool
> +        select S5PC100_SETUP_SDHCI_GPIO
> +        help
> +          Internal helper functions for S5PC100 based SDHCI systems
> +

Not aligned.
Please fix it.

> +config S5PC100_SETUP_SDHCI_GPIO
> +	bool
> +	help
> +	  Common setup code for SDHCI gpio.
> +
>  config MACH_SMDKC100
>  	bool "SMDKC100"
>  	select CPU_S5PC100
> diff --git a/arch/arm/mach-s5pc100/Makefile
b/arch/arm/mach-s5pc100/Makefile
> index 522d8b7..9242f14 100644
> --- a/arch/arm/mach-s5pc100/Makefile
> +++ b/arch/arm/mach-s5pc100/Makefile
> @@ -18,6 +18,8 @@ obj-$(CONFIG_CPU_S5PC100)	+= setup-i2c0.o
> 
>  obj-$(CONFIG_S5PC100_SETUP_FB_24BPP) += setup-fb-24bpp.o
>  obj-$(CONFIG_S5PC100_SETUP_I2C1) += setup-i2c1.o
> +obj-$(CONFIG_S5PC100_SETUP_SDHCI)       += setup-sdhci.o
> +obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o

How about union the setup-sdhci-gpio.c to setup-sdhci file?
I think don't need to separate setup-sdhci and setup-sdhci-gpio file.

> 
>  # machine support
> 
> diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
> index ec92290..d424a9f 100644
> --- a/arch/arm/mach-s5pc100/cpu.c
> +++ b/arch/arm/mach-s5pc100/cpu.c
> @@ -39,6 +39,7 @@
>  #include <plat/devs.h>
>  #include <plat/clock.h>
>  #include <plat/iic-core.h>
> +#include <plat/sdhci.h>
>  #include <plat/s5pc100.h>
> 
>  /* Initial IO mappings */
> @@ -79,6 +80,11 @@ void __init s5pc100_map_io(void)
>  {
>  	iotable_init(s5pc100_iodesc, ARRAY_SIZE(s5pc100_iodesc));
> 
> +	/* initialise device information early */
> +	s5pc100_default_sdhci0();
> +	s5pc100_default_sdhci1();
> +	s5pc100_default_sdhci2();
> +
>  	/* the i2c devices are directly compatible with s3c2440 */
>  	s3c_i2c0_setname("s3c2440-i2c");
>  	s3c_i2c1_setname("s3c2440-i2c");
> diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-
> s5pc100/include/mach/map.h
> index 82a1c9d..9d672fa 100644
> --- a/arch/arm/mach-s5pc100/include/mach/map.h
> +++ b/arch/arm/mach-s5pc100/include/mach/map.h
> @@ -55,6 +55,11 @@
> 
>  #define S5PC100_PA_FB		(0xEE000000)
> 
> +#define S5PC100_PA_HSMMC(x)	(0xED800000 + ((x) * 0x100000))
> +#define S5PC100_PA_HSMMC0	S5PC100_PA_HSMMC(0)
> +#define S5PC100_PA_HSMMC1	S5PC100_PA_HSMMC(1)
> +#define S5PC100_PA_HSMMC2	S5PC100_PA_HSMMC(2)
> +
>  #define S5PC100_PA_SDRAM	(0x20000000)
> 
>  #define S5P_PA_SDRAM		S5PC100_PA_SDRAM
> @@ -64,5 +69,8 @@
>  #define S3C_PA_IIC		S5PC100_PA_IIC0
>  #define S3C_PA_IIC1		S5PC100_PA_IIC1
>  #define S3C_PA_FB		S5PC100_PA_FB
> +#define S3C_PA_HSMMC0		S5PC100_PA_HSMMC0
> +#define S3C_PA_HSMMC1		S5PC100_PA_HSMMC1
> +#define S3C_PA_HSMMC2		S5PC100_PA_HSMMC2

The S5PC100_PA_HSMMC0/1/2 definitions are used only here.
It seems better to define S3C_PA_HSMMC0/1/2 using directly
S5PC100_PA_HSMMC(x) instead of S5PC100_PA_HSMMC0/1/2.

> 
>  #endif /* __ASM_ARCH_MAP_H */
> diff --git a/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c b/arch/arm/mach-
> s5pc100/setup-sdhci-gpio.c
> similarity index 97%
> rename from arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
> rename to arch/arm/mach-s5pc100/setup-sdhci-gpio.c
> index 185c894..0248150 100644
> --- a/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
> +++ b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
> @@ -2,7 +2,7 @@
>   *
>   * Copyright 2009 Samsung Eletronics
>   *
> - * S5PC1XX - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
> + * S5PC100 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> --
> 1.6.4

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
