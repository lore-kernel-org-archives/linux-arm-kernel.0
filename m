From: tony@atomide.com (Tony Lindgren)
Date: Tue, 25 Mar 2014 15:36:12 -0700
Subject: [PATCH 12/18] ARM: OMAP3: PM: remove access to PRM_VOLTCTRL
 register
In-Reply-To: <1393949958-816-13-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
 <1393949958-816-13-git-send-email-t-kristo@ti.com>
Message-ID: <20140325223612.GA26395@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140304 08:23]:
> There is a solitary write to this register every wakeup from off-mode,
> which isn't doing anything, so remove it.

Argh, this chunk of code is for sure the the thing that's blocking all
the voltage scaling for idle modes that twl4030 is supposed to do!

AFAIK we must have AUTO_SLEEP, AUTO_RET and AUTO_OFF bits set in
PRM_VOLTCTRL for twl4030 to scale anything. They must be set if we're
scaling over I2C4 or using the pins as triggers. Unless these bits
are set, VC won't send any SLEEP, RET or OFF commands.

Looks like we're not even set these bits anywhere like we should?

I think we should enabled these bits in vc.c init, and never clear?

Nishant and Kevin, any comments?
 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 0eecf6f..2fa9478 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -282,10 +282,6 @@ void omap_sram_idle(void)
>  			omap3_sram_restore_context();
>  			omap2_sms_restore_context();
>  		}
> -		if (core_next_state == PWRDM_POWER_OFF)
> -			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
> -					       OMAP3430_GR_MOD,
> -					       OMAP3_PRM_VOLTCTRL_OFFSET);
>  	}
>  	omap3_intc_resume_idle();
>  
> -- 
> 1.7.9.5
> 
