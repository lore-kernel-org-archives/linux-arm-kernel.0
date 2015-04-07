From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 6 Apr 2015 19:56:32 -0700
Subject: [PATCH 03/13] thermal: remove useless call to
 thermal_zone_device_set_polling
In-Reply-To: <1427385240-6086-4-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150407025630.GJ4648@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 04:53:50PM +0100, Sascha Hauer wrote:
> When the thermal zone has no get_temp callback then thermal_zone_device_register()
> calls thermal_zone_device_set_polling() with a polling delay of 0. This
> only cancels the poll_queue. Since the poll_queue hasn't been scheduled this
> is a no-op. Remove it.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

This seams reasonable to me:

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  drivers/thermal/thermal_core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index c735ac4c..dcea909 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1571,9 +1571,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  
>  	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
>  
> -	if (!tz->ops->get_temp)
> -		thermal_zone_device_set_polling(tz, 0);
> -
>  	thermal_zone_device_update(tz);
>  
>  	return tz;
> -- 
> 2.1.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/6f8bf09a/attachment-0001.sig>
