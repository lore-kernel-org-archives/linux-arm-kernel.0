From: nm@ti.com (Nishanth Menon)
Date: Fri, 17 Dec 2010 09:43:29 -0600
Subject: [PATCH 6/7] OMAP3: add comments for low power code errata
In-Reply-To: <1292580506-4421-7-git-send-email-j-pihet@ti.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
	<1292580506-4421-7-git-send-email-j-pihet@ti.com>
Message-ID: <4D0B8521.3050606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jean.pihet at newoldbits.com had written, on 12/17/2010 04:08 AM, the 
following:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Errata covered:
> - 1.157 & 1.185
> - i443
> - i581
> 
> Tested on N900 and Beagleboard with full RET and OFF modes,
> using cpuidle and suspend.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c    |    4 ++--
>  arch/arm/mach-omap2/sleep34xx.S |   11 +++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index adc0917..267f015 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -148,7 +148,7 @@ static void omap3_core_save_context(void)
>  
>  	/*
>  	 * Force write last pad into memory, as this can fail in some
> -	 * cases according to erratas 1.157, 1.185
> +	 * cases according to errata 1.157, 1.185
a better cleanup might to actually use PM_ERRATUM macros to enable 
disable this code on a need basis.
>  	 */
>  	omap_ctrl_writel(omap_ctrl_readl(OMAP343X_PADCONF_ETK_D14),
>  		OMAP343X_CONTROL_MEM_WKUP + 0x2a0);
> @@ -446,7 +446,7 @@ void omap_sram_idle(void)
>  	/*
>  	* On EMU/HS devices ROM code restores a SRDC value
>  	* from scratchpad which has automatic self refresh on timeout
> -	* of AUTO_CNT = 1 enabled. This takes care of errata 1.142.
> +	* of AUTO_CNT = 1 enabled. This takes care of erratum ID i443.
same here.
>  	* Hence store/restore the SDRC_POWER register here.
>  	*/
>  	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index 12061fd..8e5004a 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -592,6 +592,7 @@ usettbr0:
>   * Internal functions
>   */
>  
> +/* This function implements the erratum ID i443 WA, applies to 34xx >= ES3.0 */
>  	.text
>  ENTRY(es3_sdrc_fix)
>  	ldr	r4, sdrc_syscfg		@ get config addr
> @@ -637,6 +638,16 @@ sdrc_manual_1:
>  ENTRY(es3_sdrc_fix_sz)
>  	.word	. - es3_sdrc_fix
>  
> +/*
> + * This function implements the erratum ID i581 WA:
> + *  SDRC state restore before accessing the SDRAM
> + *
> + * Only used at return from non-OFF mode. For OFF
> + * mode the ROM code configures the SDRC and
> + * the DPLL before calling the restore code directly
> + * from DDR.
> + */
> +
>  /* Make sure SDRC accesses are ok */
>  wait_sdrc_ok:
Tested-by: Nishanth Menon <nm@ti.com>
Tested on:
SDP3630
SDP3430
Test script:
http://pastebin.mozilla.org/889933

-- 
Regards,
Nishanth Menon
