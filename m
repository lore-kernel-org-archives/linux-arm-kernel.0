From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 03 Oct 2012 07:29:00 -0700
Subject: [PATCH 2/2] ARM: OMAP: SmartReflex: pass device dependent data
 via platform data
In-Reply-To: <1349271133-18458-1-git-send-email-j-pihet@ti.com> (jean pihet's
 message of "Wed, 3 Oct 2012 15:32:13 +0200")
References: <1348496201-6378-3-git-send-email-j-pihet@ti.com>
 <1349271133-18458-1-git-send-email-j-pihet@ti.com>
Message-ID: <87391v39zn.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jean.pihet at newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Remove the device dependent code (ex. cpu_is_xxx()) and settings
> from the driver code and instead pass them via the platform
> data. This allows a clean separation of the driver code and the platform
> code, as required by the move of the platform header files to
> include/linux/platform_data.
>
> Note about the smartreflex functional clocks: the smartreflex fclks
> are derived from sys_clk and are named "smartreflex.%d". Since the
> smartreflex device names and the functional clock names are identical
> the device driver code uses them to control the functional clocks.

Thanks for adding this part.

One more nit below, then please resend this patch as a combined series
with the "align fclk names" patch.  (note: The previous patch 1 from this
series I've queued separately as a fix for v3.7-rc.  )

> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/sr_device.c   |   13 +++++++++++++
>  drivers/power/avs/smartreflex.c   |   38 +++++++++----------------------------
>  include/linux/power/smartreflex.h |   14 ++++++++++++--
>  3 files changed, 34 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
> index cbeae56..06de443 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -121,6 +121,19 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
>  	sr_data->senn_mod = 0x1;
>  	sr_data->senp_mod = 0x1;
>  
> +	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> +		sr_data->err_weight = OMAP3430_SR_ERRWEIGHT;
> +		sr_data->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
> +		sr_data->accum_data = OMAP3430_SR_ACCUMDATA;
> +		if (!(strcmp(sr_data->name, "smartreflex_mpu"))) {
> +			sr_data->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
> +			sr_data->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;
> +		} else {
> +			sr_data->senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT;
> +			sr_data->senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT;
> +		}
> +	}
> +
>  	sr_data->voltdm = voltdm_lookup(sr_dev_attr->sensor_voltdm_name);
>  	if (IS_ERR(sr_data->voltdm)) {
>  		pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
> diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
> index 24768a2..829467f 100644
> --- a/drivers/power/avs/smartreflex.c
> +++ b/drivers/power/avs/smartreflex.c
> @@ -133,14 +133,11 @@ static void sr_set_clk_length(struct omap_sr *sr)
>  	struct clk *sys_ck;
>  	u32 sys_clk_speed;
>  
> -	if (cpu_is_omap34xx())
> -		sys_ck = clk_get(NULL, "sys_ck");
> -	else
> -		sys_ck = clk_get(NULL, "sys_clkin_ck");
> +	sys_ck = clk_get(&sr->pdev->dev, "fck");

nit: since this isn't the sys_clk anymore, could you s/sys_ck/fck/  ?

Thanks,

Kevin
