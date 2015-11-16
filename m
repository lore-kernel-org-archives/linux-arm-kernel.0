From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 16 Nov 2015 09:55:59 -0800
Subject: [PATCH] hwmon: scpi: add thermal-of dependency
In-Reply-To: <4264967.aVlONpCXFM@wuerfel>
References: <4264967.aVlONpCXFM@wuerfel>
Message-ID: <564A18AF.1030804@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2015 08:56 AM, Arnd Bergmann wrote:
> The newly added scpi thermal support is broken when the scpi driver
> is built-in but the thermal driver is a loadable module:
>
> drivers/built-in.o: In function `scpi_hwmon_probe':
> (.text+0x444d70): undefined reference to `thermal_zone_of_sensor_unregister'
> (.text+0x444d94): undefined reference to `thermal_zone_of_sensor_register'
> drivers/built-in.o: In function `scpi_hwmon_remove':
> (text+0x444e6c): undefined reference to `thermal_zone_of_sensor_unregister'
>
> This uses the same Kconfig trick that we have in a couple of other
> drivers already to ensure we can only select the driver in valid
> configurations when either THERMAL_OF is disabled, or when with a
> dependency on CONFIG_THERMAL that can force SCPI to be a loadable
> module in the case I was hitting.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 68acc77a2d51 ("hwmon: Support thermal zones registration for SCP temperature sensors")

Applied.

Thanks,
Guenter

>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 842b0043ad94..597814177f50 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -324,6 +324,7 @@ config SENSORS_APPLESMC
>   config SENSORS_ARM_SCPI
>   	tristate "ARM SCPI Sensors"
>   	depends on ARM_SCPI_PROTOCOL
> +	depends on THERMAL || !THERMAL_OF
>   	help
>   	  This driver provides support for temperature, voltage, current
>   	  and power sensors available on ARM Ltd's SCP based platforms. The
>
>
