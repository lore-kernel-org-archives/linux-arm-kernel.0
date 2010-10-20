From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 20 Oct 2010 19:53:21 +0900
Subject: [PATCH] ARM: S3C2416: Add Power Management support for SMDK2416
In-Reply-To: <1279003800-16899-1-git-send-email-sbkim73@samsung.com>
References: <1279003800-16899-1-git-send-email-sbkim73@samsung.com>
Message-ID: <05da01cb7045$051f41e0$0f5dc5a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangbeom Kim wrote:
> 
> From: Abhilash Kesavan <a.kesavan@samsung.com>
> 
> Adds suspend-to-ram support for SMDK2416 based on existing 2412 PM code
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---
> Note: it depends on patches:
> 
> ARM: S3C24XX: Fix gpiolib support for ports K..M
> 
>  .../mach-s3c2410/include/mach/regs-s3c2443-clock.h |    2 +
>  arch/arm/mach-s3c2416/Kconfig                      |    6 ++
>  arch/arm/mach-s3c2416/Makefile                     |    2 +-
>  arch/arm/mach-s3c2416/irq.c                        |    2 +
>  arch/arm/mach-s3c2416/pm.c                         |   84
> ++++++++++++++++++++
>  5 files changed, 95 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-s3c2416/pm.c
> 
> diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
> b/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
> index 08ab9df..101aeea 100644
> --- a/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
> +++ b/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
> @@ -118,6 +118,8 @@
>  #define S3C2443_SCLKCON_UARTCLK		(1<<8)
>  #define S3C2443_SCLKCON_USBHOST		(1<<1)
> 
> +#define S3C2443_PWRCFG_SLEEP		(1<<15)
> +
>  #include <asm/div64.h>
> 
>  static inline unsigned int
> diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
> index 657e4fe..87b9c9f 100644
> --- a/arch/arm/mach-s3c2416/Kconfig
> +++ b/arch/arm/mach-s3c2416/Kconfig
> @@ -25,6 +25,11 @@ config S3C2416_DMA
>  	help
>  	  Internal config node for S3C2416 DMA support
> 
> +config S3C2416_PM
> +	bool
> +	help
> +	  Internal config node to apply S3C2416 power management
> +
>  menu "S3C2416 Machines"
> 
>  config MACH_SMDK2416
> @@ -33,6 +38,7 @@ config MACH_SMDK2416
>  	select S3C_DEV_FB
>  	select S3C_DEV_HSMMC
>  	select S3C_DEV_HSMMC1
> +	select S3C2416_PM if PM
>  	help
>  	  Say Y here if you are using an SMDK2416
> 
> diff --git a/arch/arm/mach-s3c2416/Makefile
b/arch/arm/mach-s3c2416/Makefile
> index 6c12c7b..ef038d6 100644
> --- a/arch/arm/mach-s3c2416/Makefile
> +++ b/arch/arm/mach-s3c2416/Makefile
> @@ -11,7 +11,7 @@ obj-				:=
> 
>  obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o clock.o
>  obj-$(CONFIG_CPU_S3C2416)	+= irq.o
> -
> +obj-$(CONFIG_S3C2416_PM)	+= pm.o
>  #obj-$(CONFIG_S3C2416_DMA)	+= dma.o
> 
>  # Machine support
> diff --git a/arch/arm/mach-s3c2416/irq.c b/arch/arm/mach-s3c2416/irq.c
> index 89f521d..084d121 100644
> --- a/arch/arm/mach-s3c2416/irq.c
> +++ b/arch/arm/mach-s3c2416/irq.c
> @@ -243,6 +243,8 @@ static int __init s3c2416_irq_add(struct sys_device
> *sysdev)
> 
>  static struct sysdev_driver s3c2416_irq_driver = {
>  	.add		= s3c2416_irq_add,
> +	.suspend	= s3c24xx_irq_suspend,
> +	.resume		= s3c24xx_irq_resume,
>  };
> 
>  static int __init s3c2416_irq_init(void)
> diff --git a/arch/arm/mach-s3c2416/pm.c b/arch/arm/mach-s3c2416/pm.c
> new file mode 100644
> index 0000000..4d41f28
> --- /dev/null
> +++ b/arch/arm/mach-s3c2416/pm.c
> @@ -0,0 +1,84 @@
> +/* linux/arch/arm/mach-s3c2416/pm.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S3C2416 - PM support (Based on Ben Dooks' S3C2412 PM support)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/sysdev.h>
> +#include <linux/io.h>
> +
> +#include <asm/cacheflush.h>
> +
> +#include <mach/regs-power.h>
> +#include <mach/regs-s3c2443-clock.h>
> +
> +#include <plat/cpu.h>
> +#include <plat/pm.h>
> +
> +extern void s3c2412_sleep_enter(void);
> +
> +static void s3c2416_cpu_suspend(void)
> +{
> +	flush_cache_all();
> +
> +	/* enable wakeup sources regardless of battery state */
> +	__raw_writel(S3C2443_PWRCFG_SLEEP, S3C2443_PWRCFG);
> +
> +	/* set the mode as sleep, 2BED represents "Go to BED" */
> +	__raw_writel(0x2BED, S3C2443_PWRMODE);
> +
> +	s3c2412_sleep_enter();
> +}
> +
> +static void s3c2416_pm_prepare(void)
> +{
> +	/*
> +	 * write the magic value u-boot uses to check for resume into
> +	 * the INFORM0 register, and ensure INFORM1 is set to the
> +	 * correct address to resume from.
> +	 */
> +	__raw_writel(0x2BED, S3C2412_INFORM0);
> +	__raw_writel(virt_to_phys(s3c_cpu_resume), S3C2412_INFORM1);
> +}
> +
> +static int s3c2416_pm_add(struct sys_device *sysdev)
> +{
> +	pm_cpu_prep = s3c2416_pm_prepare;
> +	pm_cpu_sleep = s3c2416_cpu_suspend;
> +
> +	return 0;
> +}
> +
> +static int s3c2416_pm_suspend(struct sys_device *dev, pm_message_t state)
> +{
> +	return 0;
> +}
> +
> +static int s3c2416_pm_resume(struct sys_device *dev)
> +{
> +	/* unset the return-from-sleep amd inform flags */
> +	__raw_writel(0x0, S3C2443_PWRMODE);
> +	__raw_writel(0x0, S3C2412_INFORM0);
> +	__raw_writel(0x0, S3C2412_INFORM1);
> +
> +	return 0;
> +}
> +
> +static struct sysdev_driver s3c2416_pm_driver = {
> +	.add		= s3c2416_pm_add,
> +	.suspend	= s3c2416_pm_suspend,
> +	.resume		= s3c2416_pm_resume,
> +};
> +
> +static __init int s3c2416_pm_init(void)
> +{
> +	return sysdev_driver_register(&s3c2416_sysclass,
&s3c2416_pm_driver);
> +}
> +
> +arch_initcall(s3c2416_pm_init);
> --

Ok...will apply.

Ben, if any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
