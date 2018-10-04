From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 4 Oct 2018 20:37:00 +0200
Subject: [PATCH 1/2] rtc: Add ASPEED RTC driver
In-Reply-To: <20181003133155.27494-2-joel@jms.id.au>
References: <20181003133155.27494-1-joel@jms.id.au>
 <20181003133155.27494-2-joel@jms.id.au>
Message-ID: <20181004183700.GA5626@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 03/10/2018 15:31:54+0200, Joel Stanley wrote:
> +static int aspeed_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct aspeed_rtc *rtc = dev_get_drvdata(dev);
> +	unsigned int cent, year, mon, day, hour, min, sec;
> +	unsigned long flags;
> +	u32 reg1, reg2;
> +
> +	spin_lock_irqsave(&rtc->lock, flags);
> +
> +	do {
> +		reg2 = readl(rtc->base + RTC_YEAR);
> +		reg1 = readl(rtc->base + RTC_TIME);
> +	} while (reg2 != readl(rtc->base + RTC_YEAR));
> +
> +	day  = (reg1 >> 24) & 0x1f;
> +	hour = (reg1 >> 16) & 0x1f;
> +	min  = (reg1 >>  8) & 0x3f;
> +	sec  = (reg1 >>  0) & 0x3f;
> +	cent = (reg2 >> 16) & 0x1f;
> +	year = (reg2 >>  8) & 0x7f;
> +	/*
> +	 * Month is 1-12 in hardware, and 0-11 in struct rtc_time, however we
> +	 * are using mktime64 which is 1-12, so no adjustment is necessary
> +	 */
> +	mon  = (reg2 >>  0) & 0x0f;
> +
> +	rtc_time64_to_tm(mktime64(cent * 100 + year, mon, day, hour, min, sec),
> +			tm);
> +

This is quite wasteful. You already have the broken out time. Why don't
you directly fill the tm struct?

> +static int aspeed_rtc_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct aspeed_rtc *rtc;
> +
> +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	rtc->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(rtc->base))
> +		return PTR_ERR(rtc->base);
> +
> +	platform_set_drvdata(pdev, rtc);
> +
> +	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
> +						&aspeed_rtc_ops, THIS_MODULE);
> +

Please use devm_rtc_allocate_device to allocate the rtc and then
register it with rtc_register_device. Please also fill
rtc->range_{min,max} before the registration.

> +	if (IS_ERR(rtc->rtc_dev))
> +		return PTR_ERR(rtc->rtc_dev);
> +
> +	spin_lock_init(&rtc->lock);
> +
> +	/* Enable RTC and clear the unlock bit */
> +	writel(RTC_ENABLE, rtc->base + RTC_CTRL);
> +

Maybe this should only be done in set_time so you can know whether the
time that is read in read_time has a chance to be valid.

For example you could return -EINVAL when RTC_ENABLE is not set if this
bit is readable.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
