From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 23 Feb 2015 13:50:44 -0800
Subject: [rtc-linux] [PATCH 2/2] rtc: mediatek: Add MT63xx RTC driver
In-Reply-To: <1422437276-41334-3-git-send-email-eddie.huang@mediatek.com>
References: <1422437276-41334-1-git-send-email-eddie.huang@mediatek.com>
 <1422437276-41334-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150223135044.108ea32a65063a50aa36a309@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Jan 2015 17:27:56 +0800 Eddie Huang <eddie.huang@mediatek.com> wrote:

> From: Tianping Fang <tianping.fang@mediatek.com>
> 
> Add Mediatek MT63xx RTC driver

There are a couple of checkpatch warnings which should be addressed,
please:

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#150: 
new file mode 100644

WARNING: DT compatible string "mediatek,mt6397-rtc" appears un-documented -- check ./Documentation/devicetree/bindings/
#488: FILE: drivers/rtc/rtc-mt6397.c:334:
+	{ .compatible = "mediatek,mt6397-rtc", },




>
> ...
>
> +static u16 rtc_read(struct mt6397_rtc *rtc, u32 offset)
> +{
> +	u32 rdata = 0;
> +	u32 addr = rtc->addr_base + offset;
> +
> +	if (offset < rtc->addr_range)
> +		regmap_read(rtc->regmap, addr, &rdata);
> +
> +	return (u16)rdata;
> +}
> +
> +static void rtc_write(struct mt6397_rtc *rtc, u32 offset, u32 data)
> +{
> +	u32 addr;
> +
> +	addr = rtc->addr_base + offset;
> +
> +	if (offset < rtc->addr_range)
> +		regmap_write(rtc->regmap, addr, data);
> +}

regmap_read() and regmap_write() can return errors.  There is no
checking for this.

> +static void rtc_write_trigger(struct mt6397_rtc *rtc)
> +{
> +	rtc_write(rtc, RTC_WRTGR, 1);
> +	while (rtc_read(rtc, RTC_BBPU) & RTC_BBPU_CBUSY)
> +		cpu_relax();
> +}
> +
>
> ...
>
> +static int mtk_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
> +{
> +	struct rtc_time *tm = &alm->time;
> +	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> +	u16 irqen, pdn2;
> +
> +	mutex_lock(&rtc->lock);
> +	irqen = rtc_read(rtc, RTC_IRQ_EN);
> +	pdn2 = rtc_read(rtc, RTC_PDN2);
> +	tm->tm_sec  = rtc_read(rtc, RTC_AL_SEC);
> +	tm->tm_min  = rtc_read(rtc, RTC_AL_MIN);
> +	tm->tm_hour = rtc_read(rtc, RTC_AL_HOU) & RTC_AL_HOU_MASK;
> +	tm->tm_mday = rtc_read(rtc, RTC_AL_DOM) & RTC_AL_DOM_MASK;
> +	tm->tm_mon  = rtc_read(rtc, RTC_AL_MTH) & RTC_AL_MTH_MASK;
> +	tm->tm_year = rtc_read(rtc, RTC_AL_YEA);
> +	mutex_unlock(&rtc->lock);
> +
> +	alm->enabled = !!(irqen & RTC_IRQ_EN_AL);
> +	alm->pending = !!(pdn2 & RTC_PDN2_PWRON_ALARM);
> +
> +	tm->tm_year += RTC_MIN_YEAR_OFFSET;
> +	tm->tm_mon--;
> +
> +	return 0;
> +}
> +
> +static int mtk_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
> +{
> +	struct rtc_time *tm = &alm->time;
> +	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> +	u16 irqen;
> +
> +	tm->tm_year -= RTC_MIN_YEAR_OFFSET;
> +	tm->tm_mon++;
> +
> +	if (alm->enabled) {
> +		mutex_lock(&rtc->lock);
> +		rtc_write(rtc, RTC_AL_YEA, tm->tm_year);
> +		rtc_write(rtc, RTC_AL_MTH, (rtc_read(rtc, RTC_AL_MTH) &
> +				RTC_NEW_SPARE3) | tm->tm_mon);
> +		rtc_write(rtc, RTC_AL_DOM, (rtc_read(rtc, RTC_AL_DOM) &
> +				RTC_NEW_SPARE1) | tm->tm_mday);
> +		rtc_write(rtc, RTC_AL_HOU, (rtc_read(rtc, RTC_AL_HOU) &
> +				RTC_NEW_SPARE_FG_MASK) | tm->tm_hour);
> +		rtc_write(rtc, RTC_AL_MIN, tm->tm_min);
> +		rtc_write(rtc, RTC_AL_SEC, tm->tm_sec);
> +		rtc_write(rtc, RTC_AL_MASK, RTC_AL_MASK_DOW);
> +		rtc_write_trigger(rtc);
> +		irqen = rtc_read(rtc, RTC_IRQ_EN) | RTC_IRQ_EN_ONESHOT_AL;
> +		rtc_write(rtc, RTC_IRQ_EN, irqen);
> +		rtc_write_trigger(rtc);
> +		mutex_unlock(&rtc->lock);
> +	}
> +
> +	return 0;
> +}

This all looks a bit racy.  Wouldn't it be better if the testing of and
modification of ->enabled and ->pending were protected by the mutex?

>
> ...
>
> +static int mtk_rtc_probe(struct platform_device *pdev)
> +{
> +	struct mt6397_chip *mt6397_chip = dev_get_drvdata(pdev->dev.parent);
> +	struct mt6397_rtc *rtc;
> +	u32 reg[2];
> +	int ret = 0;
> +
> +	rtc = devm_kzalloc(&pdev->dev, sizeof(struct mt6397_rtc), GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32_array(pdev->dev.of_node, "reg", reg, 2);
> +	if (ret) {
> +		dev_err(&pdev->dev, "couldn't read rtc base address!\n");
> +		return -EINVAL;
> +	}
> +	rtc->addr_base = reg[0];
> +	rtc->addr_range = reg[1];
> +	rtc->regmap = mt6397_chip->regmap;
> +	rtc->dev = &pdev->dev;
> +	mutex_init(&rtc->lock);
> +
> +	platform_set_drvdata(pdev, rtc);
> +
> +	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
> +				&mtk_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(rtc->rtc_dev)) {
> +		dev_err(&pdev->dev, "register rtc device failed\n");
> +		return PTR_ERR(rtc->rtc_dev);
> +	}
> +
> +	rtc->irq = platform_get_irq(pdev, 0);
> +	if (rtc->irq < 0) {
> +		ret = rtc->irq;
> +		goto out_rtc;
> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
> +			rtc_irq_handler_thread, IRQF_ONESHOT,
> +			"mt6397-rtc", rtc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
> +			rtc->irq, ret);
> +		goto out_rtc;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, 1);
> +
> +	return 0;
> +
> +out_rtc:
> +	rtc_device_unregister(rtc->rtc_dev);
> +	return ret;
> +
> +}

It seems strange to request the IRQ after having registered the rtc. 
And possibly racy - I seem to recall another driver having issues with
this recently.

A lot of rtc drivers are requesting the IRQ after registration so
presumably it isn't a huge problem.  But still, wouldn't it be better
to defer registration until after the IRQ has been successfully
obtained?

>
> ...
>
