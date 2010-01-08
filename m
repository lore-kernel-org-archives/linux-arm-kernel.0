From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 8 Jan 2010 05:30:01 +0000
Subject: [PATCH 8/8] S3C64xx: add support to the RTC driver
In-Reply-To: <b2e8f9f70911200404o5728db5dr7fb34e62bfba497b@mail.gmail.com>
References: <b2e8f9f70911200404o5728db5dr7fb34e62bfba497b@mail.gmail.com>
Message-ID: <20100108053001.GA1224@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 01:04:17PM +0100, Maurus Cuelenaere wrote:
> Add support for the S3C64xx SoC to the generic S3C RTC driver.
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  arch/arm/mach-s3c6400/include/mach/map.h  |    1 +
>  arch/arm/plat-s3c/include/plat/regs-rtc.h |    4 +
>  arch/arm/plat-s3c/include/plat/rtc.h      |   20 ++++++
>  arch/arm/plat-s3c24xx/devs.c              |   14 +++-
>  arch/arm/plat-s3c64xx/Makefile            |    1 +
>  arch/arm/plat-s3c64xx/dev-rtc.c           |   50 ++++++++++++++
>  drivers/rtc/Kconfig                       |    2 +-
>  drivers/rtc/rtc-s3c.c                     |  102 ++++++++++++++++++++++++-----
>  8 files changed, 171 insertions(+), 23 deletions(-)
>  create mode 100644 arch/arm/plat-s3c/include/plat/rtc.h
>  create mode 100644 arch/arm/plat-s3c64xx/dev-rtc.c
> 
> diff --git a/arch/arm/mach-s3c6400/include/mach/map.h
> b/arch/arm/mach-s3c6400/include/mach/map.h
> index f3b48f8..0880f4d 100644
> --- a/arch/arm/mach-s3c6400/include/mach/map.h
> +++ b/arch/arm/mach-s3c6400/include/mach/map.h
> @@ -42,6 +42,7 @@
>  #define S3C64XX_PA_FB		(0x77100000)
>  #define S3C64XX_PA_USB_HSOTG	(0x7C000000)
>  #define S3C64XX_PA_WATCHDOG	(0x7E004000)
> +#define S3C64XX_PA_RTC		(0x7E005000)
>  #define S3C64XX_PA_SYSCON	(0x7E00F000)
>  #define S3C64XX_PA_AC97		(0x7F001000)
>  #define S3C64XX_PA_IIS0		(0x7F002000)
> diff --git a/arch/arm/plat-s3c/include/plat/regs-rtc.h
> b/arch/arm/plat-s3c/include/plat/regs-rtc.h
> index d5837cf..65c190d 100644
> --- a/arch/arm/plat-s3c/include/plat/regs-rtc.h
> +++ b/arch/arm/plat-s3c/include/plat/regs-rtc.h
> @@ -20,6 +20,10 @@
>  #define S3C2410_RTCCON_CLKSEL (1<<1)
>  #define S3C2410_RTCCON_CNTSEL (1<<2)
>  #define S3C2410_RTCCON_CLKRST (1<<3)
> +#define S3C64XX_RTCCON_TICEN  (1<<8)
> +
> +#define S3C64XX_RTCCON_TICMSK (0xF<<7)
> +#define S3C64XX_RTCCON_TICSHT (7)
> 
>  #define S3C2410_TICNT	      S3C2410_RTCREG(0x44)
>  #define S3C2410_TICNT_ENABLE  (1<<7)
> diff --git a/arch/arm/plat-s3c/include/plat/rtc.h
> b/arch/arm/plat-s3c/include/plat/rtc.h
> new file mode 100644
> index 0000000..cb09ad3
> --- /dev/null
> +++ b/arch/arm/plat-s3c/include/plat/rtc.h
> @@ -0,0 +1,20 @@
> +/* arch/arm/plat-s3c/include/plat/rtc.h
> + *
> + * Copyright (c) 2009 Maurus Cuelenaere <mcuelenaere@gmail.com>
> + *
> + * S3C RTC driver information
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __ASM_PLAT_RTC_H
> +#define __ASM_PLAT_RTC_H
> +
> +struct s3c_rtc_platdata {
> +	int max_user_freq;
> +};

The driver should be able to deal with changing this value based on the
device name, we don't really need extra platform data at the moment.

> +#endif /* __ASM_PLAT_RTC_H */
> diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
> index f52a92c..7e9440b 100644
> --- a/arch/arm/plat-s3c24xx/devs.c
> +++ b/arch/arm/plat-s3c24xx/devs.c
> @@ -32,6 +32,7 @@
> 
>  #include <plat/regs-serial.h>
>  #include <plat/udc.h>
> +#include <plat/rtc.h>
> 
>  #include <plat/devs.h>
>  #include <plat/cpu.h>
> @@ -291,11 +292,16 @@ static struct resource s3c_rtc_resource[] = {
>  	}
>  };
> 
> +static struct s3c_rtc_platdata s3c_rtc_pdata = {
> +	.max_user_freq	= 128,
> +};
> +
>  struct platform_device s3c_device_rtc = {
> -	.name		  = "s3c2410-rtc",
> -	.id		  = -1,
> -	.num_resources	  = ARRAY_SIZE(s3c_rtc_resource),
> -	.resource	  = s3c_rtc_resource,
> +	.name		  	= "s3c2410-rtc",
> +	.id		  	= -1,
> +	.num_resources	  	= ARRAY_SIZE(s3c_rtc_resource),
> +	.resource	  	= s3c_rtc_resource,
> +	.dev.platform_data	= &s3c_rtc_pdata,
>  };
> 
>  EXPORT_SYMBOL(s3c_device_rtc);
> diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
> index a8c5d17..25d9f6d 100644
> --- a/arch/arm/plat-s3c64xx/Makefile
> +++ b/arch/arm/plat-s3c64xx/Makefile
> @@ -14,6 +14,7 @@ obj-				:=
> 
>  obj-y				+= dev-uart.o
>  obj-y				+= dev-adc.o
> +obj-y				+= dev-rtc.o
>  obj-y				+= cpu.o
>  obj-y				+= irq.o
>  obj-y				+= irq-eint.o
> diff --git a/arch/arm/plat-s3c64xx/dev-rtc.c b/arch/arm/plat-s3c64xx/dev-rtc.c
> new file mode 100644
> index 0000000..c0681da
> --- /dev/null
> +++ b/arch/arm/plat-s3c64xx/dev-rtc.c
> @@ -0,0 +1,50 @@
> +/* linux/arch/arm/plat-s3c64xx/dev-rtc.c
> + *
> + * Copyright 2009 by Maurus Cuelenaere <mcuelenaere@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/platform_device.h>
> +
> +#include <mach/irqs.h>
> +#include <mach/map.h>
> +
> +#include <plat/devs.h>
> +#include <plat/rtc.h>
> +
> +static struct resource s3c_rtc_resource[] = {
> +	[0] = {
> +		.start = S3C64XX_PA_RTC,
> +		.end   = S3C64XX_PA_RTC + 0xff,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start = IRQ_RTC_ALARM,
> +		.end   = IRQ_RTC_ALARM,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	[2] = {
> +		.start = IRQ_RTC_TIC,
> +		.end   = IRQ_RTC_TIC,
> +		.flags = IORESOURCE_IRQ
> +	}
> +};
> +
> +static struct s3c_rtc_platdata s3c_rtc_pdata = {
> +	.max_user_freq	= 32768,
> +};
> +
> +struct platform_device s3c_device_rtc = {
> +	.name		  	= "s3c64xx-rtc",
> +	.id		  	= -1,
> +	.num_resources	  	= ARRAY_SIZE(s3c_rtc_resource),
> +	.resource	  	= s3c_rtc_resource,
> +	.dev.platform_data	= &s3c_rtc_pdata,
> +};
> +
> +EXPORT_SYMBOL(s3c_device_rtc);
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 3c20dae..1b7a0c7 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -585,7 +585,7 @@ config RTC_DRV_OMAP
> 
>  config RTC_DRV_S3C
>  	tristate "Samsung S3C series SoC RTC"
> -	depends on ARCH_S3C2410
> +	depends on ARCH_S3C2410 || ARCH_S3C64XX
>  	help
>  	  RTC (Realtime Clock) driver for the clock inbuilt into the
>  	  Samsung S3C24XX series of SoCs. This can provide periodic
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index e0d7b99..f10b13b 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -27,6 +27,12 @@
>  #include <asm/io.h>
>  #include <asm/irq.h>
>  #include <plat/regs-rtc.h>
> +#include <plat/rtc.h>
> +
> +enum s3c_cpu_type {
> +	TYPE_S3C2410,
> +	TYPE_S3C64XX,
> +};
> 
>  /* I have yet to find an S3C implementation with more than one
>   * of these rtc blocks in */
> @@ -36,6 +42,7 @@ static struct resource *s3c_rtc_mem;
>  static void __iomem *s3c_rtc_base;
>  static int s3c_rtc_alarmno = NO_IRQ;
>  static int s3c_rtc_tickno  = NO_IRQ;
> +static enum s3c_cpu_type s3c_rtc_cpu_type;
> 
>  static DEFINE_SPINLOCK(s3c_rtc_pie_lock);
> 
> @@ -79,12 +86,23 @@ static int s3c_rtc_setpie(struct device *dev, int enabled)
>  	pr_debug("%s: pie=%d\n", __func__, enabled);
> 
>  	spin_lock_irq(&s3c_rtc_pie_lock);
> -	tmp = readb(s3c_rtc_base + S3C2410_TICNT) & ~S3C2410_TICNT_ENABLE;
> 
> -	if (enabled)
> -		tmp |= S3C2410_TICNT_ENABLE;
> +	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
> +		tmp = readb(s3c_rtc_base + S3C2410_RTCCON) & ~S3C64XX_RTCCON_TICEN;
> +
> +		if (enabled)
> +			tmp |= S3C64XX_RTCCON_TICEN;
> +
> +		writeb(tmp, s3c_rtc_base + S3C2410_RTCCON);
> +	} else {
> +		tmp = readb(s3c_rtc_base + S3C2410_TICNT) & ~S3C2410_TICNT_ENABLE;
> +
> +		if (enabled)
> +			tmp |= S3C2410_TICNT_ENABLE;
> +
> +		writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
> +	}
> 
> -	writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
>  	spin_unlock_irq(&s3c_rtc_pie_lock);
> 
>  	return 0;
> @@ -92,15 +110,25 @@ static int s3c_rtc_setpie(struct device *dev, int enabled)
> 
>  static int s3c_rtc_setfreq(struct device *dev, int freq)
>  {
> -	unsigned int tmp;
> +    struct s3c_rtc_platdata* pdata = dev->platform_data;
> +	unsigned int tmp = 0, ticnt;
> 
>  	if (!is_power_of_2(freq))
>  		return -EINVAL;
> 
>  	spin_lock_irq(&s3c_rtc_pie_lock);
> 
> -	tmp = readb(s3c_rtc_base + S3C2410_TICNT) & S3C2410_TICNT_ENABLE;
> -	tmp |= (128 / freq)-1;
> +	if (pdata->max_user_freq)
> +	    ticnt = (pdata->max_user_freq / freq)-1;
> +	else
> +	    ticnt = (128 / freq)-1;
> +
> +	if (s3c_rtc_cpu_type == TYPE_S3C2410) {
> +		tmp = readb(s3c_rtc_base + S3C2410_TICNT);
> +		tmp &= S3C2410_TICNT_ENABLE;
> +	}
> +
> +	tmp |= ticnt;
> 
>  	writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
>  	spin_unlock_irq(&s3c_rtc_pie_lock);
> @@ -282,10 +310,14 @@ static int s3c_rtc_setalarm(struct device *dev,
> struct rtc_wkalrm *alrm)
> 
>  static int s3c_rtc_proc(struct device *dev, struct seq_file *seq)
>  {
> -	unsigned int ticnt = readb(s3c_rtc_base + S3C2410_TICNT);
> +	unsigned int ticnt;
> 
> -	seq_printf(seq, "periodic_IRQ\t: %s\n",
> -		     (ticnt & S3C2410_TICNT_ENABLE) ? "yes" : "no" );
> +	if (s3c_rtc_cpu_type == TYPE_S3C64XX)
> +		ticnt = readb(s3c_rtc_base + S3C2410_RTCCON) & S3C64XX_RTCCON_TICEN;
> +	else
> +		ticnt = readb(s3c_rtc_base + S3C2410_TICNT) & S3C2410_TICNT_ENABLE;
> +
> +	seq_printf(seq, "periodic_IRQ\t: %s\n", ticnt  ? "yes" : "no" );
>  	return 0;
>  }
> 
> @@ -352,10 +384,14 @@ static void s3c_rtc_enable(struct
> platform_device *pdev, int en)
> 
>  	if (!en) {
>  		tmp = readb(base + S3C2410_RTCCON);
> +		if (s3c_rtc_cpu_type == TYPE_S3C64XX)
> +			tmp &= ~S3C64XX_RTCCON_TICEN;
>  		writeb(tmp & ~S3C2410_RTCCON_RTCEN, base + S3C2410_RTCCON);
> 
> -		tmp = readb(base + S3C2410_TICNT);
> -		writeb(tmp & ~S3C2410_TICNT_ENABLE, base + S3C2410_TICNT);
> +		if (s3c_rtc_cpu_type == TYPE_S3C2410) {
> +			tmp = readb(base + S3C2410_TICNT);
> +			writeb(tmp & ~S3C2410_TICNT_ENABLE, base + S3C2410_TICNT);
> +		}
>  	} else {
>  		/* re-enable the device, and check it is ok */
> 
> @@ -401,6 +437,7 @@ static int __devexit s3c_rtc_remove(struct
> platform_device *dev)
> 
>  static int __devinit s3c_rtc_probe(struct platform_device *pdev)
>  {
> +	struct s3c_rtc_platdata* pdata = pdev->dev.platform_data;
>  	struct rtc_device *rtc;
>  	struct resource *res;
>  	int ret;
> @@ -471,7 +508,12 @@ static int __devinit s3c_rtc_probe(struct
> platform_device *pdev)
>  		goto err_nortc;
>  	}
> 
> -	rtc->max_user_freq = 128;
> +	if (pdata->max_user_freq)
> +		rtc->max_user_freq = pdata->max_user_freq;
> +	else
> +		rtc->max_user_freq = 128;
> +
> +	s3c_rtc_cpu_type = platform_get_device_id(pdev)->driver_data;
> 
>  	platform_set_drvdata(pdev, rtc);
>  	return 0;
> @@ -491,20 +533,30 @@ static int __devinit s3c_rtc_probe(struct
> platform_device *pdev)
> 
>  /* RTC Power management control */
> 
> -static int ticnt_save;
> +static int ticnt_save, ticnt_en_save;
> 
>  static int s3c_rtc_suspend(struct platform_device *pdev, pm_message_t state)
>  {
>  	/* save TICNT for anyone using periodic interrupts */
>  	ticnt_save = readb(s3c_rtc_base + S3C2410_TICNT);
> +	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
> +		ticnt_en_save = readb(s3c_rtc_base + S3C2410_RTCCON);
> +		ticnt_en_save &= S3C64XX_RTCCON_TICEN;
> +	}
>  	s3c_rtc_enable(pdev, 0);
>  	return 0;
>  }
> 
>  static int s3c_rtc_resume(struct platform_device *pdev)
>  {
> +	unsigned int tmp;
> +
>  	s3c_rtc_enable(pdev, 1);
>  	writeb(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
> +	if (s3c_rtc_cpu_type == TYPE_S3C64XX && ticnt_en_save) {
> +		tmp = readb(s3c_rtc_base + S3C2410_RTCCON);
> +		writeb(tmp | ticnt_en_save, s3c_rtc_base + S3C2410_RTCCON);
> +	}
>  	return 0;
>  }
>  #else
> @@ -512,13 +564,27 @@ static int s3c_rtc_resume(struct platform_device *pdev)
>  #define s3c_rtc_resume  NULL
>  #endif
> 
> -static struct platform_driver s3c2410_rtc_driver = {
> +static struct platform_device_id s3c_rtc_driver_ids[] = {
> +	{
> +		.name		= "s3c2410-rtc",
> +		.driver_data	= TYPE_S3C2410,
> +	}, {
> +		.name		= "s3c64xx-rtc",
> +		.driver_data	= TYPE_S3C64XX,
> +	},
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(platform, s3c_rtc_driver_ids);
> +
> +static struct platform_driver s3c_rtc_driver = {
>  	.probe		= s3c_rtc_probe,
>  	.remove		= __devexit_p(s3c_rtc_remove),
>  	.suspend	= s3c_rtc_suspend,
>  	.resume		= s3c_rtc_resume,
> +	.id_table	= s3c_rtc_driver_ids,
>  	.driver		= {
> -		.name	= "s3c2410-rtc",
> +		.name	= "s3c-rtc-v2",
>  		.owner	= THIS_MODULE,
>  	},
>  };
> @@ -528,12 +594,12 @@ static char __initdata banner[] = "S3C24XX RTC,
> (c) 2004,2006 Simtec Electronics
>  static int __init s3c_rtc_init(void)
>  {
>  	printk(banner);
> -	return platform_driver_register(&s3c2410_rtc_driver);
> +	return platform_driver_register(&s3c_rtc_driver);
>  }
> 
>  static void __exit s3c_rtc_exit(void)
>  {
> -	platform_driver_unregister(&s3c2410_rtc_driver);
> +	platform_driver_unregister(&s3c_rtc_driver);
>  }
> 
>  module_init(s3c_rtc_init);
> -- 
> 1.6.5.3
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
