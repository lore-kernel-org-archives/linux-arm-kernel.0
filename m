From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 15 Feb 2016 18:13:03 -0800
Subject: [PATCH v2 2/3] hwmon: Create an NSA320 hardware monitoring driver
In-Reply-To: <1455578705-10531-3-git-send-email-linux@baker-net.org.uk>
References: <1455578705-10531-1-git-send-email-linux@baker-net.org.uk>
 <1455578705-10531-3-git-send-email-linux@baker-net.org.uk>
Message-ID: <56C285AF.9020207@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2016 03:25 PM, Adam Baker wrote:
> Create a driver to support the hardware monitoring chip present in
> the Zyxel NSA320 and some of the other Zyxel NAS devices.
>
> The driver reads fan speed and temperature from a suitably
> pre-programmed MCU on the device.
>
> Signed-off-by: Adam Baker <linux@baker-net.org.uk>

Couple of additional comments below.

> ---

Please provide a change log here for the next version (or a comment indicating that
there is no change from the previous version). "Added Ack by ..." is a useful
change log.

>   drivers/hwmon/Kconfig        |  15 +++
>   drivers/hwmon/Makefile       |   1 +
>   drivers/hwmon/nsa320-hwmon.c | 215 +++++++++++++++++++++++++++++++++++++++++++

Please also provide Documentation/hwmon/nsa320-hwmon.

>   3 files changed, 231 insertions(+)
>   create mode 100644 drivers/hwmon/nsa320-hwmon.c
>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 80a73bf..08fd7f5 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1186,6 +1186,21 @@ config SENSORS_NCT7904
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called nct7904.
>
> +config SENSORS_NSA320
> +	tristate "ZyXEL NSA320 and compatible fan speed and temperature sensors"
> +	depends on GPIOLIB && OF
> +	depends on MACH_KIRKWOOD || COMPILE_TEST
> +	help
> +	  If you say yes here you get support for hardware monitoring
> +	  for the ZyXEL NSA320 Media Server and other compatible devices
> +	  (probably the NSA325 and some NSA310 variants).
> +
> +	  The sensor data is taken from a Holtek HT46R065 microcontroller
> +	  connected to GPIO lines.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nsa320-hwmon.
> +
>   config SENSORS_PCF8591
>   	tristate "Philips PCF8591 ADC/DAC"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 12a3239..e555d6d 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -125,6 +125,7 @@ obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
>   obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
>   obj-$(CONFIG_SENSORS_NCT7904)	+= nct7904.o
>   obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
> +obj-$(CONFIG_SENSORS_NSA320)	+= nsa320-hwmon.o

NSA ... NTC

>   obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>   obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>   obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
> diff --git a/drivers/hwmon/nsa320-hwmon.c b/drivers/hwmon/nsa320-hwmon.c
> new file mode 100644
> index 0000000..f4bfa65
> --- /dev/null
> +++ b/drivers/hwmon/nsa320-hwmon.c
> @@ -0,0 +1,215 @@
> +/*
> + * drivers/hwmon/nsa320-hwmon.c
> + *
> + * ZyXEL NSA320 Media Servers
> + * hardware monitoring
> + *
> + * Copyright (C) 2016 Adam Baker <linux@baker-net.org.uk>
> + * based on a board file driver
> + * Copyright (C) 2012 Peter Schildmann <linux@schildmann.info>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License v2 as published by the
> + * Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#define MAGIC_NUMBER 0x55
> +
> +/*
> + * The Zyxel hwmon MCU is a Holtek HT46R065 that is factory programmed
> + * to perform temperature and fan speed monitoring. It is read by taking
> + * the active pin low. The 32 bit output word is then clocked onto the
> + * data line. The MSB of the data word is a magic nuber to indicate it
> + * has been read correctly, the next byte is the fan speed (in hundreds
> + * of RPM) and the last two bytes are the temperature (in tenths of a
> + * degree)
> + */
> +
> +struct nsa320_hwmon {
> +	struct mutex		update_lock;	/* lock GPIO operations */
> +	unsigned long		last_updated;	/* jiffies */
> +	u32			mcu_data;
> +	struct gpio_desc	*act;
> +	struct gpio_desc	*clk;
> +	struct gpio_desc	*data;
> +};
> +
> +enum nsa320_inputs {
> +	NSA3XX_TEMP = 0,
> +	NSA3XX_FAN = 1,
> +};
> +
> +static const char * const nsa320_input_names[] = {
> +	[NSA3XX_FAN] = "Chassis Fan",
> +	[NSA3XX_TEMP] = "System Temperature",

Swap lines, please.

> +};
> +
> +/* Although this protocol looks similar to SPI the long delay

Please use standard multi-line comments.

> + * between the active (aka chip select) signal and the shorter
> + * delay between clock pulses are needed for reliable operation.
> + * The delays provided are taken from the manufacturer kernel,
> + * testing suggest they probably incorporate a reasonable safety
> + * margin. (The single device tested became unreliable if the
> + * delay was reduced to 1/10th of this value.)
> + */
> +static int nsa320_hwmon_update(struct device *dev)
> +{
> +	u32 mcu_data;
> +	u32 mask;
> +	struct nsa320_hwmon *hwmon = dev_get_drvdata(dev);
> +
> +	mutex_lock(&hwmon->update_lock);
> +
> +	mcu_data = hwmon->mcu_data;
> +
> +	if (time_after(jiffies, hwmon->last_updated + HZ) || mcu_data == 0) {
> +		gpiod_set_value(hwmon->act, 1);
> +		msleep(100);
> +
> +		for (mask = BIT(31); mask; mask >>= 1) {
> +			gpiod_set_value(hwmon->clk, 0);
> +			usleep_range(100, 200);
> +			gpiod_set_value(hwmon->clk, 1);
> +			usleep_range(100, 200);
> +			if (gpiod_get_value(hwmon->data))
> +				mcu_data |= mask;

This is problematic. The code only sets additional bits in mcu_data
and never removes any (since mcu_data starts off with hwmon->mcu_data).

> +		}
> +
> +		gpiod_set_value(hwmon->act, 0);
> +		dev_dbg(dev, "Read raw MCU data %08x\n", mcu_data);
> +
> +		if ((mcu_data >> 24) != MAGIC_NUMBER) {
> +			dev_dbg(dev, "Read invalid MCU data %08x\n", mcu_data);
> +			return -EIO;
> +		}
> +
> +		hwmon->mcu_data = mcu_data;
> +		hwmon->last_updated = jiffies;
> +	}
> +
> +	mutex_unlock(&hwmon->update_lock);
> +
> +	return 0;
> +}
> +
> +static ssize_t show_label(struct device *dev,
> +			  struct device_attribute *attr, char *buf)
> +{
> +	int channel = to_sensor_dev_attr(attr)->index;
> +
> +	return sprintf(buf, "%s\n", nsa320_input_names[channel]);
> +}
> +
> +static ssize_t show_value(struct device *dev,
> +			  struct device_attribute *attr, char *buf)
> +{
> +	int channel = to_sensor_dev_attr(attr)->index;
> +	struct nsa320_hwmon *hwmon = dev_get_drvdata(dev);
> +	unsigned long value = 0;

int should be sufficient, and it does not need to be initialized.

> +	int ret = nsa320_hwmon_update(dev);
> +
> +	if (ret)
> +		return ret;
> +
> +	switch (channel) {
> +	case NSA3XX_TEMP:
> +		value = (hwmon->mcu_data & 0xffff) * 100;
> +		break;
> +	case NSA3XX_FAN:
> +		value = ((hwmon->mcu_data & 0xff0000) >> 16) * 100;
> +		break;
> +	default:
> +		return -EINVAL;

Hmmm ... this would be an implementation error, and leaves the user
guessing where the error comes from. Better make the value 0 here,
and display a warning with a traceback.

This shows, though, why using a single function in cases like this
is not necessarily the best idea. Ultimately you end up having code
which has to deal with impossible cases. I'll leave it up to you,
but I think a better implementation would be to have two separate
show functions.

static ssize_t show_temp(struct device *dev,
			 struct device_attribute *attr, char *buf)
{
	struct nsa320_hwmon *hwmon = dev_get_drvdata(dev);
	int ret = nsa320_hwmon_update(dev);

	if (ret)
		return ret;

	return sprintf(buf, "%u\n", (hwmon->mcu_data & 0xffff) * 100);
}

static ssize_t show_fan(struct device *dev,
			struct device_attribute *attr, char *buf)
{
	struct nsa320_hwmon *hwmon = dev_get_drvdata(dev);
	int ret = nsa320_hwmon_update(dev);

	if (ret)
		return ret;

	return sprintf(buf, "%u\n", ((hwmon->mcu_data & 0xff0000) >> 16) * 100);
}

[ and you could use DEVICE_ATTR() for the show functions ]

You could simplify the functions further, by having nsa320_hwmon_update(dev)
either return an error or the value directly (a valid value will never be < 0).

static ssize_t show_temp(struct device *dev,
			 struct device_attribute *attr, char *buf)
{
	int mcu_data = nsa320_hwmon_update(dev);

	if (mcu_data < 0)
		return mcu_data;

	return sprintf(buf, "%d\n", (mcu_data & 0xffff) * 100);
}

> +	}
> +	return sprintf(buf, "%lu\n", value);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL, NSA3XX_TEMP);
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_value, NULL, NSA3XX_TEMP);
> +static SENSOR_DEVICE_ATTR(fan1_label, S_IRUGO, show_label, NULL, NSA3XX_FAN);
> +static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_value, NULL, NSA3XX_FAN);
> +
> +static struct attribute *nsa320_attrs[] = {
> +	&sensor_dev_attr_temp1_label.dev_attr.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_fan1_label.dev_attr.attr,
> +	&sensor_dev_attr_fan1_input.dev_attr.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(nsa320);
> +
> +static const struct of_device_id of_nsa320_hwmon_match[] = {
> +	{ .compatible = "zyxel,nsa320-mcu", },
> +	{ },
> +};
> +
> +static int nsa320_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct nsa320_hwmon	*hwmon;
> +	struct device		*classdev;
> +
> +	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +
> +	/* Look up the GPIO pins to use */
> +	hwmon->act = devm_gpiod_get(&pdev->dev, "act", GPIOD_OUT_LOW);
> +	if (IS_ERR(hwmon->act))
> +		return PTR_ERR(hwmon->act);
> +
> +	hwmon->clk = devm_gpiod_get(&pdev->dev, "clk", GPIOD_OUT_HIGH);
> +	if (IS_ERR(hwmon->clk))
> +		return PTR_ERR(hwmon->clk);
> +
> +	hwmon->data = devm_gpiod_get(&pdev->dev, "data", GPIOD_IN);
> +	if (IS_ERR(hwmon->data))
> +		return PTR_ERR(hwmon->data);
> +
> +	mutex_init(&hwmon->update_lock);
> +
> +	classdev = devm_hwmon_device_register_with_groups(&pdev->dev,
> +					"nsa320", hwmon, nsa320_groups);
> +
> +	return PTR_ERR_OR_ZERO(classdev);
> +
> +}
> +
> +/* All allocations use devres so remove() is not needed. */
> +
> +static struct platform_driver nsa320_hwmon_driver = {
> +	.probe = nsa320_hwmon_probe,
> +	.driver = {
> +		.name = "nsa320-hwmon",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(of_nsa320_hwmon_match),
> +	},
> +};
> +
> +module_platform_driver(nsa320_hwmon_driver);
> +
> +MODULE_DEVICE_TABLE(of, of_nsa320_hwmon_match);
> +MODULE_AUTHOR("Peter Schildmann <linux@schildmann.info>");
> +MODULE_AUTHOR("Adam Baker <linux@baker-net.org.uk>");
> +MODULE_DESCRIPTION("NSA3XX Hardware Monitoring");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:nsa320-hwmon");
>
