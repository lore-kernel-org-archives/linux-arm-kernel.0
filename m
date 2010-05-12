From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 May 2010 14:52:42 +0900
Subject: [PATCH 08/16] ARM: S5PC100: Move frame buffer helpers from
	plat-s5pc1xx to mach-s5pc100
In-Reply-To: <1270190944-21644-9-git-send-email-m.szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-9-git-send-email-m.szyprowski@samsung.com>
Message-ID: <001a01caf197$59187050$0b4950f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Move frame buffer helpers from plat-s5pc1xx to mach-s5pc100.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pc100/Kconfig                      |    7 +++++++
>  arch/arm/mach-s5pc100/Makefile                     |    4 ++++
>  arch/arm/mach-s5pc100/include/mach/irqs.h          |    5 +++++
>  arch/arm/mach-s5pc100/include/mach/map.h           |    5 ++++-
>  .../setup-fb-24bpp.c                               |    4 ++--
>  5 files changed, 22 insertions(+), 3 deletions(-)
>  rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/setup-fb-24bpp.c (91%)
> 
> diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
> index 54c83a4..26e0028 100644
> --- a/arch/arm/mach-s5pc100/Kconfig
> +++ b/arch/arm/mach-s5pc100/Kconfig
> @@ -12,6 +12,13 @@ config CPU_S5PC100
>  	help
>  	  Enable S5PC100 CPU support
> 
> +# platform specific device setup

I think 'machine' is better in your comment than 'platform'

> +
> +config S5PC100_SETUP_FB_24BPP
> +	bool
> +	help
> +          Common setup code for S5PC100 with an 24bpp RGB display helper.
> +
>  config MACH_SMDKC100
>  	bool "SMDKC100"
>  	select CPU_S5PC100
> diff --git a/arch/arm/mach-s5pc100/Makefile
b/arch/arm/mach-s5pc100/Makefile
> index 187b06d..878dc61 100644
> --- a/arch/arm/mach-s5pc100/Makefile
> +++ b/arch/arm/mach-s5pc100/Makefile
> @@ -14,6 +14,10 @@ obj-				:=
>  obj-$(CONFIG_CPU_S5PC100)	+= cpu.o init.o clock.o gpio.o
>  obj-$(CONFIG_CPU_S5PC100)	+= setup-i2c0.o
> 
> +# Device setup
> +
> +obj-$(CONFIG_S5PC100_SETUP_FB_24BPP) += setup-fb-24bpp.o
> +
>  # machine support
> 
>  obj-$(CONFIG_MACH_SMDKC100)	+= mach-smdkc100.o
> diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-
> s5pc100/include/mach/irqs.h
> index 6789eeb..c0747f1 100644
> --- a/arch/arm/mach-s5pc100/include/mach/irqs.h
> +++ b/arch/arm/mach-s5pc100/include/mach/irqs.h
> @@ -105,4 +105,9 @@
> 
>  #define NR_IRQS		(IRQ_EINT(31) + 1)
> 
> +/* Compatibility */
> +#define IRQ_LCD_FIFO		IRQ_LCD0
> +#define IRQ_LCD_VSYNC		IRQ_LCD1
> +#define IRQ_LCD_SYSTEM		IRQ_LCD2
> +

I found above code in the mainline.
Please check commit edd6e3f89d7fe245149669400bd213140c16d6e4 that is from
Pawel Osciak.

>  #endif /* __ASM_ARCH_IRQS_H */
> diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-
> s5pc100/include/mach/map.h
> index a79b09f..f08fd76 100644
> --- a/arch/arm/mach-s5pc100/include/mach/map.h
> +++ b/arch/arm/mach-s5pc100/include/mach/map.h
> @@ -25,7 +25,6 @@
>  #define S5PC100_PA_OTHERS	(0xE0200000)
>  #define S5PC100_VA_OTHERS	(S3C_VA_SYS + 0x10000)
> 
> -
>  #define S5PC100_PA_GPIO		(0xE0300000)
>  #define S5P_PA_GPIO		S5PC100_PA_GPIO
> 
> @@ -53,11 +52,15 @@
> 
>  #define S5PC100_PA_IIC0		(0xEC100000)
> 
> +#define S5PC100_PA_FB		(0xEE000000)
> +
>  #define S5PC100_PA_SDRAM	(0x20000000)
> +

Don't need empty line.

>  #define S5P_PA_SDRAM		S5PC100_PA_SDRAM
> 
>  /* compatibiltiy defines. */
>  #define S3C_PA_UART		S5PC100_PA_UART
>  #define S3C_PA_IIC		S5PC100_PA_IIC0
> +#define S3C_PA_FB		S5PC100_PA_FB
> 
>  #endif /* __ASM_ARCH_MAP_H */
> diff --git a/arch/arm/plat-s5pc1xx/setup-fb-24bpp.c
b/arch/arm/mach-s5pc100/setup-
> fb-24bpp.c
> similarity index 91%
> rename from arch/arm/plat-s5pc1xx/setup-fb-24bpp.c
> rename to arch/arm/mach-s5pc100/setup-fb-24bpp.c
> index b02c36f..6eba6cb 100644
> --- a/arch/arm/plat-s5pc1xx/setup-fb-24bpp.c
> +++ b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
> @@ -1,9 +1,9 @@
>  /*
> - * linux/arch/arm/plat-s5pc100/setup-fb-24bpp.c
> + * linux/arch/arm/mach-s5pc100/setup-fb-24bpp.c
>   *
>   * Copyright 2009 Samsung Electronics
>   *
> - * Base S5PC1XX setup information for 24bpp LCD framebuffer
> + * Base S5PC100 setup information for 24bpp LCD framebuffer
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> --

In your setup-fb-24bpp.c,
- No need DISR_OFFSET definition that is not used.

And I can't apply this patch to my branches which are based on Ben's
next-samsung or Linus' 34-rc7 also.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
