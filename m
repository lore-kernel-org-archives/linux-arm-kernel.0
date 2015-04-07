From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 6 Apr 2015 19:40:28 -0700
Subject: [PATCH 12/13] thermal: Add support for hardware-tracked trip
 points
In-Reply-To: <1427385240-6086-13-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-13-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150407024027.GG4648@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 04:53:59PM +0100, Sascha Hauer wrote:
> This adds support for hardware-tracked trip points to the device tree
> thermal sensor framework.
> 
> The framework supports an arbitrary number of trip points. Whenever
> the current temperature is updated, the trip points immediately
> below and above the current temperature are found. A .set_trips
> callback is then called with the temperatures. If there is no trip
> point above or below the current temperature, the passed trip
> temperature will be ULONG_MAX or 0 respectively. In this callback,
> the driver should program the hardware such that it is notified
> when either of these trip points are triggered. When a trip point
> is triggered, the driver should call `thermal_zone_device_update'
> for the respective thermal zone. This will cause the trip points
> to be updated again.
> 
> If .set_trips is not implemented, the framework behaves as before.
> 
> This patch is based on an earlier version from Mikko Perttunen
> <mikko.perttunen@kapsi.fi>
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/thermal_core.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h        |  3 +++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index dcdf45e..7138f8f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -434,6 +434,45 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
>  
> +static void thermal_zone_set_trips(struct thermal_zone_device *tz)
> +{
> +	unsigned long low = 0;
> +	unsigned long high = ULONG_MAX;
> +	unsigned long trip_temp, hysteresis;
> +	unsigned long temp = tz->temperature;
> +	int i;
> +
> +	if (!tz->ops->set_trips)
> +		return;
> +
> +	/* No need to change trip points */
> +	if (temp > tz->prev_low_trip && temp < tz->prev_high_trip)
> +		return;
> +
> +	for (i = 0; i < tz->trips; i++) {
> +		unsigned long trip_low;
> +
> +		tz->ops->get_trip_temp(tz, i, &trip_temp);
> +		tz->ops->get_trip_hyst(tz, i, &hysteresis);
> +
> +		trip_low = trip_temp - hysteresis;
> +
> +		if (trip_low < temp && trip_low > low)
> +			low = trip_low;
> +
> +		if (trip_temp > temp && trip_temp < high)
> +			high = trip_temp;
> +	}
> +
> +	tz->prev_low_trip = low;
> +	tz->prev_high_trip = high;
> +
> +	dev_dbg(&tz->device, "new temperature boundaries: %lu < x < %lu\n",
> +			low, high);
> +
> +	tz->ops->set_trips(tz, low, high);
> +}
> +
>  void thermal_zone_device_update(struct thermal_zone_device *tz)
>  {
>  	int count;
> @@ -460,6 +499,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  	dev_dbg(&tz->device, "last_temperature=%lu, current_temperature=%lu\n",
>  				tz->last_temperature, tz->temperature);
>  
> +	thermal_zone_set_trips(tz);

Do we need to lock the tz->lock to perform this operation of setting the
hardware trip points?

> +
>  	for (count = 0; count < tz->trips; count++)
>  		handle_thermal_trip(tz, count);
>  }
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index ac2897c..b870702 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -87,6 +87,7 @@ struct thermal_zone_device_ops {
>  	int (*unbind) (struct thermal_zone_device *,
>  		       struct thermal_cooling_device *);
>  	int (*get_temp) (struct thermal_zone_device *, unsigned long *);
> +	int (*set_trips) (struct thermal_zone_device *, unsigned long, unsigned long);
>  	int (*get_mode) (struct thermal_zone_device *,
>  			 enum thermal_device_mode *);
>  	int (*set_mode) (struct thermal_zone_device *,
> @@ -183,6 +184,8 @@ struct thermal_zone_device {
>  	unsigned long temperature;
>  	unsigned long last_temperature;
>  	unsigned long emul_temperature;
> +	unsigned long prev_low_trip;
> +	unsigned long prev_high_trip;
>  	int passive;
>  	unsigned int forced_passive;
>  	const struct thermal_zone_device_ops *ops;
> -- 
> 2.1.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/d4723b2a/attachment.sig>
