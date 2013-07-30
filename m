From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 30 Jul 2013 14:09:57 +0800
Subject: [RFC 5/8] pinctrl: imx27: imx27 pincontrol driver
In-Reply-To: <1374938808-27316-6-git-send-email-mpa@pengutronix.de>
References: <1374938808-27316-1-git-send-email-mpa@pengutronix.de>
 <1374938808-27316-6-git-send-email-mpa@pengutronix.de>
Message-ID: <20130730060955.GA12382@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 05:26:45PM +0200, Markus Pargmann wrote:
> +static struct imx_pinctrl_soc_info imx27_pinctrl_info = {
> + .pins = imx27_pinctrl_pads,
> + .npins = ARRAY_SIZE(imx27_pinctrl_pads),
> +};
> +
> +static struct of_device_id imx27_pinctrl_of_match[] = {
> + { .compatible = "fsl,imx27-iomuxc", },
> + { /* sentinel */ }
> +};
> +
> +static struct of_device_id imx21_gpio_of_match[] = {
> + { .compatible = "fsl,imx21-gpio", },

Since we also have "fsl,imx27-gpio" in the compatible string, we can
use it here.

> + { /* sentinel */ }
> +};
> +
> +struct imx27_pinctrl_private {
> + int num_gpio_childs;

Maybe I missed something.  But I see this member is used nowhere.

> + struct platform_device **gpio_dev;
> + struct mxc_gpio_platform_data *gpio_pdata;
> +};

I do not see too much point to have this structure at all.

Shawn

> +
> +static int imx27_pinctrl_probe(struct platform_device *pdev)
> +{
> + struct device_node *child;
> + struct imx_pinctrl *ipctl;
> + struct imx27_pinctrl_private *pctl;
> + int ret;
> + u32 base_addr;
> + int num_gpios = 0;
> + int i = 0;
> +
> + ret = of_property_read_u32(pdev->dev.of_node, "reg", &base_addr);
> + if (ret)
> + return ret;
> +
> + ret = imx_pinctrl_probe(pdev, &imx27_pinctrl_info);
> + if (ret)
> + return ret;
> +
> + pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
> + if (!pctl)
> + return -ENOMEM;
> +
> + ipctl = platform_get_drvdata(pdev);
> +
> + for_each_available_child_of_node(pdev->dev.of_node, child) {
> + u32 memoffset;
> + if (!of_match_node(imx21_gpio_of_match, child))
> + continue;
> + ret = of_property_read_u32(child, "reg", &memoffset);
> + if (ret)
> + continue;
> + ++num_gpios;
> + }
> +
> + pctl->num_gpio_childs = num_gpios;
> + pctl->gpio_dev = devm_kzalloc(&pdev->dev,
> + sizeof(*pctl->gpio_dev) * num_gpios, GFP_KERNEL);
> + pctl->gpio_pdata = devm_kzalloc(&pdev->dev,
> + sizeof(*pctl->gpio_pdata) * num_gpios, GFP_KERNEL);
> +
> + if (!pctl->gpio_pdata || !pctl->gpio_dev)
> + return -ENOMEM;
> +
> +
> + for_each_available_child_of_node(pdev->dev.of_node, child) {
> + u32 memoffset;
> +
> + if (!of_match_node(imx21_gpio_of_match, child))
> + continue;
> + ret = of_property_read_u32(child, "reg", &memoffset);
> + if (ret)
> + continue;
> +
> + memoffset -= base_addr;
> + pctl->gpio_pdata[i].base = ipctl->base + memoffset;
> +
> + pctl->gpio_dev[i] = of_device_alloc(child, NULL, &pdev->dev);
> + pctl->gpio_dev[i]->dev.platform_data = &pctl->gpio_pdata[i];
> + pctl->gpio_dev[i]->dev.bus = &platform_bus_type;
> +
> + ret = of_device_add(pctl->gpio_dev[i]);
> + if (ret) {
> + dev_err(&pdev->dev,
> + "Failed to add child gpio device\n");
> + goto gpio_err;
> + }
> + ++i;
> + }
> + return 0;
> +gpio_err:
> + while (i--)
> + put_device(&pctl->gpio_dev[i]->dev);
> + return ret;
> +}
> +
> +static struct platform_driver imx27_pinctrl_driver = {
> + .driver = {
> + .name = "imx27-pinctrl",
> + .owner = THIS_MODULE,
> + .of_match_table = of_match_ptr(imx27_pinctrl_of_match),
> + },
> + .probe = imx27_pinctrl_probe,
> + .remove = imx_pinctrl_remove,
> +};
> +
> +static int __init imx27_pinctrl_init(void)
> +{
> + return platform_driver_register(&imx27_pinctrl_driver);
> +}
> +arch_initcall(imx27_pinctrl_init);
> +
> +static void __exit imx27_pinctrl_exit(void)
> +{
> + platform_driver_unregister(&imx27_pinctrl_driver);
> +}
> +module_exit(imx27_pinctrl_exit);
> +MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
> +MODULE_DESCRIPTION("Freescale IMX27 pinctrl driver");
> +MODULE_LICENSE("GPL v2");
> --
> 1.8.3.2
>
