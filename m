From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 28 Feb 2016 16:45:01 -0800
Subject: [PATCH v3 2/3] hwmon: Create an NSA320 hardware monitoring driver
In-Reply-To: <1456698614-15176-3-git-send-email-linux@baker-net.org.uk>
References: <1456698614-15176-1-git-send-email-linux@baker-net.org.uk>
 <1456698614-15176-3-git-send-email-linux@baker-net.org.uk>
Message-ID: <56D3948D.6000805@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2016 02:30 PM, Adam Baker wrote:
> Create a driver to support the hardware monitoring chip present in
> the Zyxel NSA320 and some of the other Zyxel NAS devices.
>
> The driver reads fan speed and temperature from a suitably
> pre-programmed MCU on the device.
>
> Signed-off-by: Adam Baker <linux@baker-net.org.uk>
> ---
> Changes since v2
> Updated based on Guenter Roeck's review,
> - return a single value that is result or error from the update function
> - use separate show_value routimes for fan and temp
> - Added Documentation/hwmon/nsa320-hwmon
> ---
>   Documentation/hwmon/nsa320   |  53 +++++++++++
>   drivers/hwmon/Kconfig        |  15 +++
>   drivers/hwmon/Makefile       |   1 +
>   drivers/hwmon/nsa320-hwmon.c | 215 +++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 284 insertions(+)
>   create mode 100644 Documentation/hwmon/nsa320
>   create mode 100644 drivers/hwmon/nsa320-hwmon.c
>
> diff --git a/Documentation/hwmon/nsa320 b/Documentation/hwmon/nsa320
> new file mode 100644
> index 0000000..fdbd694
> --- /dev/null
> +++ b/Documentation/hwmon/nsa320
> @@ -0,0 +1,53 @@
> +Kernel driver nsa320_hwmon
> +==========================
> +
> +Supported chips:
> +  * Holtek HT46R065 microcontroller with onboard firmware that configures
> +	it to act as a hardware monitor.
> +    Prefix: 'nsa320'
> +    Addresses scanned: none
> +    Datasheet: Not available, driver was reverse engineered based upon the
> +	Zyxel kernel source
> +
> +Author:
> +  Adam Baker <linux@baker-net.org.uk>
> +
> +Description
> +-----------
> +
> +This chip is known to be used in the Zyxel NSA320 and NSA325 NAS Units and
> +also in some variants of the NSA310 but the driver has only been tested
> +on the NSA320. In all of these devices it is connected to the same 3 GPIO
> +lines which are used to provide chip select, clock and data lines. The
> +interface behaves similarly to SPI but at much lower speeds than are normally
> +used for SPI.
> +
> +Following each chip select pulse the chip will generate a single 32 bit word
> +that contains 0x55 as a marker to indicate that data is being read correctly,
> +followed by an 8 bit fan speed in 100s of RPM and a 16 bit temperature in
> +tenths of a degree.
> +
> +
> +sysfs-Interface
> +---------------
> +
> +temp1_input - temperature input
> +fan1_input - fan speed
> +
> +Notes
> +-----
> +
> +The access timings used in the driver are the same as used in the Zyxel
> +provided kernel. Testing has shown that if the delay between chip select and
> +the first clock pulse is reduced from 100 ms to just under 10ms then the chip
> +will not produce any output. If the duration of either phase of the clock
> +is reduced from 100 us to less than 15 us then data pulses are likely to be
> +read twice corrupting the output. The above analysis is based upon a sample
> +of one unit but suggests that the Zyxel provided delay values include a
> +reasonable tolerance.
> +
> +The driver incorporates a limit that it will not check for updated values
> +faster than once a second. This is because the hardware takes a relatively long
> +time to read the data from the device and when it does it reads both temp and
> +fan speed. As the most likely case for two accesses in quick succession is
> +to read both of these values avoiding a second read delay is desirable.
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
> index 12a3239..9e22cf7 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -124,6 +124,7 @@ obj-$(CONFIG_SENSORS_NCT6683)	+= nct6683.o
>   obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
>   obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
>   obj-$(CONFIG_SENSORS_NCT7904)	+= nct7904.o
> +obj-$(CONFIG_SENSORS_NSA320)	+= nsa320-hwmon.o
>   obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
>   obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>   obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
> diff --git a/drivers/hwmon/nsa320-hwmon.c b/drivers/hwmon/nsa320-hwmon.c
> new file mode 100644
> index 0000000..e833550
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
> +	unsigned long		mcu_data;
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
> +	[NSA3XX_TEMP] = "System Temperature",
> +	[NSA3XX_FAN] = "Chassis Fan",
> +};
> +
> +/*
> + * Although this protocol looks similar to SPI the long delay
> + * between the active (aka chip select) signal and the shorter
> + * delay between clock pulses are needed for reliable operation.
> + * The delays provided are taken from the manufacturer kernel,
> + * testing suggest they probably incorporate a reasonable safety
> + * margin. (The single device tested became unreliable if the
> + * delay was reduced to 1/10th of this value.)
> + */
> +static unsigned long nsa320_hwmon_update(struct device *dev)

Please make this either int or s32.

> +{
> +	u32 mcu_data;

You can (and should) still use u32 here.

Thanks,
Guenter
