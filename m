From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 6 Feb 2015 16:41:42 +0800
Subject: [PATCH 4/4] usb: phy: add phy-hi6220
In-Reply-To: <1423147620-5760-5-git-send-email-zhangfei.gao@linaro.org>
References: <1423147620-5760-1-git-send-email-zhangfei.gao@linaro.org>
 <1423147620-5760-5-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20150206084141.GE5007@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 10:47:00PM +0800, Zhangfei Gao wrote:
> Add usb phy controller for hi6220 platform
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/usb/phy/Kconfig      |   9 ++
>  drivers/usb/phy/Makefile     |   1 +
>  drivers/usb/phy/phy-hi6220.c | 290 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 300 insertions(+)
>  create mode 100644 drivers/usb/phy/phy-hi6220.c
> 
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index c6d0c8e..405a3d0 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -173,6 +173,15 @@ config USB_MXS_PHY
>  
>  	  MXS Phy is used by some of the i.MX SoCs, for example imx23/28/6x.
>  
> +config USB_HI6220_PHY
> +	tristate "hi6220 USB PHY support"
> +	select USB_PHY
> +	select MFD_SYSCON
> +	help
> +	  Enable this to support the HISILICON HI6220 USB PHY.
> +
> +	  To compile this driver as a module, choose M here.
> +
>  config USB_RCAR_PHY
>  	tristate "Renesas R-Car USB PHY support"
>  	depends on USB || USB_GADGET
> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
> index 75f2bba..819283c 100644
> --- a/drivers/usb/phy/Makefile
> +++ b/drivers/usb/phy/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_SAMSUNG_USBPHY)		+= phy-samsung-usb.o
>  obj-$(CONFIG_TWL6030_USB)		+= phy-twl6030-usb.o
>  obj-$(CONFIG_USB_EHCI_TEGRA)		+= phy-tegra-usb.o
>  obj-$(CONFIG_USB_GPIO_VBUS)		+= phy-gpio-vbus-usb.o
> +obj-$(CONFIG_USB_HI6220_PHY)		+= phy-hi6220.o

To align the naming method, phy-hi6220-usb is better.

>  obj-$(CONFIG_USB_ISP1301)		+= phy-isp1301.o
>  obj-$(CONFIG_USB_MSM_OTG)		+= phy-msm-usb.o
>  obj-$(CONFIG_USB_MV_OTG)		+= phy-mv-usb.o
> diff --git a/drivers/usb/phy/phy-hi6220.c b/drivers/usb/phy/phy-hi6220.c
> new file mode 100644
> index 0000000..87b1f0e
> --- /dev/null
> +++ b/drivers/usb/phy/phy-hi6220.c
> @@ -0,0 +1,290 @@
> +/*
> + * Copyright (c) 2015 Linaro Ltd.
> + * Copyright (c) 2015 Hisilicon Limited.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/usb/otg.h>
> +
> +#define SC_PERIPH_CTRL4			0x00c
> +
> +#define PERIPH_CTRL4_PICO_SIDDQ		BIT(6)
> +#define PERIPH_CTRL4_PICO_OGDISABLE	BIT(8)
> +#define PERIPH_CTRL4_PICO_VBUSVLDEXT	BIT(10)
> +#define PERIPH_CTRL4_PICO_VBUSVLDEXTSEL	BIT(11)
> +#define PERIPH_CTRL4_OTG_PHY_SEL	BIT(21)
> +
> +#define SC_PERIPH_CTRL5			0x010
> +
> +#define PERIPH_CTRL5_USBOTG_RES_SEL	BIT(3)
> +#define PERIPH_CTRL5_PICOPHY_ACAENB	BIT(4)
> +#define PERIPH_CTRL5_PICOPHY_BC_MODE	BIT(5)
> +#define PERIPH_CTRL5_PICOPHY_CHRGSEL	BIT(6)
> +#define PERIPH_CTRL5_PICOPHY_VDATSRCEND	BIT(7)
> +#define PERIPH_CTRL5_PICOPHY_VDATDETENB	BIT(8)
> +#define PERIPH_CTRL5_PICOPHY_DCDENB	BIT(9)
> +#define PERIPH_CTRL5_PICOPHY_IDDIG	BIT(10)
> +
> +#define SC_PERIPH_CTRL8			0x018
> +
> +#define EYE_PATTERN_PARA		0x7053348c
> +
> +#define SC_PERIPH_RSTDIS0		0x304
> +
> +#define PERIPH_RSTDIS0_USBOTG_BUS	BIT(4)
> +#define PERIPH_RSTDIS0_POR_PICOPHY	BIT(5)
> +#define PERIPH_RSTDIS0_USBOTG		BIT(6)
> +#define PERIPH_RSTDIS0_USBOTG_32K	BIT(7)
> +
> +enum usb_mode {
> +	USB_EMPTY,
> +	GADGET_DEVICE,
> +	OTG_HOST,
> +};

This usb_mode is a little strange, what state you would like to
use?

> +
> +struct hi6220_priv {
> +	struct usb_phy phy;
> +	struct delayed_work work;
> +	struct regmap *reg;
> +	struct clk *clk;
> +	struct regulator *vcc;
> +	int gpio_vbus_det;
> +	int gpio_id_det;
> +	enum usb_mode mode;
> +};
> +
> +static void hi6220_start_periphrals(struct hi6220_priv *priv, bool on)
> +{
> +	struct usb_otg *otg = priv->phy.otg;
> +
> +	if (!otg->gadget)
> +		return;
> +
> +	if (on)
> +		usb_gadget_connect(otg->gadget);
> +	else
> +		usb_gadget_disconnect(otg->gadget);
> +}
> +
> +static void hi6220_detect_work(struct work_struct *work)
> +{
> +	struct hi6220_priv *priv =
> +		container_of(work, struct hi6220_priv, work.work);
> +	int id_det, vbus_det;
> +	enum usb_mode mode;
> +
> +	if (!gpio_is_valid(priv->gpio_id_det) ||
> +	    !gpio_is_valid(priv->gpio_vbus_det))
> +		return;
> +
> +	id_det = gpio_get_value_cansleep(priv->gpio_id_det);
> +	vbus_det = gpio_get_value_cansleep(priv->gpio_vbus_det);
> +
> +	if (vbus_det == 0) {
> +		if (id_det == 1)
> +			mode = GADGET_DEVICE;
> +		else
> +			mode = OTG_HOST;
> +	} else {
> +		mode = USB_EMPTY;
> +	}
> +
> +	if (mode == GADGET_DEVICE && priv->mode == USB_EMPTY)
> +		hi6220_start_periphrals(priv, true);
> +	if (mode == USB_EMPTY && priv->mode == GADGET_DEVICE)
> +		hi6220_start_periphrals(priv, false);
> +
> +	priv->mode = mode;
> +}
> +
> +static irqreturn_t hiusb_gpio_intr(int irq, void *data)
> +{
> +	struct hi6220_priv *priv = (struct hi6220_priv *)data;
> +
> +	/* add debounce time */
> +	schedule_delayed_work(&priv->work, msecs_to_jiffies(100));
> +	return IRQ_HANDLED;
> +}
> +
> +static int mv_otg_set_peripheral(struct usb_otg *otg,

mv? You may want to use hi

> +				 struct usb_gadget *gadget)
> +{
> +	struct hi6220_priv *priv;
> +
> +	priv = container_of(otg->usb_phy, struct hi6220_priv, phy);
> +	otg->gadget = gadget;
> +	return 0;
> +}
> +
> +static void hi6220_phy_setup(struct hi6220_priv *priv)
> +{
> +	u32 val, mask;
> +	int ret;
> +
> +	if (priv->reg == NULL)
> +		return;
> +
> +	val = PERIPH_RSTDIS0_USBOTG_BUS | PERIPH_RSTDIS0_POR_PICOPHY |
> +	      PERIPH_RSTDIS0_USBOTG | PERIPH_RSTDIS0_USBOTG_32K;
> +	mask = val;
> +	ret = regmap_update_bits(priv->reg, SC_PERIPH_RSTDIS0, mask, val);
> +	if (ret)
> +		return;
> +
> +	ret = regmap_read(priv->reg, SC_PERIPH_CTRL5, &val);
> +	val = PERIPH_CTRL5_USBOTG_RES_SEL | PERIPH_CTRL5_PICOPHY_ACAENB;
> +	mask = val | PERIPH_CTRL5_PICOPHY_BC_MODE;
> +	ret = regmap_update_bits(priv->reg, SC_PERIPH_CTRL5, mask, val);
> +	if (ret)
> +		return;
> +
> +	val =  PERIPH_CTRL4_PICO_VBUSVLDEXT | PERIPH_CTRL4_PICO_VBUSVLDEXTSEL |
> +	       PERIPH_CTRL4_OTG_PHY_SEL;
> +	mask = val | PERIPH_CTRL4_PICO_SIDDQ | PERIPH_CTRL4_PICO_OGDISABLE;
> +	ret = regmap_update_bits(priv->reg, SC_PERIPH_CTRL4, mask, val);
> +	if (ret)
> +		return;
> +
> +	ret = regmap_write(priv->reg, SC_PERIPH_CTRL8, EYE_PATTERN_PARA);
> +	if (ret)
> +		return;
> +}
> +
> +static int hi6220_phy_probe(struct platform_device *pdev)
> +{
> +	struct hi6220_priv *priv;
> +	struct usb_otg *otg;
> +	struct device_node *np = pdev->dev.of_node;
> +	int ret, irq;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
> +	if (!otg)
> +		return -ENOMEM;
> +
> +	priv->phy.dev = &pdev->dev;
> +	priv->phy.otg = otg;
> +	priv->phy.label = "hi6220";
> +	platform_set_drvdata(pdev, priv);
> +	otg->set_peripheral = mv_otg_set_peripheral;
> +
> +	priv->gpio_vbus_det = of_get_named_gpio(np, "hisilicon,gpio_vbus_det", 0);
> +	if (priv->gpio_vbus_det == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +	if (!gpio_is_valid(priv->gpio_vbus_det)) {
> +		dev_err(&pdev->dev, "invalid gpio %d\n", priv->gpio_vbus_det);
> +		return -ENODEV;
> +	}
> +
> +	priv->gpio_id_det = of_get_named_gpio(np, "hisilicon,gpio_id_det", 0);
> +	if (priv->gpio_id_det == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +	if (!gpio_is_valid(priv->gpio_id_det)) {
> +		dev_err(&pdev->dev, "invalid gpio %d\n", priv->gpio_id_det);
> +		return -ENODEV;
> +	}
> +
> +	priv->reg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +					"hisilicon,peripheral-syscon");
> +	if (IS_ERR(priv->reg))
> +		priv->reg = NULL;

You may differentiate -ENODEV and other errors, for other errors, you 
can show an error, and return directly.

> +
> +	INIT_DELAYED_WORK(&priv->work, hi6220_detect_work);
> +
> +	ret = devm_gpio_request_one(&pdev->dev, priv->gpio_vbus_det,
> +				    GPIOF_IN, "gpio_vbus_det");
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "gpio request failed for gpio_vbus_det\n");
> +		return ret;
> +	}
> +
> +	ret = devm_gpio_request_one(&pdev->dev, priv->gpio_id_det,
> +				    GPIOF_IN, "gpio_id_det");
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "gpio request failed for gpio_id_det\n");
> +		return ret;
> +	}
> +
> +	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
> +	if (!IS_ERR(priv->vcc)) {
> +		ret = regulator_enable(priv->vcc);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to enable regulator\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		regulator_disable(priv->vcc);
> +		return PTR_ERR(priv->clk);
> +	}
> +	clk_prepare_enable(priv->clk);
> +
> +	irq = gpio_to_irq(priv->gpio_vbus_det);
> +	ret = devm_request_irq(&pdev->dev, gpio_to_irq(priv->gpio_vbus_det),
> +			       hiusb_gpio_intr, IRQF_NO_SUSPEND |
> +			       IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> +			       "vbus_gpio_intr", priv);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request gpio irq failed.\n");
> +		goto err_irq;
> +	}

You may put the devm_request_irq to the last, in case, the unexpected
interrupt occurs during the setup.

> +
> +	hi6220_phy_setup(priv);
> +	ret = usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);

Use usb_add_phy_dev please, see the doc for usb_add_phy.

> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't register transceiver\n");
> +		goto err_irq;
> +	}
> +	schedule_delayed_work(&priv->work, 0);
> +
> +	return 0;
> +err_irq:
> +	clk_disable_unprepare(priv->clk);
> +	regulator_disable(priv->vcc);
> +	return ret;
> +}
> +
> +static int hi6220_phy_remove(struct platform_device *pdev)
> +{
> +	struct hi6220_priv *priv = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(priv->clk);
> +	regulator_disable(priv->vcc);
> +	return 0;
> +}
> +
> +static const struct of_device_id hi6220_phy_of_match[] = {
> +	{.compatible = "hisilicon,hi6220-usb-phy",},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, hi6220_phy_of_match);
> +
> +static struct platform_driver hi6220_phy_driver = {
> +	.probe	= hi6220_phy_probe,
> +	.remove	= hi6220_phy_remove,
> +	.driver = {
> +		.name	= "hi6220-usb-phy",
> +		.of_match_table	= hi6220_phy_of_match,
> +	}
> +};
> +module_platform_driver(hi6220_phy_driver);
> +
> +MODULE_DESCRIPTION("HISILICON HI6220 USB PHY driver");
> +MODULE_ALIAS("platform:hi6220-usb-phy");
> +MODULE_LICENSE("GPL");
> -- 

-- 

Best Regards,
Peter Chen
