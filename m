From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 26 Dec 2012 06:21:46 +0000
Subject: [PATCH 09/12] ARM: OMAP2+: powerdomain: skip register reads for
 powerdomains known to be on
In-Reply-To: <20121209200327.3196.27686.stgit@dusk.lan>
References: <20121209200108.3196.12452.stgit@dusk.lan>
 <20121209200327.3196.27686.stgit@dusk.lan>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECA6CF8@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Mon, Dec 10, 2012 at 01:33:28, Paul Walmsley wrote:
> There's no need to determine the current power state for powerdomains
> that must be on while the kernel is running.  We mark these
> powerdomains with a new flag, PWRDM_ACTIVE_WITH_KERNEL.  Any
> powerdomain marked with that flag is reported as being in the ON power
> state while the kernel is running.
[...]
> diff --git a/arch/arm/mach-omap2/powerdomains33xx_data.c b/arch/arm/mach-omap2/powerdomains33xx_data.c
> index 869adb8..acb148a 100644
> --- a/arch/arm/mach-omap2/powerdomains33xx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains33xx_data.c
> @@ -123,7 +123,8 @@ static struct powerdomain mpu_33xx_pwrdm = {
>  	.pwrstst_offs		= AM33XX_PM_MPU_PWRSTST_OFFSET,
>  	.pwrsts			= PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
> -	.flags			= PWRDM_HAS_LOWPOWERSTATECHANGE,
> +	.flags			= (PWRDM_HAS_LOWPOWERSTATECHANGE |
> +				   PWRDM_ACTIVE_WITH_KERNEL),

In case of AM33xx, this flag should be set for PER and WKUP pwrdms also.
EMIF, L3, L4 etc come under PER so this domain can't transition on an active
system. PRCM and Control module come under WKUP, so the WKUP should the kernel
should attempt to transition WKUP domain also.

Regards,
Vaibhav
