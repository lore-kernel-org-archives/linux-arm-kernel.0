From: khilman@ti.com (Kevin Hilman)
Date: Wed, 02 Mar 2011 14:17:59 -0800
Subject: [PATCH 05/17] omap4: pm: Initialise all the clockdomains to
	supported states
In-Reply-To: <1298112158-28469-6-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 19 Feb 2011 16:12:26 +0530")
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87r5ap5fqg.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Initialise hardware supervised mode for all clockdomains if it's
> supported. Initiate sleep transition for other clockdomains,
> if they are not being used.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/pm44xx.c |   22 +++++++++++++++++++++-
>  1 files changed, 21 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index b142673..9a9dc41 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -17,9 +17,11 @@
>  #include <linux/slab.h>
>  #include <plat/clock.h>
>  
> -#include "powerdomain.h"
>  #include <mach/omap4-common.h>
>  
> +#include "powerdomain.h"
> +#include "clockdomain.h"
> +
>  struct power_state {
>  	struct powerdomain *pwrdm;
>  	u32 next_state;
> @@ -74,6 +76,22 @@ static const struct platform_suspend_ops omap_pm_ops = {
>  };
>  #endif /* CONFIG_SUSPEND */
>  
> +/*
> + * Enable hardwarew supervised mode for all clockdomains if it's

typo: hardware

> + * supported. Initiate sleep transition for other clockdomains, if
> + * they are not used
> + */
> +static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
> +{
> +	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
> +		clkdm_allow_idle(clkdm);
> +	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
> +			atomic_read(&clkdm->usecount) == 0)
> +		clkdm_sleep(clkdm);
> +	return 0;
> +}
> +
> +
>  static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>  {
>  	struct power_state *pwrst;
> @@ -116,6 +134,8 @@ static int __init omap4_pm_init(void)
>  	/* Enable autoidle for all clks which support it*/
>  	omap_clk_enable_autoidle();
>  
> +	(void) clkdm_for_each(clkdms_setup, NULL);
> +
>  	ret = omap4_mpuss_init();
>  	if (ret) {
>  		pr_err("Failed to initialise OMAP4 MPUSS\n");
