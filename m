From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Fri, 1 Feb 2013 05:05:54 +0000
Subject: [Patch v2 2/2] ARM: OMAP2: am33xx-hwmod: Fix "register offset
 NULL check" bug
In-Reply-To: <alpine.DEB.2.00.1301311528320.23099@utopia.booyaka.com>
References: <1359642327-5542-1-git-send-email-gururaja.hebbar@ti.com>
 <1359642327-5542-3-git-send-email-gururaja.hebbar@ti.com>
 <alpine.DEB.2.00.1301311528320.23099@utopia.booyaka.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB5B145@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 21:00:32, Paul Walmsley wrote:
> + Koen
> 
> Hi
> 
> On Thu, 31 Jan 2013, Hebbar Gururaja wrote:
> 
> > am33xx_cm_wait_module_ready() checks if register offset is NULL.
> > 
> > int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
> > {
> > 	int i = 0;
> > 
> > 	if (!clkctrl_offs)
> > 		return 0;
> > 
> > In case of AM33xx, CLKCTRL register offset for different clock domains
> > are not uniformly placed. An example of this would be the RTC clock
> > domain with CLKCTRL offset at 0x00.
> > In such cases the module ready check is skipped which leads to a data
> > abort during boot-up when RTC registers is accessed.
> > 
> > Remove this check here to avoid checking module readiness for modules
> > with clkctrl register offset at 0x00.
> > 
> > Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> 
> Some text has been added to the patch description to describe Koen's test 
> results, and the updated patch has been queued for v3.8-rc fixes.  Updated 
> patch follows.
> 
> - Paul


Thanks for the review & update.


Regards, 
Gururaja

> 
> From: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Date: Thu, 31 Jan 2013 19:55:27 +0530
> Subject: [PATCH] ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL check"
>  bug
> 
> am33xx_cm_wait_module_ready() checks if register offset is NULL.
> 
> int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
> {
> 	int i = 0;
> 
> 	if (!clkctrl_offs)
> 		return 0;
> 
> In case of AM33xx, CLKCTRL register offset for different clock domains
> are not uniformly placed. An example of this would be the RTC clock
> domain with CLKCTRL offset at 0x00.
> In such cases the module ready check is skipped which leads to a data
> abort during boot-up when RTC registers is accessed.
> 
> Remove this check here to avoid checking module readiness for modules
> with clkctrl register offset at 0x00.
> 
> Koen Kooi notes that this patch fixes a crash on boot with
> CONFIG_RTC_DRV_OMAP=y with v3.8-rc5.
> 
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Cc: Koen Kooi <koen@dominion.thruhere.net>
> [paul at pwsan.com: noted Koen's test in the patch description]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/cm33xx.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
> index 058ce3c..325a515 100644
> --- a/arch/arm/mach-omap2/cm33xx.c
> +++ b/arch/arm/mach-omap2/cm33xx.c
> @@ -241,9 +241,6 @@ int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
>  {
>  	int i = 0;
>  
> -	if (!clkctrl_offs)
> -		return 0;
> -
>  	omap_test_timeout(_is_module_ready(inst, cdoffs, clkctrl_offs),
>  			  MAX_MODULE_READY_TIME, i);
>  
> -- 
> 1.7.10.4
> 
> 
