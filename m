From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 29 Aug 2012 10:50:08 +0300
Subject: [PATCH v6 1/3] USB: chipidea: add imx usbmisc support
In-Reply-To: <1346137109-32247-2-git-send-email-richard.zhao@freescale.com>
References: <1346137109-32247-1-git-send-email-richard.zhao@freescale.com>
 <1346137109-32247-2-git-send-email-richard.zhao@freescale.com>
Message-ID: <871uiqkuhb.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Zhao <richard.zhao@freescale.com> writes:

> i.MX usb controllers shares non-core registers, which may include
> SoC specific controls. We take it as a usbmisc device and usbmisc
> driver set operations needed by ci13xxx_imx driver.
>
> For example, Sabrelite board has bad over-current design, we can
> usbmisc to disable over-current detect.

Why does this have to be part of the usb driver instead of SoC specific
code? It looks like you've created a whole new device/driver
infrastructure just to disable overcurrent for a specific board.

And the infrastructure boils down to a complex way of passing a callback
from imx driver to another imx driver, that only works if they are
probed in the right order. I don't see any point in doing it like this
other than inflating the device tree tables even further.

Why can't this be part of the SoC code like it is done, for example in
arch/arm/mach-omap2/control.c?

Regards,
--
Alex

> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    5 +
>  .../devicetree/bindings/usb/usbmisc-imx.txt        |   14 ++
>  drivers/usb/chipidea/Makefile                      |    2 +-
>  drivers/usb/chipidea/ci13xxx_imx.c                 |   64 ++++++++
>  drivers/usb/chipidea/ci13xxx_imx.h                 |   28 ++++
>  drivers/usb/chipidea/usbmisc_imx6q.c               |  162 ++++++++++++++++++++
>  6 files changed, 274 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
>  create mode 100644 drivers/usb/chipidea/ci13xxx_imx.h
>  create mode 100644 drivers/usb/chipidea/usbmisc_imx6q.c
>
> diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> index 2c29041..5778b9c 100644
> --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> @@ -7,7 +7,10 @@ Required properties:
>  
>  Optional properties:
>  - fsl,usbphy: phandler of usb phy that connects to the only one port
> +- fsl,usbmisc: phandler of non-core register device, with one argument
> +  that indicate usb controller index
>  - vbus-supply: regulator for vbus
> +- disable-over-current: disable over current detect
>  
>  Examples:
>  usb at 02184000 { /* USB OTG */
> @@ -15,4 +18,6 @@ usb at 02184000 { /* USB OTG */
>  	reg = <0x02184000 0x200>;
>  	interrupts = <0 43 0x04>;
>  	fsl,usbphy = <&usbphy1>;
> +	fsl,usbmisc = <&usbmisc 0>;
> +	disable-over-current;
>  };
> diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> new file mode 100644
> index 0000000..97ce94e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> @@ -0,0 +1,14 @@
> +* Freescale i.MX non-core registers
> +
> +Required properties:
> +- #index-cells: Cells used to descibe usb controller index. Should be <1>
> +- compatible: Should be one of below:
> +	"fsl,imx6q-usbmisc" for imx6q
> +- reg: Should contain registers location and length
> +
> +Examples:
> +usbmisc at 02184800 {
> +	#index-cells = <1>;
> +	compatible = "fsl,imx6q-usbmisc";
> +	reg = <0x02184800 0x200>;
> +};
> diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> index 5c66d9c..57e510f 100644
> --- a/drivers/usb/chipidea/Makefile
> +++ b/drivers/usb/chipidea/Makefile
> @@ -15,5 +15,5 @@ ifneq ($(CONFIG_PCI),)
>  endif
>  
>  ifneq ($(CONFIG_OF_DEVICE),)
> -	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o
> +	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o usbmisc_imx6q.o
>  endif
> diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
> index ef60d06..96ac67b 100644
> --- a/drivers/usb/chipidea/ci13xxx_imx.c
> +++ b/drivers/usb/chipidea/ci13xxx_imx.c
> @@ -22,6 +22,7 @@
>  #include <linux/regulator/consumer.h>
>  
>  #include "ci.h"
> +#include "ci13xxx_imx.h"
>  
>  #define pdev_to_phy(pdev) \
>  	((struct usb_phy *)platform_get_drvdata(pdev))
> @@ -34,6 +35,55 @@ struct ci13xxx_imx_data {
>  	struct regulator *reg_vbus;
>  };
>  
> +static const struct usbmisc_ops *usbmisc_ops;
> +
> +/* Common functions shared by usbmisc drivers */
> +
> +int usbmisc_set_ops(const struct usbmisc_ops *ops)
> +{
> +	if (usbmisc_ops)
> +		return -EBUSY;
> +
> +	usbmisc_ops = ops;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usbmisc_set_ops);
> +
> +void usbmisc_unset_ops(const struct usbmisc_ops *ops)
> +{
> +	usbmisc_ops = NULL;
> +}
> +EXPORT_SYMBOL_GPL(usbmisc_unset_ops);
> +
> +int usbmisc_get_init_data(struct device *dev, struct usbmisc_usb_device *usbdev)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct of_phandle_args args;
> +	int ret;
> +
> +	usbdev->dev = dev;
> +
> +	ret = of_parse_phandle_with_args(np, "fsl,usbmisc", "#index-cells",
> +					0, &args);
> +	if (ret) {
> +		dev_err(dev, "Failed to parse property fsl,usbmisc, errno %d\n",
> +			ret);
> +		memset(usbdev, 0, sizeof(*usbdev));
> +		return ret;
> +	}
> +	usbdev->index = args.args[0];
> +	of_node_put(args.np);
> +
> +	if (of_find_property(np, "disable-over-current", NULL))
> +		usbdev->disable_oc = 1;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usbmisc_get_init_data);
> +
> +/* End of common functions shared by usbmisc drivers*/
> +
>  static struct ci13xxx_platform_data ci13xxx_imx_platdata __devinitdata  = {
>  	.name			= "ci13xxx_imx",
>  	.flags			= CI13XXX_REQUIRE_TRANSCEIVER |
> @@ -51,6 +101,10 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
>  	struct regulator *reg_vbus;
>  	int ret;
>  
> +	if (of_find_property(pdev->dev.of_node, "fsl,usbmisc", NULL)
> +		&& !usbmisc_ops)
> +		return -EPROBE_DEFER;
> +
>  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>  	if (!data) {
>  		dev_err(&pdev->dev, "Failed to allocate CI13xxx-IMX data!\n");
> @@ -120,6 +174,16 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
>  		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
>  		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
>  	}
> +
> +	if (usbmisc_ops && usbmisc_ops->init) {
> +		ret = usbmisc_ops->init(&pdev->dev);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"usbmisc init failed, ret=%d\n", ret);
> +			goto err;
> +		}
> +	}
> +
>  	plat_ci = ci13xxx_add_device(&pdev->dev,
>  				pdev->resource, pdev->num_resources,
>  				&ci13xxx_imx_platdata);
> diff --git a/drivers/usb/chipidea/ci13xxx_imx.h b/drivers/usb/chipidea/ci13xxx_imx.h
> new file mode 100644
> index 0000000..2e88acc
> --- /dev/null
> +++ b/drivers/usb/chipidea/ci13xxx_imx.h
> @@ -0,0 +1,28 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/* Used to set SoC specific callbacks */
> +struct usbmisc_ops {
> +	/* It's called once when probe a usb device */
> +	int (*init)(struct device *dev);
> +};
> +
> +struct usbmisc_usb_device {
> +	struct device *dev; /* usb controller device */
> +	int index;
> +
> +	int disable_oc:1; /* over current detect disabled */
> +};
> +
> +int usbmisc_set_ops(const struct usbmisc_ops *ops);
> +void usbmisc_unset_ops(const struct usbmisc_ops *ops);
> +int
> +usbmisc_get_init_data(struct device *dev, struct usbmisc_usb_device *usbdev);
> diff --git a/drivers/usb/chipidea/usbmisc_imx6q.c b/drivers/usb/chipidea/usbmisc_imx6q.c
> new file mode 100644
> index 0000000..416e3fc
> --- /dev/null
> +++ b/drivers/usb/chipidea/usbmisc_imx6q.c
> @@ -0,0 +1,162 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +
> +#include "ci13xxx_imx.h"
> +
> +#define USB_DEV_MAX 4
> +
> +#define BM_OVER_CUR_DIS		BIT(7)
> +
> +struct imx6q_usbmisc {
> +	void __iomem *base;
> +	spinlock_t lock;
> +	struct clk *clk;
> +	struct usbmisc_usb_device usbdev[USB_DEV_MAX];
> +};
> +
> +static struct imx6q_usbmisc *usbmisc;
> +
> +static struct usbmisc_usb_device *get_usbdev(struct device *dev)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < USB_DEV_MAX; i++) {
> +		if (usbmisc->usbdev[i].dev == dev)
> +			return &usbmisc->usbdev[i];
> +		else if (!usbmisc->usbdev[i].dev)
> +			break;
> +	}
> +
> +	if (i >= USB_DEV_MAX)
> +		return ERR_PTR(-EBUSY);
> +
> +	ret = usbmisc_get_init_data(dev, &usbmisc->usbdev[i]);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return &usbmisc->usbdev[i];
> +}
> +
> +static int usbmisc_imx6q_init(struct device *dev)
> +{
> +
> +	struct usbmisc_usb_device *usbdev;
> +	unsigned long flags;
> +	u32 reg;
> +
> +	usbdev = get_usbdev(dev);
> +	if (IS_ERR(usbdev))
> +		return PTR_ERR(usbdev);
> +
> +	if (usbdev->disable_oc) {
> +		spin_lock_irqsave(&usbmisc->lock, flags);
> +		reg = readl(usbmisc->base + usbdev->index * 4);
> +		writel(reg | BM_OVER_CUR_DIS,
> +			usbmisc->base + usbdev->index * 4);
> +		spin_unlock_irqrestore(&usbmisc->lock, flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct usbmisc_ops imx6q_usbmisc_ops = {
> +	.init = usbmisc_imx6q_init,
> +};
> +
> +static const struct of_device_id usbmisc_imx6q_dt_ids[] = {
> +	{ .compatible = "fsl,imx6q-usbmisc"},
> +	{ /* sentinel */ }
> +};
> +
> +static int __devinit usbmisc_imx6q_probe(struct platform_device *pdev)
> +{
> +	struct resource	*res;
> +	struct imx6q_usbmisc *data;
> +	int ret;
> +
> +	if (usbmisc)
> +		return -EBUSY;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&data->lock);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->base = devm_request_and_ioremap(&pdev->dev, res);
> +	if (!data->base)
> +		return -EADDRNOTAVAIL;
> +
> +	data->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->clk)) {
> +		dev_err(&pdev->dev,
> +			"failed to get clock, err=%ld\n", PTR_ERR(data->clk));
> +		return PTR_ERR(data->clk);
> +	}
> +
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"clk_prepare_enable failed, err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = usbmisc_set_ops(&imx6q_usbmisc_ops);
> +	if (ret) {
> +		clk_disable_unprepare(data->clk);
> +		return ret;
> +	}
> +
> +	usbmisc = data;
> +
> +	return 0;
> +}
> +
> +static int __devexit usbmisc_imx6q_remove(struct platform_device *pdev)
> +{
> +	usbmisc_unset_ops(&imx6q_usbmisc_ops);
> +	clk_disable_unprepare(usbmisc->clk);
> +	return 0;
> +}
> +
> +static struct platform_driver usbmisc_imx6q_driver = {
> +	.probe = usbmisc_imx6q_probe,
> +	.remove = __devexit_p(usbmisc_imx6q_remove),
> +	.driver = {
> +		.name = "usbmisc_imx6q",
> +		.owner = THIS_MODULE,
> +		.of_match_table = usbmisc_imx6q_dt_ids,
> +	 },
> +};
> +
> +int __init usbmisc_imx6q_drv_init(void)
> +{
> +	return platform_driver_register(&usbmisc_imx6q_driver);
> +}
> +subsys_initcall(usbmisc_imx6q_drv_init);
> +
> +void __exit usbmisc_imx6q_drv_exit(void)
> +{
> +	platform_driver_unregister(&usbmisc_imx6q_driver);
> +}
> +module_exit(usbmisc_imx6q_drv_exit);
> +
> +MODULE_ALIAS("platform:usbmisc-imx6q");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("driver for imx6q usb non-core registers");
> +MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>");
> -- 
> 1.7.9.5
