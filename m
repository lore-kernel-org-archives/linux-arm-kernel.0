From: mgreer@animalcreek.com (Mark A. Greer)
Date: Tue, 8 Jan 2013 13:43:47 -0700
Subject: [PATCH] ARM: OMAP AM3517/05: hwmod data: block WFI when EMAC
 active
In-Reply-To: <alpine.DEB.2.00.1301081916190.18536@utopia.booyaka.com>
References: <alpine.DEB.2.00.1212301828590.8175@utopia.booyaka.com>
 <alpine.DEB.2.00.1301081916190.18536@utopia.booyaka.com>
Message-ID: <20130108204347.GC1876@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 07:21:16PM +0000, Paul Walmsley wrote:
> On Sun, 30 Dec 2012, Paul Walmsley wrote:

Hi Paul.

> > However, for some reason, we don't have an EMAC hwmod -- probably some 
> > bug in the data -- so set the flag on the MDIO hwmod data instead.
> 
> Mark and I discussed this in private E-mail.  Looks like I managed to 
> confuse AM33xx and AM3517 :-(  Here's the updated patch.
> 
> 
> - Paul
> 
> 
> From: Paul Walmsley <paul@pwsan.com>
> Date: Sun, 30 Dec 2012 10:36:36 -0700
> Subject: [PATCH] ARM: OMAP AM3517/05: hwmod data: block WFI when EMAC active
> 
> According to Mark Greer, on OMAP AM3517/3505 chips, the EMAC is unable
> to wake the ARM up from WFI:
> 
>     http://www.spinics.net/lists/arm-kernel/msg174734.html
> 
> Further troubleshooting was unable to narrow the problem down.  So we
> don't have much choice other than to block WFI when the EMAC is active
> with the HWMOD_BLOCK_WFI flag.
> 
> Based on Mark's original patch.  We're removing the omap_device-based
> pm_lats code, so a different approach was needed.
> 
> This second version contains some corrections thanks to Mark's review.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 8bb2628..7af28b7 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -3493,7 +3493,13 @@ static struct omap_hwmod am35xx_emac_hwmod = {
>  	.name		= "davinci_emac",
>  	.mpu_irqs	= am35xx_emac_mpu_irqs,
>  	.class		= &am35xx_emac_class,
> -	.flags		= HWMOD_NO_IDLEST,
> +	/*
> +	 * According to Mark Greer, the MPU will not return from WFI
> +	 * when the EMAC signals an interrupt.  We're missing an EMAC
> +	 * hwmod for some reason, so add the flag to the MDIO instead.
> +	 * http://www.spinics.net/lists/arm-kernel/msg174734.html
> +	 */
> +	.flags		= (HWMOD_NO_IDLEST | HWMOD_BLOCK_WFI),
>  };

Sorry to nag but I think the comment needs to be updated to remove the
sentence about the missing EMAC hwmod.

Mark
--
