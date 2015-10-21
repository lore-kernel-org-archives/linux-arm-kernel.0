From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Oct 2015 21:07:49 -0600
Subject: [PATCH] thermal: Add Raspberry Pi BCM2835 thermal driver
In-Reply-To: <1444592950-16533-1-git-send-email-lkundrak@v3.sk>
References: <1444592950-16533-1-git-send-email-lkundrak@v3.sk>
Message-ID: <56270185.7030209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2015 01:49 PM, Lubomir Rintel wrote:
> BCM2835 thermal sensor accessible via Raspberry Pi VideoCore 4 firmware
> interface.
> 
> Based on work by Craig McGeachie, ported to the Raspberry Pi firmware
> interface (from the original mailbox client version).

> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig

> +config BCM2835_THERMAL
> +	tristate "BCM2835 Temperature sensor on Raspberry Pi"
> +	depends on RASPBERRYPI_FIRMWARE
> +	help
> +	  Support for the Broadcom BCM2835 thermal sensor driver on Raspberry Pi
> +	  devices in the Linux thermal framework. The BCM2835 has one sensor on
> +	  chip, with one trip point and no cooling devices.

That's about the minimum explanation that I'd expect to see in the DT
binding too.

If someone were to implement the binding for another OS, they should be
able to understand what to implement purely by reading the binding,
without reference to another OS's driver.

> diff --git a/drivers/thermal/bcm2835-thermal.c b/drivers/thermal/bcm2835-thermal.c

> +static int bcm2835_get_trip_type(struct thermal_zone_device *thermal_dev,
> +			int trip_num, enum thermal_trip_type *trip_type)
> +{
> +	*trip_type = THERMAL_TRIP_HOT;
> +
> +	return 0;
> +}

Shouldn't that validate trip_num, and return an error when it's not 0?

> +static struct platform_driver bcm2835_thermal_driver = {
> +	.driver = {
> +		.name = "bcm2835_thermal",
> +		.owner = THIS_MODULE,

I don't think .owner is required any more.

> +};
> +
> +module_platform_driver(bcm2835_thermal_driver);

Nit: Typically/often you'd put the module_platform_driver() line right
after the closing brace without a blank line between.
