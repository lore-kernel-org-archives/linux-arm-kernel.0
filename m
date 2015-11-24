From: javi.merino@arm.com (Javi Merino)
Date: Tue, 24 Nov 2015 14:38:45 +0000
Subject: [PATCH] thermal: fix thermal_zone_bind_cooling_device prototype
In-Reply-To: <5439003.qQElgLSp5g@wuerfel>
References: <5439003.qQElgLSp5g@wuerfel>
Message-ID: <20151124143844.GA17897@e104805>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 05:48:52PM +0100, Arnd Bergmann wrote:
> When the prototype for thermal_zone_bind_cooling_device
> changed, the static inline wrapper function was left alone,
> which in theory can cause build warnings:
> 
> I have seen this error in the past:
> drivers/thermal/db8500_thermal.c: In function 'db8500_cdev_bind':
> drivers/thermal/db8500_thermal.c:78:9: error: too many arguments to function 'thermal_zone_bind_cooling_device'
>    ret = thermal_zone_bind_cooling_device(thermal, i, cdev,
> 
> while this one no longer shows up, there is no doubt that
> the prototype is still wrong, so let's just fix it anyway.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6cd9e9f629f1 ("thermal: of: fix cooling device weights in device tree")

Yes, we forgot to fix the case for !THERMAL

Reviewed-by: Javi Merino <javi.merino@arm.com>

> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 4014a59828fc..613c29bd6baf 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -438,7 +438,8 @@ static inline void thermal_zone_device_unregister(
>  static inline int thermal_zone_bind_cooling_device(
>  	struct thermal_zone_device *tz, int trip,
>  	struct thermal_cooling_device *cdev,
> -	unsigned long upper, unsigned long lower)
> +	unsigned long upper, unsigned long lower,
> +	unsigned int weight)
>  { return -ENODEV; }
>  static inline int thermal_zone_unbind_cooling_device(
>  	struct thermal_zone_device *tz, int trip,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
