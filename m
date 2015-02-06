From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Fri, 6 Feb 2015 19:47:12 +0800
Subject: [PATCH 4/4] usb: phy: add phy-hi6220
In-Reply-To: <20150206084141.GE5007@shlinux2>
References: <1423147620-5760-1-git-send-email-zhangfei.gao@linaro.org>
 <1423147620-5760-5-git-send-email-zhangfei.gao@linaro.org>
 <20150206084141.GE5007@shlinux2>
Message-ID: <CABQgh9GfmoeLo-HnhM=sk-XBw1KoLMsa=RZZWkHu-hGPpMK+=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 February 2015 at 16:41, Peter Chen <peter.chen@freescale.com> wrote:
> On Thu, Feb 05, 2015 at 10:47:00PM +0800, Zhangfei Gao wrote:

>> @@ -18,6 +18,7 @@ obj-$(CONFIG_SAMSUNG_USBPHY)                += phy-samsung-usb.o
>>  obj-$(CONFIG_TWL6030_USB)            += phy-twl6030-usb.o
>>  obj-$(CONFIG_USB_EHCI_TEGRA)         += phy-tegra-usb.o
>>  obj-$(CONFIG_USB_GPIO_VBUS)          += phy-gpio-vbus-usb.o
>> +obj-$(CONFIG_USB_HI6220_PHY)         += phy-hi6220.o
>
> To align the naming method, phy-hi6220-usb is better.
Sure,


>> +enum usb_mode {
>> +     USB_EMPTY,
>> +     GADGET_DEVICE,
>> +     OTG_HOST,
>> +};
>
> This usb_mode is a little strange, what state you would like to
> use?

it is internal state machine, to distinguish otg gadget mode and host mode.
There are two gpio, we use gpio_vbus interrupt as well as gpio_id
status to distinguish gadget or host.

>> +static irqreturn_t hiusb_gpio_intr(int irq, void *data)
>> +{
>> +     struct hi6220_priv *priv = (struct hi6220_priv *)data;
>> +
>> +     /* add debounce time */
>> +     schedule_delayed_work(&priv->work, msecs_to_jiffies(100));
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static int mv_otg_set_peripheral(struct usb_otg *otg,
>
> mv? You may want to use hi
Yes, my bad.


>> +static void hi6220_phy_setup(struct hi6220_priv *priv)
>> +{
>> +     u32 val, mask;
>> +     int ret;
>> +
>> +     if (priv->reg == NULL)
>> +             return;
>> +
>> +     val = PERIPH_RSTDIS0_USBOTG_BUS | PERIPH_RSTDIS0_POR_PICOPHY |
>> +           PERIPH_RSTDIS0_USBOTG | PERIPH_RSTDIS0_USBOTG_32K;
>> +     mask = val;
>> +     ret = regmap_update_bits(priv->reg, SC_PERIPH_RSTDIS0, mask, val);
>> +     if (ret)
>> +             return;
>> +
>> +     ret = regmap_read(priv->reg, SC_PERIPH_CTRL5, &val);
>> +     val = PERIPH_CTRL5_USBOTG_RES_SEL | PERIPH_CTRL5_PICOPHY_ACAENB;
>> +     mask = val | PERIPH_CTRL5_PICOPHY_BC_MODE;
>> +     ret = regmap_update_bits(priv->reg, SC_PERIPH_CTRL5, mask, val);
>> +     if (ret)
>> +             return;
>> +
>> +     val =  PERIPH_CTRL4_PICO_VBUSVLDEXT | PERIPH_CTRL4_PICO_VBUSVLDEXTSEL |
>> +            PERIPH_CTRL4_OTG_PHY_SEL;
>> +     mask = val | PERIPH_CTRL4_PICO_SIDDQ | PERIPH_CTRL4_PICO_OGDISABLE;
>> +     ret = regmap_update_bits(priv->reg, SC_PERIPH_CTRL4, mask, val);
>> +     if (ret)
>> +             return;
>> +
>> +     ret = regmap_write(priv->reg, SC_PERIPH_CTRL8, EYE_PATTERN_PARA);
>> +     if (ret)
>> +             return;
>> +}
>> +
>> +static int hi6220_phy_probe(struct platform_device *pdev)
>> +{
>> +     struct hi6220_priv *priv;
>> +     struct usb_otg *otg;
>> +     struct device_node *np = pdev->dev.of_node;
>> +     int ret, irq;
>> +
>> +     priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +     if (!priv)
>> +             return -ENOMEM;
>> +
>> +     otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
>> +     if (!otg)
>> +             return -ENOMEM;
>> +
>> +     priv->phy.dev = &pdev->dev;
>> +     priv->phy.otg = otg;
>> +     priv->phy.label = "hi6220";
>> +     platform_set_drvdata(pdev, priv);
>> +     otg->set_peripheral = mv_otg_set_peripheral;
>> +
>> +     priv->gpio_vbus_det = of_get_named_gpio(np, "hisilicon,gpio_vbus_det", 0);
>> +     if (priv->gpio_vbus_det == -EPROBE_DEFER)
>> +             return -EPROBE_DEFER;
>> +     if (!gpio_is_valid(priv->gpio_vbus_det)) {
>> +             dev_err(&pdev->dev, "invalid gpio %d\n", priv->gpio_vbus_det);
>> +             return -ENODEV;
>> +     }
>> +
>> +     priv->gpio_id_det = of_get_named_gpio(np, "hisilicon,gpio_id_det", 0);
>> +     if (priv->gpio_id_det == -EPROBE_DEFER)
>> +             return -EPROBE_DEFER;
>> +     if (!gpio_is_valid(priv->gpio_id_det)) {
>> +             dev_err(&pdev->dev, "invalid gpio %d\n", priv->gpio_id_det);
>> +             return -ENODEV;
>> +     }
>> +
>> +     priv->reg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>> +                                     "hisilicon,peripheral-syscon");
>> +     if (IS_ERR(priv->reg))
>> +             priv->reg = NULL;
>
> You may differentiate -ENODEV and other errors, for other errors, you
> can show an error, and return directly.

Here I want to set this property as optional, in case other platform
do not need this property.
So phy_setup also add protection if (priv->reg == NULL) return;

>
>> +
>> +     INIT_DELAYED_WORK(&priv->work, hi6220_detect_work);
>> +
>> +     ret = devm_gpio_request_one(&pdev->dev, priv->gpio_vbus_det,
>> +                                 GPIOF_IN, "gpio_vbus_det");
>> +     if (ret < 0) {
>> +             dev_err(&pdev->dev, "gpio request failed for gpio_vbus_det\n");
>> +             return ret;
>> +     }
>> +
>> +     ret = devm_gpio_request_one(&pdev->dev, priv->gpio_id_det,
>> +                                 GPIOF_IN, "gpio_id_det");
>> +     if (ret < 0) {
>> +             dev_err(&pdev->dev, "gpio request failed for gpio_id_det\n");
>> +             return ret;
>> +     }
>> +
>> +     priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
>> +     if (!IS_ERR(priv->vcc)) {
>> +             ret = regulator_enable(priv->vcc);
>> +             if (ret) {
>> +                     dev_err(&pdev->dev, "Failed to enable regulator\n");
>> +                     return -ENODEV;
>> +             }
>> +     }
>> +
>> +     priv->clk = devm_clk_get(&pdev->dev, NULL);
>> +     if (IS_ERR(priv->clk)) {
>> +             regulator_disable(priv->vcc);
>> +             return PTR_ERR(priv->clk);
>> +     }
>> +     clk_prepare_enable(priv->clk);
>> +
>> +     irq = gpio_to_irq(priv->gpio_vbus_det);
>> +     ret = devm_request_irq(&pdev->dev, gpio_to_irq(priv->gpio_vbus_det),
>> +                            hiusb_gpio_intr, IRQF_NO_SUSPEND |
>> +                            IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
>> +                            "vbus_gpio_intr", priv);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "request gpio irq failed.\n");
>> +             goto err_irq;
>> +     }
>
> You may put the devm_request_irq to the last, in case, the unexpected
> interrupt occurs during the setup.
It does not matter, since otg->gadget = NULL.
In fact we manually call schedule_delayed_work to get the gpio status
for setting internal state machine

>
>> +
>> +     hi6220_phy_setup(priv);
>> +     ret = usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
>
> Use usb_add_phy_dev please, see the doc for usb_add_phy.
OK, got it.

Thanks Peter for the review.
