From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 31 Jul 2012 15:56:37 -0500
Subject: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain
 transitioning to OFF when in-use
In-Reply-To: <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-9-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com>
Message-ID: <50184685.9010608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 07/12/2012 04:17 PM, Paul Walmsley wrote:

[snip]

> @@ -170,6 +201,18 @@ static int omap2_clkdm_clk_enable(struct clockdomain *clkdm)
>  	if (!clkdm->clktrctrl_mask)
>  		return 0;
>  
> +	/*
> +	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
> +	 * more details on the unpleasant problem this is working
> +	 * around
> +	 */
> +	if (clkdm->flags & (CLKDM_MISSING_IDLE_REPORTING |
> +			    CLKDM_CAN_FORCE_WAKEUP)) {
> +		(cpu_is_omap24xx()) ? omap2_clkdm_wakeup(clkdm) :
> +			omap3_clkdm_wakeup(clkdm);
> +		return 0;
> +	}
> +
>  	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
>  				clkdm->clktrctrl_mask);

I think that the above needs to be ...

diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index e5bb219..d2b081d 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -253,8 +253,8 @@ static int omap3xxx_clkdm_clk_enable(struct clockdomain *clkdm)
         * more details on the unpleasant problem this is working
         * around
         */
-       if (clkdm->flags & (CLKDM_MISSING_IDLE_REPORTING |
-                           CLKDM_CAN_FORCE_WAKEUP)) {
+       if ((clkdm->flags & CLKDM_MISSING_IDLE_REPORTING) &&
+                               (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)) {
                omap3_clkdm_wakeup(clkdm);
                return 0;

... otherwise I see other clkdm such as MPU being put in force-wakeup state 
although they don't have CLKDM_MISSING_IDLE_REPORTING set.

Cheers
Jon
