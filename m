From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Mon, 9 Feb 2015 11:31:55 +0800
Subject: [PATCH 4/4] usb: phy: add phy-hi6220
In-Reply-To: <20150209015734.GA3045@shlinux2>
References: <1423147620-5760-1-git-send-email-zhangfei.gao@linaro.org>
 <1423147620-5760-5-git-send-email-zhangfei.gao@linaro.org>
 <20150206084141.GE5007@shlinux2>
 <CABQgh9GfmoeLo-HnhM=sk-XBw1KoLMsa=RZZWkHu-hGPpMK+=A@mail.gmail.com>
 <20150209015734.GA3045@shlinux2>
Message-ID: <CABQgh9GGJgArv12a0cWgTyKMgUXhvojr+Z_-sM=8ceY+i5rMmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 February 2015 at 09:57, Peter Chen <peter.chen@freescale.com> wrote:
>> >> +static int hi6220_phy_probe(struct platform_device *pdev)
>> >> +{
>> >> +     struct hi6220_priv *priv;
>> >> +     struct usb_otg *otg;
>> >> +     struct device_node *np = pdev->dev.of_node;
>> >> +     int ret, irq;
>> >> +
>> >> +     priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> >> +     if (!priv)
>> >> +             return -ENOMEM;
>> >> +
>> >> +     otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
>> >> +     if (!otg)
>> >> +             return -ENOMEM;
>> >> +
>> >> +     priv->phy.dev = &pdev->dev;
>> >> +     priv->phy.otg = otg;
>> >> +     priv->phy.label = "hi6220";
>> >> +     platform_set_drvdata(pdev, priv);
>> >> +     otg->set_peripheral = mv_otg_set_peripheral;
>> >> +
>> >> +     priv->gpio_vbus_det = of_get_named_gpio(np, "hisilicon,gpio_vbus_det", 0);
>> >> +     if (priv->gpio_vbus_det == -EPROBE_DEFER)
>> >> +             return -EPROBE_DEFER;
>> >> +     if (!gpio_is_valid(priv->gpio_vbus_det)) {
>> >> +             dev_err(&pdev->dev, "invalid gpio %d\n", priv->gpio_vbus_det);
>> >> +             return -ENODEV;
>> >> +     }
>> >> +
>> >> +     priv->gpio_id_det = of_get_named_gpio(np, "hisilicon,gpio_id_det", 0);
>> >> +     if (priv->gpio_id_det == -EPROBE_DEFER)
>> >> +             return -EPROBE_DEFER;
>> >> +     if (!gpio_is_valid(priv->gpio_id_det)) {
>> >> +             dev_err(&pdev->dev, "invalid gpio %d\n", priv->gpio_id_det);
>> >> +             return -ENODEV;
>> >> +     }
>> >> +
>> >> +     priv->reg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>> >> +                                     "hisilicon,peripheral-syscon");
>> >> +     if (IS_ERR(priv->reg))
>> >> +             priv->reg = NULL;
>> >
>> > You may differentiate -ENODEV and other errors, for other errors, you
>> > can show an error, and return directly.
>>
>> Here I want to set this property as optional, in case other platform
>> do not need this property.
>> So phy_setup also add protection if (priv->reg == NULL) return;
>>
>
> If syscon_regmap_lookup_by_phandle returns -EPROBE_DEFER, you may want
> to try later.
>
It should not.
syscon is postcore_initcall(syscon_init);

Thanks
