From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 17 Apr 2012 18:02:36 -0600 (MDT)
Subject: [PATCH 2/2] ARM: OMAP2+: omap_hwmod: Add api to enable/disable
 module level wakeup events
In-Reply-To: <1334580053-17242-3-git-send-email-govindraj.raja@ti.com>
References: <1334580053-17242-1-git-send-email-govindraj.raja@ti.com>
 <1334580053-17242-3-git-send-email-govindraj.raja@ti.com>
Message-ID: <alpine.DEB.2.00.1204171800120.29048@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, 16 Apr 2012, Govindraj.R wrote:

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 2c27fdb..05576ae 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -382,6 +382,35 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
>  }
>  
>  /**
> + * _enable_module_level_wakeup - enable/disable module level wakeup on hwmod.
> + * @oh: struct omap_hwmod *
> + * @set_wake: bool value indicating to set (true) or clear (false) module level
> + *		wakeup enable
> + *
> + * Set or clear the  module level wakeup capability the
> + * hwmod @oh. This function configures th PM_WKEN reg bits if they
> + * are available from hwmod. No return value
> + */
> +static void _enable_module_level_wakeup(struct omap_hwmod *oh, bool set_wake)
> +{
> +	u32 v;
> +
> +	if (oh->prcm.omap2.module_wakeup_offs &&
> +			oh->prcm.omap2.module_wakeup_bit) {
> +		v = omap2_prm_read_mod_reg(oh->prcm.omap2.module_offs,
> +				oh->prcm.omap2.module_wakeup_offs);
> +
> +		if (set_wake)
> +			v |= oh->prcm.omap2.module_wakeup_bit;
> +		else
> +			v &= ~oh->prcm.omap2.module_wakeup_bit;
> +
> +		omap2_prm_write_mod_reg(v, oh->prcm.omap2.module_offs,
> +				oh->prcm.omap2.module_wakeup_offs);
> +	}
> +}

Please move the direct PRM register accesses to the PRM code, such as 
prm2xxx_3xxx.c and prm44xx.c, as mentioned here:

    http://www.spinics.net/lists/linux-serial/msg05945.html

We are trying to move the PRM code to drivers/ and the only code that 
should be doing direct PRM register accesses is the PRM code itself.  
Other code (like the hwmod code) should be calling higher-level 
functions exported by the PRM code, such as something like 
"omap_prm_enable_prcm_module_wakeup()"


- Paul
