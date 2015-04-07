From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 6 Apr 2015 20:29:49 -0700
Subject: [PATCH 10/13] thermal: Make struct thermal_zone_device_ops const
In-Reply-To: <1427385240-6086-11-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-11-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150407032948.GN4648@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 04:53:57PM +0100, Sascha Hauer wrote:
> Now that the of thermal support no longer changes the
> thermal_zone_device_ops it can be const again.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  include/linux/thermal.h        | 6 +++---

I believe this change deserves to be done together with the required driver 
updates on those parts that calls this function.

>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index acf00b5..dcdf45e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1455,7 +1455,7 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
>   */
>  struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  	int trips, int mask, void *devdata,
> -	struct thermal_zone_device_ops *ops,
> +	const struct thermal_zone_device_ops *ops,
>  	const struct thermal_zone_params *tzp,
>  	int passive_delay, int polling_delay)
>  {
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 2f77091..ac2897c 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -185,7 +185,7 @@ struct thermal_zone_device {
>  	unsigned long emul_temperature;
>  	int passive;
>  	unsigned int forced_passive;
> -	struct thermal_zone_device_ops *ops;
> +	const struct thermal_zone_device_ops *ops;
>  	const struct thermal_zone_params *tzp;
>  	struct thermal_governor *governor;
>  	struct list_head thermal_instances;
> @@ -317,7 +317,7 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
>  
>  #if IS_ENABLED(CONFIG_THERMAL)
>  struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
> -		void *, struct thermal_zone_device_ops *,
> +		void *, const struct thermal_zone_device_ops *,
>  		const struct thermal_zone_params *, int, int);
>  void thermal_zone_device_unregister(struct thermal_zone_device *);
>  
> @@ -345,7 +345,7 @@ void thermal_notify_framework(struct thermal_zone_device *, int);
>  #else
>  static inline struct thermal_zone_device *thermal_zone_device_register(
>  	const char *type, int trips, int mask, void *devdata,
> -	struct thermal_zone_device_ops *ops,
> +	const struct thermal_zone_device_ops *ops,
>  	const struct thermal_zone_params *tzp,
>  	int passive_delay, int polling_delay)
>  { return ERR_PTR(-ENODEV); }
> -- 
> 2.1.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/ca99de30/attachment.sig>
