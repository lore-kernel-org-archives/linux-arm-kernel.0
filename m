From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 16 Mar 2015 16:30:48 +0100
Subject: [PATCH 2/2] rtc: mediatek: Add MT63xx RTC driver
In-Reply-To: <1422437276-41334-3-git-send-email-eddie.huang@mediatek.com>
References: <1422437276-41334-1-git-send-email-eddie.huang@mediatek.com>
 <1422437276-41334-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150316153048.GC10068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eddie,

On Wed, Jan 28, 2015 at 05:27:56PM +0800, Eddie Huang wrote:
> From: Tianping Fang <tianping.fang@mediatek.com>
> 
> Add Mediatek MT63xx RTC driver
MT6397?

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index f15cddf..8ac52d8 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1427,6 +1427,16 @@ config RTC_DRV_MOXART
>  	   This driver can also be built as a module. If so, the module
>  	   will be called rtc-moxart
>  
> +config RTC_DRV_MT63XX
> +	tristate "Mediatek Real Time Clock driver"
> +	depends on MFD_MT6397
I suggest:

	depends on MFD_MT6397 || COMPILE_TEST

(maybe + any hard dependencies you need for compilation).

> +	help
> +	  This selects the Mediatek(R) RTC driver, you should add support
> +	  for Mediatek MT6397 PMIC before select Mediatek(R) RTC driver.
> +
> +	  If you want to use Mediatek(R) RTC interface, select Y or M here.
> +	  If unsure, Please select N.
Given the dependency above I'd say choosing y here is fine. Instead of
recommending that I'd just drop this line.

> [...]
> +static u16 rtc_read(struct mt6397_rtc *rtc, u32 offset)
rtc_read is a bad name for a driver. There are already 6 functions with
this name in the kernel. Better use a unique prefix.

> [...]
> +static irqreturn_t rtc_irq_handler_thread(int irq, void *data)
> +{
> +	struct mt6397_rtc *rtc = data;
> +	u16 irqsta, irqen;
> +
> +	mutex_lock(&rtc->lock);
> +	irqsta = rtc_read(rtc, RTC_IRQ_STA);
Do you really need to lock for a single read access?

> +	mutex_unlock(&rtc->lock);
> +
> +	if (irqsta & RTC_IRQ_STA_AL) {
> +		rtc_update_irq(rtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
> +		irqen = irqsta & ~RTC_IRQ_EN_AL;
> +		rtc_write(rtc, RTC_IRQ_EN, irqen);
> +		rtc_write_trigger(rtc);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static int mtk_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	unsigned long time;
> +	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> +
> +	mutex_lock(&rtc->lock);
> +	do {
> +		tm->tm_sec = rtc_read(rtc, RTC_TC_SEC);
> +		tm->tm_min = rtc_read(rtc, RTC_TC_MIN);
> +		tm->tm_hour = rtc_read(rtc, RTC_TC_HOU);
> +		tm->tm_mday = rtc_read(rtc, RTC_TC_DOM);
> +		tm->tm_mon = rtc_read(rtc, RTC_TC_MTH);
> +		tm->tm_year = rtc_read(rtc, RTC_TC_YEA);
> +	} while (rtc_read(rtc, RTC_TC_SEC) < tm->tm_sec);
> +	mutex_unlock(&rtc->lock);
> +
> +	tm->tm_year += RTC_MIN_YEAR_OFFSET;
> +	tm->tm_mon--;
> +	rtc_tm_to_time(tm, &time);
rtc_tm_to_time is deprecated, better use rtc_tm_to_time64.

> +	tm->tm_wday = (time / 86400 + 4) % 7;
> +
> +	return 0;
> +}
> +
> +static int mtk_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> +
> +	tm->tm_year -= RTC_MIN_YEAR_OFFSET;
> +	tm->tm_mon++;
> +	mutex_lock(&rtc->lock);
> +	rtc_write(rtc, RTC_TC_YEA, tm->tm_year);
> +	rtc_write(rtc, RTC_TC_MTH, tm->tm_mon);
> +	rtc_write(rtc, RTC_TC_DOM, tm->tm_mday);
> +	rtc_write(rtc, RTC_TC_HOU, tm->tm_hour);
> +	rtc_write(rtc, RTC_TC_MIN, tm->tm_min);
> +	rtc_write(rtc, RTC_TC_SEC, tm->tm_sec);
Is this racy? I.e. what happens if RTC_TC_SEC overflows just before you
write to it but after you wrote RTC_TC_MIN?

> +	rtc_write_trigger(rtc);
> +	mutex_unlock(&rtc->lock);
> +
> +	return 0;
> +}
> +
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
This looks strange. Why doesn't RTC_NEW_SPARE3 contain the register
name? I would have expected:

	(rtc_read(rtc, RTC_AL_MTH) & ~RTC_AL_MTH_MASK) | tm->tm_mon;


> +		rtc_write(rtc, RTC_AL_DOM, (rtc_read(rtc, RTC_AL_DOM) &
> +				RTC_NEW_SPARE1) | tm->tm_mday);
> +		rtc_write(rtc, RTC_AL_HOU, (rtc_read(rtc, RTC_AL_HOU) &
> +				RTC_NEW_SPARE_FG_MASK) | tm->tm_hour);
> +		rtc_write(rtc, RTC_AL_MIN, tm->tm_min);
> +		rtc_write(rtc, RTC_AL_SEC, tm->tm_sec);
> +		rtc_write(rtc, RTC_AL_MASK, RTC_AL_MASK_DOW);
Is this racy? I.e. if the previous set alarm is

	2015-03-13 14:15:00

and you write

	2015-03.14 17:17:00

is it possible that this triggers an alarm if the update happens at

	2015-03-14 14:15:00

?

> +		rtc_write_trigger(rtc);
> +		irqen = rtc_read(rtc, RTC_IRQ_EN) | RTC_IRQ_EN_ONESHOT_AL;
> +		rtc_write(rtc, RTC_IRQ_EN, irqen);
> +		rtc_write_trigger(rtc);
> +		mutex_unlock(&rtc->lock);
	} else {
		/* disable alarm here */

> +	}
> +
> +	return 0;
> +}
> +
> +static struct rtc_class_ops mtk_rtc_ops = {
> +	.read_time  = mtk_rtc_read_time,
> +	.set_time   = mtk_rtc_set_time,
> +	.read_alarm = mtk_rtc_read_alarm,
> +	.set_alarm  = mtk_rtc_set_alarm,
> +};
> +
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
This looks strange, but maybe that's right as you reuse the parent's
regmap.

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
platform_get_irq(pdev, 0) = 0 should be treated as error, too.

> +		ret = rtc->irq;
> +		goto out_rtc;
> +	}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
