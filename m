From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 6 Apr 2015 18:45:48 -0700
Subject: [PATCH 01/13] thermal: Make temperatures consistently unsigned
 long
In-Reply-To: <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150407014546.GA4648@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 04:53:48PM +0100, Sascha Hauer wrote:
> The thermal framework uses int, long and unsigned long for temperatures
> in millicelsius. The majority of functions uses unsigned long, so change
> the remaining functions to use this type aswell.

I believe it make sense to change all to be int. int covers for the
required temperature range. 

Rui is just introducing the concept of invalid temp, which is below 0 K.

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/thermal_core.c | 10 +++++-----
>  include/linux/thermal.h        |  6 +++---

This change is not that straight forward as it looks like. 

In order to standardize this, apart from the thermal core
we will need to make drivers aware of the change too.
That will require changing the thermal zone device ops and all its
users, for the trip temperature, temperature, and hysteresis cases.

>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 174d3bc..0e4ad7c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -378,7 +378,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>  
>  	if (trip_type == THERMAL_TRIP_CRITICAL) {
>  		dev_emerg(&tz->device,
> -			  "critical temperature reached(%d C),shutting down\n",
> +			  "critical temperature reached(%lu C),shutting down\n",
>  			  tz->temperature / 1000);
>  		orderly_poweroff(true);
>  	}
> @@ -453,7 +453,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
>  
>  static void update_temperature(struct thermal_zone_device *tz)
>  {
> -	long temp;
> +	unsigned long temp;
>  	int ret;
>  
>  	ret = thermal_zone_get_temp(tz, &temp);
> @@ -469,7 +469,7 @@ static void update_temperature(struct thermal_zone_device *tz)
>  	mutex_unlock(&tz->lock);
>  
>  	trace_thermal_temperature(tz);
> -	dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
> +	dev_dbg(&tz->device, "last_temperature=%lu, current_temperature=%lu\n",
>  				tz->last_temperature, tz->temperature);
>  }
>  
> @@ -512,7 +512,7 @@ static ssize_t
>  temp_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	long temperature;
> +	unsigned long temperature;
>  	int ret;
>  
>  	ret = thermal_zone_get_temp(tz, &temperature);
> @@ -520,7 +520,7 @@ temp_show(struct device *dev, struct device_attribute *attr, char *buf)
>  	if (ret)
>  		return ret;
>  
> -	return sprintf(buf, "%ld\n", temperature);
> +	return sprintf(buf, "%lu\n", temperature);
>  }
>  
>  static ssize_t
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5eac316..db6c12b 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -180,9 +180,9 @@ struct thermal_zone_device {
>  	int trips;
>  	int passive_delay;
>  	int polling_delay;
> -	int temperature;
> -	int last_temperature;
> -	int emul_temperature;
> +	unsigned long temperature;
> +	unsigned long last_temperature;
> +	unsigned long emul_temperature;
>  	int passive;
>  	unsigned int forced_passive;
>  	struct thermal_zone_device_ops *ops;

Something like the following would be required to do a standardization.
Of course, the code below requires changing drivers too:

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6bbe11c..84c9777 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -92,7 +92,7 @@ struct thermal_zone_device_ops {
 		     struct thermal_cooling_device *);
 	int (*unbind) (struct thermal_zone_device *,
 		       struct thermal_cooling_device *);
-	int (*get_temp) (struct thermal_zone_device *, unsigned long *);
+	int (*get_temp) (struct thermal_zone_device *, int *);
 	int (*get_mode) (struct thermal_zone_device *,
 			 enum thermal_device_mode *);
 	int (*set_mode) (struct thermal_zone_device *,
@@ -100,15 +100,15 @@ struct thermal_zone_device_ops {
 	int (*get_trip_type) (struct thermal_zone_device *, int,
 		enum thermal_trip_type *);
 	int (*get_trip_temp) (struct thermal_zone_device *, int,
-			      unsigned long *);
+			      int *);
 	int (*set_trip_temp) (struct thermal_zone_device *, int,
-			      unsigned long);
+			      int);
 	int (*get_trip_hyst) (struct thermal_zone_device *, int,
-			      unsigned long *);
+			      int *);
 	int (*set_trip_hyst) (struct thermal_zone_device *, int,
-			      unsigned long);
-	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
-	int (*set_emul_temp) (struct thermal_zone_device *, unsigned long);
+			      int);
+	int (*get_crit_temp) (struct thermal_zone_device *, int *);
+	int (*set_emul_temp) (struct thermal_zone_device *, int);
 	int (*get_trend) (struct thermal_zone_device *, int,
 			  enum thermal_trend *);
 	int (*notify) (struct thermal_zone_device *, int,
@@ -321,9 +321,9 @@ struct thermal_genl_event {
  *		   temperature.
  */
 struct thermal_zone_of_device_ops {
-	int (*get_temp)(void *, long *);
-	int (*get_trend)(void *, long *);
-	int (*set_emul_temp)(void *, unsigned long);
+	int (*get_temp)(void *, int *);
+	int (*get_trend)(void *, int *);
+	int (*set_emul_temp)(void *, int);
 };
 
 /**
@@ -336,8 +336,8 @@ struct thermal_zone_of_device_ops {
 
 struct thermal_trip {
 	struct device_node *np;
-	unsigned long int temperature;
-	unsigned long int hysteresis;
+	int temperature;
+	int hysteresis;
 	enum thermal_trip_type type;
 };
 
@@ -395,7 +395,7 @@ thermal_of_cooling_device_register(struct device_node *np, char *, void *,
 				   const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
-int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp);
+int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
@@ -446,7 +446,7 @@ static inline struct thermal_zone_device *thermal_zone_get_zone_by_name(
 		const char *name)
 { return ERR_PTR(-ENODEV); }
 static inline int thermal_zone_get_temp(
-		struct thermal_zone_device *tz, unsigned long *temp)
+		struct thermal_zone_device *tz, int *temp)
 { return -ENODEV; }
 static inline int get_tz_trend(struct thermal_zone_device *tz, int trip)
 { return -ENODEV; }


> -- 
> 2.1.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/f80c7d4d/attachment-0001.sig>
