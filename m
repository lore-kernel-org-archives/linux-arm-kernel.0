From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 2 Jul 2013 11:32:34 +0530
Subject: [PATCH 3/4] rtc: omap: add rtc wakeup support to alarm events
In-Reply-To: <1372412109-986-4-git-send-email-gururaja.hebbar@ti.com>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
 <1372412109-986-4-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <51D26CFA.5090500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/28/2013 3:05 PM, Hebbar Gururaja wrote:
> On some platforms (like AM33xx), a special register (RTC_IRQWAKEEN)
> is available to enable Alarm Wakeup feature. This register needs to be
> properly handled for the rtcwake to work properly.
> 
> Platforms using such IP should set "ti,am3352-rtc" in rtc device dt
> compatibility node.
> 
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Rob Landley <rob@landley.net>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: rtc-linux at googlegroups.com
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-doc at vger.kernel.org
> ---

[...]

> -#define	OMAP_RTC_DATA_DA830_IDX	1
> +#define	OMAP_RTC_DATA_DA830_IDX		1
> +#define	OMAP_RTC_DATA_AM335X_IDX	2
>  
>  static struct platform_device_id omap_rtc_devtype[] = {
>  	{
> @@ -309,6 +321,9 @@ static struct platform_device_id omap_rtc_devtype[] = {
>  	}, {
>  		.name	= "da830-rtc",
>  		.driver_data = OMAP_RTC_HAS_KICKER,
> +	}, {
> +		.name	= "am335x-rtc",

may be use am3352-rtc here just to keep the platform device name and of
compatible in sync.

> +		.driver_data = OMAP_RTC_HAS_KICKER | OMAP_RTC_HAS_IRQWAKEEN,
>  	},
>  	{},

It is better to use the index defined above in the static initialization
so they remain in sync.

	...
	[OMAP_RTC_DATA_DA830_IDX] = {
		.name	= "da830-rtc",
		.driver_data = OMAP_RTC_HAS_KICKER,
	},
	...

>  };
> @@ -318,6 +333,9 @@ static const struct of_device_id omap_rtc_of_match[] = {
>  	{	.compatible	= "ti,da830-rtc",
>  		.data		= &omap_rtc_devtype[OMAP_RTC_DATA_DA830_IDX],
>  	},
> +	{	.compatible	= "ti,am3352-rtc",
> +		.data		= &omap_rtc_devtype[OMAP_RTC_DATA_AM335X_IDX],
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, omap_rtc_of_match);

Apart from these minor issues, the patch looks good to me.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
