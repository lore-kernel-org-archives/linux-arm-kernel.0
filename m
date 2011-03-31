From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 31 Mar 2011 15:20:06 +0400
Subject: [PATCH 4/8] OMAP2+: omap_hwmod: manage the omap_devices the
	wake-up latency constraints
In-Reply-To: <1301498364-726-5-git-send-email-j-pihet@ti.com>
References: <1301498364-726-1-git-send-email-j-pihet@ti.com>
	<1301498364-726-5-git-send-email-j-pihet@ti.com>
Message-ID: <4D946366.4000805@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 30-03-2011 19:19, jean.pihet at newoldbits.com wrote:

> From: Jean Pihet<j-pihet@ti.com>

> Hwmod is queried from the omap device layer to manage the power domains
> wake-up latency constraints. Hwmod retrieves the correct power domain
> and if it exists it calls the corresponding power domain function.

> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
> on MPU, CORE and PER.

> Signed-off-by: Jean Pihet<j-pihet@ti.com>
[...]

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e034294..62de888 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
[...]
> @@ -2322,11 +2323,34 @@ ohsps_unlock:
>   	return ret;
>   }
>
> +/*
> + * omap_hwmod_set_wkup_constraint- set/release a wake-up latency constraint
> + *
> + * @oh: struct omap_hwmod* to which the target device belongs to.
> + * @cookie: identifier of the constraints list for @oh.
> + * @min_latency: the minimum allowed wake-up latency for @oh.
> + *
> + * Returns 0 upon success.
> + */
> +int omap_hwmod_set_wkup_lat_constraint(struct omap_hwmod *oh,
> +				       void *cookie, long min_latency)
> +{
> +	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
> +
> +	if (!PTR_ERR(pwrdm)) {

    What's the point of calling PTR_ERR() at all, if just '!pwrdm' will give 
the same result?

WBR, Sergei
