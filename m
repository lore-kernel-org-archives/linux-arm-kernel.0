From: rui.zhang@intel.com (Zhang Rui)
Date: Tue, 26 Mar 2013 22:24:09 +0800
Subject: [PATCH for 3.9] thermal: mvebu: Fix valid check for thermal
 register
In-Reply-To: <1363898527-3660-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363898527-3660-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1364307849.2821.22.camel@rzhang1-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-03-21 at 17:42 -0300, Ezequiel Garcia wrote:
> The correct value is obtain by first shifting the register by the offset,
> later applying the valid mask and finally invert the result.
> This check was lacking an extra parenthesis to be strictly correct.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

applied to thermal -next.

thanks,
rui
> ---
> I've taken this fix out of the thermal patchset,
> so we can apply it earlier on v3.9.
> 
>  drivers/thermal/kirkwood_thermal.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
> index 65cb4f0..ee433b7 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -41,8 +41,8 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
>  	reg = readl_relaxed(priv->sensor);
>  
>  	/* Valid check */
> -	if (!(reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
> -	    KIRKWOOD_THERMAL_VALID_MASK) {
> +	if (!((reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
> +	    KIRKWOOD_THERMAL_VALID_MASK)) {
>  		dev_err(&thermal->device,
>  			"Temperature sensor reading not valid\n");
>  		return -EIO;
