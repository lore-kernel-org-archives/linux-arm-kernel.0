From: rui.zhang@intel.com (Zhang Rui)
Date: Tue, 26 Mar 2013 22:24:33 +0800
Subject: [PATCH 1/2] thermal: kirkwood: Fix thermal sensor formula
In-Reply-To: <1363954983-30822-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363954983-30822-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363954983-30822-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1364307873.2821.23.camel@rzhang1-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-03-22 at 09:23 -0300, Ezequiel Garcia wrote:
> The currently formula has been taken from the 88AP510 SoC datasheet,
> which is not exactly correct. The correct value for the temperature
> in Celcius of the sensor present in this SoC is:
> 
>   Celsius = (322-reg)/1.3625
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

applied to thermal -next.

thanks,
rui
> ---
>  drivers/thermal/kirkwood_thermal.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
> index 65cb4f0..84b331f 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -49,13 +49,13 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
>  	}
>  
>  	/*
> -	 * Calculate temperature. See Section 8.10.1 of the 88AP510,
> -	 * datasheet, which has the same sensor.
> -	 * Documentation/arm/Marvell/README
> +	 * Calculate temperature. According to Marvell internal
> +	 * documentation the formula for this is:
> +	 * Celsius = (322-reg)/1.3625
>  	 */
>  	reg = (reg >> KIRKWOOD_THERMAL_TEMP_OFFSET) &
>  		KIRKWOOD_THERMAL_TEMP_MASK;
> -	*temp = ((2281638UL - (7298*reg)) / 10);
> +	*temp = ((3220000000UL - (10000000UL * reg)) / 13625);
>  
>  	return 0;
>  }
