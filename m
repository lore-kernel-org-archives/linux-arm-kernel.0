From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 14 Jan 2015 00:02:46 +0100
Subject: [PATCH 2/4] drivers/rtc/rtc-armada38x: Add a new RTC driver for
 recent mvebu SoCs
References: <1420817565-28800-1-git-send-email-gregory.clement@free-electrons.com>
 <1420817565-28800-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <87bnm2i8rt.fsf@natisbad.org>
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
>  drivers/rtc/rtc-armada38x.c | 305 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 316 insertions(+)
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
> index 000000000000..06202dcf8001
> --- /dev/null
> +++ b/drivers/rtc/rtc-armada38x.c
> @@ -0,0 +1,305 @@
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

out of curiosity, why use a spinlock and not a mutex?


> +	int		    irq;
> +};
> +
> +/*
> + * According to the datasheet, we need to wait for 5us between each
> + * write
> + */
> +static void rtc_delayed_write(u32 val, struct armada38x_rtc *rtc, int offset)
> +{
> +	writel(val, rtc->regs + offset);
> +	udelay(5);
> +}

In the remaining of the driver, you have various direct calls to writel()
w/o that 5?s protection, to update/modifiy rtc registers. Is that 5?s
trick specific to a given subpart of the registers? In that case, I
guess it would help to update the comment.


> +
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

Bear with me; I don't have access to HW ERRATA.

Are you guaranteed to get a valid value at third read if you got a bad
one before, i.e. no need to put a while loop around that workaround? 

Additionally, the workaround seems to be related to time
setting. Looking at time setting code below, it seems the issue is also
created by the fact the writel() call is not under the protection of the
spinlock.

> +
> +	spin_unlock_irqrestore(&rtc->lock, flags);
> +
> +	rtc_time_to_tm(time_check, tm);
> +
> +	return 0;

Does the block provide anyway to detect the oscillator was not running,
i.e. the value we are reading is not valid?


> +}
> +
> +static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
> +	int ret = 0;
> +	unsigned long time;
> +
> +	ret = rtc_tm_to_time(tm, &time);


> +
> +	if (ret)
> +		goto out;
> +	/*
> +	 * Setting the RTC time not always succeeds. According to the
> +	 * errata we need to first write on the status register and
> +	 * then wait for 1s before writing to the time register to be
> +	 * sure that the data will be taken into account.
> +	 */
> +	writel(0, rtc->regs + RTC_STATUS);
> +	ssleep(1);
> +
> +	writel(time, rtc->regs + RTC_TIME);

I think writel(time + 1, ...) would correct the one second shift you
introduce using you ssleep() above.

Additionally, as discussed above, I do not see why you're not protecting
the write using you spinlock.


> +
> +out:
> +	return ret;
> +}
> +
> +static int armada38x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
> +	unsigned long time, flags;
> +	u32 val;
> +
> +	spin_lock_irqsave(&rtc->lock, flags);
> +
> +	time = readl(rtc->regs + RTC_ALARM1);
> +	val = readl(rtc->regs + RTC_IRQ1_CONF) & RTC_IRQ1_AL_EN;
> +
> +	spin_unlock_irqrestore(&rtc->lock, flags);
> +
> +	alrm->enabled = val ? 1 : 0;
> +	rtc_time_to_tm(time,  &alrm->time);
> +
> +	return 0;
> +}
> +

In the two functions below, regarding RTC interrupt activation, do you
need a check that a valid IRQ was passed in the .dts and that
devm_request_irq() went ok in probe(), i.e. that rtc->irq > 0?

> +static int armada38x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
> +	unsigned long time, flags;
> +	int ret = 0;
> +	u32 val;
> +
> +	ret = rtc_tm_to_time(&alrm->time, &time);
> +
> +	if (ret)
> +		goto out;
> +
> +	spin_lock_irqsave(&rtc->lock, flags);
> +
> +	rtc_delayed_write(time, rtc, RTC_ALARM1);
> +
> +	if (alrm->enabled) {
> +			rtc_delayed_write(RTC_IRQ1_AL_EN , rtc, RTC_IRQ1_CONF);
> +			val = readl(rtc->regs_soc + SOC_RTC_INTERRUPT);
> +		writel(val | SOC_RTC_ALARM1_MASK,
> +			rtc->regs_soc + SOC_RTC_INTERRUPT);
> +	}
> +
> +	spin_unlock_irqrestore(&rtc->lock, flags);
> +
> +out:
> +	return ret;
> +}
> +
> +static int armada38x_rtc_alarm_irq_enable(struct device *dev,
> +					 unsigned int enabled)
> +{
> +	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&rtc->lock, flags);
> +
> +	if (enabled)
> +		writel(RTC_IRQ1_AL_EN, rtc->regs + RTC_IRQ1_CONF);
> +	else
> +		writel(0, rtc->regs + RTC_IRQ1_CONF);

I find the following more readable, but it is subjective:

writel(enabled ? RTC_IRQ1_AL_EN : 0, rtc->regs + RTC_IRQ1_CONF);


> +
> +	spin_unlock_irqrestore(&rtc->lock, flags);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t armada38x_rtc_alarm_irq(int irq, void *data)
> +{
> +	struct armada38x_rtc *rtc = data;
> +	u32 val;
> +	int event = RTC_IRQF | RTC_AF;
> +
> +	dev_dbg(&rtc->rtc_dev->dev, "%s:irq(%d)\n", __func__, irq);
> +	val = readl(rtc->regs_soc + SOC_RTC_INTERRUPT);
> +
> +	spin_lock(&rtc->lock);
> +
> +	writel(val & ~SOC_RTC_ALARM1, rtc->regs_soc + SOC_RTC_INTERRUPT);

Why not putting the readl() above under protection of the spinlock to
protect a change that could occur between the readl() and the writel()?


> +	val = readl(rtc->regs + RTC_IRQ1_CONF);
> +	/* disable all the interrupts for alarm 1 */
> +	rtc_delayed_write(0, rtc, RTC_IRQ1_CONF);
> +	/* Ack the event */
> +	writel(RTC_STATUS_ALARM1, rtc->regs + RTC_STATUS);
> +
> +	spin_unlock(&rtc->lock);
> +
> +	if (val & RTC_IRQ1_FREQ_EN) {
> +		if (val & RTC_IRQ1_FREQ_1HZ)
> +			event |= RTC_UF;
> +		else
> +			event |= RTC_PF;
> +	}
> +
> +	rtc_update_irq(rtc->rtc_dev, 1, event);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct rtc_class_ops armada38x_rtc_ops = {
> +	.read_time = armada38x_rtc_read_time,
> +	.set_time = armada38x_rtc_set_time,
> +	.read_alarm = armada38x_rtc_read_alarm,
> +	.set_alarm = armada38x_rtc_set_alarm,
> +	.alarm_irq_enable = armada38x_rtc_alarm_irq_enable,
> +};
> +
> +static __init int armada38x_rtc_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct armada38x_rtc *rtc;
> +	int ret;
> +
> +	rtc = devm_kzalloc(&pdev->dev, sizeof(struct armada38x_rtc),
> +			    GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&rtc->lock);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	rtc->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(rtc->regs))
> +		return PTR_ERR(rtc->regs);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	rtc->regs_soc = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(rtc->regs_soc))
> +		return PTR_ERR(rtc->regs_soc);
> +
> +	rtc->irq = platform_get_irq(pdev, 0);
> +
> +	if (rtc->irq < 0) {
> +		dev_err(&pdev->dev, "no irq\n");
> +		return rtc->irq;
> +	}
> +	if (devm_request_irq(&pdev->dev, rtc->irq, armada38x_rtc_alarm_irq,
> +				0, pdev->name, rtc) < 0) {
> +		dev_warn(&pdev->dev, "Interrupt not available.\n");
> +		rtc->irq = -1;
> +	}
> +	platform_set_drvdata(pdev, rtc);
> +
> +	device_init_wakeup(&pdev->dev, 1);

if devm_request_irq() returns an error, should device_init_wakeup() be
called? See comment below under armada38x_rtc_suspend().

> +	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
> +					&armada38x_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(rtc->rtc_dev)) {
> +		ret = PTR_ERR(rtc->rtc_dev);
> +		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
> +		if (ret == 0)
> +			ret = -EINVAL;

I may be missing something but I do not see how ret can be 0 above
because the initial check uses IS_ERR() and not IS_ERR_OR_NULL().


> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int armada38x_rtc_suspend(struct device *dev)
> +{
> +	if (device_may_wakeup(dev)) {
> +		struct armada38x_rtc *rtc = dev_get_drvdata(dev);
> +
> +		return enable_irq_wake(rtc->irq);
> +	}

AFAICT, rtc->irq maybe -1 in the call above. You need to either call
device_init_wakeup() when devm_request_irq() succeed or check rtc->irq
is valid in the "if" above.

> +
> +	return 0;
> +}
> +
> +static int armada38x_rtc_resume(struct device *dev)
> +{
> +	if (device_may_wakeup(dev)) {
> +		struct armada38x_rtc *rtc = dev_get_drvdata(dev);
> +
> +		return disable_irq_wake(rtc->irq);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(armada38x_rtc_pm_ops,
> +			 armada38x_rtc_suspend, armada38x_rtc_resume);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id armada38x_rtc_of_match_table[] = {
> +	{ .compatible = "marvell,armada-380-rtc", },
> +	{}
> +};
> +#endif
> +
> +static struct platform_driver armada38x_rtc_driver = {
> +	.driver		= {
> +		.name	= "armada38x-rtc",
> +		.pm	= &armada38x_rtc_pm_ops,
> +		.of_match_table = of_match_ptr(armada38x_rtc_of_match_table),
> +	},
> +};
> +
> +module_platform_driver_probe(armada38x_rtc_driver, armada38x_rtc_probe);
> +
> +MODULE_DESCRIPTION("Marvell Armada 38x RTC driver");
> +MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
> +MODULE_LICENSE("GPL");
