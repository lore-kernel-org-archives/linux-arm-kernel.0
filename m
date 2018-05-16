From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 16 May 2018 11:21:44 -0700
Subject: [PATCH RFC 3/6] hwmon: Add support for RPi voltage sensor
In-Reply-To: <1526477827-10859-4-git-send-email-stefan.wahren@i2se.com>
References: <1526477827-10859-1-git-send-email-stefan.wahren@i2se.com>
 <1526477827-10859-4-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20180516182144.GB22705@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 03:37:04PM +0200, Stefan Wahren wrote:
> Currently there is no easy way to detect under-voltage conditions on a remote
> Raspberry Pi. This hwmon driver retrieves the state of the under-voltage sensor
> via mailbox interface. The handling based on Noralf's modifications to the
> downstream firmware driver. In case of an under-voltage condition only an entry
> is written to the kernel log.
> 

My major concern is how this is displayed with the 'sensors' command.
Can you test and report ?

Of course, it would be much better if the firmware would also report
the actual voltage, but I guess we can't have everything.

More comments inline.

Thanks,
Guenter

> CC: "Noralf Tr?nnes" <noralf@tronnes.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/hwmon/Kconfig             |  10 ++
>  drivers/hwmon/Makefile            |   1 +
>  drivers/hwmon/raspberrypi-hwmon.c | 207 ++++++++++++++++++++++++++++++++++++++

Please also provide Documentation/hwmon/raspberrypi-hwmon.

>  3 files changed, 218 insertions(+)
>  create mode 100644 drivers/hwmon/raspberrypi-hwmon.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 768aed5..7f935cf 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1298,6 +1298,16 @@ config SENSORS_PWM_FAN
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called pwm-fan.
>  
> +config SENSORS_RASPBERRYPI_HWMON
> +	tristate "Raspberry Pi voltage monitor"
> +	depends on (ARCH_BCM2835 && RASPBERRYPI_FIRMWARE) || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
> +	help
> +	  If you say yes here you get support for voltage sensor on the
> +	  Raspberry Pi.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called raspberrypi-hwmon.
> +
>  config SENSORS_SHT15
>  	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
>  	depends on GPIOLIB || COMPILE_TEST
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index e7d52a3..a929770 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
>  obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
>  obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
> +obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
>  obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
>  obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
>  obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
> diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
> new file mode 100644
> index 0000000..2003f6c
> --- /dev/null
> +++ b/drivers/hwmon/raspberrypi-hwmon.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Raspberry Pi voltage sensor driver
> + *
> + * Based on firmware/raspberrypi.c by Noralf Tr?nnes
> + *
> + * Copyright (C) 2018 Stefan Wahren <stefan.wahren@i2se.com>
> + */
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>

Unnecessary include

> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
> +#define UNDERVOLTAGE_STICKY_BIT	BIT(16)
> +
> +struct rpi_hwmon_data {
> +	struct device *hwmon_dev;
> +	struct rpi_firmware *fw;
> +	u32 last_throttled;
> +	struct delayed_work get_values_poll_work;
> +};
> +
> +static void rpi_firmware_get_throttled(struct rpi_hwmon_data *data)
> +{
> +	u32 new_uv, old_uv, value;
> +	int ret;
> +
> +	/* Clear sticky bits */

Please make more explicit that this is a request/command sent to the firmware.

> +	value = 0xffff;
> +
> +	ret = rpi_firmware_property(data->fw, RPI_FIRMWARE_GET_THROTTLED,
> +				    &value, sizeof(value));
> +	if (ret) {
> +		dev_err_once(data->hwmon_dev, "%s: Failed to get throttled (%d)\n",
> +			     __func__, ret);

The function name seems unnecessary.

> +		return;
> +	}
> +
> +	new_uv = value & UNDERVOLTAGE_STICKY_BIT;
> +	old_uv = data->last_throttled & UNDERVOLTAGE_STICKY_BIT;
> +	data->last_throttled = value;
> +
> +	if (new_uv == old_uv)
> +		return;
> +
> +	if (new_uv)
> +		dev_crit(data->hwmon_dev, "Under-voltage detected! (0x%08x)\n",
> +			 value);
> +	else
> +		dev_info(data->hwmon_dev, "Voltage normalised (0x%08x)\n",
> +			 value);

What value do those hex values provide to the user ?

> +
> +	sysfs_notify(&data->hwmon_dev->kobj, NULL, "in0_lcrit_alarm");
> +}
> +
> +static void get_values_poll(struct work_struct *work)
> +{
> +	struct rpi_hwmon_data *data;
> +
> +	data = container_of(work, struct rpi_hwmon_data,
> +			    get_values_poll_work.work);
> +
> +	rpi_firmware_get_throttled(data);
> +
> +	/*
> +	 * We can't run faster than the sticky shift (100ms) since we get
> +	 * flipping in the sticky bits that are cleared.
> +	 */
> +	schedule_delayed_work(&data->get_values_poll_work, 2 * HZ);
> +}
> +
> +static int rpi_read(struct device *dev, enum hwmon_sensor_types type,
> +		    u32 attr, int channel, long *val)
> +{
> +	struct rpi_hwmon_data *data = dev_get_drvdata(dev);
> +
> +	if (type != hwmon_in)
> +		return -EOPNOTSUPP;
> +
> +	if (attr != hwmon_in_lcrit_alarm)
> +		return -EOPNOTSUPP;
> +
> +	if (channel)
> +		return -EOPNOTSUPP;
> +
There is only one channel, one attribute, and one type supported.
As such, the checks are unnecessary.

> +	*val = !!(data->last_throttled & UNDERVOLTAGE_STICKY_BIT);
> +	return 0;
> +}
> +
> +static umode_t rpi_is_visible(const void *_data, enum hwmon_sensor_types type,
> +			      u32 attr, int channel)
> +{
> +	if (type != hwmon_in)
> +		return 0;
> +
> +	if (attr != hwmon_in_lcrit_alarm)
> +		return 0;
> +
> +	if (channel)
> +		return 0;

Same as above. In the list below, there is not a single conditional attribute.
Given that, the checks should be unnecessary, and it should be sufficient to
just return 0444.

> +
> +	return 0444;
> +}
> +
> +static const u32 rpi_in_config[] = {
> +	HWMON_I_LCRIT_ALARM,
> +	0
> +};
> +
> +static const struct hwmon_channel_info rpi_in = {
> +	.type = hwmon_in,
> +	.config = rpi_in_config,
> +};
> +
> +static const struct hwmon_channel_info *rpi_info[] = {
> +	&rpi_in,
> +	NULL
> +};
> +
> +static const struct hwmon_ops rpi_hwmon_ops = {
> +	.is_visible = rpi_is_visible,
> +	.read = rpi_read,
> +};
> +
> +static const struct hwmon_chip_info rpi_chip_info = {
> +	.ops = &rpi_hwmon_ops,
> +	.info = rpi_info,
> +};
> +
> +static int rpi_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *fw_node;
> +	struct rpi_hwmon_data *data;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	fw_node = of_get_parent(dev->of_node);
> +	if (!fw_node) {
> +		dev_err(dev, "Missing firmware node\n");
> +		return -ENOENT;
> +	}
> +
> +	data->fw = rpi_firmware_get(fw_node);
> +	of_node_put(fw_node);
> +	if (!data->fw)
> +		return -EPROBE_DEFER;
> +
> +	ret = rpi_firmware_property(data->fw, RPI_FIRMWARE_GET_THROTTLED,
> +				    &data->last_throttled,
> +				    sizeof(data->last_throttled));
> +	if (ret) {
> +		dev_info(dev, "Firmware doesn't support GET_THROTTLED\n");

If this is an error -> dev_err().

> +		return -EOPNOTSUPP;

or return -ENODEV.

> +	}
> +
> +	data->hwmon_dev = devm_hwmon_device_register_with_info(dev, "rpi_volt",
> +							       data,
> +							       &rpi_chip_info,
> +							       NULL);
> +
> +	INIT_DELAYED_WORK(&data->get_values_poll_work, get_values_poll);
> +	platform_set_drvdata(pdev, data);
> +
> +	if (!PTR_ERR_OR_ZERO(data->hwmon_dev))
> +		schedule_delayed_work(&data->get_values_poll_work, 2 * HZ);
> +
> +	return PTR_ERR_OR_ZERO(data->hwmon_dev);
> +}
> +
> +static int rpi_hwmon_remove(struct platform_device *pdev)
> +{
> +	struct rpi_hwmon_data *data = platform_get_drvdata(pdev);
> +
> +	cancel_delayed_work_sync(&data->get_values_poll_work);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rpi_hwmon_of_match[] = {
> +	{ .compatible = "raspberrypi,bcm2835-hwmon", },
> +	{ /* sentinel */},
> +};
> +MODULE_DEVICE_TABLE(of, rpi_hwmon_of_match);
> +
> +static struct platform_driver rpi_hwmon_driver = {
> +	.probe = rpi_hwmon_probe,
> +	.remove = rpi_hwmon_remove,
> +	.driver = {
> +		.name = "raspberrypi-hwmon",
> +		.of_match_table = rpi_hwmon_of_match,
> +	},
> +};
> +module_platform_driver(rpi_hwmon_driver);
> +
> +MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
> +MODULE_DESCRIPTION("Raspberry Pi voltage sensor driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
