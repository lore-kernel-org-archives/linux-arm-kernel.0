From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 1 Sep 2010 09:22:34 +0800
Subject: [rtc-linux] [PATCH 15/74] ST SPEAr: adding support for rtc
In-Reply-To: <d9930e7793964f07a2e0acf7f52b45306e308ddd.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<d9930e7793964f07a2e0acf7f52b45306e308ddd.1283161023.git.viresh.kumar@st.com>
Message-ID: <AANLkTin8+fwS_XZx7Hx2DPj8y=xnFZAd=Wjoi1B4ZHbY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/30 Viresh KUMAR <viresh.kumar@st.com>:
> From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
>
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
> ?arch/arm/mach-spear13xx/clock.c ? ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-spear13xx/include/mach/generic.h | ? ?1 +
> ?arch/arm/mach-spear13xx/spear1300_evb.c ? ? ? ?| ? ?1 +
> ?arch/arm/mach-spear13xx/spear13xx.c ? ? ? ? ? ?| ? 19 +
> ?arch/arm/mach-spear3xx/clock.c ? ? ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-spear3xx/include/mach/generic.h ?| ? ?1 +
> ?arch/arm/mach-spear3xx/spear300_evb.c ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-spear3xx/spear310_evb.c ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-spear3xx/spear320_evb.c ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-spear3xx/spear3xx.c ? ? ? ? ? ? ?| ? 19 +
> ?arch/arm/mach-spear6xx/clock.c ? ? ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-spear6xx/include/mach/generic.h ?| ? ?1 +
> ?arch/arm/mach-spear6xx/spear600_evb.c ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-spear6xx/spear6xx.c ? ? ? ? ? ? ?| ? 19 +
> ?drivers/rtc/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?7 +
> ?drivers/rtc/Makefile ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> ?drivers/rtc/rtc-spear.c ? ? ? ? ? ? ? ? ? ? ? ?| ?598 ++++++++++++++++++++++++
> ?17 files changed, 674 insertions(+), 3 deletions(-)
> ?create mode 100644 drivers/rtc/rtc-spear.c
>


Please split your this patch into two parts, one submitted to LAKM,
the other submitted to Linux-rtc list.

> diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
> index cef3b13..cc692cc 100644
> --- a/arch/arm/mach-spear13xx/clock.c
> +++ b/arch/arm/mach-spear13xx/clock.c
> @@ -736,7 +736,7 @@ static struct clk_lookup spear_clk_lookups[] = {
> ? ? ? ?{.con_id = "osc3_25m_clk", ? ? ?.clk = &osc3_25m_clk},
>
> ? ? ? ?/* clock derived from 32 KHz osc clk */
> - ? ? ? {.dev_id = "rtc", ? ? ? ? ? ? ? .clk = &rtc_clk},
> + ? ? ? {.dev_id = "rtc-spear", ? ? ? ? .clk = &rtc_clk},
>
> ? ? ? ?/* clock derived from 24/25 MHz osc1/osc3 clk */
> ? ? ? ?{.con_id = "pll1_clk", ? ? ? ? ?.clk = &pll1_clk},
> diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
> index 41c1a53..dc80421 100644
> --- a/arch/arm/mach-spear13xx/include/mach/generic.h
> +++ b/arch/arm/mach-spear13xx/include/mach/generic.h
> @@ -30,6 +30,7 @@
>
> ?/* Add spear13xx family device structure declarations here */
> ?extern struct amba_device uart_device;
> +extern struct platform_device rtc_device;
> ?extern struct sys_timer spear13xx_timer;
>
> ?/* Add spear1300 machine device structure declarations here */
> diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
> index d72c8a8..60c5fee 100644
> --- a/arch/arm/mach-spear13xx/spear1300_evb.c
> +++ b/arch/arm/mach-spear13xx/spear1300_evb.c
> @@ -22,6 +22,7 @@ static struct amba_device *amba_devs[] __initdata = {
> ?};
>
> ?static struct platform_device *plat_devs[] __initdata = {
> + ? ? ? &rtc_device,
> ?};
>
> ?static void __init spear1300_evb_init(void)
> diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
> index d11e300..bdca713 100644
> --- a/arch/arm/mach-spear13xx/spear13xx.c
> +++ b/arch/arm/mach-spear13xx/spear13xx.c
> @@ -37,6 +37,25 @@ struct amba_device uart_device = {
> ? ? ? ?.irq = {IRQ_UART, NO_IRQ},
> ?};
>
> +/* rtc device registration */
> +static struct resource rtc_resources[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .start = SPEAR13XX_RTC_BASE,
> + ? ? ? ? ? ? ? .end = SPEAR13XX_RTC_BASE + SZ_4K - 1,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .start = IRQ_RTC,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_IRQ,
> + ? ? ? },
> +};
> +
> +struct platform_device rtc_device = {
> + ? ? ? .name = "rtc-spear",
> + ? ? ? .id = -1,
> + ? ? ? .num_resources = ARRAY_SIZE(rtc_resources),
> + ? ? ? .resource = rtc_resources,
> +};
> +
> ?/* Do spear13xx familiy common initialization part here */
> ?void __init spear13xx_init(void)
> ?{
> diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
> index dc19666..147d0a3 100644
> --- a/arch/arm/mach-spear3xx/clock.c
> +++ b/arch/arm/mach-spear3xx/clock.c
> @@ -467,7 +467,7 @@ static struct clk_lookup spear_clk_lookups[] = {
> ? ? ? ?{ .con_id = "osc_32k_clk", ? ? ?.clk = &osc_32k_clk},
> ? ? ? ?{ .con_id = "osc_24m_clk", ? ? ?.clk = &osc_24m_clk},
> ? ? ? ?/* clock derived from 32 KHz osc clk */
> - ? ? ? { .dev_id = "rtc", ? ? ? ? ? ? ?.clk = &rtc_clk},
> + ? ? ? { .dev_id = "rtc-spear", ? ? ? ?.clk = &rtc_clk},
> ? ? ? ?/* clock derived from 24 MHz osc clk */
> ? ? ? ?{ .con_id = "pll1_clk", ? ? ? ? .clk = &pll1_clk},
> ? ? ? ?{ .con_id = "pll3_48m_clk", ? ? .clk = &pll3_48m_clk},
> diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
> index d76ee98..408bb8d 100644
> --- a/arch/arm/mach-spear3xx/include/mach/generic.h
> +++ b/arch/arm/mach-spear3xx/include/mach/generic.h
> @@ -33,6 +33,7 @@
> ?/* Add spear3xx family device structure declarations here */
> ?extern struct amba_device gpio_device;
> ?extern struct amba_device uart_device;
> +extern struct platform_device rtc_device;
> ?extern struct sys_timer spear3xx_timer;
>
> ?/* Add spear3xx family function declarations here */
> diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
> index 3bb7fbc..392ee4a 100644
> --- a/arch/arm/mach-spear3xx/spear300_evb.c
> +++ b/arch/arm/mach-spear3xx/spear300_evb.c
> @@ -44,6 +44,7 @@ static struct amba_device *amba_devs[] __initdata = {
>
> ?static struct platform_device *plat_devs[] __initdata = {
> ? ? ? ?/* spear3xx specific devices */
> + ? ? ? &rtc_device,
>
> ? ? ? ?/* spear300 specific devices */
> ?};
> diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
> index 7dd93bd..15ca8fc 100644
> --- a/arch/arm/mach-spear3xx/spear310_evb.c
> +++ b/arch/arm/mach-spear3xx/spear310_evb.c
> @@ -50,6 +50,7 @@ static struct amba_device *amba_devs[] __initdata = {
>
> ?static struct platform_device *plat_devs[] __initdata = {
> ? ? ? ?/* spear3xx specific devices */
> + ? ? ? &rtc_device,
>
> ? ? ? ?/* spear310 specific devices */
> ? ? ? ?&plgpio_device,
> diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
> index 82f4e76..48155cc 100644
> --- a/arch/arm/mach-spear3xx/spear320_evb.c
> +++ b/arch/arm/mach-spear3xx/spear320_evb.c
> @@ -48,6 +48,7 @@ static struct amba_device *amba_devs[] __initdata = {
>
> ?static struct platform_device *plat_devs[] __initdata = {
> ? ? ? ?/* spear3xx specific devices */
> + ? ? ? &rtc_device,
>
> ? ? ? ?/* spear320 specific devices */
> ? ? ? ?&plgpio_device,
> diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
> index 89cf8ea..6d8791e 100644
> --- a/arch/arm/mach-spear3xx/spear3xx.c
> +++ b/arch/arm/mach-spear3xx/spear3xx.c
> @@ -54,6 +54,25 @@ struct amba_device uart_device = {
> ? ? ? ?.irq = {IRQ_UART, NO_IRQ},
> ?};
>
> +/* rtc device registration */
> +static struct resource rtc_resources[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .start = SPEAR3XX_ICM3_RTC_BASE,
> + ? ? ? ? ? ? ? .end = SPEAR3XX_ICM3_RTC_BASE + SZ_4K - 1,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .start = IRQ_BASIC_RTC,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_IRQ,
> + ? ? ? },
> +};
> +
> +struct platform_device rtc_device = {
> + ? ? ? .name = "rtc-spear",
> + ? ? ? .id = -1,
> + ? ? ? .num_resources = ARRAY_SIZE(rtc_resources),
> + ? ? ? .resource = rtc_resources,
> +};
> +
> ?/* Do spear3xx familiy common initialization part here */
> ?void __init spear3xx_init(void)
> ?{
> diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
> index 4a91991..66fc622 100644
> --- a/arch/arm/mach-spear6xx/clock.c
> +++ b/arch/arm/mach-spear6xx/clock.c
> @@ -569,7 +569,7 @@ static struct clk_lookup spear_clk_lookups[] = {
> ? ? ? ?{ .con_id = "osc_32k_clk", ? ? ?.clk = &osc_32k_clk},
> ? ? ? ?{ .con_id = "osc_30m_clk", ? ? ?.clk = &osc_30m_clk},
> ? ? ? ?/* clock derived from 32 KHz os ? ? ? ? ?clk */
> - ? ? ? { .dev_id = "rtc", ? ? ? ? ? ? ?.clk = &rtc_clk},
> + ? ? ? { .dev_id = "rtc-spear", ? ? ? ?.clk = &rtc_clk},
> ? ? ? ?/* clock derived from 30 MHz os ? ? ? ? ?clk */
> ? ? ? ?{ .con_id = "pll1_clk", ? ? ? ? .clk = &pll1_clk},
> ? ? ? ?{ .con_id = "pll3_48m_clk", ? ? .clk = &pll3_48m_clk},
> diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
> index d6a04f2..674b16c 100644
> --- a/arch/arm/mach-spear6xx/include/mach/generic.h
> +++ b/arch/arm/mach-spear6xx/include/mach/generic.h
> @@ -32,6 +32,7 @@
> ?extern struct amba_device clcd_device;
> ?extern struct amba_device gpio_device[];
> ?extern struct amba_device uart_device[];
> +extern struct platform_device rtc_device;
> ?extern struct sys_timer spear6xx_timer;
>
> ?/* Add spear6xx family function declarations here */
> diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
> index 88e69f4..861e83d 100644
> --- a/arch/arm/mach-spear6xx/spear600_evb.c
> +++ b/arch/arm/mach-spear6xx/spear600_evb.c
> @@ -26,6 +26,7 @@ static struct amba_device *amba_devs[] __initdata = {
> ?};
>
> ?static struct platform_device *plat_devs[] __initdata = {
> + ? ? ? &rtc_device,
> ?};
>
> ?static void __init spear600_evb_init(void)
> diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
> index d0f6b9d..1e403cb 100644
> --- a/arch/arm/mach-spear6xx/spear6xx.c
> +++ b/arch/arm/mach-spear6xx/spear6xx.c
> @@ -121,6 +121,25 @@ struct amba_device gpio_device[] = {
> ? ? ? ?}
> ?};
>
> +/* rtc device registration */
> +static struct resource rtc_resources[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .start = SPEAR6XX_ICM3_RTC_BASE,
> + ? ? ? ? ? ? ? .end = SPEAR6XX_ICM3_RTC_BASE + SZ_4K - 1,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .start = IRQ_BASIC_RTC,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_IRQ,
> + ? ? ? },
> +};
> +
> +struct platform_device rtc_device = {
> + ? ? ? .name = "rtc-spear",
> + ? ? ? .id = -1,
> + ? ? ? .num_resources = ARRAY_SIZE(rtc_resources),
> + ? ? ? .resource = rtc_resources,
> +};
> +
> ?/* This will add devices, and do machine specific tasks */
> ?void __init spear6xx_init(void)
> ?{
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 48ca713..f099473 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -625,6 +625,13 @@ config RTC_DRV_WM8350
> ? ? ? ? ?This driver can also be built as a module. If so, the module
> ? ? ? ? ?will be called "rtc-wm8350".
>
> +config RTC_DRV_SPEAR
> + ? ? ? tristate "SPEAR ST RTC"
> + ? ? ? default y
> + ? ? ? help
> + ? ? ? ?If you say Y here you will get support for the RTC found on
> + ? ? ? ?spear
> +
> ?config RTC_DRV_PCF50633
> ? ? ? ?depends on MFD_PCF50633
> ? ? ? ?tristate "NXP PCF50633 RTC"
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 0f207b3..44df01a 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -86,6 +86,7 @@ obj-$(CONFIG_RTC_DRV_S35390A) += rtc-s35390a.o
> ?obj-$(CONFIG_RTC_DRV_S3C) ? ? ?+= rtc-s3c.o
> ?obj-$(CONFIG_RTC_DRV_SA1100) ? += rtc-sa1100.o
> ?obj-$(CONFIG_RTC_DRV_SH) ? ? ? += rtc-sh.o
> +obj-$(CONFIG_RTC_DRV_SPEAR) ? ?+= rtc-spear.o
> ?obj-$(CONFIG_RTC_DRV_STARFIRE) += rtc-starfire.o
> ?obj-$(CONFIG_RTC_DRV_STK17TA8) += rtc-stk17ta8.o
> ?obj-$(CONFIG_RTC_DRV_STMP) ? ? += rtc-stmp3xxx.o
> diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
> new file mode 100644
> index 0000000..5b49124
> --- /dev/null
> +++ b/drivers/rtc/rtc-spear.c
> @@ -0,0 +1,598 @@
> +/*
> + * drivers/rtc/rtc-spear.c
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Rajeev Kumar<rajeev-dlh.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/bcd.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +#include <asm/mach/time.h>
> +
> +/* RTC registers */
> +#define TIME_REG ? ? ? ? ? ? ? 0x00
> +#define DATE_REG ? ? ? ? ? ? ? 0x04
> +#define ALARM_TIME_REG ? ? ? ? 0x08
> +#define ALARM_DATE_REG ? ? ? ? 0x0C
> +#define CTRL_REG ? ? ? ? ? ? ? 0x10
> +#define STATUS_REG ? ? ? ? ? ? 0x14
> +
> +/* TIME_REG & ALARM_TIME_REG */
> +#define SECONDS_UNITS ? ? ? ? ?(0xf<<0) ? ? ? ?/* seconds units position */
> +#define SECONDS_TENS ? ? ? ? ? (0x7<<4) ? ? ? ?/* seconds tens position */
> +#define MINUTES_UNITS ? ? ? ? ?(0xf<<8) ? ? ? ?/* minutes units position */
> +#define MINUTES_TENS ? ? ? ? ? (0x7<<12) ? ? ? /* minutes tens position */
> +#define HOURS_UNITS ? ? ? ? ? ?(0xf<<16) ? ? ? /* hours units position */
> +#define HOURS_TENS ? ? ? ? ? ? (0x3<<20) ? ? ? /* hours tens position */
> +
> +/* DATE_REG & ALARM_DATE_REG */
> +#define DAYS_UNITS ? ? ? ? ? ? (0xf<<0) ? ? ? ?/* days units position */
> +#define DAYS_TENS ? ? ? ? ? ? ?(0x3<<4) ? ? ? ?/* days tens position */
> +#define MONTHS_UNITS ? ? ? ? ? (0xf<<8) ? ? ? ?/* months units position */
> +#define MONTHS_TENS ? ? ? ? ? ?(0x1<<12) ? ? ? /* months tens position */
> +#define YEARS_UNITS ? ? ? ? ? ?(0xf<<16) ? ? ? /* years units position */
> +#define YEARS_TENS ? ? ? ? ? ? (0xf<<20) ? ? ? /* years tens position */
> +#define YEARS_HUNDREDS ? ? ? ? (0xf<<24) ? ? ? /* years hundereds position */
> +#define YEARS_MILLENIUMS ? ? ? (0xf<<28) ? ? ? /* years millenium position */
> +
> +/* MASK SHIFT TIME_REG & ALARM_TIME_REG*/
> +#define SECOND_SHIFT ? ? ? ? ? 0x00 ? ? ? ? ? ?/* seconds units */
> +#define MINUTE_SHIFT ? ? ? ? ? 0x08 ? ? ? ? ? ?/* minutes units position */
> +#define HOUR_SHIFT ? ? ? ? ? ? 0x10 ? ? ? ? ? ?/* hours units position */
> +#define MDAY_SHIFT ? ? ? ? ? ? 0x00 ? ? ? ? ? ?/* Month day shift */
> +#define MONTH_SHIFT ? ? ? ? ? ?0x08 ? ? ? ? ? ?/* Month shift */
> +#define YEAR_SHIFT ? ? ? ? ? ? 0x10 ? ? ? ? ? ?/* Year shift */
> +
> +#define SECOND_MASK ? ? ? ? ? ?0x7F
> +#define MIN_MASK ? ? ? ? ? ? ? 0x7F
> +#define HOUR_MASK ? ? ? ? ? ? ?0x3F
> +#define DAY_MASK ? ? ? ? ? ? ? 0x3F
> +#define MONTH_MASK ? ? ? ? ? ? 0x7F
> +#define YEAR_MASK ? ? ? ? ? ? ?0xFFFF
> +
> +/* date reg equal to time reg, for debug only */
> +#define TIME_BYP ? ? ? ? ? ? ? (1<<9)
> +#define INT_ENABLE ? ? ? ? ? ? (1<<31) ? ? ? ? /* interrupt enable */
> +
> +/* STATUS_REG */
> +#define CLK_UNCONNECTED ? ? ? ? ? ? ? ?(1<<0)
> +#define PEND_WR_TIME ? ? ? ? ? (1<<2)
> +#define PEND_WR_DATE ? ? ? ? ? (1<<3)
> +#define LOST_WR_TIME ? ? ? ? ? (1<<4)
> +#define LOST_WR_DATE ? ? ? ? ? (1<<5)
> +#define RTC_INT_MASK ? ? ? ? ? (1<<31)
> +#define STATUS_BUSY ? ? ? ? ? ?(PEND_WR_TIME | PEND_WR_DATE)
> +#define STATUS_FAIL ? ? ? ? ? ?(LOST_WR_TIME | LOST_WR_DATE)
> +
> +struct spear_rtc_config {
> + ? ? ? struct clk *clk;
> + ? ? ? spinlock_t lock;
> + ? ? ? void __iomem *ioaddr;
> +};
> +
> +static inline void spear_rtc_clear_interrupt(struct spear_rtc_config *config)
> +{
> + ? ? ? unsigned int val;
> + ? ? ? unsigned long flags;
> +
> + ? ? ? spin_lock_irqsave(&config->lock, flags);
> + ? ? ? val = readl(config->ioaddr + STATUS_REG);
> + ? ? ? val |= RTC_INT_MASK;
> + ? ? ? writel(val, config->ioaddr + STATUS_REG);
> + ? ? ? spin_unlock_irqrestore(&config->lock, flags);
> +}
> +
> +static inline void spear_rtc_enable_interrupt(struct spear_rtc_config *config)
> +{
> + ? ? ? unsigned int val;
> +
> + ? ? ? val = readl(config->ioaddr + CTRL_REG);
> + ? ? ? if (!(val & INT_ENABLE)) {
> + ? ? ? ? ? ? ? spear_rtc_clear_interrupt(config);
> + ? ? ? ? ? ? ? val |= INT_ENABLE;
> + ? ? ? ? ? ? ? writel(val, config->ioaddr + CTRL_REG);
> + ? ? ? }
> +}
> +
> +static inline void spear_rtc_disable_interrupt(struct spear_rtc_config *config)
> +{
> + ? ? ? unsigned int val;
> +
> + ? ? ? val = readl(config->ioaddr + CTRL_REG);
> + ? ? ? if (val & INT_ENABLE) {
> + ? ? ? ? ? ? ? val &= ~INT_ENABLE;
> + ? ? ? ? ? ? ? writel(val, config->ioaddr + CTRL_REG);
> + ? ? ? }
> +}
> +
> +static inline int is_write_complete(struct spear_rtc_config *config)
> +{
> + ? ? ? int ret = 0;
> + ? ? ? unsigned long flags;
> +
> + ? ? ? spin_lock_irqsave(&config->lock, flags);
> + ? ? ? if ((readl(config->ioaddr + STATUS_REG)) & STATUS_FAIL)
> + ? ? ? ? ? ? ? ret = -EIO;
> + ? ? ? spin_unlock_irqrestore(&config->lock, flags);
> +
> + ? ? ? return ret;
> +}
> +
> +static void rtc_wait_not_busy(struct spear_rtc_config *config)
> +{
> + ? ? ? int status, count = 0;
> + ? ? ? unsigned long flags;
> +
> + ? ? ? /* Assuming BUSY may stay active for 80 msec) */
> + ? ? ? for (count = 0; count < 80; count++) {
> + ? ? ? ? ? ? ? spin_lock_irqsave(&config->lock, flags);
> + ? ? ? ? ? ? ? status = readl(config->ioaddr + STATUS_REG);
> + ? ? ? ? ? ? ? spin_unlock_irqrestore(&config->lock, flags);
> + ? ? ? ? ? ? ? if ((status & STATUS_BUSY) == 0)
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? /* check status busy, after each msec */
> + ? ? ? ? ? ? ? msleep(1);
> + ? ? ? }
> +}
> +
> +static irqreturn_t spear_rtc_irq(int irq, void *dev_id)
> +{
> + ? ? ? struct rtc_device *rtc = (struct rtc_device *)dev_id;
> + ? ? ? struct spear_rtc_config *config = dev_get_drvdata(&rtc->dev);
> + ? ? ? unsigned long flags, events = 0;
> + ? ? ? unsigned int irq_data;
> +
> + ? ? ? spin_lock_irqsave(&config->lock, flags);
> + ? ? ? irq_data = readl(config->ioaddr + STATUS_REG);
> + ? ? ? spin_unlock_irqrestore(&config->lock, flags);
> +
> + ? ? ? if ((irq_data & RTC_INT_MASK)) {
> + ? ? ? ? ? ? ? spear_rtc_clear_interrupt(config);
> + ? ? ? ? ? ? ? events = RTC_IRQF | RTC_AF;
> + ? ? ? ? ? ? ? rtc_update_irq(rtc, 1, events);
> + ? ? ? ? ? ? ? return IRQ_HANDLED;
> + ? ? ? } else
> + ? ? ? ? ? ? ? return IRQ_NONE;
> +
> +}
> +
> +static int tm2bcd(struct rtc_time *tm)
> +{
> + ? ? ? if (rtc_valid_tm(tm) != 0)
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? tm->tm_sec = bin2bcd(tm->tm_sec);
> + ? ? ? tm->tm_min = bin2bcd(tm->tm_min);
> + ? ? ? tm->tm_hour = bin2bcd(tm->tm_hour);
> + ? ? ? tm->tm_mday = bin2bcd(tm->tm_mday);
> + ? ? ? tm->tm_mon = bin2bcd(tm->tm_mon + 1);
> + ? ? ? tm->tm_year = bin2bcd(tm->tm_year);
> +
> + ? ? ? return 0;
> +}
> +
> +static void bcd2tm(struct rtc_time *tm)
> +{
> + ? ? ? tm->tm_sec = bcd2bin(tm->tm_sec);
> + ? ? ? tm->tm_min = bcd2bin(tm->tm_min);
> + ? ? ? tm->tm_hour = bcd2bin(tm->tm_hour);
> + ? ? ? tm->tm_mday = bcd2bin(tm->tm_mday);
> + ? ? ? tm->tm_mon = bcd2bin(tm->tm_mon) - 1;
> + ? ? ? /* epoch == 1900 */
> + ? ? ? tm->tm_year = bcd2bin(tm->tm_year);
> +}
> +
> +/*
> + * spear_rtc_read_time - set the time
> + * @dev: rtc device in use
> + * @tm: holds date and time
> + *
> + * This function read time and date. On success it will return 0
> + * otherwise -ve error is returned.
> + */
> +static int spear_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
> + ? ? ? struct rtc_device *rtc = platform_get_drvdata(pdev);
> + ? ? ? struct spear_rtc_config *config = dev_get_drvdata(&rtc->dev);
> + ? ? ? unsigned int time, date;
> +
> + ? ? ? /* we don't report wday/yday/isdst ... */
> + ? ? ? rtc_wait_not_busy(config);
> +
> + ? ? ? time = readl(config->ioaddr + TIME_REG);
> + ? ? ? date = readl(config->ioaddr + DATE_REG);
> + ? ? ? tm->tm_sec = (time >> SECOND_SHIFT) & SECOND_MASK;
> + ? ? ? tm->tm_min = (time >> MINUTE_SHIFT) & MIN_MASK;
> + ? ? ? tm->tm_hour = (time >> HOUR_SHIFT) & HOUR_MASK;
> + ? ? ? tm->tm_mday = (date >> MDAY_SHIFT) & DAY_MASK;
> + ? ? ? tm->tm_mon = (date >> MONTH_SHIFT) & MONTH_MASK;
> + ? ? ? tm->tm_year = (date >> YEAR_SHIFT) & YEAR_MASK;
> +
> + ? ? ? bcd2tm(tm);
> + ? ? ? return 0;
> +}
> +
> +/*
> + * spear_rtc_set_time - set the time
> + * @dev: rtc device in use
> + * @tm: holds date and time
> + *
> + * This function set time and date. On success it will return 0
> + * otherwise -ve error is returned.
> + */
> +static int spear_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
> + ? ? ? struct rtc_device *rtc = platform_get_drvdata(pdev);
> + ? ? ? struct spear_rtc_config *config = dev_get_drvdata(&rtc->dev);
> + ? ? ? unsigned int time, date, err = 0;
> +
> + ? ? ? if (tm2bcd(tm) < 0)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? rtc_wait_not_busy(config);
> + ? ? ? time = (tm->tm_sec << SECOND_SHIFT) | (tm->tm_min << MINUTE_SHIFT) |
> + ? ? ? ? ? ? ? (tm->tm_hour << HOUR_SHIFT);
> + ? ? ? date = (tm->tm_mday << MDAY_SHIFT) | (tm->tm_mon << MONTH_SHIFT) |
> + ? ? ? ? ? ? ? (tm->tm_year << YEAR_SHIFT);
> + ? ? ? writel(time, config->ioaddr + TIME_REG);
> + ? ? ? writel(date, config->ioaddr + DATE_REG);
> + ? ? ? err = is_write_complete(config);
> + ? ? ? if (err < 0)
> + ? ? ? ? ? ? ? return err;
> +
> + ? ? ? return 0;
> +}
> +
> +/*
> + * spear_rtc_read_alarm - read the alarm time
> + * @dev: rtc device in use
> + * @alm: holds alarm date and time
> + *
> + * This function read alarm time and date. On success it will return 0
> + * otherwise -ve error is returned.
> + */
> +static int spear_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
> +{
> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
> + ? ? ? struct rtc_device *rtc = platform_get_drvdata(pdev);
> + ? ? ? struct spear_rtc_config *config = dev_get_drvdata(&rtc->dev);
> + ? ? ? unsigned int time, date;
> +
> + ? ? ? rtc_wait_not_busy(config);
> +
> + ? ? ? time = readl(config->ioaddr + ALARM_TIME_REG);
> + ? ? ? date = readl(config->ioaddr + ALARM_DATE_REG);
> + ? ? ? alm->time.tm_sec = (time >> SECOND_SHIFT) & SECOND_MASK;
> + ? ? ? alm->time.tm_min = (time >> MINUTE_SHIFT) & MIN_MASK;
> + ? ? ? alm->time.tm_hour = (time >> HOUR_SHIFT) & HOUR_MASK;
> + ? ? ? alm->time.tm_mday = (date >> MDAY_SHIFT) & DAY_MASK;
> + ? ? ? alm->time.tm_mon = (date >> MONTH_SHIFT) & MONTH_MASK;
> + ? ? ? alm->time.tm_year = (date >> YEAR_SHIFT) & YEAR_MASK;
> +
> + ? ? ? bcd2tm(&alm->time);
> + ? ? ? alm->enabled = readl(config->ioaddr + CTRL_REG) & INT_ENABLE;
> +
> + ? ? ? return 0;
> +}
> +
> +/*
> + * spear_rtc_set_alarm - set the alarm time
> + * @dev: rtc device in use
> + * @alm: holds alarm date and time
> + *
> + * This function set alarm time and date. On success it will return 0
> + * otherwise -ve error is returned.
> + */
> +static int spear_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
> +{
> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
> + ? ? ? struct rtc_device *rtc = platform_get_drvdata(pdev);
> + ? ? ? struct spear_rtc_config *config = dev_get_drvdata(&rtc->dev);
> + ? ? ? unsigned int time, date, err = 0;
> +
> + ? ? ? if (tm2bcd(&alm->time) < 0)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? rtc_wait_not_busy(config);
> +
> + ? ? ? time = (alm->time.tm_sec << SECOND_SHIFT) | (alm->time.tm_min <<
> + ? ? ? ? ? ? ? ? ? ? ? MINUTE_SHIFT) | (alm->time.tm_hour << HOUR_SHIFT);
> + ? ? ? date = (alm->time.tm_mday << MDAY_SHIFT) | (alm->time.tm_mon <<
> + ? ? ? ? ? ? ? ? ? ? ? MONTH_SHIFT) | (alm->time.tm_year << YEAR_SHIFT);
> +
> + ? ? ? writel(time, config->ioaddr + ALARM_TIME_REG);
> + ? ? ? writel(date, config->ioaddr + ALARM_DATE_REG);
> + ? ? ? err = is_write_complete(config);
> + ? ? ? if (err < 0)
> + ? ? ? ? ? ? ? return err;
> +
> + ? ? ? if (alm->enabled)
> + ? ? ? ? ? ? ? spear_rtc_enable_interrupt(config);
> + ? ? ? else
> + ? ? ? ? ? ? ? spear_rtc_disable_interrupt(config);
> +
> + ? ? ? return 0;
> +}
> +
> +#ifdef CONFIG_RTC_INTF_DEV
> +static int
> +spear_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
> +{
> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
> + ? ? ? struct rtc_device *rtc = platform_get_drvdata(pdev);
> + ? ? ? struct spear_rtc_config *config = dev_get_drvdata(&rtc->dev);
> + ? ? ? struct rtc_time tm;
> + ? ? ? struct rtc_wkalrm alm;
> + ? ? ? void __user *uarg = (void __user *)arg;
> + ? ? ? int err = 0;
> +
> + ? ? ? switch (cmd) {
> + ? ? ? ? ? ? ? /* AIE = Alarm Interrupt Enable */
> + ? ? ? case RTC_AIE_OFF:
> + ? ? ? ? ? ? ? spear_rtc_disable_interrupt(config);
> + ? ? ? ? ? ? ? break;
> + ? ? ? case RTC_AIE_ON:
> + ? ? ? ? ? ? ? spear_rtc_enable_interrupt(config);
> + ? ? ? ? ? ? ? break;
> + ? ? ? case RTC_SET_TIME:
> + ? ? ? ? ? ? ? if (copy_from_user(&tm, uarg, sizeof(tm)))
> + ? ? ? ? ? ? ? ? ? ? ? return -EFAULT;
> + ? ? ? ? ? ? ? return spear_rtc_set_time(dev, &tm);
> + ? ? ? case RTC_RD_TIME:
> + ? ? ? ? ? ? ? err = spear_rtc_read_time(dev, &tm);
> + ? ? ? ? ? ? ? if (err < 0)
> + ? ? ? ? ? ? ? ? ? ? ? return err;
> +
> + ? ? ? ? ? ? ? if (copy_to_user(uarg, &tm, sizeof(tm)))
> + ? ? ? ? ? ? ? ? ? ? ? return -EFAULT;
> + ? ? ? ? ? ? ? break;
> + ? ? ? case RTC_ALM_SET:
> + ? ? ? ? ? ? ? if (copy_from_user(&alm.time, uarg, sizeof(tm)))
> + ? ? ? ? ? ? ? ? ? ? ? return -EFAULT;
> + ? ? ? ? ? ? ? alm.enabled = 0;
> + ? ? ? ? ? ? ? alm.pending = 0;
> + ? ? ? ? ? ? ? spear_rtc_set_alarm(dev, &alm);
> + ? ? ? ? ? ? ? break;
> + ? ? ? case RTC_ALM_READ:
> + ? ? ? ? ? ? ? err = spear_rtc_read_alarm(dev, &alm);
> + ? ? ? ? ? ? ? if (err < 0)
> + ? ? ? ? ? ? ? ? ? ? ? return err;
> +
> + ? ? ? ? ? ? ? if (copy_to_user(uarg, &alm.time, sizeof(tm)))
> + ? ? ? ? ? ? ? ? ? ? ? return -EFAULT;
> + ? ? ? ? ? ? ? break;
> + ? ? ? default:
> + ? ? ? ? ? ? ? return -ENOIOCTLCMD;
> + ? ? ? }
> +
> + ? ? ? return 0;
> +}
> +
> +#else
> +#define spear_rtc_ioctl ? ? ? ?NULL
> +#endif
> +
> +static struct rtc_class_ops spear_rtc_ops = {
> + ? ? ? .ioctl = spear_rtc_ioctl,
> + ? ? ? .read_time = spear_rtc_read_time,
> + ? ? ? .set_time = spear_rtc_set_time,
> + ? ? ? .read_alarm = spear_rtc_read_alarm,
> + ? ? ? .set_alarm = spear_rtc_set_alarm,
> +};
> +
> +static int __devinit spear_rtc_probe(struct platform_device *pdev)
> +{
> + ? ? ? struct resource *res;
> + ? ? ? struct rtc_device *rtc;
> + ? ? ? struct spear_rtc_config *config;
> + ? ? ? unsigned int status = 0;
> + ? ? ? int irq;
> +
> + ? ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + ? ? ? if (!res) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "no resource defined\n");
> + ? ? ? ? ? ? ? return -EBUSY;
> + ? ? ? }
> + ? ? ? if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "rtc region already claimed\n");
> + ? ? ? ? ? ? ? return -EBUSY;
> + ? ? ? }
> +
> + ? ? ? config = kzalloc(sizeof(*config), GFP_KERNEL);
> + ? ? ? if (!config) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "out of memory\n");
> + ? ? ? ? ? ? ? status = -ENOMEM;
> + ? ? ? ? ? ? ? goto err_release_region;
> + ? ? ? }
> +
> + ? ? ? config->clk = clk_get(&pdev->dev, NULL);
> + ? ? ? if (IS_ERR(config->clk)) {
> + ? ? ? ? ? ? ? status = PTR_ERR(config->clk);
> + ? ? ? ? ? ? ? goto err_kfree;
> + ? ? ? }
> +
> + ? ? ? status = clk_enable(config->clk);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? goto err_clk_put;
> +
> + ? ? ? config->ioaddr = ioremap(res->start, resource_size(res));
> + ? ? ? if (!config->ioaddr) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "ioremap fail\n");
> + ? ? ? ? ? ? ? status = -ENOMEM;
> + ? ? ? ? ? ? ? goto err_disable_clock;
> + ? ? ? }
> +
> + ? ? ? rtc = rtc_device_register(pdev->name, &pdev->dev, &spear_rtc_ops,
> + ? ? ? ? ? ? ? ? ? ? ? THIS_MODULE);
> + ? ? ? if (IS_ERR(rtc)) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "can't register RTC device, err %ld\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PTR_ERR(rtc));
> + ? ? ? ? ? ? ? status = PTR_ERR(rtc);
> + ? ? ? ? ? ? ? goto err_iounmap;
> + ? ? ? }
> + ? ? ? platform_set_drvdata(pdev, rtc);
> + ? ? ? dev_set_drvdata(&rtc->dev, config);
> +
> + ? ? ? spin_lock_init(&config->lock);
> +
> + ? ? ? /* alarm irqs */
> + ? ? ? irq = platform_get_irq(pdev, 0);
> + ? ? ? if (irq < 0) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "no update irq?\n");
> + ? ? ? ? ? ? ? status = irq;
> + ? ? ? ? ? ? ? goto err_clear_platdata;
> + ? ? ? }
> +
> + ? ? ? status = request_irq(irq, spear_rtc_irq, 0, pdev->name, rtc);
> + ? ? ? if (status) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "Alarm interrupt IRQ%d already \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? claimed\n", irq);
> + ? ? ? ? ? ? ? goto err_clear_platdata;
> + ? ? ? }
> +
> + ? ? ? if (!device_can_wakeup(&pdev->dev))
> + ? ? ? ? ? ? ? device_init_wakeup(&pdev->dev, 1);
> +
> + ? ? ? return 0;
> +
> +err_clear_platdata:
> + ? ? ? platform_set_drvdata(pdev, NULL);
> + ? ? ? dev_set_drvdata(&rtc->dev, NULL);
> + ? ? ? rtc_device_unregister(rtc);
> +err_iounmap:
> + ? ? ? iounmap(config->ioaddr);
> +err_disable_clock:
> + ? ? ? clk_disable(config->clk);
> +err_clk_put:
> + ? ? ? clk_put(config->clk);
> +err_kfree:
> + ? ? ? kfree(config);
> +err_release_region:
> + ? ? ? release_mem_region(res->start, resource_size(res));
> +
> + ? ? ? return status;
> +}
> +
> +static int __devexit spear_rtc_remove(struct platform_device *pdev)
> +{
> + ? ? ? struct rtc_device *rtc = platform_get_drvdata(pdev);
> + ? ? ? struct spear_rtc_config *config = dev_get_drvdata(&rtc->dev);
> + ? ? ? int irq;
> + ? ? ? struct resource *res;
> +
> + ? ? ? /* leave rtc running, but disable irqs */
> + ? ? ? spear_rtc_disable_interrupt(config);
> + ? ? ? device_init_wakeup(&pdev->dev, 0);
> + ? ? ? irq = platform_get_irq(pdev, 0);
> + ? ? ? if (irq)
> + ? ? ? ? ? ? ? free_irq(irq, pdev);
> + ? ? ? clk_disable(config->clk);
> + ? ? ? clk_put(config->clk);
> + ? ? ? iounmap(config->ioaddr);
> + ? ? ? kfree(config);
> + ? ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + ? ? ? if (res)
> + ? ? ? ? ? ? ? release_mem_region(res->start, resource_size(res));
> + ? ? ? platform_set_drvdata(pdev, NULL);
> + ? ? ? dev_set_drvdata(&rtc->dev, NULL);
> + ? ? ? rtc_device_unregister(rtc);
> +
> + ? ? ? return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +
> +static int spear_rtc_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> + ? ? ? struct rtc_device *rtc = platform_get_drvdata(pdev);
> + ? ? ? struct spear_rtc_config *config = dev_get_drvdata(&rtc->dev);
> + ? ? ? int irq;
> +
> + ? ? ? irq = platform_get_irq(pdev, 0);
> + ? ? ? if (device_may_wakeup(&pdev->dev))
> + ? ? ? ? ? ? ? enable_irq_wake(irq);
> + ? ? ? else {
> + ? ? ? ? ? ? ? spear_rtc_disable_interrupt(config);
> + ? ? ? ? ? ? ? clk_disable(config->clk);
> + ? ? ? }
> +
> + ? ? ? return 0;
> +}
> +
> +static int spear_rtc_resume(struct platform_device *pdev)
> +{
> + ? ? ? struct rtc_device *rtc = platform_get_drvdata(pdev);
> + ? ? ? struct spear_rtc_config *config = dev_get_drvdata(&rtc->dev);
> + ? ? ? int irq;
> +
> + ? ? ? irq = platform_get_irq(pdev, 0);
> +
> + ? ? ? if (device_may_wakeup(&pdev->dev))
> + ? ? ? ? ? ? ? disable_irq_wake(irq);
> + ? ? ? else {
> + ? ? ? ? ? ? ? clk_enable(config->clk);
> + ? ? ? ? ? ? ? spear_rtc_enable_interrupt(config);
> + ? ? ? }
> +
> + ? ? ? return 0;
> +}
> +
> +#else
> +#define spear_rtc_suspend ? ? ?NULL
> +#define spear_rtc_resume ? ? ? NULL
> +#endif
> +
> +static void spear_rtc_shutdown(struct platform_device *pdev)
> +{
> + ? ? ? struct rtc_device *rtc = platform_get_drvdata(pdev);
> + ? ? ? struct spear_rtc_config *config = dev_get_drvdata(&rtc->dev);
> +
> + ? ? ? spear_rtc_disable_interrupt(config);
> + ? ? ? clk_disable(config->clk);
> +}
> +
> +static struct platform_driver spear_rtc_driver = {
> + ? ? ? .probe = spear_rtc_probe,
> + ? ? ? .remove = __devexit_p(spear_rtc_remove),
> + ? ? ? .suspend = spear_rtc_suspend,
> + ? ? ? .resume = spear_rtc_resume,
> + ? ? ? .shutdown = spear_rtc_shutdown,
> + ? ? ? .driver = {
> + ? ? ? ? ? ? ? .name = "rtc-spear",
> + ? ? ? ? ? ? ? .owner = THIS_MODULE,
> + ? ? ? },
> +};
> +
> +static int __init rtc_init(void)
> +{
> + ? ? ? return platform_driver_register(&spear_rtc_driver);
> +}
> +module_init(rtc_init);
> +
> +static void __exit rtc_exit(void)
> +{
> + ? ? ? platform_driver_unregister(&spear_rtc_driver);
> +}
> +module_exit(rtc_exit);
> +
> +MODULE_ALIAS("rtc-spear");
> +MODULE_AUTHOR("Rajeev Kumar");
> +MODULE_LICENSE("GPL");
> --
> 1.7.2.2
>
> --
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
