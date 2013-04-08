From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 8 Apr 2013 09:33:29 +0200
Subject: [RFC 1/5] ARM: at91: add general purpose backup register
 (GPBR) support
In-Reply-To: <1365347572-14972-1-git-send-email-jhovold@gmail.com>
References: <20130407150938.GA25605@localhost>
 <1365347572-14972-1-git-send-email-jhovold@gmail.com>
Message-ID: <20130408073329.GO20693@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:12 Sun 07 Apr     , Johan Hovold wrote:
> 
> Add General Purpose Backup Register (GPBR) support.
> 
> Most at91 SoCs have at least four 32-bit General Purpose Backup
> Registers (GPBR) powered by backup-power (VDDBU). One such register is
> currently used by rtc-at91sam9 driver to store the RTC time base.
> 
> Make sure the registers are mapped by arch setup code and add generic
> accessors for in-kernel use.
> 
> This is a step in adding device-tree support to the rtc-at91sam9 driver.
> 
This is a regression

we loose the tracking of what request and use the GPBR

Best Regsards,
J.
> Signed-off-by: Johan Hovold <jhovold@gmail.com>
> ---
>  arch/arm/mach-at91/at91sam9260.c            |  1 +
>  arch/arm/mach-at91/at91sam9260_devices.c    | 15 +++--------
>  arch/arm/mach-at91/at91sam9261.c            |  1 +
>  arch/arm/mach-at91/at91sam9261_devices.c    | 15 +++--------
>  arch/arm/mach-at91/at91sam9263.c            |  1 +
>  arch/arm/mach-at91/at91sam9263_devices.c    | 18 +++----------
>  arch/arm/mach-at91/at91sam9g45.c            |  1 +
>  arch/arm/mach-at91/at91sam9g45_devices.c    | 15 +++--------
>  arch/arm/mach-at91/at91sam9rl.c             |  1 +
>  arch/arm/mach-at91/at91sam9rl_devices.c     | 15 +++--------
>  arch/arm/mach-at91/generic.h                |  3 +++
>  arch/arm/mach-at91/include/mach/at91_gpbr.h | 29 ++++++++++++++++++++
>  arch/arm/mach-at91/setup.c                  | 10 +++++++
>  drivers/rtc/rtc-at91sam9.c                  | 41 +++++++++--------------------
>  14 files changed, 76 insertions(+), 90 deletions(-)
>  create mode 100644 arch/arm/mach-at91/include/mach/at91_gpbr.h
> 
> diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
> index b67cd53..984b0d5 100644
> --- a/arch/arm/mach-at91/at91sam9260.c
> +++ b/arch/arm/mach-at91/at91sam9260.c
> @@ -334,6 +334,7 @@ static void __init at91sam9260_map_io(void)
>  
>  static void __init at91sam9260_ioremap_registers(void)
>  {
> +	at91_ioremap_gpbr(AT91SAM9260_BASE_GPBR, 0x10);
>  	at91_ioremap_shdwc(AT91SAM9260_BASE_SHDWC);
>  	at91_ioremap_rstc(AT91SAM9260_BASE_RSTC);
>  	at91_ioremap_ramc(0, AT91SAM9260_BASE_SDRAMC, 512);
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
> index eda8d16..10c71a8 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> @@ -649,8 +649,6 @@ static struct resource rtt_resources[] = {
>  		.end	= AT91SAM9260_BASE_RTT + SZ_16 - 1,
>  		.flags	= IORESOURCE_MEM,
>  	}, {
> -		.flags	= IORESOURCE_MEM,
> -	}, {
>  		.flags  = IORESOURCE_IRQ,
>  	},
>  };
> @@ -666,16 +664,9 @@ static struct platform_device at91sam9260_rtt_device = {
>  static void __init at91_add_device_rtt_rtc(void)
>  {
>  	at91sam9260_rtt_device.name = "rtc-at91sam9";
> -	/*
> -	 * The second resource is needed:
> -	 * GPBR will serve as the storage for RTC time offset
> -	 */
> -	at91sam9260_rtt_device.num_resources = 3;
> -	rtt_resources[1].start = AT91SAM9260_BASE_GPBR +
> -				 4 * CONFIG_RTC_DRV_AT91SAM9_GPBR;
> -	rtt_resources[1].end = rtt_resources[1].start + 3;
> -	rtt_resources[2].start = NR_IRQS_LEGACY + AT91_ID_SYS;
> -	rtt_resources[2].end = NR_IRQS_LEGACY + AT91_ID_SYS;
> +	at91sam9260_rtt_device.num_resources = 2;
> +	rtt_resources[1].start = NR_IRQS_LEGACY + AT91_ID_SYS;
> +	rtt_resources[1].end = NR_IRQS_LEGACY + AT91_ID_SYS;
>  }
>  #else
>  static void __init at91_add_device_rtt_rtc(void)
> diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
> index 0204f4c..b234c5d 100644
> --- a/arch/arm/mach-at91/at91sam9261.c
> +++ b/arch/arm/mach-at91/at91sam9261.c
> @@ -278,6 +278,7 @@ static void __init at91sam9261_map_io(void)
>  
>  static void __init at91sam9261_ioremap_registers(void)
>  {
> +	at91_ioremap_gpbr(AT91SAM9261_BASE_GPBR, 0x10);
>  	at91_ioremap_shdwc(AT91SAM9261_BASE_SHDWC);
>  	at91_ioremap_rstc(AT91SAM9261_BASE_RSTC);
>  	at91_ioremap_ramc(0, AT91SAM9261_BASE_SDRAMC, 512);
> diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
> index 629ea5f..e8ff5e7 100644
> --- a/arch/arm/mach-at91/at91sam9261_devices.c
> +++ b/arch/arm/mach-at91/at91sam9261_devices.c
> @@ -618,8 +618,6 @@ static struct resource rtt_resources[] = {
>  		.end	= AT91SAM9261_BASE_RTT + SZ_16 - 1,
>  		.flags	= IORESOURCE_MEM,
>  	}, {
> -		.flags	= IORESOURCE_MEM,
> -	}, {
>  		.flags  = IORESOURCE_IRQ,
>  	}
>  };
> @@ -634,16 +632,9 @@ static struct platform_device at91sam9261_rtt_device = {
>  static void __init at91_add_device_rtt_rtc(void)
>  {
>  	at91sam9261_rtt_device.name = "rtc-at91sam9";
> -	/*
> -	 * The second resource is needed:
> -	 * GPBR will serve as the storage for RTC time offset
> -	 */
> -	at91sam9261_rtt_device.num_resources = 3;
> -	rtt_resources[1].start = AT91SAM9261_BASE_GPBR +
> -				 4 * CONFIG_RTC_DRV_AT91SAM9_GPBR;
> -	rtt_resources[1].end = rtt_resources[1].start + 3;
> -	rtt_resources[2].start = NR_IRQS_LEGACY + AT91_ID_SYS;
> -	rtt_resources[2].end = NR_IRQS_LEGACY + AT91_ID_SYS;
> +	at91sam9261_rtt_device.num_resources = 2;
> +	rtt_resources[1].start = NR_IRQS_LEGACY + AT91_ID_SYS;
> +	rtt_resources[1].end = NR_IRQS_LEGACY + AT91_ID_SYS;
>  }
>  #else
>  static void __init at91_add_device_rtt_rtc(void)
> diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
> index c0cbb81..42d09f5 100644
> --- a/arch/arm/mach-at91/at91sam9263.c
> +++ b/arch/arm/mach-at91/at91sam9263.c
> @@ -315,6 +315,7 @@ static void __init at91sam9263_map_io(void)
>  
>  static void __init at91sam9263_ioremap_registers(void)
>  {
> +	at91_ioremap_gpbr(AT91SAM9263_BASE_GPBR, 0x50);
>  	at91_ioremap_shdwc(AT91SAM9263_BASE_SHDWC);
>  	at91_ioremap_rstc(AT91SAM9263_BASE_RSTC);
>  	at91_ioremap_ramc(0, AT91SAM9263_BASE_SDRAMC0, 512);
> diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
> index 858c8aa..374fe56 100644
> --- a/arch/arm/mach-at91/at91sam9263_devices.c
> +++ b/arch/arm/mach-at91/at91sam9263_devices.c
> @@ -1014,8 +1014,6 @@ static struct resource rtt0_resources[] = {
>  		.end	= AT91SAM9263_BASE_RTT0 + SZ_16 - 1,
>  		.flags	= IORESOURCE_MEM,
>  	}, {
> -		.flags	= IORESOURCE_MEM,
> -	}, {
>  		.flags  = IORESOURCE_IRQ,
>  	}
>  };
> @@ -1032,8 +1030,6 @@ static struct resource rtt1_resources[] = {
>  		.end	= AT91SAM9263_BASE_RTT1 + SZ_16 - 1,
>  		.flags	= IORESOURCE_MEM,
>  	}, {
> -		.flags	= IORESOURCE_MEM,
> -	}, {
>  		.flags  = IORESOURCE_IRQ,
>  	}
>  };
> @@ -1052,18 +1048,14 @@ static void __init at91_add_device_rtt_rtc(void)
>  
>  	switch (CONFIG_RTC_DRV_AT91SAM9_RTT) {
>  	case 0:
> -		/*
> -		 * The second resource is needed only for the chosen RTT:
> -		 * GPBR will serve as the storage for RTC time offset
> -		 */
> -		at91sam9263_rtt0_device.num_resources = 3;
> +		at91sam9263_rtt0_device.num_resources = 2;
>  		at91sam9263_rtt1_device.num_resources = 1;
>  		pdev = &at91sam9263_rtt0_device;
>  		r = rtt0_resources;
>  		break;
>  	case 1:
>  		at91sam9263_rtt0_device.num_resources = 1;
> -		at91sam9263_rtt1_device.num_resources = 3;
> +		at91sam9263_rtt1_device.num_resources = 2;
>  		pdev = &at91sam9263_rtt1_device;
>  		r = rtt1_resources;
>  		break;
> @@ -1074,10 +1066,8 @@ static void __init at91_add_device_rtt_rtc(void)
>  	}
>  
>  	pdev->name = "rtc-at91sam9";
> -	r[1].start = AT91SAM9263_BASE_GPBR + 4 * CONFIG_RTC_DRV_AT91SAM9_GPBR;
> -	r[1].end = r[1].start + 3;
> -	r[2].start = NR_IRQS_LEGACY + AT91_ID_SYS;
> -	r[2].end = NR_IRQS_LEGACY + AT91_ID_SYS;
> +	r[1].start = NR_IRQS_LEGACY + AT91_ID_SYS;
> +	r[1].end = NR_IRQS_LEGACY + AT91_ID_SYS;
>  }
>  #else
>  static void __init at91_add_device_rtt_rtc(void)
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> index b4968aa..4b9547f 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -361,6 +361,7 @@ static void __init at91sam9g45_map_io(void)
>  
>  static void __init at91sam9g45_ioremap_registers(void)
>  {
> +	at91_ioremap_gpbr(AT91SAM9G45_BASE_GPBR, 0x10);
>  	at91_ioremap_shdwc(AT91SAM9G45_BASE_SHDWC);
>  	at91_ioremap_rstc(AT91SAM9G45_BASE_RSTC);
>  	at91_ioremap_ramc(0, AT91SAM9G45_BASE_DDRSDRC1, 512);
> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index fe626d4..65d700b 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -1290,8 +1290,6 @@ static struct resource rtt_resources[] = {
>  		.end	= AT91SAM9G45_BASE_RTT + SZ_16 - 1,
>  		.flags	= IORESOURCE_MEM,
>  	}, {
> -		.flags	= IORESOURCE_MEM,
> -	}, {
>  		.flags  = IORESOURCE_IRQ,
>  	}
>  };
> @@ -1306,16 +1304,9 @@ static struct platform_device at91sam9g45_rtt_device = {
>  static void __init at91_add_device_rtt_rtc(void)
>  {
>  	at91sam9g45_rtt_device.name = "rtc-at91sam9";
> -	/*
> -	 * The second resource is needed:
> -	 * GPBR will serve as the storage for RTC time offset
> -	 */
> -	at91sam9g45_rtt_device.num_resources = 3;
> -	rtt_resources[1].start = AT91SAM9G45_BASE_GPBR +
> -				 4 * CONFIG_RTC_DRV_AT91SAM9_GPBR;
> -	rtt_resources[1].end = rtt_resources[1].start + 3;
> -	rtt_resources[2].start = NR_IRQS_LEGACY + AT91_ID_SYS;
> -	rtt_resources[2].end = NR_IRQS_LEGACY + AT91_ID_SYS;
> +	at91sam9g45_rtt_device.num_resources = 2;
> +	rtt_resources[1].start = NR_IRQS_LEGACY + AT91_ID_SYS;
> +	rtt_resources[1].end = NR_IRQS_LEGACY + AT91_ID_SYS;
>  }
>  #else
>  static void __init at91_add_device_rtt_rtc(void)
> diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
> index 3de3e04..bf7e555 100644
> --- a/arch/arm/mach-at91/at91sam9rl.c
> +++ b/arch/arm/mach-at91/at91sam9rl.c
> @@ -281,6 +281,7 @@ static void __init at91sam9rl_map_io(void)
>  
>  static void __init at91sam9rl_ioremap_registers(void)
>  {
> +	at91_ioremap_gpbr(AT91SAM9RL_BASE_GPBR, 0x10);
>  	at91_ioremap_shdwc(AT91SAM9RL_BASE_SHDWC);
>  	at91_ioremap_rstc(AT91SAM9RL_BASE_RSTC);
>  	at91_ioremap_ramc(0, AT91SAM9RL_BASE_SDRAMC, 512);
> diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
> index 352468f..533948c 100644
> --- a/arch/arm/mach-at91/at91sam9rl_devices.c
> +++ b/arch/arm/mach-at91/at91sam9rl_devices.c
> @@ -687,8 +687,6 @@ static struct resource rtt_resources[] = {
>  		.end	= AT91SAM9RL_BASE_RTT + SZ_16 - 1,
>  		.flags	= IORESOURCE_MEM,
>  	}, {
> -		.flags	= IORESOURCE_MEM,
> -	}, {
>  		.flags  = IORESOURCE_IRQ,
>  	}
>  };
> @@ -703,16 +701,9 @@ static struct platform_device at91sam9rl_rtt_device = {
>  static void __init at91_add_device_rtt_rtc(void)
>  {
>  	at91sam9rl_rtt_device.name = "rtc-at91sam9";
> -	/*
> -	 * The second resource is needed:
> -	 * GPBR will serve as the storage for RTC time offset
> -	 */
> -	at91sam9rl_rtt_device.num_resources = 3;
> -	rtt_resources[1].start = AT91SAM9RL_BASE_GPBR +
> -				 4 * CONFIG_RTC_DRV_AT91SAM9_GPBR;
> -	rtt_resources[1].end = rtt_resources[1].start + 3;
> -	rtt_resources[2].start = NR_IRQS_LEGACY + AT91_ID_SYS;
> -	rtt_resources[2].end = NR_IRQS_LEGACY + AT91_ID_SYS;
> +	at91sam9rl_rtt_device.num_resources = 2;
> +	rtt_resources[1].start = NR_IRQS_LEGACY + AT91_ID_SYS;
> +	rtt_resources[1].end = NR_IRQS_LEGACY + AT91_ID_SYS;
>  }
>  #else
>  static void __init at91_add_device_rtt_rtc(void)
> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> index fc593d6..6d444cc 100644
> --- a/arch/arm/mach-at91/generic.h
> +++ b/arch/arm/mach-at91/generic.h
> @@ -59,6 +59,9 @@ extern void at91_irq_resume(void);
>  /* idle */
>  extern void at91sam9_idle(void);
>  
> +/* backup registers */
> +extern void at91_ioremap_gpbr(u32 base_addr, u32 size);
> +
>  /* reset */
>  extern void at91_ioremap_rstc(u32 base_addr);
>  extern void at91sam9_alt_restart(char, const char *);
> diff --git a/arch/arm/mach-at91/include/mach/at91_gpbr.h b/arch/arm/mach-at91/include/mach/at91_gpbr.h
> new file mode 100644
> index 0000000..f4b4895
> --- /dev/null
> +++ b/arch/arm/mach-at91/include/mach/at91_gpbr.h
> @@ -0,0 +1,29 @@
> +/*
> + * arch/arm/mach-at91/include/mach/at91_gpbr.h
> + *
> + * Copyright (C) 2013 Johan Hovold <jhovold@gmail.com>
> + *
> + * General Purpose Backup Registers (GPBR)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef AT91_GPBR_H
> +#define AT91_GPBR_H
> +
> +extern void __iomem *at91_gpbr_base;
> +
> +static inline u32 at91_gpbr_read(unsigned nr)
> +{
> +	return __raw_readl(at91_gpbr_base + ((nr) << 2));
> +}
> +
> +static inline void at91_gpbr_write(unsigned nr, u32 value)
> +{
> +	__raw_writel(value, at91_gpbr_base + ((nr) << 2));
> +}
> +
> +#endif	/* AT91_GPBR_H */
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index 9e7c1e1..b01f4aa 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -18,6 +18,7 @@
>  #include <mach/hardware.h>
>  #include <mach/cpu.h>
>  #include <mach/at91_dbgu.h>
> +#include <mach/at91_gpbr.h>
>  #include <mach/at91_pmc.h>
>  
>  #include "at91_shdwc.h"
> @@ -277,6 +278,15 @@ void __init at91_map_io(void)
>  		at91_boot_soc.map_io();
>  }
>  
> +void __iomem *at91_gpbr_base;
> +
> +void __init at91_ioremap_gpbr(u32 base_addr, u32 size)
> +{
> +	at91_gpbr_base = ioremap(base_addr, size);
> +	if (!at91_gpbr_base)
> +		panic("AT91: Failed to ioremap gpbr registers\n");
> +}
> +
>  void __iomem *at91_shdwc_base = NULL;
>  
>  static void at91sam9_poweroff(void)
> diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
> index 39cfd2e..983667b 100644
> --- a/drivers/rtc/rtc-at91sam9.c
> +++ b/drivers/rtc/rtc-at91sam9.c
> @@ -21,6 +21,7 @@
>  #include <linux/slab.h>
>  #include <linux/platform_data/atmel.h>
>  
> +#include <mach/at91_gpbr.h>
>  #include <mach/at91_rtt.h>
>  #include <mach/cpu.h>
>  
> @@ -57,7 +58,7 @@ struct sam9_rtc {
>  	void __iomem		*rtt;
>  	struct rtc_device	*rtcdev;
>  	u32			imr;
> -	void __iomem		*gpbr;
> +	unsigned		gpbr;
>  	int 			irq;
>  };
>  
> @@ -66,11 +67,6 @@ struct sam9_rtc {
>  #define rtt_writel(rtc, field, val) \
>  	__raw_writel((val), (rtc)->rtt + AT91_RTT_ ## field)
>  
> -#define gpbr_readl(rtc) \
> -	__raw_readl((rtc)->gpbr)
> -#define gpbr_writel(rtc, val) \
> -	__raw_writel((val), (rtc)->gpbr)
> -
>  /*
>   * Read current time and date in RTC
>   */
> @@ -81,7 +77,7 @@ static int at91_rtc_readtime(struct device *dev, struct rtc_time *tm)
>  	u32 offset;
>  
>  	/* read current time offset */
> -	offset = gpbr_readl(rtc);
> +	offset = at91_gpbr_read(rtc->gpbr);
>  	if (offset == 0)
>  		return -EILSEQ;
>  
> @@ -124,11 +120,11 @@ static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
>  	rtt_writel(rtc, MR, mr & ~(AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN));
>  
>  	/* read current time offset */
> -	offset = gpbr_readl(rtc);
> +	offset = at91_gpbr_read(rtc->gpbr);
>  
>  	/* store the new base time in a battery backup register */
>  	secs += 1;
> -	gpbr_writel(rtc, secs);
> +	at91_gpbr_write(rtc->gpbr, secs);
>  
>  	/* adjust the alarm time for the new base */
>  	alarm = rtt_readl(rtc, AR);
> @@ -160,7 +156,7 @@ static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	u32 alarm = rtt_readl(rtc, AR);
>  	u32 offset;
>  
> -	offset = gpbr_readl(rtc);
> +	offset = at91_gpbr_read(rtc->gpbr);
>  	if (offset == 0)
>  		return -EILSEQ;
>  
> @@ -192,7 +188,7 @@ static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	if (err != 0)
>  		return err;
>  
> -	offset = gpbr_readl(rtc);
> +	offset = at91_gpbr_read(rtc->gpbr);
>  	if (offset == 0) {
>  		/* time is not set */
>  		return -EILSEQ;
> @@ -291,17 +287,14 @@ static const struct rtc_class_ops at91_rtc_ops = {
>   */
>  static int at91_rtc_probe(struct platform_device *pdev)
>  {
> -	struct resource	*r, *r_gpbr;
> +	struct resource	*r;
>  	struct sam9_rtc	*rtc;
>  	int		ret, irq;
>  	u32		mr;
>  
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	r_gpbr = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (!r || !r_gpbr) {
> -		dev_err(&pdev->dev, "need 2 ressources\n");
> -		return -ENODEV;
> -	}
> +	if (!r)
> +		return -ENXIO;
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> @@ -327,19 +320,14 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  		goto fail;
>  	}
>  
> -	rtc->gpbr = ioremap(r_gpbr->start, resource_size(r_gpbr));
> -	if (!rtc->gpbr) {
> -		dev_err(&pdev->dev, "failed to map gpbr registers, aborting.\n");
> -		ret = -ENOMEM;
> -		goto fail_gpbr;
> -	}
> +	rtc->gpbr = CONFIG_RTC_DRV_AT91SAM9_GPBR;
>  
>  	mr = rtt_readl(rtc, MR);
>  
>  	/* unless RTT is counting at 1 Hz, re-initialize it */
>  	if ((mr & AT91_RTT_RTPRES) != AT91_SLOW_CLOCK) {
>  		mr = AT91_RTT_RTTRST | (AT91_SLOW_CLOCK & AT91_RTT_RTPRES);
> -		gpbr_writel(rtc, 0);
> +		at91_gpbr_write(rtc->gpbr, 0);
>  	}
>  
>  	/* disable all interrupts (same as on shutdown path) */
> @@ -368,15 +356,13 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  	 * clock, discrete RTC, etc
>  	 */
>  
> -	if (gpbr_readl(rtc) == 0)
> +	if (at91_gpbr_read(rtc->gpbr) == 0)
>  		dev_warn(&pdev->dev, "%s: SET TIME!\n",
>  				dev_name(&rtc->rtcdev->dev));
>  
>  	return 0;
>  
>  fail_register:
> -	iounmap(rtc->gpbr);
> -fail_gpbr:
>  	iounmap(rtc->rtt);
>  fail:
>  	platform_set_drvdata(pdev, NULL);
> @@ -398,7 +384,6 @@ static int at91_rtc_remove(struct platform_device *pdev)
>  
>  	rtc_device_unregister(rtc->rtcdev);
>  
> -	iounmap(rtc->gpbr);
>  	iounmap(rtc->rtt);
>  	platform_set_drvdata(pdev, NULL);
>  	kfree(rtc);
> -- 
> 1.8.1.5
> 
