From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 15 Jul 2015 16:25:23 +0530
Subject: [PATCH v4 1/2] phy-sun4i-usb: Add full support for usb0 phy / OTG
In-Reply-To: <1433088626-8858-2-git-send-email-hdegoede@redhat.com>
References: <1433088626-8858-1-git-send-email-hdegoede@redhat.com>
 <1433088626-8858-2-git-send-email-hdegoede@redhat.com>
Message-ID: <55A63C1B.1010503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sunday 31 May 2015 09:40 PM, Hans de Goede wrote:
> The usb0 phy is connected to an OTG controller, and as such needs some special
> handling:
> 
> 1) It allows explicit control over the pullups, enable these on phy_init and
> disable them on phy_exit.
> 
> 2) It has bits to signal id and vbus detect to the musb-core, add support for
> for monitoring id and vbus detect gpio-s for use in dual role mode, and set
> these bits to the correct values for operating in host only mode when no
> gpios are specified in the devicetree.
> 
> 3) When in dual role mode the musb sunxi glue needs to know if the a host or
> device cable is plugged in, so when in dual role mode register an extcon.
> 
> While updating the devicetree binding documentation also add documentation
> for the sofar undocumented usage of regulators for vbus for all 3 phys.

merged this to linux-phy tree.

Cheers
Kishon
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Removed the sunxi specific phy functions, instead the id / vbus gpio polling
>  has been moved to the phy-sun4i-usb driver and their status is exported
>  through extcon for the sunxi-musb glue
> Changes in v3:
> -No changes
> Changes in v4:
> -Do not call regulator_disable in an unbalanced manner when an external vbus
>  is present
> ---
>  .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  18 +-
>  drivers/phy/Kconfig                                |   1 +
>  drivers/phy/phy-sun4i-usb.c                        | 273 ++++++++++++++++++++-
>  3 files changed, 281 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> index 16528b9..557fa99 100644
> --- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> @@ -23,6 +23,13 @@ Required properties:
>    * "usb1_reset"
>    * "usb2_reset" for sun4i, sun6i or sun7i
>  
> +Optional properties:
> +- usb0_id_det-gpios : gpio phandle for reading the otg id pin value
> +- usb0_vbus_det-gpios : gpio phandle for detecting the presence of usb0 vbus
> +- usb0_vbus-supply : regulator phandle for controller usb0 vbus
> +- usb1_vbus-supply : regulator phandle for controller usb1 vbus
> +- usb2_vbus-supply : regulator phandle for controller usb2 vbus
> +
>  Example:
>  	usbphy: phy at 0x01c13400 {
>  		#phy-cells = <1>;
> @@ -32,6 +39,13 @@ Example:
>  		reg-names = "phy_ctrl", "pmu1", "pmu2";
>  		clocks = <&usb_clk 8>;
>  		clock-names = "usb_phy";
> -		resets = <&usb_clk 1>, <&usb_clk 2>;
> -		reset-names = "usb1_reset", "usb2_reset";
> +		resets = <&usb_clk 0>, <&usb_clk 1>, <&usb_clk 2>;
> +		reset-names = "usb0_reset", "usb1_reset", "usb2_reset";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
> +		usb0_id_det-gpios = <&pio 7 19 GPIO_ACTIVE_HIGH>; /* PH19 */
> +		usb0_vbus_det-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
> +		usb0_vbus-supply = <&reg_usb0_vbus>;
> +		usb1_vbus-supply = <&reg_usb1_vbus>;
> +		usb2_vbus-supply = <&reg_usb2_vbus>;
>  	};
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index a53bd5b..4614fba 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -173,6 +173,7 @@ config PHY_SUN4I_USB
>  	tristate "Allwinner sunxi SoC USB PHY driver"
>  	depends on ARCH_SUNXI && HAS_IOMEM && OF
>  	depends on RESET_CONTROLLER
> +	select EXTCON
>  	select GENERIC_PHY
>  	help
>  	  Enable this to support the transceiver that is part of Allwinner
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> index 91c5be4..b45d707 100644
> --- a/drivers/phy/phy-sun4i-usb.c
> +++ b/drivers/phy/phy-sun4i-usb.c
> @@ -1,7 +1,7 @@
>  /*
>   * Allwinner sun4i USB phy driver
>   *
> - * Copyright (C) 2014 Hans de Goede <hdegoede@redhat.com>
> + * Copyright (C) 2014-2015 Hans de Goede <hdegoede@redhat.com>
>   *
>   * Based on code from
>   * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
> @@ -23,17 +23,23 @@
>  
>  #include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/extcon.h>
>  #include <linux/io.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_gpio.h>
>  #include <linux/phy/phy.h>
>  #include <linux/phy/phy-sun4i-usb.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> +#include <linux/workqueue.h>
> +
> +#define DRIVER_NAME "sun4i-usb-phy"
>  
>  #define REG_ISCR			0x00
>  #define REG_PHYCTL			0x04
> @@ -47,6 +53,17 @@
>  #define SUNXI_AHB_INCRX_ALIGN_EN	BIT(8)
>  #define SUNXI_ULPI_BYPASS_EN		BIT(0)
>  
> +/* ISCR, Interface Status and Control bits */
> +#define ISCR_ID_PULLUP_EN		(1 << 17)
> +#define ISCR_DPDM_PULLUP_EN	(1 << 16)
> +/* sunxi has the phy id/vbus pins not connected, so we use the force bits */
> +#define ISCR_FORCE_ID_MASK	(3 << 14)
> +#define ISCR_FORCE_ID_LOW		(2 << 14)
> +#define ISCR_FORCE_ID_HIGH	(3 << 14)
> +#define ISCR_FORCE_VBUS_MASK	(3 << 12)
> +#define ISCR_FORCE_VBUS_LOW	(2 << 12)
> +#define ISCR_FORCE_VBUS_HIGH	(3 << 12)
> +
>  /* Common Control Bits for Both PHYs */
>  #define PHY_PLL_BW			0x03
>  #define PHY_RES45_CAL_EN		0x0c
> @@ -63,6 +80,13 @@
>  
>  #define MAX_PHYS			3
>  
> +/*
> + * Note do not raise the debounce time, we must report Vusb high within 100ms
> + * otherwise we get Vbus errors
> + */
> +#define DEBOUNCE_TIME			msecs_to_jiffies(50)
> +#define POLL_TIME			msecs_to_jiffies(250)
> +
>  struct sun4i_usb_phy_data {
>  	void __iomem *base;
>  	struct mutex mutex;
> @@ -74,13 +98,58 @@ struct sun4i_usb_phy_data {
>  		struct regulator *vbus;
>  		struct reset_control *reset;
>  		struct clk *clk;
> +		bool regulator_on;
>  		int index;
>  	} phys[MAX_PHYS];
> +	/* phy0 / otg related variables */
> +	struct extcon_dev extcon;
> +	const char *extcon_cable_names[3];
> +	bool phy0_init;
> +	bool phy0_poll;
> +	struct gpio_desc *id_det_gpio;
> +	struct gpio_desc *vbus_det_gpio;
> +	int id_det_irq;
> +	int vbus_det_irq;
> +	int id_det;
> +	int vbus_det;
> +	struct delayed_work detect;
>  };
>  
>  #define to_sun4i_usb_phy_data(phy) \
>  	container_of((phy), struct sun4i_usb_phy_data, phys[(phy)->index])
>  
> +static void sun4i_usb_phy0_update_iscr(struct phy *_phy, u32 clr, u32 set)
> +{
> +	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
> +	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
> +	u32 iscr;
> +
> +	iscr = readl(data->base + REG_ISCR);
> +	iscr &= ~clr;
> +	iscr |= set;
> +	writel(iscr, data->base + REG_ISCR);
> +}
> +
> +static void sun4i_usb_phy0_set_id_detect(struct phy *phy, u32 val)
> +{
> +	if (val)
> +		val = ISCR_FORCE_ID_HIGH;
> +	else
> +		val = ISCR_FORCE_ID_LOW;
> +
> +	sun4i_usb_phy0_update_iscr(phy, ISCR_FORCE_ID_MASK, val);
> +}
> +
> +static void sun4i_usb_phy0_set_vbus_detect(struct phy *phy, u32 val)
> +{
> +	if (val)
> +		val = ISCR_FORCE_VBUS_HIGH;
> +	else
> +		val = ISCR_FORCE_VBUS_LOW;
> +
> +	sun4i_usb_phy0_update_iscr(phy, ISCR_FORCE_VBUS_MASK, val);
> +}
> +
>  static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
>  				int len)
>  {
> @@ -171,12 +240,39 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>  
>  	sun4i_usb_phy_passby(phy, 1);
>  
> +	if (phy->index == 0) {
> +		data->phy0_init = true;
> +
> +		/* Enable pull-ups */
> +		sun4i_usb_phy0_update_iscr(_phy, 0, ISCR_DPDM_PULLUP_EN);
> +		sun4i_usb_phy0_update_iscr(_phy, 0, ISCR_ID_PULLUP_EN);
> +
> +		if (data->id_det_gpio) {
> +			/* OTG mode, force ISCR and cable state updates */
> +			data->id_det = -1;
> +			data->vbus_det = -1;
> +			queue_delayed_work(system_wq, &data->detect, 0);
> +		} else {
> +			/* Host only mode */
> +			sun4i_usb_phy0_set_id_detect(_phy, 0);
> +			sun4i_usb_phy0_set_vbus_detect(_phy, 1);
> +		}
> +	}
> +
>  	return 0;
>  }
>  
>  static int sun4i_usb_phy_exit(struct phy *_phy)
>  {
>  	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
> +	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
> +
> +	if (phy->index == 0) {
> +		/* Disable pull-ups */
> +		sun4i_usb_phy0_update_iscr(_phy, ISCR_DPDM_PULLUP_EN, 0);
> +		sun4i_usb_phy0_update_iscr(_phy, ISCR_ID_PULLUP_EN, 0);
> +		data->phy0_init = false;
> +	}
>  
>  	sun4i_usb_phy_passby(phy, 0);
>  	reset_control_assert(phy->reset);
> @@ -188,20 +284,46 @@ static int sun4i_usb_phy_exit(struct phy *_phy)
>  static int sun4i_usb_phy_power_on(struct phy *_phy)
>  {
>  	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
> -	int ret = 0;
> +	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
> +	int ret;
> +
> +	if (!phy->vbus || phy->regulator_on)
> +		return 0;
> +
> +	/* For phy0 only turn on Vbus if we don't have an ext. Vbus */
> +	if (phy->index == 0 && data->vbus_det)
> +		return 0;
>  
> -	if (phy->vbus)
> -		ret = regulator_enable(phy->vbus);
> +	ret = regulator_enable(phy->vbus);
> +	if (ret)
> +		return ret;
>  
> -	return ret;
> +	phy->regulator_on = true;
> +
> +	/* We must report Vbus high within OTG_TIME_A_WAIT_VRISE msec. */
> +	if (phy->index == 0 && data->phy0_poll)
> +		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
> +
> +	return 0;
>  }
>  
>  static int sun4i_usb_phy_power_off(struct phy *_phy)
>  {
>  	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
> +	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
> +
> +	if (!phy->vbus || !phy->regulator_on)
> +		return 0;
>  
> -	if (phy->vbus)
> -		regulator_disable(phy->vbus);
> +	regulator_disable(phy->vbus);
> +	phy->regulator_on = false;
> +
> +	/*
> +	 * phy0 vbus typically slowly discharges, sometimes this causes the
> +	 * Vbus gpio to not trigger an edge irq on Vbus off, so force a rescan.
> +	 */
> +	if (phy->index == 0 && !data->phy0_poll)
> +		mod_delayed_work(system_wq, &data->detect, POLL_TIME);
>  
>  	return 0;
>  }
> @@ -221,6 +343,61 @@ static struct phy_ops sun4i_usb_phy_ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
> +{
> +	struct sun4i_usb_phy_data *data =
> +		container_of(work, struct sun4i_usb_phy_data, detect.work);
> +	struct phy *phy0 = data->phys[0].phy;
> +	int id_det, vbus_det, id_notify = 0, vbus_notify = 0;
> +
> +	id_det = gpiod_get_value_cansleep(data->id_det_gpio);
> +	vbus_det = gpiod_get_value_cansleep(data->vbus_det_gpio);
> +
> +	mutex_lock(&phy0->mutex);
> +
> +	if (!data->phy0_init) {
> +		mutex_unlock(&phy0->mutex);
> +		return;
> +	}
> +
> +	if (id_det != data->id_det) {
> +		sun4i_usb_phy0_set_id_detect(phy0, id_det);
> +		data->id_det = id_det;
> +		id_notify = 1;
> +	}
> +
> +	if (vbus_det != data->vbus_det) {
> +		sun4i_usb_phy0_set_vbus_detect(phy0, vbus_det);
> +		data->vbus_det = vbus_det;
> +		vbus_notify = 1;
> +	}
> +
> +	mutex_unlock(&phy0->mutex);
> +
> +	if (id_notify)
> +		extcon_set_cable_state(&data->extcon,
> +				       extcon_cable_name[EXTCON_USB_HOST],
> +				       !id_det);
> +
> +	if (vbus_notify)
> +		extcon_set_cable_state(&data->extcon,
> +				       extcon_cable_name[EXTCON_USB],
> +				       vbus_det);
> +
> +	if (data->phy0_poll)
> +		queue_delayed_work(system_wq, &data->detect, POLL_TIME);
> +}
> +
> +static irqreturn_t sun4i_usb_phy0_id_vbus_det_irq(int irq, void *dev_id)
> +{
> +	struct sun4i_usb_phy_data *data = dev_id;
> +
> +	/* vbus or id changed, let the pins settle and then scan them */
> +	mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static struct phy *sun4i_usb_phy_xlate(struct device *dev,
>  					struct of_phandle_args *args)
>  {
> @@ -240,13 +417,20 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>  	struct phy_provider *phy_provider;
>  	bool dedicated_clocks;
>  	struct resource *res;
> -	int i;
> +	int i, ret;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
>  	mutex_init(&data->mutex);
> +	INIT_DELAYED_WORK(&data->detect, sun4i_usb_phy0_id_vbus_det_scan);
> +	data->extcon_cable_names[0] = extcon_cable_name[EXTCON_USB_HOST];
> +	data->extcon_cable_names[1] = extcon_cable_name[EXTCON_USB];
> +	data->extcon_cable_names[2] = NULL;
> +	data->extcon.name = DRIVER_NAME;
> +	data->extcon.supported_cable = data->extcon_cable_names;
> +	data->extcon.dev.parent = dev;
>  
>  	if (of_device_is_compatible(np, "allwinner,sun5i-a13-usb-phy"))
>  		data->num_phys = 2;
> @@ -269,6 +453,34 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->base))
>  		return PTR_ERR(data->base);
>  
> +	data->id_det_gpio = devm_gpiod_get(dev, "usb0_id_det", GPIOD_IN);
> +	if (IS_ERR(data->id_det_gpio)) {
> +		if (PTR_ERR(data->id_det_gpio) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		data->id_det_gpio = NULL;
> +	}
> +
> +	data->vbus_det_gpio = devm_gpiod_get(dev, "usb0_vbus_det", GPIOD_IN);
> +	if (IS_ERR(data->vbus_det_gpio)) {
> +		if (PTR_ERR(data->vbus_det_gpio) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		data->vbus_det_gpio = NULL;
> +	}
> +
> +	/* We either want both gpio pins or neither (when in host mode) */
> +	if (!data->id_det_gpio != !data->vbus_det_gpio) {
> +		dev_err(dev, "failed to get id or vbus detect pin\n");
> +		return -ENODEV;
> +	}
> +
> +	if (data->id_det_gpio) {
> +		ret = devm_extcon_dev_register(dev, &data->extcon);
> +		if (ret) {
> +			dev_err(dev, "failed to register extcon: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	for (i = 0; i < data->num_phys; i++) {
>  		struct sun4i_usb_phy *phy = data->phys + i;
>  		char name[16];
> @@ -318,12 +530,54 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>  		phy_set_drvdata(phy->phy, &data->phys[i]);
>  	}
>  
> +	data->id_det_irq = gpiod_to_irq(data->id_det_gpio);
> +	data->vbus_det_irq = gpiod_to_irq(data->vbus_det_gpio);
> +	if (data->id_det_irq  < 0 || data->vbus_det_irq < 0)
> +		data->phy0_poll = true;
> +
> +	if (data->id_det_irq >= 0) {
> +		ret = devm_request_irq(dev, data->id_det_irq,
> +				sun4i_usb_phy0_id_vbus_det_irq,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				"usb0-id-det", data);
> +		if (ret) {
> +			dev_err(dev, "Err requesting id-det-irq: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (data->vbus_det_irq >= 0) {
> +		ret = devm_request_irq(dev, data->vbus_det_irq,
> +				sun4i_usb_phy0_id_vbus_det_irq,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				"usb0-vbus-det", data);
> +		if (ret) {
> +			dev_err(dev, "Err requesting vbus-det-irq: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	dev_set_drvdata(dev, data);
>  	phy_provider = devm_of_phy_provider_register(dev, sun4i_usb_phy_xlate);
>  
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
>  
> +static int sun4i_usb_phy_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sun4i_usb_phy_data *data = dev_get_drvdata(dev);
> +
> +	if (data->id_det_irq >= 0)
> +		devm_free_irq(dev, data->id_det_irq, data);
> +	if (data->vbus_det_irq >= 0)
> +		devm_free_irq(dev, data->vbus_det_irq, data);
> +
> +	cancel_delayed_work_sync(&data->detect);
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id sun4i_usb_phy_of_match[] = {
>  	{ .compatible = "allwinner,sun4i-a10-usb-phy" },
>  	{ .compatible = "allwinner,sun5i-a13-usb-phy" },
> @@ -335,9 +589,10 @@ MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
>  
>  static struct platform_driver sun4i_usb_phy_driver = {
>  	.probe	= sun4i_usb_phy_probe,
> +	.remove	= sun4i_usb_phy_remove,
>  	.driver = {
>  		.of_match_table	= sun4i_usb_phy_of_match,
> -		.name  = "sun4i-usb-phy",
> +		.name  = DRIVER_NAME,
>  	}
>  };
>  module_platform_driver(sun4i_usb_phy_driver);
> 
