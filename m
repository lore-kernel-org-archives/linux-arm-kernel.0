From: khilman@ti.com (Kevin Hilman)
Date: Thu, 06 Oct 2011 16:53:01 -0700
Subject: [PATCH] ARM: OMAP3: PM: restrict erratum i443 handling to
	OMAP3430 only
In-Reply-To: <alpine.DEB.2.00.1110061341460.4611@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 6 Oct 2011 13:43:23 -0600 (MDT)")
References: <alpine.DEB.2.00.1110061341460.4611@utopia.booyaka.com>
Message-ID: <8762k1n0de.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Based on the documents that I have here, there doesn't appear to be an
> equivalent to erratum i443 for OMAP3630, so restrict this one to OMAP34xx
> chips.
>
> Also, explicitly restrict this erratum to EMU and HS devices.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
> Unfortunately, I don't have any HS/EMU devices in my testbed, so it's not 
> possible for me to test this one on anything but GP chips.

I don't have any 36xx HS/EMU device either, but this erratum does indeed
seem to be 34xx specific.

Barring any objections, I'll queue this for v3.2 (branch: for_3.2/pm-cleanup-2)

Kevin


>  arch/arm/mach-omap2/pm34xx.c |   20 +++++++++++---------
>  1 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index a6156bd..9e14ae5 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -407,13 +407,14 @@ void omap_sram_idle(void)
>  	omap3_intc_prepare_idle();
>  
>  	/*
> -	* On EMU/HS devices ROM code restores a SRDC value
> -	* from scratchpad which has automatic self refresh on timeout
> -	* of AUTO_CNT = 1 enabled. This takes care of erratum ID i443.
> -	* Hence store/restore the SDRC_POWER register here.
> -	*/
> -	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
> -	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
> +	 * On EMU/HS devices ROM code restores a SRDC value
> +	 * from scratchpad which has automatic self refresh on timeout
> +	 * of AUTO_CNT = 1 enabled. This takes care of erratum ID i443.
> +	 * Hence store/restore the SDRC_POWER register here.
> +	 */
> +	if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
> +	    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
> +	     omap_type() == OMAP2_DEVICE_TYPE_SEC) &&
>  	    core_next_state == PWRDM_POWER_OFF)
>  		sdrc_pwr = sdrc_read_reg(SDRC_POWER);
>  
> @@ -430,8 +431,9 @@ void omap_sram_idle(void)
>  		omap34xx_do_sram_idle(save_state);
>  
>  	/* Restore normal SDRC POWER settings */
> -	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
> -	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
> +	if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
> +	    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
> +	     omap_type() == OMAP2_DEVICE_TYPE_SEC) &&
>  	    core_next_state == PWRDM_POWER_OFF)
>  		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
