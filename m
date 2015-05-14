From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 15 May 2015 00:56:34 +0200
Subject: [rtc-linux] [PATCH 1/2] rtc: add rtc-lpc24xx driver
In-Reply-To: <20150514221531.GG3338@piout.net>
References: <1431624875-20990-1-git-send-email-manabian@gmail.com>
 <1431624875-20990-2-git-send-email-manabian@gmail.com>
 <20150514221531.GG3338@piout.net>
Message-ID: <CAGhQ9Vy31h5pesO8ZRfpXnPF2t2PpKM8Jz5gqpp9RuvGb8PMSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 May 2015 at 00:15, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> On 14/05/2015 at 19:34:34 +0200, Joachim Eastwood wrote :
>> Add driver for the RTC found on NXP LPC24xx/178x/18xx/43xx devices.
>> The RTC provides calendar and clock functionality together with
>> periodic tick and alarm interrupt support.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>>  drivers/rtc/Kconfig       |  11 ++
>>  drivers/rtc/Makefile      |   1 +
>>  drivers/rtc/rtc-lpc24xx.c | 379 ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 391 insertions(+)
>>  create mode 100644 drivers/rtc/rtc-lpc24xx.c
>>
>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>> index 6149ae01e11f..42b890716b1c 100644
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -1427,6 +1427,17 @@ config RTC_DRV_JZ4740
>>         This driver can also be buillt as a module. If so, the module
>>         will be called rtc-jz4740.
>>
>> +config RTC_DRV_LPC24XX
>> +     depends on OF && (ARCH_LPC18XX || TEST_COMPILE)
>
> You probably meant COMPILE_TEST

ops, yes :)

>and it probably needs to depend on HAS_IOMEM

Indeed.

>> +     tristate "NXP LPC2K RTC"
>
> I'm not sure about LPC2K, you use LPC24XX for the config symbol and the
> filename also, just below the string is LPC32XX. But maybe that is fine
> if this is the most commonly used denomination.

I left the name used in the original driver. But I agree, using
LPC24XX everywhere would be more consistent. I'll change it in the
next version.

>> +     help
>> +       This enables support for the NXP RTC found which can be found on
>> +       LPC24xx/178x/18xx/43xx devices.
>> +
>> +       If you have one of the devices above enable this driver to use
>> +       the hardware RTC. This driver can also be buillt as a module. If
>> +       so, the module will be called rtc-lpc24xx.
>> +
>>  config RTC_DRV_LPC32XX
>>       depends on ARCH_LPC32XX
>>       tristate "NXP LPC32XX RTC"

<snip>

>> +static int lpc24xx_rtc_probe(struct platform_device *pdev)
>> +{
>> +     const struct of_device_id *match;
>> +     struct lpc24xx_rtc *rtc;
>> +     struct resource *res;
>> +     u32 rtc_ccr = 0;
>> +     int irq, ret;
>> +
>> +     match = of_match_device(lpc24xx_rtc_match, &pdev->dev);
>> +     if (!match) {
>
> Because you are only using DT, this will never happen. Else the
> lpc24xx_rtc_probe would not be called

This will go away in the next version since I'll be removing support
for the older versions of this ip block and thus no need for the match
data.

>> +             dev_err(&pdev->dev, "no device match found\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
>> +     if (!rtc)
>> +             return -ENOMEM;
>> +
>> +     rtc->features = (u32)match->data;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     rtc->rtc_base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(rtc->rtc_base))
>> +             return PTR_ERR(rtc->rtc_base);
>> +
>> +     irq = platform_get_irq(pdev, 0);
>> +     if (irq < 0) {
>> +             dev_warn(&pdev->dev, "can't get interrupt resource\n");
>> +             return irq;
>> +     }
>> +
>> +     rtc->clk_rtc = devm_clk_get(&pdev->dev, "rtc");
>> +     if (IS_ERR(rtc->clk_rtc)) {
>> +             dev_err(&pdev->dev, "error getting rtc clock\n");
>> +             return PTR_ERR(rtc->clk_rtc);
>> +     }
>> +
>> +     rtc->clk_reg = devm_clk_get(&pdev->dev, "reg");
>> +     if (IS_ERR(rtc->clk_reg)) {
>> +             dev_err(&pdev->dev, "error getting reg clock\n");
>> +             return PTR_ERR(rtc->clk_reg);
>> +     }
>> +
>> +     ret = clk_prepare_enable(rtc->clk_rtc);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "unable to enable rtc clock\n");
>> +             return ret;
>> +     }
>> +
>> +     ret = clk_prepare_enable(rtc->clk_reg);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "unable to enable reg clock\n");
>> +             goto disable_rtc_clk;
>> +     }
>> +
>> +     platform_set_drvdata(pdev, rtc);
>> +
>> +     /* Clear the counter increment state */
>> +     rtc_writel(rtc, LPC24XX_ILR, LPC24XX_RTCCIF);
>> +
>> +     if (rtc->features & HAVE_PRESCALER) {
>> +             /* Clock source is 32k oscillator */
>> +             rtc_ccr = LPC24XX_CLKSRC;
>> +             rtc_writel(rtc, LPC24XX_CCR, rtc_ccr);
>> +
>> +             /* Set prescaler to divide by 1 */
>> +             rtc_writel(rtc, LPC24XX_PREINT, 0);
>> +             rtc_writel(rtc, LPC24XX_PREFRAC, 0);
>> +     }
>> +
>> +     if (rtc->features & HAVE_SUBSECOND) {
>> +             /* Disable sub-second interrupt */
>> +             rtc_writel(rtc, LPC24XX_CISS, 0);
>> +     }
>> +
>> +     /* Only 1-second interrupt will generate interrupt */
>> +     rtc_writel(rtc, LPC24XX_CIIR, LPC24XX_IMSEC);
>> +
>> +     /* Enable RTC count */
>> +     rtc_writel(rtc, LPC24XX_CCR, rtc_ccr | LPC24XX_CLKEN);
>> +
>> +     ret = devm_request_irq(&pdev->dev, irq, lpc24xx_rtc_interrupt, 0,
>> +                            pdev->name, rtc);
>> +     if (ret < 0) {
>> +             dev_warn(&pdev->dev, "can't request interrupt\n");
>> +             goto disable_clks;
>> +     }
>> +
>> +     rtc->rtc = devm_rtc_device_register(&pdev->dev, "lpc2k-rtc",
>
> Same comment regarding the lpc2k name, also applies below.

Yeah, I'll change it.

>> +                                         &lpc24xx_rtc_ops, THIS_MODULE);
>> +     if (IS_ERR(rtc->rtc)) {
>> +             dev_err(&pdev->dev, "can't register rtc device\n");
>> +             ret = PTR_ERR(rtc->rtc);
>> +             goto disable_clks;
>> +     }
>> +
>> +     return 0;
>> +
>> +disable_clks:
>> +     clk_disable_unprepare(rtc->clk_reg);
>> +disable_rtc_clk:
>> +     clk_disable_unprepare(rtc->clk_rtc);
>> +     return ret;
>> +}
>> +
>> +static int lpc24xx_rtc_remove(struct platform_device *pdev)
>> +{
>> +     struct lpc24xx_rtc *rtc = platform_get_drvdata(pdev);
>> +
>> +     /*
>> +      * Disable alarm, but leave RTC enabled so it
>> +      * remains valid across reset cycles.
>> +      */
>> +     rtc_writel(rtc, LPC24XX_AMR, LPC24XX_ALARM_DISABLE);
>> +     rtc_writel(rtc, LPC24XX_CCR, 0);
>> +
>> +     clk_disable_unprepare(rtc->clk_rtc);
>> +     clk_disable_unprepare(rtc->clk_reg);
>> +
>> +     return 0;
>> +}
>> +
>> +static struct platform_driver lpc24xx_rtc_driver = {
>> +     .probe  = lpc24xx_rtc_probe,
>> +     .remove = lpc24xx_rtc_remove,
>> +     .driver = {
>> +             .name = "lpc2k-rtc",
>> +             .of_match_table = lpc24xx_rtc_match,
>> +     },
>> +};
>> +module_platform_driver(lpc24xx_rtc_driver);
>> +
>> +MODULE_AUTHOR("Kevin Wells <wellsk40@gmail.com");
>> +MODULE_DESCRIPTION("RTC driver for the LPC24xx SoC");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:lpc2k-rtc");

Thanks for looking and commenting.

regards,
Joachim Eastwood
