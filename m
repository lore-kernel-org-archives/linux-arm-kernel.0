From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 30 Mar 2015 16:15:50 +0800
Subject: [PATCH v2 2/3] rtc: mediatek: Add MT6397 RTC driver
In-Reply-To: <CAKdAkRSRXZ=1T+2Mfvjc4DsCCt1rxqGZpEuOUkU5KfPD2__BnQ@mail.gmail.com>
References: <1426657537-41414-1-git-send-email-eddie.huang@mediatek.com>
 <1426657537-41414-3-git-send-email-eddie.huang@mediatek.com>
 <CAKdAkRSRXZ=1T+2Mfvjc4DsCCt1rxqGZpEuOUkU5KfPD2__BnQ@mail.gmail.com>
Message-ID: <1427703350.26464.15.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On Fri, 2015-03-20 at 22:25 -0700, Dmitry Torokhov wrote:
> Hi Eddie,
> 
> 
> On Tue, Mar 17, 2015 at 10:45 PM, Eddie Huang <eddie.huang@mediatek.com> wrote:
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
> > +
> > +       rtc->regmap = mt6397_chip->regmap;
> > +       rtc->dev = &pdev->dev;
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
> This is wrong. Whenever you jump to this label the RTC device has not
> been registered yet.

Oops, will fix in next round.

Eddie
