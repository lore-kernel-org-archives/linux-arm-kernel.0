From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Mon, 2 Sep 2013 10:09:11 -0400
Subject: [PATCHv2 3/5] drivers: thermal: make usage of CONFIG_THERMAL_HWMON
 optional
In-Reply-To: <1377807167-12206-1-git-send-email-eduardo.valentin@ti.com>
References: <1377648836.2335.252.camel@rzhang-lenovo>
 <1377807167-12206-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <52249C07.60806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 29-08-2013 16:12, Eduardo Valentin wrote:
> When registering a new thermal_device, the thermal framework
> will always add a hwmon sysfs interface.
> 
> This patch adds a flag to make this behavior optional. Now
> when registering a new thermal device, the caller can
> optionally inform if hwmon interface is desirable. This can
> be done by means of passing a thermal_zone_params.no_hwmon == true.
> 
> In order to keep same behavior as of today, all current
> calls will by default create the hwmon interface.
> 
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-pm at vger.kernel.org
> Cc: Zhang Rui <rui.zhang@intel.com>
> Suggested-by: Wei Ni <wni@nvidia.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  Documentation/thermal/sysfs-api.txt | 5 +++++
>  drivers/thermal/thermal_core.c      | 8 +++++---
>  include/linux/thermal.h             | 8 ++++++++
>  3 files changed, 18 insertions(+), 3 deletions(-)
> ---
> 
> Hello all,
> 
> So, here is then a different way of implementing same feature.
> As requested by Rui, now the flag goes via thermal_zone_params,
> because this seams to be the preferred way, at least in near future.
> 
> Using this method the amount of subsystems involved is reduced to 1:
> thermal, as requested by Raphael. I just made is a negative flag
> in order to keep the same behavior of the existing drivers, without
> changing them. The flag is documented though.
> 

Objections on this way of adding this flag?

Rui,

If you are OK, I can add this series to my tree too.


> All best,
> 
> 
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> index a71bd5b..37c5486 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -142,6 +142,11 @@ temperature) and throttle appropriate devices.
>      This is an optional feature where some platforms can choose not to
>      provide this data.
>      .governor_name: Name of the thermal governor used for this zone
> +    .no_hwmon: a boolean to indicate if the thermal to hwmon sysfs interface
> +               is required. when no_hwmon == false, a hwmon sysfs interface
> +               will be created. when no_hwmon == true, nothing will be done.
> +               In case the thermal_zone_params is NULL, the hwmon interface
> +               will be created (for backward compatibility).
>      .num_tbps: Number of thermal_bind_params entries for this zone
>      .tbp: thermal_bind_params entries
>  
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 247528b..51648bf 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1462,9 +1462,11 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  
>  	mutex_unlock(&thermal_governor_lock);
>  
> -	result = thermal_add_hwmon_sysfs(tz);
> -	if (result)
> -		goto unregister;
> +	if (!tz->tzp || !tz->tzp->no_hwmon) {
> +		result = thermal_add_hwmon_sysfs(tz);
> +		if (result)
> +			goto unregister;
> +	}
>  
>  	mutex_lock(&thermal_list_lock);
>  	list_add_tail(&tz->node, &thermal_tz_list);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index a386a1c..b4a975f 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -214,6 +214,14 @@ struct thermal_bind_params {
>  /* Structure to define Thermal Zone parameters */
>  struct thermal_zone_params {
>  	char governor_name[THERMAL_NAME_LENGTH];
> +
> +	/*
> +	 * a boolean to indicate if the thermal to hwmon sysfs interface
> +	 * is required. when no_hwmon == false, a hwmon sysfs interface
> +	 * will be created. when no_hwmon == true, nothing will be done
> +	 */
> +	bool no_hwmon;
> +
>  	int num_tbps;	/* Number of tbp entries */
>  	struct thermal_bind_params *tbp;
>  };
> 




-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130902/72a1609d/attachment.sig>
