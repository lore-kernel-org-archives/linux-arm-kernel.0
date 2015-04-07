From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 6 Apr 2015 19:23:08 -0700
Subject: [PATCH 05/13] thermal: inline only once used function
In-Reply-To: <1427385240-6086-6-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150407022307.GE4648@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 04:53:52PM +0100, Sascha Hauer wrote:
> Inline update_temperature into its only caller to make the code
> more readable.

I am not sure I understand how this is improving readability, can you
please elaborate?

The way it is now it is more modular at least.

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/thermal_core.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index ebca854..6d0fdad 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -431,11 +431,15 @@ exit:
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
>  
> -static void update_temperature(struct thermal_zone_device *tz)
> +void thermal_zone_device_update(struct thermal_zone_device *tz)
>  {
> +	int count;
>  	unsigned long temp;
>  	int ret;
>  
> +	if (!tz->ops->get_temp)
> +		return;
> +
>  	ret = thermal_zone_get_temp(tz, &temp);
>  	if (ret) {
>  		dev_warn(&tz->device, "failed to read out thermal zone %d\n",
> @@ -451,16 +455,6 @@ static void update_temperature(struct thermal_zone_device *tz)
>  	trace_thermal_temperature(tz);
>  	dev_dbg(&tz->device, "last_temperature=%lu, current_temperature=%lu\n",
>  				tz->last_temperature, tz->temperature);
> -}
> -
> -void thermal_zone_device_update(struct thermal_zone_device *tz)
> -{
> -	int count;
> -
> -	if (!tz->ops->get_temp)
> -		return;
> -
> -	update_temperature(tz);
>  
>  	for (count = 0; count < tz->trips; count++)
>  		handle_thermal_trip(tz, count);
> -- 
> 2.1.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/9e258001/attachment.sig>
