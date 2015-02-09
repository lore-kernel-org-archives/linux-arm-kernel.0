From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 10 Feb 2015 00:00:16 +0800
Subject: [PATCH v2 4/4] usb: phy: add phy-hi6220-usb
In-Reply-To: <54D8C391.1080603@linaro.org>
References: <1423284966-3485-1-git-send-email-zhangfei.gao@linaro.org>
 <1423284966-3485-5-git-send-email-zhangfei.gao@linaro.org>
 <20150209021133.GB3045@shlinux2> <54D8C391.1080603@linaro.org>
Message-ID: <CABQgh9FVYN8dbg=bx8OyPmRo+atPUT7Qr6YK3+ATe4QXgw8nJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 February 2015 at 22:26, zhangfei <zhangfei.gao@linaro.org> wrote:
>
>
> On 02/09/2015 10:11 AM, Peter Chen wrote:
>
>>> +static void hi6220_detect_work(struct work_struct *work)
>>> +{
>>> +       struct hi6220_priv *priv =
>>> +               container_of(work, struct hi6220_priv, work.work);
>>> +       int gpio_id, gpio_vubs;
>>
>>
>> %s/gpio_vubs/gpio_vbus
>
>
> Yes, typo
>
>
>>> +static void hi6220_phy_setup(struct hi6220_priv *priv, bool on)
>>> +{
>>> +       struct regmap *reg = priv->reg;
>>> +       u32 val, mask;
>>> +       int ret;
>>> +
>>> +       if (priv->reg == NULL)
>>> +               return;
>>> +
>>> +       if (on) {
>>> +               val = RST0_USBOTG_BUS | RST0_POR_PICOPHY |
>>> +                     RST0_USBOTG | RST0_USBOTG_32K;
>>> +               mask = val;
>>> +               ret = regmap_update_bits(reg, SC_PERIPH_RSTDIS0, mask,
>>> val);
>>> +               if (ret)
>>> +                       return;
>>> +
>>> +               ret = regmap_read(reg, SC_PERIPH_CTRL5, &val);
>>> +               val = CTRL5_USBOTG_RES_SEL | CTRL5_PICOPHY_ACAENB;
>>> +               mask = val | CTRL5_PICOPHY_BC_MODE;
>>> +               ret = regmap_update_bits(reg, SC_PERIPH_CTRL5, mask,
>>> val);
>>> +               if (ret)
>>> +                       return;
>>> +
>>> +               val =  CTRL4_PICO_VBUSVLDEXT | CTRL4_PICO_VBUSVLDEXTSEL |
>>> +                      CTRL4_OTG_PHY_SEL;
>>> +               mask = val | CTRL4_PICO_SIDDQ | CTRL4_PICO_OGDISABLE;
>>> +               ret = regmap_update_bits(reg, SC_PERIPH_CTRL4, mask,
>>> val);
>>> +               if (ret)
>>> +                       return;
>>> +
>>> +               ret = regmap_write(reg, SC_PERIPH_CTRL8,
>>> EYE_PATTERN_PARA);
>>> +               if (ret)
>>> +                       return;
>>> +       } else {
>>> +               val = CTRL4_PICO_SIDDQ;
>>> +               mask = val;
>>> +               ret = regmap_update_bits(reg, SC_PERIPH_CTRL4, mask,
>>> val);
>>> +               if (ret)
>>> +                       return;
>>> +
>>> +               ret = regmap_read(reg, SC_PERIPH_CTRL4, &val);
>>> +
>>> +               val = RST0_USBOTG_BUS | RST0_POR_PICOPHY |
>>> +                     RST0_USBOTG | RST0_USBOTG_32K;
>>> +               mask = val;
>>> +               ret = regmap_update_bits(reg, SC_PERIPH_RSTEN0, mask,
>>> val);
>>> +               if (ret)
>>> +                       return;
>>> +       }
>>
>>
>> You have return value check for regmap API, but no error message or
>> return value for hi6220_phy_setup, it looks strange.
>
>
> There was dev_err(priv->dev, "failed to setup phy\n");
> Then I found priv->dev is the only one place to use, so I remove this for
> simple.
>
>
>>
>>> +}
>>> +
>>> +static int hi6220_phy_probe(struct platform_device *pdev)
>>> +{
>>> +       struct hi6220_priv *priv;
>>> +       struct usb_otg *otg;
>>> +       struct device_node *np = pdev->dev.of_node;
>>> +       int ret, irq;
>>> +
>>> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>>> +       if (!priv)
>>> +               return -ENOMEM;
>>> +
>>> +       otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
>>> +       if (!otg)
>>> +               return -ENOMEM;
>>> +
>>> +       priv->phy.dev = &pdev->dev;
>>> +       priv->phy.otg = otg;
>>> +       priv->phy.label = "hi6220";
>>> +       priv->phy.type = USB_PHY_TYPE_USB2;
>>> +       otg->set_peripheral = hi6220_set_peripheral;
>>> +       platform_set_drvdata(pdev, priv);
>>> +
>>> +       priv->gpio_vbus = of_get_named_gpio(np, "hisilicon,gpio-vbus",
>>> 0);
>>> +       if (priv->gpio_vbus == -EPROBE_DEFER)
>>> +               return -EPROBE_DEFER;
>>> +       if (!gpio_is_valid(priv->gpio_vbus)) {
>>> +               dev_err(&pdev->dev, "invalid gpio %d\n",
>>> priv->gpio_vbus);
>>> +               return -ENODEV;
>>> +       }
>>> +
>>> +       priv->gpio_id = of_get_named_gpio(np, "hisilicon,gpio-id", 0);
>>> +       if (priv->gpio_id == -EPROBE_DEFER)
>>> +               return -EPROBE_DEFER;
>>> +       if (!gpio_is_valid(priv->gpio_id)) {
>>> +               dev_err(&pdev->dev, "invalid gpio %d\n", priv->gpio_id);
>>> +               return -ENODEV;
>>> +       }
>>> +
>>> +       priv->reg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>>> +                                       "hisilicon,peripheral-syscon");
>>> +       if (IS_ERR(priv->reg))
>>> +               priv->reg = NULL;
>>> +
>>
>>
>> see my comments at your v1.
>
> As replied in v1, EPROBE_DEFER does not needed.
> syscon is register far earlier.
>
>>
>>> +       INIT_DELAYED_WORK(&priv->work, hi6220_detect_work);
>>> +
>>> +       ret = devm_gpio_request_one(&pdev->dev, priv->gpio_vbus,
>>> +                                   GPIOF_IN, "gpio_vbus");
>>> +       if (ret < 0) {
>>> +               dev_err(&pdev->dev, "gpio request failed for
>>> gpio_vbus\n");
>>> +               return ret;
>>> +       }
>>> +
>>> +       ret = devm_gpio_request_one(&pdev->dev, priv->gpio_id,
>>> +                                   GPIOF_IN, "gpio_id");
>>> +       if (ret < 0) {
>>> +               dev_err(&pdev->dev, "gpio request failed for gpio_id\n");
>>> +               return ret;
>>> +       }
>>> +
>>> +       priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
>>> +       if (!IS_ERR(priv->vcc)) {
>>
>>
>> EPROBE_DEFER?
>
> No, this is not needed, since regulator is registered earlier than device.
>
> drivers/Makefile
> # regulators early, since some subsystems rely on them to initialize
> obj-$(CONFIG_REGULATOR)         += regulator/
>

After reconsideration, EPROBE_DEFER should be added here in case of module.

Thanks
