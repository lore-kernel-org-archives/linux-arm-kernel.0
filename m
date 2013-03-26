From: rui.zhang@intel.com (Zhang Rui)
Date: Tue, 26 Mar 2013 22:24:55 +0800
Subject: [PATCH 2/2] thermal: dove: Fix thermal sensor formula
In-Reply-To: <1363954983-30822-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363954983-30822-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363954983-30822-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1364307895.2821.24.camel@rzhang1-mobl4>
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
> Tested by compilation only.
> 
>  drivers/thermal/dove_thermal.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
> index 7b0bfa0..ddd73a5 100644
> --- a/drivers/thermal/dove_thermal.c
> +++ b/drivers/thermal/dove_thermal.c
> @@ -107,12 +107,13 @@ static int dove_get_temp(struct thermal_zone_device *thermal,
>  	}
>  
>  	/*
> -	 * Calculate temperature. See Section 8.10.1 of 88AP510,
> -	 * Documentation/arm/Marvell/README
> +	 * Calculate temperature. According to Marvell internal
> +	 * documentation the formula for this is:
> +	 * Celsius = (322-reg)/1.3625
>  	 */
>  	reg = readl_relaxed(priv->sensor);
>  	reg = (reg >> DOVE_THERMAL_TEMP_OFFSET) & DOVE_THERMAL_TEMP_MASK;
> -	*temp = ((2281638UL - (7298*reg)) / 10);
> +	*temp = ((3220000000UL - (10000000UL * reg)) / 13625);
>  
>  	return 0;
>  }
