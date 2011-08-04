From: khilman@ti.com (Kevin Hilman)
Date: Thu, 04 Aug 2011 14:55:35 -0700
Subject: [PATCH 2/2] omap_twl: Prevent SR to enable for am3517/am3505
	devices
In-Reply-To: <1312473569-1212-1-git-send-email-abhilash.kv@ti.com> (Abhilash
	K. V.'s message of "Thu, 4 Aug 2011 21:29:29 +0530")
References: <1312473569-1212-1-git-send-email-abhilash.kv@ti.com>
Message-ID: <87hb5w3kq0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash K V <abhilash.kv@ti.com> writes:

> From: Vaibhav Hiremath <hvaibhav@ti.com>
>
> In case of AM3517 & AM3505, Smart Reflex is not applicable so
> we must not enable it. So add check for am3517/05 cpu revision
> in omap3_twl_init() and return -ENODEV if true, else continue.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
> ---
>  arch/arm/mach-omap2/omap_twl.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
> index 07d6140..92fadcb 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -269,6 +269,14 @@ int __init omap3_twl_init(void)
>  	if (!cpu_is_omap34xx())
>  		return -ENODEV;
>  
> +	/*
> +	 * In case of AM3517/AM3505 we should not be going down
> +	 * further, since SR is not applicable there.
> +	 */
> +	if (cpu_is_omap3505() || cpu_is_omap3517()) {
> +		return -ENODEV;
> +	}
> +

Rather than using cpu_is_*, you should add a new "feature" flag for
SmartReflex.  We already have this for things like SGX, IVA, NEON, etc.
See <plat/feature.h>

Kevin


>  	if (cpu_is_omap3630()) {
>  		omap3_mpu_volt_info.vp_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
>  		omap3_mpu_volt_info.vp_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
