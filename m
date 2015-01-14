From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 14 Jan 2015 21:55:39 +0100
Subject: [PATCH v2 2/5] drivers/rtc/rtc-armada38x: Add a new RTC driver
 for recent mvebu SoCs
References: <1421257155-3379-1-git-send-email-gregory.clement@free-electrons.com>
 <1421257155-3379-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <871tmxrsj8.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> The new mvebu SoCs come with a new RTC driver. This patch adds the
> support for this new IP which is currently found in the Armada 38x
> SoCs.
>
> This RTC provides two alarms, but only the first one is used in the
> driver. The RTC also allows using periodic interrupts.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/rtc/Kconfig         |  10 ++
>  drivers/rtc/Makefile        |   1 +
>  drivers/rtc/rtc-armada38x.c | 319 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 330 insertions(+)
>  create mode 100644 drivers/rtc/rtc-armada38x.c
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index f15cddfeb897..de42ebd4b626 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1269,6 +1269,16 @@ config RTC_DRV_MV
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-mv.
>  
> +config RTC_DRV_ARMADA38X
> +	tristate "Armada 38x Marvell SoC RTC"
> +	depends on ARCH_MVEBU
> +	help
> +	  If you say yes here you will get support for the in-chip RTC
> +	  that can be found in the Armada 38x Marvell's SoC device
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called armada38x-rtc.
> +
>  config RTC_DRV_PS3
>  	tristate "PS3 RTC"
>  	depends on PPC_PS3
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index c8ef3e1e6ccd..03fe5629c464 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_RTC_DRV_88PM860X)  += rtc-88pm860x.o
>  obj-$(CONFIG_RTC_DRV_88PM80X)	+= rtc-88pm80x.o
>  obj-$(CONFIG_RTC_DRV_AB3100)	+= rtc-ab3100.o
>  obj-$(CONFIG_RTC_DRV_AB8500)	+= rtc-ab8500.o
> +obj-$(CONFIG_RTC_DRV_ARMADA38X)	+= rtc-armada38x.o
>  obj-$(CONFIG_RTC_DRV_AS3722)	+= rtc-as3722.o
>  obj-$(CONFIG_RTC_DRV_AT32AP700X)+= rtc-at32ap700x.o
>  obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
> diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
> new file mode 100644
> index 000000000000..30bae27e828c
> --- /dev/null
> +++ b/drivers/rtc/rtc-armada38x.c
> @@ -0,0 +1,319 @@
> +/*
> + * RTC driver for the Armada 38x Marvell SoCs
> + *
> + * Copyright (C) 2015 Marvell
> + *
> + * Gregory Clement <gregory.clement@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +
> +#define RTC_STATUS	    0x0
> +#define RTC_STATUS_ALARM1	    BIT(0)
> +#define RTC_STATUS_ALARM2	    BIT(1)
> +#define RTC_IRQ1_CONF	    0x4
> +#define RTC_IRQ1_AL_EN		    BIT(0)
> +#define RTC_IRQ1_FREQ_EN	    BIT(1)
> +#define RTC_IRQ1_FREQ_1HZ	    BIT(2)
> +#define RTC_TIME	    0xC
> +#define RTC_ALARM1	    0x10
> +
> +#define SOC_RTC_INTERRUPT   0x8
> +#define SOC_RTC_ALARM1		BIT(0)
> +#define SOC_RTC_ALARM2		BIT(1)
> +#define SOC_RTC_ALARM1_MASK	BIT(2)
> +#define SOC_RTC_ALARM2_MASK	BIT(3)
> +
> +struct armada38x_rtc {
> +	struct rtc_device   *rtc_dev;
> +	void __iomem	    *regs;
> +	void __iomem	    *regs_soc;
> +	spinlock_t	    lock;
> +	int		    irq;
> +};
> +
> +/*
> + * According to the datasheet, we need to wait for 5us only between
> + * two consecutive writes
> + */
> +static void rtc_delayed_write(u32 val, struct armada38x_rtc *rtc, int offset)
> +{
> +	writel(val, rtc->regs + offset);
> +	udelay(5);
> +}

The thing I do not get is how you can guarantee that an undelayed
writel() in a function will not be followed less than 5?s later by
another writel() in another function. For instance:

  1) a call to set_alarm() followed by a call to alarm_irq_enable().
  2) some writel() or even rtc_udelayed_write() w/ sth asynchronous
    occuring like your interrupt handler just after that.

I guess it may be possible to make assumptions on the fact that the
amount of code before a writel() or rtc_udelayed_write() may prevent
such scenario but it's difficult to tell, all the more w/ a spinlock
before the writel() in irq_enable().

Considering the description of the bug, why not doing the following:

 1) implement rtc_delayed_write() a bit differently:

    static inline void rtc_delayed_write(u32 val, struct armada38x_rtc *rtc, int offset)
    {
	udelay(5);
	writel(val, rtc->regs + offset);
    }

 2) remove all writel() in the driver and use rtc_delayed_write()
    everywhere.

All writes being under the protection of your spinlock, this will
guarantee the 5?s delay in all cases.


> +static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
> +	unsigned long time, time_check, flags;
> +
> +	spin_lock_irqsave(&rtc->lock, flags);
> +
> +	time = readl(rtc->regs + RTC_TIME);
> +	/*
> +	 * WA for failing time set attempts. As stated in HW ERRATA if
> +	 * more than one second between two time reads is detected
> +	 * then read once again.
> +	 */
> +	time_check = readl(rtc->regs + RTC_TIME);
> +	if ((time_check - time) > 1)
> +		time_check = readl(rtc->regs + RTC_TIME);
> +
> +	spin_unlock_irqrestore(&rtc->lock, flags);
> +
> +	rtc_time_to_tm(time_check, tm);
> +
> +	return 0;
> +}
> +
> +static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
> +	int ret = 0;
> +	unsigned long time, flags;
> +
> +	ret = rtc_tm_to_time(tm, &time);
> +
> +	if (ret)
> +		goto out;
> +	/*
> +	 * Setting the RTC time not always succeeds. According to the
> +	 * errata we need to first write on the status register and
> +	 * then wait for 100ms before writing to the time register to be
> +	 * sure that the data will be taken into account.
> +	 */
> +	spin_lock_irqsave(&rtc->lock, flags);
> +
> +	writel(0, rtc->regs + RTC_STATUS);
> +
> +	spin_unlock_irqrestore(&rtc->lock, flags);
> +
> +	msleep(100);
> +
> +	spin_lock_irqsave(&rtc->lock, flags);
> +
> +	writel(time, rtc->regs + RTC_TIME);

probably not critical (it's rtc clock and not system clock) but you still
introduce a 100ms shift when setting time here.

As for the two writel() not being done w/o releasing the spinlock, it
looks a bit weird but it seems it's ok for other functions manipulating
RTC_STATUS reg. 

Nonetheless, in the reverse direction, if a writel() occurs somewhere
(e.g. in the alarm irq handler) during your msleep(), you may do your
final writel() w/o having enforced the expected 100ms delay.


> [SNIP]
>
