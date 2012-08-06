From: khilman@ti.com (Kevin Hilman)
Date: Mon, 06 Aug 2012 16:31:10 -0700
Subject: [PATCHv4 2/8] ARM: OMAP3+: voltage/pwrdm/clkdm/clock add
 recursive usecount tracking
In-Reply-To: <1342189185-5306-3-git-send-email-t-kristo@ti.com> (Tero Kristo's
 message of "Fri, 13 Jul 2012 17:19:39 +0300")
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
 <1342189185-5306-3-git-send-email-t-kristo@ti.com>
Message-ID: <87ipcv4myp.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> This patch fixes the usecount tracking for omap3+, previously the
> usecount numbers were rather bogus and were not really useful for
> any purpose. Now usecount numbers track the number of really active
> clients on each domain. This patch also adds support for usecount
> tracking on powerdomain level and autoidle flag for clocks that
> are hardware controlled and should be skipped in usecount
> calculations.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>

[...]

>  /* Clock control for DPLL outputs */
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 9611490..68bdf36 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -981,6 +981,41 @@ int pwrdm_state_switch(struct powerdomain *pwrdm)
>  	return ret;
>  }
>  
> +/**
> + * pwrdm_clkdm_enable - increment powerdomain usecount
> + * @pwrdm: struct powerdomain *
> + *
> + * Increases the usecount for a powerdomain. Called from clockdomain
> + * code once a clockdomain's usecount reaches zero, i.e. it is ready
> + * to idle.
> + */

I think the comment here is wrong.

> +void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
> +{
> +	if (!pwrdm)
> +		return;
> +
> +	atomic_inc(&pwrdm->usecount);
> +}
> +
> +/**
> + * pwrdm_clkdm_disable - decrease powerdomain usecount
> + * @pwrdm: struct powerdomain *
> + *
> + * Decreases the usecount for a powerdomain. Called from clockdomain
> + * code once a clockdomain becomes active.
> + */

Looks like these two comments need to be swapped?

> +void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
> +{
> +	int val;
> +
> +	if (!pwrdm)
> +		return;
> +
> +	val = atomic_dec_return(&pwrdm->usecount);
> +
> +	BUG_ON(val < 0);
> +}
> +

Kevin
