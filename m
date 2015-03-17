From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 17 Mar 2015 20:31:14 +0800
Subject: [PATCH 2/2] rtc: mediatek: Add MT63xx RTC driver
In-Reply-To: <20150316153048.GC10068@pengutronix.de>
References: <1422437276-41334-1-git-send-email-eddie.huang@mediatek.com>
 <1422437276-41334-3-git-send-email-eddie.huang@mediatek.com>
 <20150316153048.GC10068@pengutronix.de>
Message-ID: <1426595474.24415.18.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Thanks your review.

On Mon, 2015-03-16 at 16:30 +0100, Uwe Kleine-K?nig wrote:
> Hello Eddie,
> 
> On Wed, Jan 28, 2015 at 05:27:56PM +0800, Eddie Huang wrote:
> > From: Tianping Fang <tianping.fang@mediatek.com>
> > 
> > Add Mediatek MT63xx RTC driver
> MT6397?

Yes, it is better to use MT6397

> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index f15cddf..8ac52d8 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -1427,6 +1427,16 @@ config RTC_DRV_MOXART
> >  	   This driver can also be built as a module. If so, the module
> >  	   will be called rtc-moxart
> >  
> > +config RTC_DRV_MT63XX
> > +	tristate "Mediatek Real Time Clock driver"
> > +	depends on MFD_MT6397
> I suggest:
> 
> 	depends on MFD_MT6397 || COMPILE_TEST
> 
> (maybe + any hard dependencies you need for compilation).

OK, will fix it

> 
> > +	help
> > +	  This selects the Mediatek(R) RTC driver, you should add support
> > +	  for Mediatek MT6397 PMIC before select Mediatek(R) RTC driver.
> > +
> > +	  If you want to use Mediatek(R) RTC interface, select Y or M here.
> > +	  If unsure, Please select N.
> Given the dependency above I'd say choosing y here is fine. Instead of
> recommending that I'd just drop this line.

ok, will drop.

> 
> > [...]
> > +static u16 rtc_read(struct mt6397_rtc *rtc, u32 offset)
> rtc_read is a bad name for a driver. There are already 6 functions with
> this name in the kernel. Better use a unique prefix.

I will use prefix mtk_

> 
> > [...]
> > +static irqreturn_t rtc_irq_handler_thread(int irq, void *data)
> > +{
> > +	struct mt6397_rtc *rtc = data;
> > +	u16 irqsta, irqen;
> > +
> > +	mutex_lock(&rtc->lock);
> > +	irqsta = rtc_read(rtc, RTC_IRQ_STA);
> Do you really need to lock for a single read access?

I think this lock is necessary, because other thread may access rtc
register at the same time, for example, call mtk_rtc_set_alarm to modify
alarm time.

> 
> > +	mutex_unlock(&rtc->lock);
> > +
> > +	if (irqsta & RTC_IRQ_STA_AL) {
> > +		rtc_update_irq(rtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
> > +		irqen = irqsta & ~RTC_IRQ_EN_AL;
> > +		rtc_write(rtc, RTC_IRQ_EN, irqen);
> > +		rtc_write_trigger(rtc);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	return IRQ_NONE;
> > +}
> > +
> > +static int mtk_rtc_read_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	unsigned long time;
> > +	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> > +
> > +	mutex_lock(&rtc->lock);
> > +	do {
> > +		tm->tm_sec = rtc_read(rtc, RTC_TC_SEC);
> > +		tm->tm_min = rtc_read(rtc, RTC_TC_MIN);
> > +		tm->tm_hour = rtc_read(rtc, RTC_TC_HOU);
> > +		tm->tm_mday = rtc_read(rtc, RTC_TC_DOM);
> > +		tm->tm_mon = rtc_read(rtc, RTC_TC_MTH);
> > +		tm->tm_year = rtc_read(rtc, RTC_TC_YEA);
> > +	} while (rtc_read(rtc, RTC_TC_SEC) < tm->tm_sec);
> > +	mutex_unlock(&rtc->lock);
> > +
> > +	tm->tm_year += RTC_MIN_YEAR_OFFSET;
> > +	tm->tm_mon--;
> > +	rtc_tm_to_time(tm, &time);
> rtc_tm_to_time is deprecated, better use rtc_tm_to_time64.

OK, will change to rtc_tm_to_time64

> 
> > +	tm->tm_wday = (time / 86400 + 4) % 7;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_rtc_set_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> > +
> > +	tm->tm_year -= RTC_MIN_YEAR_OFFSET;
> > +	tm->tm_mon++;
> > +	mutex_lock(&rtc->lock);
> > +	rtc_write(rtc, RTC_TC_YEA, tm->tm_year);
> > +	rtc_write(rtc, RTC_TC_MTH, tm->tm_mon);
> > +	rtc_write(rtc, RTC_TC_DOM, tm->tm_mday);
> > +	rtc_write(rtc, RTC_TC_HOU, tm->tm_hour);
> > +	rtc_write(rtc, RTC_TC_MIN, tm->tm_min);
> > +	rtc_write(rtc, RTC_TC_SEC, tm->tm_sec);
> Is this racy? I.e. what happens if RTC_TC_SEC overflows just before you
> write to it but after you wrote RTC_TC_MIN?

register value will write to hardware after rtc_write_trigger, so the
racy condition not exist.

> 
> > +	rtc_write_trigger(rtc);
> > +	mutex_unlock(&rtc->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
> > +{
> > +	struct rtc_time *tm = &alm->time;
> > +	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> > +	u16 irqen, pdn2;
> > +
> > +	mutex_lock(&rtc->lock);
> > +	irqen = rtc_read(rtc, RTC_IRQ_EN);
> > +	pdn2 = rtc_read(rtc, RTC_PDN2);
> > +	tm->tm_sec  = rtc_read(rtc, RTC_AL_SEC);
> > +	tm->tm_min  = rtc_read(rtc, RTC_AL_MIN);
> > +	tm->tm_hour = rtc_read(rtc, RTC_AL_HOU) & RTC_AL_HOU_MASK;
> > +	tm->tm_mday = rtc_read(rtc, RTC_AL_DOM) & RTC_AL_DOM_MASK;
> > +	tm->tm_mon  = rtc_read(rtc, RTC_AL_MTH) & RTC_AL_MTH_MASK;
> > +	tm->tm_year = rtc_read(rtc, RTC_AL_YEA);
> > +	mutex_unlock(&rtc->lock);
> > +
> > +	alm->enabled = !!(irqen & RTC_IRQ_EN_AL);
> > +	alm->pending = !!(pdn2 & RTC_PDN2_PWRON_ALARM);
> > +
> > +	tm->tm_year += RTC_MIN_YEAR_OFFSET;
> > +	tm->tm_mon--;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
> > +{
> > +	struct rtc_time *tm = &alm->time;
> > +	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> > +	u16 irqen;
> > +
> > +	tm->tm_year -= RTC_MIN_YEAR_OFFSET;
> > +	tm->tm_mon++;
> > +
> > +	if (alm->enabled) {
> > +		mutex_lock(&rtc->lock);
> > +		rtc_write(rtc, RTC_AL_YEA, tm->tm_year);
> > +		rtc_write(rtc, RTC_AL_MTH, (rtc_read(rtc, RTC_AL_MTH) &
> > +				RTC_NEW_SPARE3) | tm->tm_mon);
> This looks strange. Why doesn't RTC_NEW_SPARE3 contain the register
> name? I would have expected:
> 
> 	(rtc_read(rtc, RTC_AL_MTH) & ~RTC_AL_MTH_MASK) | tm->tm_mon;

I will remove RTC_NEW_SPARE3. Hardware will return 0 if register bit is
useless. So the bit clear is redundant. 

> 
> > +		rtc_write(rtc, RTC_AL_DOM, (rtc_read(rtc, RTC_AL_DOM) &
> > +				RTC_NEW_SPARE1) | tm->tm_mday);
> > +		rtc_write(rtc, RTC_AL_HOU, (rtc_read(rtc, RTC_AL_HOU) &
> > +				RTC_NEW_SPARE_FG_MASK) | tm->tm_hour);
> > +		rtc_write(rtc, RTC_AL_MIN, tm->tm_min);
> > +		rtc_write(rtc, RTC_AL_SEC, tm->tm_sec);
> > +		rtc_write(rtc, RTC_AL_MASK, RTC_AL_MASK_DOW);
> Is this racy? I.e. if the previous set alarm is
> 
> 	2015-03-13 14:15:00
> 
> and you write
> 
> 	2015-03.14 17:17:00
> 
> is it possible that this triggers an alarm if the update happens at
> 
> 	2015-03-14 14:15:00
> 
> ?
> 
All rtc register value write to RTC hardware after rtc_write_trigger.
Race condition should not happen. 


> > +		rtc_write_trigger(rtc);
> > +		irqen = rtc_read(rtc, RTC_IRQ_EN) | RTC_IRQ_EN_ONESHOT_AL;
> > +		rtc_write(rtc, RTC_IRQ_EN, irqen);
> > +		rtc_write_trigger(rtc);
> > +		mutex_unlock(&rtc->lock);
> 	} else {
> 		/* disable alarm here */
> 
OK, should clear RTC_IRQ_EN

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct rtc_class_ops mtk_rtc_ops = {
> > +	.read_time  = mtk_rtc_read_time,
> > +	.set_time   = mtk_rtc_set_time,
> > +	.read_alarm = mtk_rtc_read_alarm,
> > +	.set_alarm  = mtk_rtc_set_alarm,
> > +};
> > +
> > +static int mtk_rtc_probe(struct platform_device *pdev)
> > +{
> > +	struct mt6397_chip *mt6397_chip = dev_get_drvdata(pdev->dev.parent);
> > +	struct mt6397_rtc *rtc;
> > +	u32 reg[2];
> > +	int ret = 0;
> > +
> > +	rtc = devm_kzalloc(&pdev->dev, sizeof(struct mt6397_rtc), GFP_KERNEL);
> > +	if (!rtc)
> > +		return -ENOMEM;
> > +
> > +	ret = of_property_read_u32_array(pdev->dev.of_node, "reg", reg, 2);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "couldn't read rtc base address!\n");
> > +		return -EINVAL;
> > +	}
> > +	rtc->addr_base = reg[0];
> > +	rtc->addr_range = reg[1];
> This looks strange, but maybe that's right as you reuse the parent's
> regmap.

According Sascha and Mark Brown's discussion:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/323239.html

Address and interrupt will move from device tree to mfd_cell in
mt6397-core.c

> 
> > +	rtc->regmap = mt6397_chip->regmap;
> > +	rtc->dev = &pdev->dev;
> > +	mutex_init(&rtc->lock);
> > +
> > +	platform_set_drvdata(pdev, rtc);
> > +
> > +	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
> > +				&mtk_rtc_ops, THIS_MODULE);
> > +	if (IS_ERR(rtc->rtc_dev)) {
> > +		dev_err(&pdev->dev, "register rtc device failed\n");
> > +		return PTR_ERR(rtc->rtc_dev);
> > +	}
> > +
> > +	rtc->irq = platform_get_irq(pdev, 0);
> > +	if (rtc->irq < 0) {
> platform_get_irq(pdev, 0) = 0 should be treated as error, too.

OK, will fix it

> 
> > +		ret = rtc->irq;
> > +		goto out_rtc;
> > +	}
> 
> Best regards
> Uwe
> 
