From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 11 Jun 2012 11:26:35 -0600 (MDT)
Subject: [PATCH 1/2] ARM: OMAP2+: hwmod data: Fix the wrong clkdm assigned
 to PRCM modules
In-Reply-To: <1339433225-30042-2-git-send-email-b-cousson@ti.com>
References: <1339433225-30042-1-git-send-email-b-cousson@ti.com>
 <1339433225-30042-2-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1206111100130.5849@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jun 2012, Benoit Cousson wrote:

> The following commit (794b480a37e3d284d6ee7344d8a737ef60476ed5) was adding
> the PRCM IPs data for PRCM, CM, PRCM_MPU and SCRM.
> The clkdm entry are not the correct ones and does not exist in the system.
> 
> Replace them with the proper wkup, l4_ao and l4_cfg.

This does not match either the publicly avaiable documentation and the 
internal NDA hardware specifications[1].

Nor does it make sense from a logical perspective.  To take an example 
from your patch:

> @@ -2564,12 +2543,33 @@ static struct omap_hwmod_rst_info omap44xx_prm_resets[] = {
>  static struct omap_hwmod omap44xx_prm_hwmod = {
>  	.name		= "prm",
>  	.class		= &omap44xx_prcm_hwmod_class,
> -	.clkdm_name	= "prm_clkdm",
> +	.clkdm_name	= "l4_wkup_clkdm",
>  	.mpu_irqs	= omap44xx_prm_irqs,
>  	.rst_lines	= omap44xx_prm_resets,
>  	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_prm_resets),
>  };

There is no possible way that the PRM can exist in the L4_WKUP 
clockdomain.  The L4_WKUP clockdomain must be able to go inactive for the 
chip to enter idle, as we just discussed[1].  But the PRM is the 
entity that supervises chip wakeup from off-mode, so for off-mode 
to work, there's no way that the PRM can be clock-gated.

Frustrating :-(

> Fix as well the wrong OCP port used by the cm_core_aon. It uses the
> l4_cfg interconnect and not the l4_wkup.
> 
> Re-order the entries by address value.

If you split this part off into a separate patch, I'll take it.


- Paul

1. Cousson, Beno?t.  _Re: [PATCH] ARM: OMAP2+: hwmod code/data: fix 32K 
   sync timer_.  linux-omap at vger.kernel.org mailing list.  Available from 
   http://www.spinics.net/lists/arm-kernel/msg177128.html (among others).
