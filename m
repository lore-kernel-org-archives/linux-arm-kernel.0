From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 6 Nov 2014 21:41:55 -0400
Subject: [PATCH 03/21] thermal: of: Extend of-thermal.c to provide number
 of non critical trip points
In-Reply-To: <1412872737-624-4-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-4-git-send-email-l.majewski@samsung.com>
Message-ID: <20141107014152.GD10180@developer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 06:38:39PM +0200, Lukasz Majewski wrote:
> This patch extends the of-thermal.c to provide information about number of
> available non critical (i.e. non HW) trip points in the system.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>  drivers/thermal/of-thermal.c   | 12 ++++++++++++
>  drivers/thermal/thermal_core.h |  5 +++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 23c8d6c..cd74e64 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -128,6 +128,18 @@ int of_thermal_is_trip_en(struct thermal_zone_device *tz, int trip)
>  	return 1;
>  }
>  
> +int of_thermal_get_non_crit_ntrips(struct thermal_zone_device *tz)
> +{
> +	struct __thermal_zone *data = tz->devdata;
> +	int i;
> +
> +	for (i = 0; i < data->ntrips; i++)
> +		if (data->trips[i].type != THERMAL_TRIP_CRITICAL)
> +			continue;
> +
> +	return --i;
> +}
> +



I am not against this addition. But looks like we start to spread some
specific APIs that may not be used to other drivers. Maybe having a
single API to provide a read-only copy the list / array of trips might
be a better approach. I will think of a better way.

I also request you to document it accordingly.


>  static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
>  				enum thermal_trend *trend)
>  {
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index ed8ff05..334a7be 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -83,6 +83,7 @@ int of_parse_thermal_zones(void);
>  void of_thermal_destroy_zones(void);
>  int of_thermal_get_ntrips(struct thermal_zone_device *);
>  int of_thermal_is_trip_en(struct thermal_zone_device *, int);
> +int of_thermal_get_non_crit_ntrips(struct thermal_zone_device *);
>  #else
>  static inline int of_parse_thermal_zones(void) { return 0; }
>  static inline void of_thermal_destroy_zones(void) { }
> @@ -94,6 +95,10 @@ int of_thermal_is_trip_en(struct thermal_zone_device *, int)
>  {
>  	return 0;
>  }
> +int of_thermal_get_non_crit_ntrips(struct thermal_zone_device *)
here, it is supposed to be static inline.

> +{
> +	return 0;
> +}
>  #endif
>  
>  #endif /* __THERMAL_CORE_H__ */
> -- 
> 2.0.0.rc2
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/34013c3e/attachment.sig>
