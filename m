From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 31 Mar 2015 17:44:26 +0800
Subject: [PATCH v2 2/3] rtc: mediatek: Add MT6397 RTC driver
In-Reply-To: <CAAFQd5ADCaKhP=3BmJsVimvo-uXZB3pobVAUST-b5kU+98Rt+A@mail.gmail.com>
References: <1426657537-41414-1-git-send-email-eddie.huang@mediatek.com>
 <1426657537-41414-3-git-send-email-eddie.huang@mediatek.com>
 <CAAFQd5ADCaKhP=3BmJsVimvo-uXZB3pobVAUST-b5kU+98Rt+A@mail.gmail.com>
Message-ID: <1427795066.14023.64.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Mon, 2015-03-30 at 16:41 +0900, Tomasz Figa wrote:
> Hi Eddie,
> 
> Please see my comments inline.
> 
> On Wed, Mar 18, 2015 at 2:45 PM, Eddie Huang <eddie.huang@mediatek.com> wrote:
> > From: Tianping Fang <tianping.fang@mediatek.com>
> >
> > Add Mediatek MT6397 RTC driver
> 
> [snip]
> 
> > +#define RTC_BBPU               0x0000
> > +#define RTC_WRTGR              0x003c
> > +#define RTC_IRQ_EN             0x0004
> > +#define RTC_IRQ_STA            0x0002
> > +
> > +#define RTC_BBPU_CBUSY         (1 << 6)
> > +#define RTC_IRQ_STA_AL         (1 << 0)
> > +#define RTC_IRQ_STA_LP         (1 << 3)
> 
> nit: Could you use BIT() macro for definitions of single bits? (+
> further occurrences in the patch)
Will fix it.

> 
> [snip]
> 
> > +
> > +static int mtk_rtc_read(struct mt6397_rtc *rtc, u32 offset, u32 *data)
> > +{
> > +       u32 addr = rtc->addr_base + offset;
> > +
> > +       if (offset < rtc->addr_range)
> > +               return regmap_read(rtc->regmap, addr, data);
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +static int mtk_rtc_write(struct mt6397_rtc *rtc, u32 offset, u32 data)
> > +{
> > +       u32 addr;
> > +
> > +       addr = rtc->addr_base + offset;
> > +
> > +       if (offset < rtc->addr_range)
> > +               return regmap_write(rtc->regmap, addr, data);
> > +
> > +       return -EINVAL;
> > +}
> 
> Do you actually need these wrappers? Could you use regmap_write() and
> _read() directly? This would also enable you to use
> regmap_update_bits() instead of implicit read, modify and write.
These wrappers used to check register range. But I think the check is
redundant, I will bypass the check and use regmap API directly.

> 
> > +
> > +static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
> > +{
> > +       int ret;
> > +       u32 data;
> > +
> > +       ret = mtk_rtc_write(rtc, RTC_WRTGR, 1);
> > +       if (ret < 0)
> > +               goto exit;
> > +
> > +       ret = mtk_rtc_read(rtc, RTC_BBPU, &data);
> > +       if (ret < 0)
> > +               goto exit;
> > +
> > +       while (data & RTC_BBPU_CBUSY) {
> > +               cpu_relax();
> > +               ret = mtk_rtc_read(rtc, RTC_BBPU, &data);
> > +               if (ret < 0)
> > +                       goto exit;
> > +       }
> 
> The initial read and the loop could be folded into a do {} while loop?
> Also it would be safer to have a timeout here.
Because I need to check return value, so not put initial read in do { }.
Indeed, it is safer to add timeout here.


> > +
> > +static int __mtk_rtc_read_time(struct mt6397_rtc *rtc,
> > +                               struct rtc_time *tm, int *sec)
> > +{
> > +       int ret;
> > +
> > +       mutex_lock(&rtc->lock);
> > +       ret = mtk_rtc_read(rtc, RTC_TC_SEC, &tm->tm_sec);
> > +       if (ret < 0)
> > +               goto exit;
> > +       ret = mtk_rtc_read(rtc, RTC_TC_MIN, &tm->tm_min);
> > +       if (ret < 0)
> > +               goto exit;
> > +       ret = mtk_rtc_read(rtc, RTC_TC_HOU, &tm->tm_hour);
> > +       if (ret < 0)
> > +               goto exit;
> > +       ret = mtk_rtc_read(rtc, RTC_TC_DOM, &tm->tm_mday);
> > +       if (ret < 0)
> > +               goto exit;
> > +       ret = mtk_rtc_read(rtc, RTC_TC_MTH, &tm->tm_mon);
> > +       if (ret < 0)
> > +               goto exit;
> > +       ret = mtk_rtc_read(rtc, RTC_TC_YEA, &tm->tm_year);
> > +       if (ret < 0)
> > +               goto exit;
> > +       ret = mtk_rtc_read(rtc, RTC_TC_SEC, sec);
> 
> Would the hardware allow this to be merged into single burst transfer
> reading all the registers into a buffer, so then you could just copy
> the values from that buffer into target struct instead of issuing
> multiple reads one by one?
OK, Sascha already mentioned this before, I think I should change to use
single burst reading.

> 
> Also shouldn't the unused bits be masked out?
Hardware return zero in unused bits. So I think it not necessary to add
mask.

> 
> > +
> > +exit:
> > +       mutex_unlock(&rtc->lock);
> > +       return ret;
> > +}
> > +
> > +static int mtk_rtc_read_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +       time64_t time;
> > +       struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> > +       int sec, ret;
> > +
> > +       do {
> > +               ret = __mtk_rtc_read_time(rtc, tm, &sec);
> > +               if (ret < 0)
> > +                       goto exit;
> > +       } while (sec < tm->tm_sec);
> 
> Shouldn't this be while (sec > tm->tm_sec)?
No, it should keep it as is, this is used to check whether second
overflow (from 59 to 0). If yes, read time again.

> 
> > +
> > +       tm->tm_year += RTC_MIN_YEAR_OFFSET;
> > +       tm->tm_mon--;
> 
> Could you add a comment explaining why this is decremented?
Year register only have 7bits, use RTC_MIN_YEAR_OFFSET to reduce bit
usage. Minus the offset before write to register and add back the offset
after read register back. And month register start from 1, but tm_mon
start from zero. I will add comment.

> 
> > +       time = rtc_tm_to_time64(tm);
> > +
> > +       tm->tm_wday = (time / 86400 + 4) % 7;
> 
> Could you add a comment, or even better, an inline function with a
> comment, explaining this calculation?
rtc_tm_to_time64 function return time base on 01-01-1970 00:00:00.
This base time is Thursday. I will add comment

> 
> > +
> > +exit:
> > +       return ret;
> > +}
> > +
> > +static int mtk_rtc_set_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +       struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> > +       int ret;
> > +
> > +       tm->tm_year -= RTC_MIN_YEAR_OFFSET;
> > +       tm->tm_mon++;
> > +
> > +       mutex_lock(&rtc->lock);
> > +       ret = mtk_rtc_write(rtc, RTC_TC_YEA, tm->tm_year);
> > +       if (ret < 0)
> > +               goto exit;
> > +       ret = mtk_rtc_write(rtc, RTC_TC_MTH, tm->tm_mon);
> > +       if (ret < 0)
> > +               goto exit;
> > +       ret = mtk_rtc_write(rtc, RTC_TC_DOM, tm->tm_mday);
> > +       if (ret < 0)
> > +               goto exit;
> > +       ret = mtk_rtc_write(rtc, RTC_TC_HOU, tm->tm_hour);
> > +       if (ret < 0)
> > +               goto exit;
> > +       ret = mtk_rtc_write(rtc, RTC_TC_MIN, tm->tm_min);
> > +       if (ret < 0)
> > +               goto exit;
> > +       ret = mtk_rtc_write(rtc, RTC_TC_SEC, tm->tm_sec);
> > +       if (ret < 0)
> > +               goto exit;
> > +       ret = mtk_rtc_write_trigger(rtc);
> > +
> > +exit:
> > +       mutex_unlock(&rtc->lock);
> > +       return ret;
> > +}
> > +
> > +static int mtk_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
> > +{
> > +       struct rtc_time *tm = &alm->time;
> > +       struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> > +       u32 irqen, pdn2;
> > +       int ret;
> > +
> > +       mutex_lock(&rtc->lock);
> > +       ret = mtk_rtc_read(rtc, RTC_IRQ_EN, &irqen);
> > +       if (ret < 0)
> > +               goto err_exit;
> > +       ret = mtk_rtc_read(rtc, RTC_PDN2, &pdn2);
> > +       if (ret < 0)
> > +               goto err_exit;
> > +       ret = mtk_rtc_read(rtc, RTC_AL_SEC, &tm->tm_sec);
> > +       if (ret < 0)
> > +               goto err_exit;
> > +       ret = mtk_rtc_read(rtc, RTC_AL_MIN, &tm->tm_min);
> > +       if (ret < 0)
> > +               goto err_exit;
> > +       ret = mtk_rtc_read(rtc, RTC_AL_HOU, &tm->tm_hour);
> > +       if (ret < 0)
> > +               goto err_exit;
> > +       ret = mtk_rtc_read(rtc, RTC_AL_DOM, &tm->tm_mday);
> > +       if (ret < 0)
> > +               goto err_exit;
> > +       ret = mtk_rtc_read(rtc, RTC_AL_MTH, &tm->tm_mon);
> > +       if (ret < 0)
> > +               goto err_exit;
> > +       ret = mtk_rtc_read(rtc, RTC_AL_YEA, &tm->tm_year);
> > +       if (ret < 0)
> > +               goto err_exit;
> 
> Similarly to _read_time(), could this be changed into a single burst read?
will change API.

> 
> > +
> > +       alm->enabled = !!(irqen & RTC_IRQ_EN_AL);
> > +       alm->pending = !!(pdn2 & RTC_PDN2_PWRON_ALARM);
> > +       mutex_unlock(&rtc->lock);
> > +
> > +       tm->tm_year += RTC_MIN_YEAR_OFFSET;
> > +       tm->tm_mon--;
> > +
> > +       return 0;
> > +err_exit:
> > +       mutex_unlock(&rtc->lock);
> > +       return ret;
> > +}
> > +
> > +static int mtk_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
> > +{
> > +       struct rtc_time *tm = &alm->time;
> > +       struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> > +       u32 irqen;
> > +       int ret;
> > +
> > +       tm->tm_year -= RTC_MIN_YEAR_OFFSET;
> > +       tm->tm_mon++;
> > +
> > +       mutex_lock(&rtc->lock);
> > +       if (alm->enabled) {
> 
> Is this possible that an alarm was already set? Is it okay to keep it
> enabled while changing the alarm time to new one?
It's ok because all alarm time register set to hardware after call
mtk_rtc_write_trigger.

> 
> > +               ret = mtk_rtc_write(rtc, RTC_AL_YEA, tm->tm_year);
> > +               if (ret < 0)
> > +                       goto exit;
> > +               ret = mtk_rtc_write(rtc, RTC_AL_MTH, tm->tm_mon);
> > +               if (ret < 0)
> > +                       goto exit;
> > +               ret = mtk_rtc_write(rtc, RTC_AL_DOM, tm->tm_mday);
> > +               if (ret < 0)
> > +                       goto exit;
> > +               ret = mtk_rtc_write(rtc, RTC_AL_HOU, tm->tm_hour);
> > +               if (ret < 0)
> > +                       goto exit;
> > +               ret = mtk_rtc_write(rtc, RTC_AL_MIN, tm->tm_min);
> > +               if (ret < 0)
> > +                       goto exit;
> > +               ret = mtk_rtc_write(rtc, RTC_AL_SEC, tm->tm_sec);
> > +               if (ret < 0)
> > +                       goto exit;
> > +               ret = mtk_rtc_write(rtc, RTC_AL_MASK, RTC_AL_MASK_DOW);
> > +               if (ret < 0)
> > +                       goto exit;
> > +               ret = mtk_rtc_write_trigger(rtc);
> > +               if (ret < 0)
> > +                       goto exit;
> > +               ret = mtk_rtc_read(rtc, RTC_IRQ_EN, &irqen);
> > +               if (ret < 0)
> > +                       goto exit;
> > +               irqen |= RTC_IRQ_EN_ONESHOT_AL;
> > +               ret = mtk_rtc_write(rtc, RTC_IRQ_EN, irqen);
> > +               if (ret < 0)
> > +                       goto exit;
> 
> regmap_update_bits() could be used instead of the read, modify and write above.
I will check how to use this api.
> 
> > +               ret = mtk_rtc_write_trigger(rtc);
> > +               if (ret < 0)
> > +                       goto exit;
> > +       } else {
> > +               ret = mtk_rtc_read(rtc, RTC_IRQ_EN, &irqen);
> > +               if (ret < 0)
> > +                       goto exit;
> > +               irqen &= ~RTC_IRQ_EN_ONESHOT_AL;
> > +               ret = mtk_rtc_write(rtc, RTC_IRQ_EN, irqen);
> > +               if (ret < 0)
> > +                       goto exit;
> 
> Ditto.
> 
> > +       }
> > +
> > +exit:
> > +       mutex_unlock(&rtc->lock);
> > +       return ret;
> > +}
> > +
> > +static struct rtc_class_ops mtk_rtc_ops = {
> > +       .read_time  = mtk_rtc_read_time,
> > +       .set_time   = mtk_rtc_set_time,
> > +       .read_alarm = mtk_rtc_read_alarm,
> > +       .set_alarm  = mtk_rtc_set_alarm,
> > +};
> > +
> > +static int mtk_rtc_probe(struct platform_device *pdev)
> > +{
> > +       struct resource *res;
> > +       struct mt6397_chip *mt6397_chip = dev_get_drvdata(pdev->dev.parent);
> > +       struct mt6397_rtc *rtc;
> > +       int ret = 0;
> > +
> > +       rtc = devm_kzalloc(&pdev->dev, sizeof(struct mt6397_rtc), GFP_KERNEL);
> > +       if (!rtc)
> > +               return -ENOMEM;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       rtc->addr_base = res->start;
> > +       rtc->addr_range = res->end - res->start;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +       rtc->irq = irq_create_mapping(mt6397_chip->irq_domain, res->start);
> > +       if (rtc->irq <= 0)
> > +               goto out_rtc;
> 
> Just return an error code here directly. Which one is actually a good
> question. Looks like existing code is using -EINVAL or -ENXIO. Any
> ideas?
I tend to use -EINVAL
> 
> > +
> > +       rtc->regmap = mt6397_chip->regmap;
> > +       rtc->dev = &pdev->dev;q
> > +       mutex_init(&rtc->lock);
> > +
> > +       platform_set_drvdata(pdev, rtc);
> > +
> > +       ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
> > +                       mtk_rtc_irq_handler_thread,
> > +                       IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > +                       "mt6397-rtc", rtc);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
> > +                       rtc->irq, ret);
> > +               goto out_rtc;
> > +       }
> > +
> > +       rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
> > +                               &mtk_rtc_ops, THIS_MODULE);
> > +       if (IS_ERR(rtc->rtc_dev)) {
> > +               dev_err(&pdev->dev, "register rtc device failed\n");
> > +               return PTR_ERR(rtc->rtc_dev);
> > +       }
> > +
> > +       device_init_wakeup(&pdev->dev, 1);
> > +
> > +       return 0;
> > +
> > +out_rtc:
> > +       rtc_device_unregister(rtc->rtc_dev);
> 
> All references to this label are actually before rtc_device_register()
> is even called. The proper thing to do here is to dispose the created
> IRQ mapping.
OK, will call irq_dispose_mapping and free_irq

> 
> > +       return ret;
> > +
> > +}
> > +
> > +static int mtk_rtc_remove(struct platform_device *pdev)
> > +{
> > +       struct mt6397_rtc *rtc = platform_get_drvdata(pdev);
> > +
> > +       rtc_device_unregister(rtc->rtc_dev);
> 
> What about the IRQ mapping created in probe?
OK, will call irq_dispose_mapping and free_irq
> 

Eddie
