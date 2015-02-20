From: balbi@ti.com (Felipe Balbi)
Date: Fri, 20 Feb 2015 08:41:19 -0600
Subject: [PATCH v4 4/4] phy: add phy-hi6220-usb
In-Reply-To: <1423726646-30336-5-git-send-email-zhangfei.gao@linaro.org>
References: <1423726646-30336-1-git-send-email-zhangfei.gao@linaro.org>
 <1423726646-30336-5-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20150220144119.GB1707@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 12, 2015 at 03:37:26PM +0800, Zhangfei Gao wrote:
> Add usb phy controller for hi6220 platform
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/phy/Kconfig          |   9 ++
>  drivers/phy/Makefile         |   1 +
>  drivers/phy/phy-hi6220-usb.c | 306 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 316 insertions(+)
>  create mode 100644 drivers/phy/phy-hi6220-usb.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index ccad880..40a1ef1 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -162,6 +162,15 @@ config PHY_HIX5HD2_SATA
>  	help
>  	  Support for SATA PHY on Hisilicon hix5hd2 Soc.
>  
> +config PHY_HI6220_USB
> +	tristate "hi6220 USB PHY support"
> +	select USB_PHY
> +	select MFD_SYSCON
> +	help
> +	  Enable this to support the HISILICON HI6220 USB PHY.
> +
> +	  To compile this driver as a module, choose M here.
> +
>  config PHY_SUN4I_USB
>  	tristate "Allwinner sunxi SoC USB PHY driver"
>  	depends on ARCH_SUNXI && HAS_IOMEM && OF
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index aa74f96..ec43c2d 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
>  obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
>  obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
>  obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
> +obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
>  obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
>  obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
>  phy-exynos-usb2-y			+= phy-samsung-usb2.o
> diff --git a/drivers/phy/phy-hi6220-usb.c b/drivers/phy/phy-hi6220-usb.c
> new file mode 100644
> index 0000000..0d9f5ac
> --- /dev/null
> +++ b/drivers/phy/phy-hi6220-usb.c
> @@ -0,0 +1,306 @@
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
> +#define CTRL4_PICO_SIDDQ		BIT(6)
> +#define CTRL4_PICO_OGDISABLE		BIT(8)
> +#define CTRL4_PICO_VBUSVLDEXT		BIT(10)
> +#define CTRL4_PICO_VBUSVLDEXTSEL	BIT(11)
> +#define CTRL4_OTG_PHY_SEL		BIT(21)
> +
> +#define SC_PERIPH_CTRL5			0x010
> +
> +#define CTRL5_USBOTG_RES_SEL		BIT(3)
> +#define CTRL5_PICOPHY_ACAENB		BIT(4)
> +#define CTRL5_PICOPHY_BC_MODE		BIT(5)
> +#define CTRL5_PICOPHY_CHRGSEL		BIT(6)
> +#define CTRL5_PICOPHY_VDATSRCEND	BIT(7)
> +#define CTRL5_PICOPHY_VDATDETENB	BIT(8)
> +#define CTRL5_PICOPHY_DCDENB		BIT(9)
> +#define CTRL5_PICOPHY_IDDIG		BIT(10)
> +
> +#define SC_PERIPH_CTRL8			0x018
> +#define SC_PERIPH_RSTEN0		0x300
> +#define SC_PERIPH_RSTDIS0		0x304
> +
> +#define RST0_USBOTG_BUS			BIT(4)
> +#define RST0_POR_PICOPHY		BIT(5)
> +#define RST0_USBOTG			BIT(6)
> +#define RST0_USBOTG_32K			BIT(7)
> +
> +#define EYE_PATTERN_PARA		0x7053348c
> +
> +struct hi6220_priv {
> +	struct usb_phy phy;
> +	struct delayed_work work;
> +	struct regmap *reg;
> +	struct clk *clk;
> +	struct regulator *vcc;
> +	struct device *dev;
> +	int gpio_vbus;
> +	int gpio_id;
> +	enum usb_otg_state state;
> +};
> +
> +static void hi6220_start_peripheral(struct hi6220_priv *priv, bool on)
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

why is the PHY fiddling with pullups ?

> +}
> +
> +static void hi6220_detect_work(struct work_struct *work)
> +{
> +	struct hi6220_priv *priv =
> +		container_of(work, struct hi6220_priv, work.work);
> +	int gpio_id, gpio_vbus;
> +	enum usb_otg_state state;
> +
> +	if (!gpio_is_valid(priv->gpio_id) || !gpio_is_valid(priv->gpio_vbus))
> +		return;
> +
> +	gpio_id = gpio_get_value_cansleep(priv->gpio_id);
> +	gpio_vbus = gpio_get_value_cansleep(priv->gpio_vbus);

looks like this should be using extcon

> +
> +	if (gpio_vbus == 0) {
> +		if (gpio_id == 1)
> +			state = OTG_STATE_B_PERIPHERAL;
> +		else
> +			state = OTG_STATE_A_HOST;
> +	} else {
> +		state = OTG_STATE_A_HOST;
> +	}
> +
> +	if (priv->state != state) {
> +		hi6220_start_peripheral(priv, state == OTG_STATE_B_PERIPHERAL);
> +		priv->state = state;
> +	}
> +}
> +
> +static irqreturn_t hiusb_gpio_intr(int irq, void *data)
> +{
> +	struct hi6220_priv *priv = (struct hi6220_priv *)data;
> +
> +	/* add debounce time */
> +	schedule_delayed_work(&priv->work, msecs_to_jiffies(100));

this is really bad. We have threaded interrupt support, right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150220/014b497e/attachment.sig>
