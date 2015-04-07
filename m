From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 6 Apr 2015 19:43:08 -0700
Subject: [PATCH 13/13] thermal: of: implement .set_trips for device tree
 thermal zones
In-Reply-To: <1427385240-6086-14-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-14-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150407024307.GH4648@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 04:54:00PM +0100, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/of-thermal.c | 12 ++++++++++++
>  include/linux/thermal.h      |  1 +
>  2 files changed, 13 insertions(+)

Can you please include at least one user of this call back in your patch
series?

> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 9b63193..a3de5de 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -97,6 +97,17 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
>  	return data->ops->get_temp(data->sensor_data, temp);
>  }
>  
> +static int of_thermal_set_trips(struct thermal_zone_device *tz,
> +			       unsigned long low, unsigned long high)
> +{
> +	struct __thermal_zone *data = tz->devdata;
> +
> +	if (!data->ops || !data->ops->set_trips)
> +		return -ENOSYS;
> +
> +	return data->ops->set_trips(data->sensor_data, low, high);
> +}
> +
>  /**
>   * of_thermal_get_ntrips - function to export number of available trip
>   *			   points.
> @@ -367,6 +378,7 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
>  
>  static const struct thermal_zone_device_ops of_thermal_ops = {
>  	.get_temp = of_thermal_get_temp,
> +	.set_trips = of_thermal_set_trips,
>  	.get_trend = of_thermal_get_trend,
>  	.set_emul_temp = of_thermal_set_emul_temp,
>  
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index b870702..84a5b5d 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -276,6 +276,7 @@ struct thermal_genl_event {
>   */
>  struct thermal_zone_of_device_ops {
>  	int (*get_temp)(void *, unsigned long *);
> +	int (*set_trips)(void *, unsigned long, unsigned long);

Could you please keep the kernel doc entry up to date? I know we donot
have entries for all structs, but I am working in improving this.

>  	int (*get_trend)(void *, int trend, enum thermal_trend *);
>  	int (*set_emul_temp)(void *, unsigned long);
>  };
> -- 
> 2.1.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/26e049b6/attachment.sig>
