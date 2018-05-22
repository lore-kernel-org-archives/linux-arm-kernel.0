From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 22 May 2018 15:51:36 +0200 (CEST)
Subject: [PATCH RFC V2 2/6] hwmon: Add support for RPi voltage sensor
In-Reply-To: <90a768aa-ee8c-1050-cf15-60637069dbdb@roeck-us.net>
References: <1526988112-4021-1-git-send-email-stefan.wahren@i2se.com>
 <1526988112-4021-3-git-send-email-stefan.wahren@i2se.com>
 <90a768aa-ee8c-1050-cf15-60637069dbdb@roeck-us.net>
Message-ID: <659923372.11518.1526997096662@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

> Guenter Roeck <linux@roeck-us.net> hat am 22. Mai 2018 um 15:41 geschrieben:
> 
> 
> On 05/22/2018 04:21 AM, Stefan Wahren wrote:
> > Currently there is no easy way to detect undervoltage conditions on a
> > remote Raspberry Pi. This hwmon driver retrieves the state of the
> > undervoltage sensor via mailbox interface. The handling based on
> > Noralf's modifications to the downstream firmware driver. In case of
> > an undervoltage condition only an entry is written to the kernel log.
> > 
> > CC: "Noralf Tr?nnes" <noralf@tronnes.org>
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> >   Documentation/hwmon/raspberrypi-hwmon |  22 +++++
> >   drivers/hwmon/Kconfig                 |  10 ++
> >   drivers/hwmon/Makefile                |   1 +
> >   drivers/hwmon/raspberrypi-hwmon.c     | 168 ++++++++++++++++++++++++++++++++++
> >   4 files changed, 201 insertions(+)
> >   create mode 100644 Documentation/hwmon/raspberrypi-hwmon
> >   create mode 100644 drivers/hwmon/raspberrypi-hwmon.c
> > 
> > diff --git a/Documentation/hwmon/raspberrypi-hwmon b/Documentation/hwmon/raspberrypi-hwmon
> > new file mode 100644
> > index 0000000..3c92e2c
> > --- /dev/null
> > +++ b/Documentation/hwmon/raspberrypi-hwmon
> > @@ -0,0 +1,22 @@
> > +Kernel driver raspberrypi-hwmon
> > +===============================
> > +
> > +Supported boards:
> > +  * Raspberry Pi A+ (via GPIO on SoC)
> > +  * Raspberry Pi B+ (via GPIO on SoC)
> > +  * Raspberry Pi 2 B (via GPIO on SoC)
> > +  * Raspberry Pi 3 B (via GPIO on port expander)
> > +  * Raspberry Pi 3 B+ (via PMIC)
> > +
> > +Author: Stefan Wahren <stefan.wahren@i2se.com>
> > +
> > +Description
> > +-----------
> > +
> > +This driver periodically polls a mailbox property of the VC4 firmware to detect
> > +undervoltage conditions.
> > +
> > +Sysfs entries
> > +-------------
> > +
> > +in0_lcrit_alarm		Undervoltage alarm
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 768aed5..9a5bdb0 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1298,6 +1298,16 @@ config SENSORS_PWM_FAN
> >   	  This driver can also be built as a module.  If so, the module
> >   	  will be called pwm-fan.
> >   
> > +config SENSORS_RASPBERRYPI_HWMON
> > +	tristate "Raspberry Pi voltage monitor"
> > +	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
> > +	help
> > +	  If you say yes here you get support for voltage sensor on the
> > +	  Raspberry Pi.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called raspberrypi-hwmon.
> > +
> >   config SENSORS_SHT15
> >   	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
> >   	depends on GPIOLIB || COMPILE_TEST
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index e7d52a3..a929770 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
> >   obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
> >   obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
> >   obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
> > +obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
> >   obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
> >   obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
> >   obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
> > diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
> > new file mode 100644
> > index 0000000..6233e84
> > --- /dev/null
> > +++ b/drivers/hwmon/raspberrypi-hwmon.c
> > @@ -0,0 +1,168 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Raspberry Pi voltage sensor driver
> > + *
> > + * Based on firmware/raspberrypi.c by Noralf Tr?nnes
> > + *
> > + * Copyright (C) 2018 Stefan Wahren <stefan.wahren@i2se.com>
> > + */
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/workqueue.h>
> > +#include <soc/bcm2835/raspberrypi-firmware.h>
> > +
> > +#define UNDERVOLTAGE_STICKY_BIT	BIT(16)
> > +
> > +struct rpi_hwmon_data {
> > +	struct device *hwmon_dev;
> > +	struct rpi_firmware *fw;
> > +	u32 last_throttled;
> > +	struct delayed_work get_values_poll_work;
> > +};
> > +
> > +static void rpi_firmware_get_throttled(struct rpi_hwmon_data *data)
> > +{
> > +	u32 new_uv, old_uv, value;
> > +	int ret;
> > +
> > +	/* Request firmware to clear sticky bits */
> > +	value = 0xffff;
> > +
> > +	ret = rpi_firmware_property(data->fw, RPI_FIRMWARE_GET_THROTTLED,
> > +				    &value, sizeof(value));
> > +	if (ret) {
> > +		dev_err_once(data->hwmon_dev, "Failed to get throttled (%d)\n",
> > +			     ret);
> > +		return;
> > +	}
> > +
> > +	new_uv = value & UNDERVOLTAGE_STICKY_BIT;
> > +	old_uv = data->last_throttled & UNDERVOLTAGE_STICKY_BIT;
> > +	data->last_throttled = value;
> > +
> > +	if (new_uv == old_uv)
> > +		return;
> > +
> > +	if (new_uv)
> > +		dev_crit(data->hwmon_dev, "Undervoltage detected!\n");
> > +	else
> > +		dev_info(data->hwmon_dev, "Voltage normalised\n");
> > +
> > +	sysfs_notify(&data->hwmon_dev->kobj, NULL, "in0_lcrit_alarm");
> > +}
> > +
> > +static void get_values_poll(struct work_struct *work)
> > +{
> > +	struct rpi_hwmon_data *data;
> > +
> > +	data = container_of(work, struct rpi_hwmon_data,
> > +			    get_values_poll_work.work);
> > +
> > +	rpi_firmware_get_throttled(data);
> > +
> > +	/*
> > +	 * We can't run faster than the sticky shift (100ms) since we get
> > +	 * flipping in the sticky bits that are cleared.
> > +	 */
> > +	schedule_delayed_work(&data->get_values_poll_work, 2 * HZ);
> > +}
> > +
> > +static int rpi_read(struct device *dev, enum hwmon_sensor_types type,
> > +		    u32 attr, int channel, long *val)
> > +{
> > +	struct rpi_hwmon_data *data = dev_get_drvdata(dev);
> > +
> > +	*val = !!(data->last_throttled & UNDERVOLTAGE_STICKY_BIT);
> > +	return 0;
> > +}
> > +
> > +static umode_t rpi_is_visible(const void *_data, enum hwmon_sensor_types type,
> > +			      u32 attr, int channel)
> > +{
> > +	return 0444;
> > +}
> > +
> > +static const u32 rpi_in_config[] = {
> > +	HWMON_I_LCRIT_ALARM,
> > +	0
> > +};
> > +
> > +static const struct hwmon_channel_info rpi_in = {
> > +	.type = hwmon_in,
> > +	.config = rpi_in_config,
> > +};
> > +
> > +static const struct hwmon_channel_info *rpi_info[] = {
> > +	&rpi_in,
> > +	NULL
> > +};
> > +
> > +static const struct hwmon_ops rpi_hwmon_ops = {
> > +	.is_visible = rpi_is_visible,
> > +	.read = rpi_read,
> > +};
> > +
> > +static const struct hwmon_chip_info rpi_chip_info = {
> > +	.ops = &rpi_hwmon_ops,
> > +	.info = rpi_info,
> > +};
> > +
> > +static int rpi_hwmon_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct rpi_hwmon_data *data;
> > +	int ret;
> > +
> > +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	data->fw = platform_get_drvdata(to_platform_device(dev->parent));
> > +	if (!data->fw)
> > +		return -EPROBE_DEFER;
> > +
> 
> I am a bit at loss here (and sorry I didn't bring this up before).
> How would this ever be possible, given that the driver is registered
> from the firmware driver ?

Do you refer to the (wrong) return code, the assumption that the parent must be a platform driver or a possible race?

> 
> > +	ret = rpi_firmware_property(data->fw, RPI_FIRMWARE_GET_THROTTLED,
> > +				    &data->last_throttled,
> > +				    sizeof(data->last_throttled));
> > +	if (ret)
> > +		return -ENODEV;
> > +
> > +	data->hwmon_dev = devm_hwmon_device_register_with_info(dev, "rpi_volt",
> > +							       data,
> > +							       &rpi_chip_info,
> > +							       NULL);
> > +
> > +	INIT_DELAYED_WORK(&data->get_values_poll_work, get_values_poll);
> > +	platform_set_drvdata(pdev, data);
> > +
> > +	if (!PTR_ERR_OR_ZERO(data->hwmon_dev))
> > +		schedule_delayed_work(&data->get_values_poll_work, 2 * HZ);
> > +
> > +	return PTR_ERR_OR_ZERO(data->hwmon_dev);
> > +}
> > +
> > +static int rpi_hwmon_remove(struct platform_device *pdev)
> > +{
> > +	struct rpi_hwmon_data *data = platform_get_drvdata(pdev);
> > +
> > +	cancel_delayed_work_sync(&data->get_values_poll_work);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver rpi_hwmon_driver = {
> > +	.probe = rpi_hwmon_probe,
> > +	.remove = rpi_hwmon_remove,
> > +	.driver = {
> > +		.name = "raspberrypi-hwmon",
> > +	},
> > +};
> > +module_platform_driver(rpi_hwmon_driver);
> > +
> > +MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
> > +MODULE_DESCRIPTION("Raspberry Pi voltage sensor driver");
> > +MODULE_LICENSE("GPL v2");
> > 
>
