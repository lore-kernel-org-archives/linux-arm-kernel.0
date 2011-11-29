From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 29 Nov 2011 19:10:15 +0100
Subject: [PATCH 3/3] ARM: OMAP: hwmod: Look for hwmod/module level context
 lost count if supported
In-Reply-To: <1320317665-6381-4-git-send-email-rnayak@ti.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com>
 <1320317665-6381-4-git-send-email-rnayak@ti.com>
Message-ID: <4ED52007.8010804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra,

Sorry for the delay, I kind of forgot your series :-(

On 11/3/2011 11:54 AM, Nayak, Rajendra wrote:
> Now that OMAP4 has hwmod/module level context lost counters, make
> omap_hwmod_get_context_loss_count() return them on platforms where they
> exist, else fall back on the pwrdm level counters for older platforms.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |   11 ++++++++---
>   1 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index ac17748..9d140c4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2658,9 +2658,14 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
>   	struct powerdomain *pwrdm;
>   	int ret = 0;
>
> -	pwrdm = omap_hwmod_get_pwrdm(oh);
> -	if (pwrdm)
> -		ret = pwrdm_get_context_loss_count(pwrdm);
> +	if (oh->prcm.omap4.context_offs) {

I don't think it is safe to use that, since this is an union.
You do know what OMAP2 & 3 will put in that location.
It might be zero, but who knows?

> +		/* Support for per-hwmod context register */
> +		ret = oh->prcm.omap4.context_lost_counter;
> +	} else {
> +		pwrdm = omap_hwmod_get_pwrdm(oh);
> +		if (pwrdm)
> +			ret = pwrdm_get_context_loss_count(pwrdm);
> +	}
>
>   	return ret;
>   }

Regards,
Benoit
