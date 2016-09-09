From: pantelis.antoniou@konsulko.com (Pantelis Antoniou)
Date: Fri, 9 Sep 2016 22:13:20 +0300
Subject: [RFC] misc: Add Allwinner Q8 tablet hardware manager
In-Reply-To: <20160901190820.21987-2-hdegoede@redhat.com>
References: <20160901190820.21987-1-hdegoede@redhat.com>
 <20160901190820.21987-2-hdegoede@redhat.com>
Message-ID: <9E68DE9D-31CE-4F2D-9852-684A8B28A181@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

> On Sep 1, 2016, at 22:08 , Hans de Goede <hdegoede@redhat.com> wrote:
> 
> Allwinnner A13 / A23 / A33 based Q8 tablets are popular cheap 7" tablets
> of which a new batch is produced every few weeks. Each batch uses a
> different mix of touchscreen, accelerometer and wifi peripherals.
> 
> Given that each batch is different creating a devicetree for each variant
> is not desirable. This commit adds a Q8 tablet hardware manager which
> auto-detects the touchscreen and accelerometer so that a single generic
> dts can be used for these tablets.
> 
> The wifi is connected to a discoverable bus (sdio or usb) and will be
> autodetected by the mmc resp. usb subsystems.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> .../misc/allwinner,sunxi-q8-hardwaremgr.txt        |  52 +++
> drivers/misc/Kconfig                               |  12 +
> drivers/misc/Makefile                              |   1 +
> drivers/misc/q8-hardwaremgr.c                      | 512 +++++++++++++++++++++
> 4 files changed, 577 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/misc/allwinner,sunxi-q8-hardwaremgr.txt
> create mode 100644 drivers/misc/q8-hardwaremgr.c
> 
> diff --git a/Documentation/devicetree/bindings/misc/allwinner,sunxi-q8-hardwaremgr.txt b/Documentation/devicetree/bindings/misc/allwinner,sunxi-q8-hardwaremgr.txt
> new file mode 100644
> index 0000000..f428bf5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/allwinner,sunxi-q8-hardwaremgr.txt
> @@ -0,0 +1,52 @@
> +Q8 tablet hardware manager
> +--------------------------
> +
> +Allwinnner A13 / A23 / A33 based Q8 tablets are popular cheap 7" tablets of
> +which a new batch is produced every few weeks. Each batch uses a different
> +mix of touchscreen, accelerometer and wifi peripherals.
> +
> +Given that each batch is different creating a devicetree for each variant is
> +not desirable. The Q8 tablet hardware manager bindings are bindings for an os
> +module which auto-detects the touchscreen so that a single
> +generic dts can be used for these tablets.
> +
> +The wifi is connected to a discoverable bus and will be autodetected by the os.
> +
> +Required properties:
> + - compatible         : "allwinner,sunxi-q8-hardwaremgr"
> + - touchscreen        : phandle of a template touchscreen node, this must be a
> +		        child node of the touchscreen i2c bus
> +
> +Optional properties:
> + - touchscreen-supply : regulator phandle for the touchscreen vdd supply
> +
> +touschreen node required properties:
> + - interrupt-parent   : phandle pointing to the interrupt controller
> +			serving the touchscreen interrupt
> + - interrupts         : interrupt specification for the touchscreen interrupt
> + - power-gpios        : Specification for the pin connected to the touchscreen's
> +			enable / wake pin. This needs to be driven high to
> +			enable the touchscreen controller
> +
> +Example:
> +
> +/ {
> +	hwmgr {
> +		compatible = "allwinner,sunxi-q8-hardwaremgr";
> +		touchscreen = <&touchscreen>;
> +		touchscreen-supply = <&reg_ldo_io1>;
> +	};
> +};
> +
> +&i2c0 {
> +	touchscreen: touchscreen at 0 {
> +		interrupt-parent = <&pio>;
> +		interrupts = <1 5 IRQ_TYPE_EDGE_FALLING>; /* PB5 */
> +		power-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> +		/*
> +		 * Enabled by sunxi-q8-hardwaremgr if it detects a
> +		 * known model touchscreen.
> +		 */
> +		status = "disabled";
> +	};
> +};
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index a216b46..c3e7772 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -804,6 +804,18 @@ config PANEL_BOOT_MESSAGE
> 	  An empty message will only clear the display at driver init time. Any other
> 	  printf()-formatted message is valid with newline and escape codes.
> 
> +config Q8_HARDWAREMGR
> +	tristate "Allwinner Q8 tablet hardware manager"
> +	depends on GPIOLIB || COMPILE_TEST
> +	depends on I2C
> +	depends on OF
> +	default	n
> +	help
> +	  This option enables support for autodetecting the touchscreen
> +	  on Allwinner Q8 tablets.
> +
> +	  If unsure, say N.
> +
> source "drivers/misc/c2port/Kconfig"
> source "drivers/misc/eeprom/Kconfig"
> source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 7410c6d..cac76b7 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_ECHO)		+= echo/
> obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
> obj-$(CONFIG_CXL_BASE)		+= cxl/
> obj-$(CONFIG_PANEL)             += panel.o
> +obj-$(CONFIG_Q8_HARDWAREMGR)    += q8-hardwaremgr.o
> 
> lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
> lkdtm-$(CONFIG_LKDTM)		+= lkdtm_bugs.o
> diff --git a/drivers/misc/q8-hardwaremgr.c b/drivers/misc/q8-hardwaremgr.c
> new file mode 100644
> index 0000000..e75625e
> --- /dev/null
> +++ b/drivers/misc/q8-hardwaremgr.c
> @@ -0,0 +1,512 @@
> +/*
> + * Allwinner q8 formfactor tablet hardware manager
> + *
> + * Copyright (C) 2016 Hans de Goede <hdegoede@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +/*
> + * We can detect which touchscreen controller is used automatically,
> + * but some controllers can be wired up differently depending on the
> + * q8 PCB variant used, so they need different firmware files / settings.
> + *
> + * We allow the user to specify a firmware_variant to select a config
> + * from a list of known configs. We also allow overriding each setting
> + * individually.
> + */
> +
> +static int touchscreen_variant = -1;
> +module_param(touchscreen_variant, int, 0444);
> +MODULE_PARM_DESC(touchscreen_variant, "Touchscreen variant 0-x, -1 for auto");
> +
> +static int touchscreen_width = -1;
> +module_param(touchscreen_width, int, 0444);
> +MODULE_PARM_DESC(touchscreen_width, "Touchscreen width, -1 for auto");
> +
> +static int touchscreen_height = -1;
> +module_param(touchscreen_height, int, 0444);
> +MODULE_PARM_DESC(touchscreen_height, "Touchscreen height, -1 for auto");
> +
> +static int touchscreen_invert_x = -1;
> +module_param(touchscreen_invert_x, int, 0444);
> +MODULE_PARM_DESC(touchscreen_invert_x, "Touchscreen invert x, -1 for auto");
> +
> +static int touchscreen_invert_y = -1;
> +module_param(touchscreen_invert_y, int, 0444);
> +MODULE_PARM_DESC(touchscreen_invert_y, "Touchscreen invert y, -1 for auto");
> +
> +static int touchscreen_swap_x_y = -1;
> +module_param(touchscreen_swap_x_y, int, 0444);
> +MODULE_PARM_DESC(touchscreen_swap_x_y, "Touchscreen swap x y, -1 for auto");
> +
> +static char *touchscreen_fw_name;
> +module_param(touchscreen_fw_name, charp, 0444);
> +MODULE_PARM_DESC(touchscreen_fw_name, "Touchscreen firmware filename");
> +
> +#define TOUCHSCREEN_POWER_ON_DELAY	20
> +#define SILEAD_REG_ID			0xFC
> +#define EKTF2127_RESPONSE		0x52
> +#define EKTF2127_REQUEST		0x53
> +#define EKTF2127_WIDTH			0x63
> +
> +enum touchscreen_model {
> +	touchscreen_unknown,
> +	gsl1680_a082,
> +	gsl1680_b482,
> +	ektf2127,
> +	zet6251,
> +};
> +
> +struct q8_hardwaremgr_data {
> +	struct device *dev;
> +	bool touchscreen_needs_regulator;
> +	enum touchscreen_model touchscreen_model;
> +	int touchscreen_addr;
> +	int touchscreen_variant;
> +	int touchscreen_width;
> +	int touchscreen_height;
> +	int touchscreen_invert_x;
> +	int touchscreen_invert_y;
> +	int touchscreen_swap_x_y;
> +	const char *touchscreen_compatible;
> +	const char *touchscreen_fw_name;
> +};
> +
> +typedef int (*probe_func)(struct q8_hardwaremgr_data *data,
> +			  struct i2c_adapter *adap);
> +
> +#if 0
> +	ret = i2c_smbus_xfer(adap, 0x40, 0, I2C_SMBUS_WRITE, 0,
> +			     I2C_SMBUS_QUICK, NULL);
> +	if (ret < 0)
> +		return -ENODEV;
> +
> +#endif
> +

^^^ crud?

> +static int q8_hardwaremgr_probe_touchscreen(struct q8_hardwaremgr_data *data,
> +					    struct i2c_adapter *adap)
> +{
> +	struct i2c_client *client;
> +	unsigned char buff[24];
> +	__le32 chip_id;
> +	int ret;
> +
> +	msleep(TOUCHSCREEN_POWER_ON_DELAY);
> +
> +	/* Check for silead touchsceen at addr 0x40 */
> +	client = i2c_new_dummy(adap, 0x40);
> +	if (!client)
> +		return -ENOMEM;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, SILEAD_REG_ID,
> +					    sizeof(chip_id), (u8 *)&chip_id);
> +	if (ret == sizeof(chip_id)) {
> +		switch (le32_to_cpu(chip_id)) {
> +		case 0xa0820000:
> +			data->touchscreen_addr = 0x40;
> +			data->touchscreen_compatible = "silead,gsl1680";
> +			data->touchscreen_model = gsl1680_a082;
> +			dev_info(data->dev, "Found Silead touchscreen ID: 0xa0820000\n");
> +			break;
> +		case 0xb4820000:
> +			data->touchscreen_addr = 0x40;
> +			data->touchscreen_compatible = "silead,gsl1680";
> +			data->touchscreen_model = gsl1680_b482;
> +			dev_info(data->dev, "Found Silead touchscreen ID: 0xb4820000\n");
> +			break;

> +		default:
> +			dev_warn(data->dev, "Found Silead touchscreen with unknown ID: 0x%08x\n",
> +				 le32_to_cpu(chip_id));
> +		}
> +		ret = 0;
> +	}
> +	i2c_unregister_device(client);
> +	if (ret == 0 || ret == -ETIMEDOUT /* Bus stuck bail immediately */)
> +		return ret;
> +
> +	/* Check for Elan eKTF2127 touchsceen at addr 0x15 */
> +	client = i2c_new_dummy(adap, 0x15);
> +	if (!client)
> +		return -ENOMEM;
> +
> +	do {
> +		/* Read hello, ignore data, depends on initial power state */
> +		ret = i2c_master_recv(client, buff, 4);
> +		if (ret != 4)
> +			break;
> +
> +		/* Request width */
> +		buff[0] = EKTF2127_REQUEST;
> +		buff[1] = EKTF2127_WIDTH;
> +		buff[2] = 0x00;
> +		buff[3] = 0x00;
> +		ret = i2c_master_send(client, buff, 4);
> +		if (ret != 4)
> +			break;
> +
> +		msleep(20);
> +
> +		/* Read response */
> +		ret = i2c_master_recv(client, buff, 4);
> +		if (ret != 4)
> +			break;
> +			
> +		if (buff[0] == EKTF2127_RESPONSE && buff[1] == EKTF2127_WIDTH) {
> +			data->touchscreen_addr = 0x15;
> +			data->touchscreen_compatible = "elan,ektf2127";
> +			data->touchscreen_model = ektf2127;
> +			dev_info(data->dev, "Found Elan eKTF2127 touchscreen\n");
> +			ret = 0;
> +		}
> +	} while (0);
> +	i2c_unregister_device(client);
> +	if (ret == 0 || ret == -ETIMEDOUT /* Bus stuck bail immediately */)
> +		return ret;
> +
> +	/* Check for Zeitec zet6251 touchsceen at addr 0x76 */
> +	client = i2c_new_dummy(adap, 0x76);
> +	if (!client)
> +		return -ENOMEM;
> +
> +	/*
> +	 * We only do a simple read finger data packet test, because some
> +	 * versions require firmware to be loaded. If not firmware is loaded
> +	 * the buffer will be filed with 0xff, so we ignore the contents.
> +	 */
> +	ret = i2c_master_recv(client, buff, 24);
> +	if (ret == 24) {
> +		data->touchscreen_addr = 0x76;
> +		data->touchscreen_compatible = "zeitec,zet6251";
> +		data->touchscreen_model = zet6251;
> +		dev_info(data->dev, "Found Zeitec zet6251 touchscreen\n");
> +		ret = 0;
> +	}

I can understand having a switch here since it?s quite complicated but it would be better to
have a structure that defines them i.e.

struct touchscreen_detect_data {
	u32 chip_id;
	int addr;
	const char *compatible;
	enum touchscreen_model model;
	
};

static const struct touchscreen_detect_data ts_detect_data[] = {
	{
		.chip_id = 0xa0820000,
		.addr = 0x40,
		.compatible = ?silead,gsl1680?,
		.model = gsl1680_a082,
	}, ...
};
 
And so on, and restructuring by having different paths by touchscreen model type.


> +	i2c_unregister_device(client);
> +	if (ret == 0 || ret == -ETIMEDOUT /* Bus stuck bail immediately */)
> +		return ret;
> +
> +	return -ENODEV;
> +}
> +
> +static int q8_hardwaremgr_do_probe(struct q8_hardwaremgr_data *data,
> +				   const char *prefix, probe_func func)
> +{
> +	struct device *dev = data->dev;
> +	struct device_node *np;
> +	struct i2c_adapter *adap;
> +	struct regulator *reg;
> +	struct gpio_desc *gpio;
> +	int ret = 0;
> +
> +	np = of_parse_phandle(dev->of_node, prefix, 0);
> +	if (!np) {
> +		dev_err(dev, "Error %s not set\n", prefix);
> +		return -EINVAL;
> +	}
> +
> +	adap = of_get_i2c_adapter_by_node(np->parent);
> +	if (!adap) {
> +		ret = -EPROBE_DEFER;
> +		goto put_node;
> +	}
> +
> +	reg = regulator_get_optional(dev, prefix);
> +	if (IS_ERR(reg)) {
> +		ret = PTR_ERR(reg);
> +		if (ret == -EPROBE_DEFER)
> +			goto put_adapter;
> +		reg = NULL;
> +	}
> +
> +	gpio = fwnode_get_named_gpiod(&np->fwnode, "power-gpios");
> +	if (IS_ERR(gpio)) {
> +		ret = PTR_ERR(gpio);
> +		if (ret == -EPROBE_DEFER)
> +			goto put_reg;
> +		gpio = NULL;
> +	}
> +
> +	/* First try with only the power gpio driven high */
> +	if (gpio) {
> +		ret = gpiod_direction_output(gpio, 1);
> +		if (ret)
> +			goto put_gpio;
> +	}
> +
> +	dev_info(dev, "Looking for %s without a regulator\n", prefix);
> +	ret = func(data, adap);
> +	if (ret != 0 && reg) {
> +		/* Second try, also enable the regulator */
> +		ret = regulator_enable(reg);
> +		if (ret)
> +			goto restore_gpio;
> +
> +		dev_info(dev, "Looking for %s with a regulator\n", prefix);
> +		ret = func(data, adap);
> +		if (ret == 0)
> +			data->touchscreen_needs_regulator = true; 
> +
> +		regulator_disable(reg);
> +	}
> +	ret = 0; /* Not finding a device is not an error */
> +
> +restore_gpio:
> +	if (gpio)
> +		gpiod_direction_output(gpio, 0);
> +put_gpio:
> +	if (gpio)
> +		gpiod_put(gpio);
> +put_reg:
> +	if (reg)
> +		regulator_put(reg);
> +put_adapter:
> +	i2c_put_adapter(adap);
> +
> +put_node:
> +	of_node_put(np);
> +
> +	return ret;
> +}
> +
> +static void q8_hardwaremgr_apply_gsl1680_a082_variant(
> +	struct q8_hardwaremgr_data *data)
> +{
> +	if (touchscreen_variant != -1) {
> +		data->touchscreen_variant = touchscreen_variant;
> +	} else {
> +		if (of_machine_is_compatible("allwinner,sun8i-a33"))
> +			data->touchscreen_variant = 1;
> +		else
> +			data->touchscreen_variant = 0;
> +	}
> +
> +	switch (data->touchscreen_variant) {
> +	default:
> +		dev_warn(data->dev, "Error unknown touchscreen_variant %d using 0\n",
> +			 touchscreen_variant);
> +		/* Fall through */
> +	case 0:
> +		data->touchscreen_width = 1024;
> +		data->touchscreen_height = 600;
> +		data->touchscreen_fw_name = "gsl1680-a082-q8-700.fw";
> +		break;
> +	case 1:
> +		data->touchscreen_width = 480;
> +		data->touchscreen_height = 800;
> +		data->touchscreen_swap_x_y = 1;
> +		data->touchscreen_fw_name = "gsl1680-a082-q8-a70.fw";
> +		break;
> +	}
> +}
> +
> +static void q8_hardwaremgr_apply_gsl1680_b482_variant(
> +	struct q8_hardwaremgr_data *data)
> +{
> +	if (touchscreen_variant != -1)
> +		data->touchscreen_variant = touchscreen_variant;
> +
> +	switch (data->touchscreen_variant) {
> +	default:
> +		dev_warn(data->dev, "Error unknown touchscreen_variant %d using 0\n",
> +			 touchscreen_variant);
> +		/* Fall through */
> +	case 0:
> +		data->touchscreen_width = 960;
> +		data->touchscreen_height = 640;
> +		data->touchscreen_fw_name = "gsl1680-b482-q8-d702.fw";
> +		break;
> +	case 1:
> +		data->touchscreen_width = 960;
> +		data->touchscreen_height = 640;
> +		data->touchscreen_fw_name = "gsl1680-b482-q8-a70.fw";
> +		break;
> +	}
> +}
> +
> +static void q8_hardwaremgr_issue_gsl1680_warning(
> +	struct q8_hardwaremgr_data *data)
> +{
> +	dev_warn(data->dev, "gsl1680 touchscreen may require kernel cmdline parameters to function properly\n");
> +	dev_warn(data->dev, "Try q8_hardwaremgr.touchscreen_invert_x=1 if x coordinates are inverted\n");
> +	dev_warn(data->dev, "Try q8_hardwaremgr.touchscreen_variant=%d if coordinates are all over the place\n",
> +		 !data->touchscreen_variant);
> +
> +#define	show(x) \
> +	dev_info(data->dev, #x " %d (%s)\n", data->x, \
> +		 (x == -1) ? "auto" : "user supplied")
> +
> +	show(touchscreen_variant);
> +	show(touchscreen_width);
> +	show(touchscreen_height);
> +	show(touchscreen_invert_x);
> +	show(touchscreen_invert_y);
> +	show(touchscreen_swap_x_y);
> +	dev_info(data->dev, "touchscreen_fw_name %s (%s)\n",
> +		 data->touchscreen_fw_name,
> +		 (touchscreen_fw_name == NULL) ? "auto" : "user supplied");
> +#undef show
> +}
> +
> +static void q8_hardwaremgr_apply_touchscreen(struct q8_hardwaremgr_data *data)
> +{
> +	struct device *dev = data->dev;
> +	struct of_changeset cset;
> +	struct device_node *np;
> +
> +	switch (data->touchscreen_model) {
> +	case touchscreen_unknown:
> +		return;
> +	case gsl1680_a082:
> +		q8_hardwaremgr_apply_gsl1680_a082_variant(data);
> +		break;
> +	case gsl1680_b482:
> +		q8_hardwaremgr_apply_gsl1680_b482_variant(data);
> +		break;
> +	case ektf2127:
> +	case zet6251:
> +		/* These have only 1 variant */
> +		break;
> +	}
> +
> +	if (touchscreen_width != -1)
> +		data->touchscreen_width = touchscreen_width;
> +
> +	if (touchscreen_height != -1)
> +		data->touchscreen_height = touchscreen_height;
> +
> +	if (touchscreen_invert_x != -1)
> +		data->touchscreen_invert_x = touchscreen_invert_x;
> +
> +	if (touchscreen_invert_y != -1)
> +		data->touchscreen_invert_y = touchscreen_invert_y;
> +
> +	if (touchscreen_swap_x_y != -1)
> +		data->touchscreen_swap_x_y = touchscreen_swap_x_y;
> +
> +	if (touchscreen_fw_name)
> +		data->touchscreen_fw_name = touchscreen_fw_name;
> +
> +	if (data->touchscreen_model == gsl1680_a082 ||
> +	    data->touchscreen_model == gsl1680_b482)
> +		q8_hardwaremgr_issue_gsl1680_warning(data);
> +
> +	np = of_parse_phandle(data->dev->of_node, "touchscreen", 0);
> +	/* Never happens already checked in q8_hardwaremgr_do_probe() */
> +	if (WARN_ON(!np))
> +		return;
> +
> +	of_changeset_init(&cset);
> +	of_changeset_add_property_u32(&cset, np, "reg", data->touchscreen_addr);
> +	of_changeset_add_property_string(&cset, np, "compatible",
> +					 data->touchscreen_compatible);
> +
> +	if (data->touchscreen_width)
> +		of_changeset_add_property_u32(&cset, np, "touchscreen-size-x",
> +					      data->touchscreen_width);
> +	if (data->touchscreen_height)
> +		of_changeset_add_property_u32(&cset, np, "touchscreen-size-y",
> +					      data->touchscreen_height);
> +	if (data->touchscreen_invert_x)
> +		of_changeset_add_property_bool(&cset, np,
> +					       "touchscreen-inverted-x");
> +	if (data->touchscreen_invert_y)
> +		of_changeset_add_property_bool(&cset, np,
> +					       "touchscreen-inverted-y");
> +	if (data->touchscreen_swap_x_y)
> +		of_changeset_add_property_bool(&cset, np,
> +					       "touchscreen-swapped-x-y");
> +	if (data->touchscreen_fw_name)
> +		of_changeset_add_property_string(&cset, np, "firmware-name",
> +						 data->touchscreen_fw_name);
> +	if (data->touchscreen_needs_regulator) {
> +		struct property *p;
> +
> +		p = of_find_property(dev->of_node, "touchscreen-supply", NULL);
> +		/* Never happens already checked in q8_hardwaremgr_do_probe() */
> +		if (WARN_ON(!p))
> +			return;
> +
> +		of_changeset_add_property_copy(&cset, np, "vddio-supply",
> +					       p->value, p->length);
> +	}
> +
> +	of_changeset_update_property_string(&cset, np, "status", "okay");
> +	of_changeset_apply(&cset);
> +
> +	of_node_put(np);
> +}
> +
> +static int q8_hardwaremgr_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct q8_hardwaremgr_data *data;
> +	int ret = 0;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->dev = &pdev->dev;
> +
> +	ret = q8_hardwaremgr_do_probe(data, "touchscreen",
> +				      q8_hardwaremgr_probe_touchscreen);
> +	if (ret)
> +		goto error;
> +
> +	/*
> +	 * Our pinctrl may conflict with the pinctrl of the detected devices
> +	 * we're adding, so remove it before adding detected devices.
> +	 */
> +	if (dev->pins) {
> +		devm_pinctrl_put(dev->pins->p);
> +		devm_kfree(dev, dev->pins);
> +		dev->pins = NULL;
> +	}
> +

Hmm, that?s weird for sure. How can it happen?

> +	q8_hardwaremgr_apply_touchscreen(data);
> +
> +error:
> +	kfree(data);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id q8_hardwaremgr_of_match[] = {
> +	{ .compatible = "allwinner,sunxi-q8-hardwaremgr", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, q8_hardwaremgr_of_match);
> +
> +static struct platform_driver q8_hardwaremgr_driver = {
> +	.driver = {
> +		.name	= "q8-hardwaremgr",
> +		.of_match_table = of_match_ptr(q8_hardwaremgr_of_match),
> +	},
> +	.probe	= q8_hardwaremgr_probe,
> +};
> +
> +module_platform_driver(q8_hardwaremgr_driver);
> +
> +MODULE_DESCRIPTION("Allwinner q8 formfactor tablet hardware manager");
> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.9.3
> 

Regards

? Pantelis
