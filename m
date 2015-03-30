From: tfiga@google.com (Tomasz Figa)
Date: Mon, 30 Mar 2015 16:41:25 +0900
Subject: [PATCH v2 2/3] rtc: mediatek: Add MT6397 RTC driver
In-Reply-To: <1426657537-41414-3-git-send-email-eddie.huang@mediatek.com>
References: <1426657537-41414-1-git-send-email-eddie.huang@mediatek.com>
 <1426657537-41414-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <CAAFQd5ADCaKhP=3BmJsVimvo-uXZB3pobVAUST-b5kU+98Rt+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eddie,

Please see my comments inline.

On Wed, Mar 18, 2015 at 2:45 PM, Eddie Huang <eddie.huang@mediatek.com> wrote:
> From: Tianping Fang <tianping.fang@mediatek.com>
>
> Add Mediatek MT6397 RTC driver

[snip]

> +#define RTC_BBPU               0x0000
> +#define RTC_WRTGR              0x003c
> +#define RTC_IRQ_EN             0x0004
> +#define RTC_IRQ_STA            0x0002
> +
> +#define RTC_BBPU_CBUSY         (1 << 6)
> +#define RTC_IRQ_STA_AL         (1 << 0)
> +#define RTC_IRQ_STA_LP         (1 << 3)

nit: Could you use BIT() macro for definitions of single bits? (+
further occurrences in the patch)

> +
> +#define RTC_AL_MASK            0x0008
> +#define RTC_TC_SEC             0x000a
> +#define RTC_TC_MIN             0x000c
> +#define RTC_TC_HOU             0x000e
> +#define RTC_TC_DOM             0x0010
> +#define RTC_TC_MTH             0x0014
> +#define RTC_TC_YEA             0x0016
> +#define RTC_AL_SEC             0x0018
> +#define RTC_AL_MIN             0x001a

[snip]

> +
> +static int mtk_rtc_read(struct mt6397_rtc *rtc, u32 offset, u32 *data)
> +{
> +       u32 addr = rtc->addr_base + offset;
> +
> +       if (offset < rtc->addr_range)
> +               return regmap_read(rtc->regmap, addr, data);
> +
> +       return -EINVAL;
> +}
> +
> +static int mtk_rtc_write(struct mt6397_rtc *rtc, u32 offset, u32 data)
> +{
> +       u32 addr;
> +
> +       addr = rtc->addr_base + offset;
> +
> +       if (offset < rtc->addr_range)
> +               return regmap_write(rtc->regmap, addr, data);
> +
> +       return -EINVAL;
> +}

Do you actually need these wrappers? Could you use regmap_write() and
_read() directly? This would also enable you to use
regmap_update_bits() instead of implicit read, modify and write.

> +
> +static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
> +{
> +       int ret;
> +       u32 data;
> +
> +       ret = mtk_rtc_write(rtc, RTC_WRTGR, 1);
> +       if (ret < 0)
> +               goto exit;
> +
> +       ret = mtk_rtc_read(rtc, RTC_BBPU, &data);
> +       if (ret < 0)
> +               goto exit;
> +
> +       while (data & RTC_BBPU_CBUSY) {
> +               cpu_relax();
> +               ret = mtk_rtc_read(rtc, RTC_BBPU, &data);
> +               if (ret < 0)
> +                       goto exit;
> +       }

The initial read and the loop could be folded into a do {} while loop?
Also it would be safer to have a timeout here.

> +
> +exit:
> +       return ret;
> +}
> +
> +static irqreturn_t mtk_rtc_irq_handler_thread(int irq, void *data)
> +{
> +       struct mt6397_rtc *rtc = data;
> +       u32 irqsta, irqen;
> +       int ret;
> +
> +       ret = mtk_rtc_read(rtc, RTC_IRQ_STA, &irqsta);
> +
> +       if ((ret >= 0) && (irqsta & RTC_IRQ_STA_AL)) {
> +               rtc_update_irq(rtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
> +               irqen = irqsta & ~RTC_IRQ_EN_AL;
> +               mutex_lock(&rtc->lock);
> +               if (mtk_rtc_write(rtc, RTC_IRQ_EN, irqen) < 0)
> +                       mtk_rtc_write_trigger(rtc);
> +               mutex_unlock(&rtc->lock);
> +
> +               return IRQ_HANDLED;
> +       }
> +
> +       return IRQ_NONE;
> +}
> +
> +static int __mtk_rtc_read_time(struct mt6397_rtc *rtc,
> +                               struct rtc_time *tm, int *sec)
> +{
> +       int ret;
> +
> +       mutex_lock(&rtc->lock);
> +       ret = mtk_rtc_read(rtc, RTC_TC_SEC, &tm->tm_sec);
> +       if (ret < 0)
> +               goto exit;
> +       ret = mtk_rtc_read(rtc, RTC_TC_MIN, &tm->tm_min);
> +       if (ret < 0)
> +               goto exit;
> +       ret = mtk_rtc_read(rtc, RTC_TC_HOU, &tm->tm_hour);
> +       if (ret < 0)
> +               goto exit;
> +       ret = mtk_rtc_read(rtc, RTC_TC_DOM, &tm->tm_mday);
> +       if (ret < 0)
> +               goto exit;
> +       ret = mtk_rtc_read(rtc, RTC_TC_MTH, &tm->tm_mon);
> +       if (ret < 0)
> +               goto exit;
> +       ret = mtk_rtc_read(rtc, RTC_TC_YEA, &tm->tm_year);
> +       if (ret < 0)
> +               goto exit;
> +       ret = mtk_rtc_read(rtc, RTC_TC_SEC, sec);

Would the hardware allow this to be merged into single burst transfer
reading all the registers into a buffer, so then you could just copy
the values from that buffer into target struct instead of issuing
multiple reads one by one?

Also shouldn't the unused bits be masked out?

> +
> +exit:
> +       mutex_unlock(&rtc->lock);
> +       return ret;
> +}
> +
> +static int mtk_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +       time64_t time;
> +       struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> +       int sec, ret;
> +
> +       do {
> +               ret = __mtk_rtc_read_time(rtc, tm, &sec);
> +               if (ret < 0)
> +                       goto exit;
> +       } while (sec < tm->tm_sec);

Shouldn't this be while (sec > tm->tm_sec)?

> +
> +       tm->tm_year += RTC_MIN_YEAR_OFFSET;
> +       tm->tm_mon--;

Could you add a comment explaining why this is decremented?

> +       time = rtc_tm_to_time64(tm);
> +
> +       tm->tm_wday = (time / 86400 + 4) % 7;

Could you add a comment, or even better, an inline function with a
comment, explaining this calculation?

> +
> +exit:
> +       return ret;
> +}
> +
> +static int mtk_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +       struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> +       int ret;
> +
> +       tm->tm_year -= RTC_MIN_YEAR_OFFSET;
> +       tm->tm_mon++;
> +
> +       mutex_lock(&rtc->lock);
> +       ret = mtk_rtc_write(rtc, RTC_TC_YEA, tm->tm_year);
> +       if (ret < 0)
> +               goto exit;
> +       ret = mtk_rtc_write(rtc, RTC_TC_MTH, tm->tm_mon);
> +       if (ret < 0)
> +               goto exit;
> +       ret = mtk_rtc_write(rtc, RTC_TC_DOM, tm->tm_mday);
> +       if (ret < 0)
> +               goto exit;
> +       ret = mtk_rtc_write(rtc, RTC_TC_HOU, tm->tm_hour);
> +       if (ret < 0)
> +               goto exit;
> +       ret = mtk_rtc_write(rtc, RTC_TC_MIN, tm->tm_min);
> +       if (ret < 0)
> +               goto exit;
> +       ret = mtk_rtc_write(rtc, RTC_TC_SEC, tm->tm_sec);
> +       if (ret < 0)
> +               goto exit;
> +       ret = mtk_rtc_write_trigger(rtc);
> +
> +exit:
> +       mutex_unlock(&rtc->lock);
> +       return ret;
> +}
> +
> +static int mtk_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
> +{
> +       struct rtc_time *tm = &alm->time;
> +       struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> +       u32 irqen, pdn2;
> +       int ret;
> +
> +       mutex_lock(&rtc->lock);
> +       ret = mtk_rtc_read(rtc, RTC_IRQ_EN, &irqen);
> +       if (ret < 0)
> +               goto err_exit;
> +       ret = mtk_rtc_read(rtc, RTC_PDN2, &pdn2);
> +       if (ret < 0)
> +               goto err_exit;
> +       ret = mtk_rtc_read(rtc, RTC_AL_SEC, &tm->tm_sec);
> +       if (ret < 0)
> +               goto err_exit;
> +       ret = mtk_rtc_read(rtc, RTC_AL_MIN, &tm->tm_min);
> +       if (ret < 0)
> +               goto err_exit;
> +       ret = mtk_rtc_read(rtc, RTC_AL_HOU, &tm->tm_hour);
> +       if (ret < 0)
> +               goto err_exit;
> +       ret = mtk_rtc_read(rtc, RTC_AL_DOM, &tm->tm_mday);
> +       if (ret < 0)
> +               goto err_exit;
> +       ret = mtk_rtc_read(rtc, RTC_AL_MTH, &tm->tm_mon);
> +       if (ret < 0)
> +               goto err_exit;
> +       ret = mtk_rtc_read(rtc, RTC_AL_YEA, &tm->tm_year);
> +       if (ret < 0)
> +               goto err_exit;

Similarly to _read_time(), could this be changed into a single burst read?

> +
> +       alm->enabled = !!(irqen & RTC_IRQ_EN_AL);
> +       alm->pending = !!(pdn2 & RTC_PDN2_PWRON_ALARM);
> +       mutex_unlock(&rtc->lock);
> +
> +       tm->tm_year += RTC_MIN_YEAR_OFFSET;
> +       tm->tm_mon--;
> +
> +       return 0;
> +err_exit:
> +       mutex_unlock(&rtc->lock);
> +       return ret;
> +}
> +
> +static int mtk_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
> +{
> +       struct rtc_time *tm = &alm->time;
> +       struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> +       u32 irqen;
> +       int ret;
> +
> +       tm->tm_year -= RTC_MIN_YEAR_OFFSET;
> +       tm->tm_mon++;
> +
> +       mutex_lock(&rtc->lock);
> +       if (alm->enabled) {

Is this possible that an alarm was already set? Is it okay to keep it
enabled while changing the alarm time to new one?

> +               ret = mtk_rtc_write(rtc, RTC_AL_YEA, tm->tm_year);
> +               if (ret < 0)
> +                       goto exit;
> +               ret = mtk_rtc_write(rtc, RTC_AL_MTH, tm->tm_mon);
> +               if (ret < 0)
> +                       goto exit;
> +               ret = mtk_rtc_write(rtc, RTC_AL_DOM, tm->tm_mday);
> +               if (ret < 0)
> +                       goto exit;
> +               ret = mtk_rtc_write(rtc, RTC_AL_HOU, tm->tm_hour);
> +               if (ret < 0)
> +                       goto exit;
> +               ret = mtk_rtc_write(rtc, RTC_AL_MIN, tm->tm_min);
> +               if (ret < 0)
> +                       goto exit;
> +               ret = mtk_rtc_write(rtc, RTC_AL_SEC, tm->tm_sec);
> +               if (ret < 0)
> +                       goto exit;
> +               ret = mtk_rtc_write(rtc, RTC_AL_MASK, RTC_AL_MASK_DOW);
> +               if (ret < 0)
> +                       goto exit;
> +               ret = mtk_rtc_write_trigger(rtc);
> +               if (ret < 0)
> +                       goto exit;
> +               ret = mtk_rtc_read(rtc, RTC_IRQ_EN, &irqen);
> +               if (ret < 0)
> +                       goto exit;
> +               irqen |= RTC_IRQ_EN_ONESHOT_AL;
> +               ret = mtk_rtc_write(rtc, RTC_IRQ_EN, irqen);
> +               if (ret < 0)
> +                       goto exit;

regmap_update_bits() could be used instead of the read, modify and write above.

> +               ret = mtk_rtc_write_trigger(rtc);
> +               if (ret < 0)
> +                       goto exit;
> +       } else {
> +               ret = mtk_rtc_read(rtc, RTC_IRQ_EN, &irqen);
> +               if (ret < 0)
> +                       goto exit;
> +               irqen &= ~RTC_IRQ_EN_ONESHOT_AL;
> +               ret = mtk_rtc_write(rtc, RTC_IRQ_EN, irqen);
> +               if (ret < 0)
> +                       goto exit;

Ditto.

> +       }
> +
> +exit:
> +       mutex_unlock(&rtc->lock);
> +       return ret;
> +}
> +
> +static struct rtc_class_ops mtk_rtc_ops = {
> +       .read_time  = mtk_rtc_read_time,
> +       .set_time   = mtk_rtc_set_time,
> +       .read_alarm = mtk_rtc_read_alarm,
> +       .set_alarm  = mtk_rtc_set_alarm,
> +};
> +
> +static int mtk_rtc_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       struct mt6397_chip *mt6397_chip = dev_get_drvdata(pdev->dev.parent);
> +       struct mt6397_rtc *rtc;
> +       int ret = 0;
> +
> +       rtc = devm_kzalloc(&pdev->dev, sizeof(struct mt6397_rtc), GFP_KERNEL);
> +       if (!rtc)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       rtc->addr_base = res->start;
> +       rtc->addr_range = res->end - res->start;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +       rtc->irq = irq_create_mapping(mt6397_chip->irq_domain, res->start);
> +       if (rtc->irq <= 0)
> +               goto out_rtc;

Just return an error code here directly. Which one is actually a good
question. Looks like existing code is using -EINVAL or -ENXIO. Any
ideas?

> +
> +       rtc->regmap = mt6397_chip->regmap;
> +       rtc->dev = &pdev->dev;q
> +       mutex_init(&rtc->lock);
> +
> +       platform_set_drvdata(pdev, rtc);
> +
> +       ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
> +                       mtk_rtc_irq_handler_thread,
> +                       IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> +                       "mt6397-rtc", rtc);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
> +                       rtc->irq, ret);
> +               goto out_rtc;
> +       }
> +
> +       rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
> +                               &mtk_rtc_ops, THIS_MODULE);
> +       if (IS_ERR(rtc->rtc_dev)) {
> +               dev_err(&pdev->dev, "register rtc device failed\n");
> +               return PTR_ERR(rtc->rtc_dev);
> +       }
> +
> +       device_init_wakeup(&pdev->dev, 1);
> +
> +       return 0;
> +
> +out_rtc:
> +       rtc_device_unregister(rtc->rtc_dev);

All references to this label are actually before rtc_device_register()
is even called. The proper thing to do here is to dispose the created
IRQ mapping.

> +       return ret;
> +
> +}
> +
> +static int mtk_rtc_remove(struct platform_device *pdev)
> +{
> +       struct mt6397_rtc *rtc = platform_get_drvdata(pdev);
> +
> +       rtc_device_unregister(rtc->rtc_dev);

What about the IRQ mapping created in probe?

Best regards,
Tomasz
